require "engine.class"
local DamageType = require "engine.DamageType"
local Map = require "engine.Map"
local Target = require "engine.Target"
local Talents = require "engine.interface.ActorTalents"
local Chat = require "mod.class.Chat"

--- Interface to add ToME combat system
module(..., package.seeall, class.make)

--- Checks what to do with the target
-- Talk ? attack ? displace ?
function _M:bumpInto(target)
	local reaction = self:reactionToward(target)
	if reaction < 0 then
		return self:meleeTarget(self:meleeAttack(target), target:getDefense(),target)
	elseif reaction >= 0 then
		-- Chat
		if self.player and target.can_talk then 
			local chat = Chat.new(target.can_talk, target, self) 
			chat:invoke() 
		elseif self.move_others then
			-- Displace
			game.level.map:remove(self.x, self.y, Map.ACTOR)
			game.level.map:remove(target.x, target.y, Map.ACTOR)
			game.level.map(self.x, self.y, Map.ACTOR, target)
			game.level.map(target.x, target.y, Map.ACTOR, self)
			self.x, self.y, target.x, target.y = target.x, target.y, self.x, self.y
		end
	end
end

--- Makes the death happen!
function _M:meleeTarget(atk, def, target)
	local srcname = game.level.map.seens(self.x, self.y) and self.name:capitalize() or "Something"

	if target:knowTalent(target.T_DEFENSIVE_MARTIAL_ARTS) then def = def + 1 end

	local dam = self:strMod() + self.melee_bonus
	local hit, crit = self:combatRoll(atk, def, self.crit)
	
	if hit then
		dam = dam + self:meleeRoll()
		if crit then
			game.logSeen(self, "%s preforms a critical hit!", srcname)
			dam = dam + self:meleeRoll()
		end
	else
		game.logSeen(self, "%s misses %s.", srcname, target.name)
	end

	if hit then
		DamageType:get(DamageType.PHYSICAL).projector(self, target.x, target.y, DamageType.PHYSICAL, math.max(1, dam))
	end

	-- We use up our own energy
	self:useEnergy(game.energy_to_act)
end

function _M:combatRoll(atk, def, threat)
	local roll = rng.dice(1, 20)
	local crit_roll = rng.dice(1, 20)

	local hit = nil
	local crit = nil

	-- Checks the combat roll
	if roll == 1 then 
		hit = false
	elseif roll == 20 then 
		hit = true
	elseif (roll + atk >= def) then 
		hit = true
	else 
		hit = false
	end

	if (roll >= 20 - threat) and (crit_roll + atk >= def) and hit then
		crit = true
	end

	return hit, crit
end

function _M:meleeAttack(target)
	local atk = self:strMod() + (target.size - self.size) * 2 + self.atk
	
	if self:knowTalent(self.T_BRAWL) and not self:getInven("MAINHAND")[1] then atk = atk + 1 end
	if self:knowTalent(self.T_IMPROVED_BRAWL) and not self:getInven("MAINHAND")[1] then atk = atk + 1 end
	
	return atk
end

function _M:getDefense()
	local def = self.defense + self:dexMod()

	if self:getInven("BODY") then
		local armor = self:getInven("BODY")[1]
		if armor and self:hasProficiency(armor.subtype) then
			def = def + self.prof_defense
		end
	end

	if self:attr("light_sensitive") and self.lite > 0 then
		def = def - 2
	end
	
	local hack = self:hasEffect(self.EFF_HACKED)
	if hack then
		def = def - 2
	end

	if self:knowTalent(self.T_IRON_WILL) and self.life < 0.2*self.life then
		def = def + 2
	end

	return def
end

function _M:meleeRoll()
	local weapon = self:hasMeleeWeapon()
	local melee = {}	

	if weapon then
		melee = weapon.melee
	else	
		melee = self.melee		
	end

	return self:damageRoll(melee)
end

function _M:hasMeleeWeapon()
	if not self:getInven("MAINHAND") then return end
	local weapon = self:getInven("MAINHAND")[1]
	if not weapon or not weapon.melee then
		return nil
	end
	return weapon
end

function _M:damageRoll(weapon)
	return rng.dice(weapon.num, weapon.sides) + (weapon.bonus or 0)
end

-- Ranged Attack functions
function _M:rangedTarget(target, talent, tg)
	local weapon = self:hasRangedWeapon()
	local ammo = self:hasAmmo(weapon.ammo)

	if not weapon then
		game.logPlayer(self, "You need to wield a gun to shoot.")
		return nil
	end

	if weapon.ammo and not ammo then
		game.logPlayer(self, "You need "..weapon.ammo.." to shoot.")
		return nil
	end

	local tg = tg or {type="ball"}
	tg.range = tg.range or weapon.ranged.range
	tg.radius = weapon.ranged.radius or 0
	tg.talent = tg.talent or talent
	tg.atk = tg.atk or 0
	tg.bonus = tg.bonus or 0
	tg.crit = tg.crit or 0

	local damage_type = weapon.ranged.damage_type or DamageType.PHYSICAL

	local x, y, target = self:getTarget(tg)
	if not x or not y or not target then return nil end

	local srcname = game.level.map.seens(self.x, self.y) and self.name:capitalize() or "Something"

	local dam = self.ranged_bonus + tg.bonus
	local hit, crit = self:combatRoll(self:rangedAttack(target) + tg.atk, target:getDefense(), self:rangedCrit(tg))
	
	if hit or weapon.never_miss then
		-- Roll and apply damage
		dam = dam + self:rangedRoll()
		if crit and not weapon.no_crit then
			game.logSeen(self, "%s preforms a critical hit!", srcname)
			dam = dam + self:rangedRoll()
		end
	
		self:project(tg, target.x, target.y, damage_type, dam, {type = weapon.particle or "gun"})

		-- Project from ammo (incindiary bullets etc.)
		if ammo and ammo.project then
			for typ, dam in pairs(ammo.project) do
				self:project(tg, target.x, target.y, typ, self:damageRoll(dam))
			end
		end

		-- Burst damage on crits
		if ammo and ammo.burst and crit then
			for typ, dam in pairs(ammo.burst) do
				self:project({type="ball", radius=1}, target.x, target.y, typ, self:damageRoll(dam), {type=DamageType:get(typ).name})
			end
		end
	else
		game.logSeen(self, "%s misses %s.", srcname, target.name)
	end

	if weapon.ammo then
		ammo.remaining = ammo.remaining - 1
	end

	self:useEnergy(game.energy_to_act)

	if weapon.charging then
		weapon.ranged.num = weapon.min_charge-1
	end
end

function _M:rangedAttack(target)
	local atk = self:dexMod() + (target.size - self.size) * 2 + self.ranged_atk
	
	local weapon = self:hasRangedWeapon()
	if weapon.subtype and not self:hasProficiency(weapon.subtype) then
		atk = atk - 4
	end

	if weapon.subtype and self:hasFocus(weapon.subtype) then
		atk = atk + 1
	end

	return atk
end

function _M:rangedCrit(tg)
	local crit = 0 + tg.crit + self.crit

	local weapon = self:hasRangedWeapon()
	if weapon.subtype and self:hasImprovedCritial(weapon.subtype) then
		crit = crit + 1
	end
	if weapon.ranged.crit then
		crit = crit.weapon.ranged.crit
	end

	return crit
end

-- Checks weapon/armor training
_M.proficiencies = {
	handgun =  Talents.T_HANDGUN_PROFICIENCY,
	longarm =  Talents.T_LONGARM_PROFICIENCY,
	light =    Talents.T_LIGHT_PROFICIENCY,
	medium =   Talents.T_MEDIUM_PROFICIENCY,
	heavy =    Talents.T_HEAVY_PROFICIENCY,
}

function _M:hasProficiency(type)
	if self:knowTalent(proficiencies[type]) then return true
	else return false end
end

_M.focuses = {
	handgun =   Talents.T_HANDGUN_FOCUS,
	longarm =   Talents.T_LONGARM_FOCUS,
}

function _M:hasFocus(type)
	if self:knowTalent(focuses[type]) then return true
	else return false end
end

_M.specializations = {
	handgun =    Talents.T_HANDGUN_SPECIALIZATION,
	longarm =    Talents.T_LONGARM_SPECIALIZATION,
}

function _M:hasSpecialization(type)
	if self:knowTalent(specializations[type]) then return true
	else return false end
end

_M.greaterSpecializations = {
	handgun =    Talents.T_GREATER_HANDGUN_SPECIALIZATION,
	longarm =    Talents.T_GREATER_LONGARM_SPECIALIZATION,
}

function _M:hasGreaterSpecialization(type)
	if self:knowTalent(greaterSpecializations[type]) then return true
	else return false end
end

_M.improvedCritials = {
	handgun =   Talents.T_HANDGUN_CRITICAL,
	longarm =   Talents.T_LONGARM_CRITICAL,
}

function _M:hasImprovedCritial(type)
	if self:knowTalent(improvedCritials[type]) then return true
	else return false end
end

function _M:hasRangedWeapon(type)
	if not self:getInven("MAINHAND") then 
		if self.ranged then return self
		else return nil end
	end

	local weapon = self:getInven("MAINHAND")[1]
	if not weapon or not weapon.ranged then
		if self.ranged then
			return self
		else
			return nil
		end
	end
	return weapon
end

function _M:rangedRoll()
	local weapon = self:hasRangedWeapon()
	local ranged = {}	
	ranged = weapon.ranged

	local dam = self:damageRoll(ranged)

	if weapon.subtype and self:hasSpecialization(weapon.subtype) then dam = dam + 2 end
	if weapon.subtype and self:hasGreaterSpecialization(weapon.subtype) then dam = dam + 2 end
	
	return dam
end

function _M:hasAmmo(type)
	if not self:getInven("CLIP") then return nil end

	local ammo = self:getInven("CLIP")[1]
	if not ammo then
		return nil
	end
	
	
	if (type and not (type == ammo.subtype)) or not (ammo.remaining > 0) then
		return nil
	end
	
	return ammo
end