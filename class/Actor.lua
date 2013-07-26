require "engine.class"
require "engine.Actor"
require "engine.Autolevel"
require "engine.interface.ActorTemporaryEffects"
require "engine.interface.ActorLife"
require "engine.interface.ActorProject"
require "engine.interface.ActorLevel"
require "engine.interface.ActorQuest"
require "engine.interface.ActorStats"
require "engine.interface.ActorTalents"
require "engine.interface.ActorResource"
require "engine.interface.ActorFOV"
require "engine.interface.ActorInventory"
require "mod.class.interface.Combat"

local Map = require "engine.Map"

module(..., package.seeall, class.inherit(
	engine.Actor,
	engine.interface.ActorTemporaryEffects,
	engine.interface.ActorLife,
	engine.interface.ActorProject,
	engine.interface.ActorLevel,
	engine.interface.ActorQuest,
	engine.interface.ActorStats,
	engine.interface.ActorTalents,
	engine.interface.ActorResource,
	engine.interface.ActorFOV,
	engine.interface.ActorInventory,
	mod.class.interface.Combat
))

function _M:init(t, no_default)
	-- Define some basic combat stats
	-- self.combat_armor = 0
	self.defense = self.defense or 10
	self.atk = self.atk or 0
	
	self.ranged_atk = self.ranged_atk or 0
	self.melee_atk = self.melee_atk or 0

	self.melee = self.melee or {num = 1, sides = 3, bonus = 0}
	self.melee_bonus = self.melee_bonus or 0

	self.ranged_bonus = self.ranged_bonus or 0

	self.resists = self.resists or {}

	self.size = self.size or 3

	self.unused_stats = self.unused_stats or 6
	self.unused_talents = self.unused_talents or 4

	-- Saving throws
	self.saves = self.saves or {}
	self.saves.fortitude = self.saves.fortitude or 0
	self.saves.reflex = self.saves_reflex or 0
	self.saves.mental = self.saves.mental or 0
	self.saves.physical = self.saves.physical or 0

	-- Default regen
	t.power_regen = t.power_regen or 1
	t.life_regen = t.life_regen or 0

	self.life_rating = self.life_rating or 4
	self.life = self.max_life

	engine.Actor.init(self, t, no_default)
	engine.interface.ActorTemporaryEffects.init(self, t)
	engine.interface.ActorLife.init(self, t)
	engine.interface.ActorProject.init(self, t)
	engine.interface.ActorTalents.init(self, t)
	engine.interface.ActorResource.init(self, t)
	engine.interface.ActorStats.init(self, t)
	engine.interface.ActorLevel.init(self, t)
	engine.interface.ActorFOV.init(self, t)
	engine.interface.ActorInventory.init(self, t)
end

function _M:act()
	if not engine.Actor.act(self) then return end

	self.changed = true

	-- Cooldown talents
	self:cooldownTalents()
	-- Regen resources
	self:regenLife()
	self:regenResources()
	-- Compute timed effects
	self:timedEffects()

	-- Shrug off effects
	for eff_id, params in pairs(self.tmp) do
		local DC = params.DC_ongoing or 10
		local eff = self.tempeffect_def[eff_id]
		if eff.decrease == 0 then 
			if self:saveRoll(DC, eff.type) then
				params.dur = 0 
			end
		end
	end

	-- Still enough energy to act ?
	if self.energy.value < game.energy_to_act then return false end

	return true
end

function _M:move(x, y, force)
	local moved = false
	local ox, oy = self.x, self.y
	if force or self:enoughEnergy() then
		moved = engine.Actor.move(self, x, y, force)
		if not force and moved and (self.x ~= ox or self.y ~= oy) and not self.did_energy then self:useEnergy() end
	end
	self.did_energy = nil
	return moved
end

function _M:tooltip()
	return ([[%s%s
#00ffff#Level: %d
#ff0000#HP: %d / %d
Stats: %d /  %d / %d / %d
%s]]):format(
	self:getDisplayString(),
	self.name,
	self.level,
	self.life, self.max_life,
	self:getStr(),
	self:getDex(),
	self:getInt(),
	self:getCon(),
	self.desc or ""
	)
end

function _M:onTakeHit(value, src)
	return value
end

function _M:die(src)
	engine.interface.ActorLife.die(self, src)

	-- Gives the killer some exp for the kill
	if src and src.gainExp then
		src:gainExp(self:worthExp(src))
	end

	-- Drop stuff
	local invens = {}
	for inven_id, inven in pairs(self.inven) do invens[#invens+1] = inven end
	table.sort(invens, function(a,b) if a.id == 1 then return false elseif b.id == 1 then return true else return a.id < b.id end end)
		for _, inven in ipairs(invens) do
			for i, o in ipairs(inven) do
				o.droppedBy = self.name
				game.level.map:addObject(self.x, self.y, o)
			end
		end
	self.inven = {}

	return true
end

function _M:levelup()
	engine.interface.ActorLevel.levelup(self)
	engine.interface.ActorTalents.resolveLevelTalents(self)

	local rating = self.life_rating
	if not self.fixed_rating then
		rating = math.floor(rng.range(math.floor(self.life_rating * 0.5), math.floor(self.life_rating * 1.5)))
	end
	
	self.max_life = self.max_life + rating

	self.atk = self.atk + 1
	self.defense = self.defense + 1

	self.unused_talents = self.unused_talents + 1
	if self.level % 4 == 0 then self.unused_stats = self.unused_stats + 1 end

	self.life = self.max_life
end

--- Notifies a change of stat value
function _M:onStatChange(stat, v)
	-- Temporary fix for NPC classes
	if stat == self.STAT_CON and type(self.max_life) == "number" then
		self.max_life = self.max_life + v*2
	end
end

function _M:attack(target)
	self:bumpInto(target)
end


--- Called before a talent is used
-- Check the actor can cast it
-- @param ab the talent (not the id, the table)
-- @return true to continue, false to stop
function _M:preUseTalent(ab, silent)
	if not self:enoughEnergy() then print("fail energy") return false end

	if ab.mode == "sustained" then
		if ab.sustain_power and self.max_power < ab.sustain_power and not self:isTalentActive(ab.id) then
			game.logPlayer(self, "You do not have enough power to activate %s.", ab.name)
			return false
		end
	else
		if ab.power and self:getPower() < ab.power then
			game.logPlayer(self, "You do not have enough power to cast %s.", ab.name)
			return false
		end
	end

	if not silent then
		-- Allow for silent talents
		if ab.message ~= nil then
			if ab.message then
				game.logSeen(self, "%s", self:useTalentMessage(ab))
			end
		elseif ab.mode == "sustained" and not self:isTalentActive(ab.id) then
			game.logSeen(self, "%s activates %s.", self.name:capitalize(), ab.name)
		elseif ab.mode == "sustained" and self:isTalentActive(ab.id) then
			game.logSeen(self, "%s deactivates %s.", self.name:capitalize(), ab.name)
		else
			game.logSeen(self, "%s uses %s.", self.name:capitalize(), ab.name)
		end
	end
	return true
end

--- Called before a talent is used
-- Check if it must use a turn, mana, stamina, ...
-- @param ab the talent (not the id, the table)
-- @param ret the return of the talent action
-- @return true to continue, false to stop
function _M:postUseTalent(ab, ret)
	if not ret then return end

	self:useEnergy()

	if ab.mode == "sustained" then
		if not self:isTalentActive(ab.id) then
			if ab.sustain_power then
				self.max_power = self.max_power - ab.sustain_power
			end
		else
			if ab.sustain_power then
				self.max_power = self.max_power + ab.sustain_power
			end
		end
	else
		if ab.power then
			self:incPower(-ab.power)
		end
	end

	return true
end

--- Return the full description of a talent
-- You may overload it to add more data (like power usage, ...)
function _M:getTalentFullDescription(t)
	local d = {}

	if t.mode == "passive" then d[#d+1] = "#6fff83#Use mode: #00FF00#Passive"
	elseif t.mode == "sustained" then d[#d+1] = "#6fff83#Use mode: #00FF00#Sustained"
	else d[#d+1] = "#6fff83#Use mode: #00FF00#Activated"
	end

	if t.power or t.sustain_power then d[#d+1] = "#6fff83#Power cost: #7fffd4#"..(t.power or t.sustain_power) end
	if self:getTalentRange(t) > 1 then d[#d+1] = "#6fff83#Range: #FFFFFF#"..self:getTalentRange(t)
	else d[#d+1] = "#6fff83#Range: #FFFFFF#melee/personal"
	end
	if t.cooldown then d[#d+1] = "#6fff83#Cooldown: #FFFFFF#"..t.cooldown end

	return table.concat(d, "\n").."\n#6fff83#Description: #FFFFFF#"..t.info(self, t)
end

--- How much experience is this actor worth
-- @param target to whom is the exp rewarded
-- @return the experience rewarded
function _M:worthExp(target)
	if not target.level or self.level < target.level - 3 then return 0 end

	local mult = 2
	return self.level * mult * self.exp_worth
end

function _M:strMod()
	return math.floor(self:getStr()/2 - 5)
end

function _M:dexMod()
	return math.floor(self:getDex()/2 - 5)
end

function _M:intMod()
	return math.floor(self:getInt()/2 - 5)
end

function _M:conMod()
	return math.floor(self:getCon()/2 - 5)
end

function _M:saveRoll(DC, type)
	local roll = rng.dice(1, 20)
	local saves = self.saves[type]

	if type == "physical" then saves = saves + self:strMod() end
	if type == "reflex" then saves = saves + self:dexMod() end
	if type == "mental" then saves = saves + self:intMod() end
	if type == "fortitude" then saves = saves + self:conMod() end

	if roll == 1 then return false end
	if roll == 20 then return true end

	if roll + saves > DC then return true end
end