require "engine.class"
require "engine.Object"
require "engine.interface.ObjectActivable"

local Stats = require("engine.interface.ActorStats")
local Talents = require("engine.interface.ActorTalents")
local DamageType = require("engine.DamageType")

module(..., package.seeall, class.inherit(
	engine.Object,
	engine.interface.ObjectActivable,
	engine.interface.ActorTalents
))

function _M:init(t, no_default)
	t.encumber = t.encumber or 0

	engine.Object.init(self, t, no_default)
	engine.interface.ObjectActivable.init(self, t)
	engine.interface.ActorTalents.init(self, t)
end

function _M:canAct()
	if self.power_regen or self.use_talent or self.can_act then return true end
	return false
end

function _M:act()
	self:regenPower()
	self:cooldownTalents()
	self:useEnergy()
end

function _M:use(who, typ, inven, item)
	inven = who:getInven(inven)

	if self:wornInven() and not self.wielded and not self.use_no_wear then
		game.logPlayer(who, "You must wear this object to use it!")
		return
	end

	local types = {}
	if self:canUseObject() then types[#types+1] = "use" end

	if not typ and #types == 1 then typ = types[1] end

	if typ == "use" then
		local ret = {self:useObject(who, inven, item)}
		if ret[1] then
			if self.use_sound then game:playSoundNear(who, self.use_sound) end
			who:useEnergy(game.energy_to_act * (inven.use_speed or 1))
		end
		return unpack(ret)
	end
end

function _M:getDice(t)
	local dice = " "..t.num.."d"..t.sides
	if t.bonus then dice = dice.."+"..t.bonus end

	return dice
end

function _M:getDamageType(dam)
	local type = DamageType:get(dam)

	local text = type.text_color or "#aaaaaa#"
	text = text..type.name
	
	return text
end

function _M:getCapacity()
	return " "..self.remaining.."/"..self.capacity
end

function _M:getName(t)
	local name = self.name

	if self.melee then
		name = name..self:getDice(self.melee).."(melee)"
	end

	if self.ranged then
		name = name..self:getDice(self.ranged).."(ranged "..self.ranged.range..")"
	end

	if self.capacity then
		name = name..self:getCapacity()
	end

	return name
end

--- Gets the full desc of the object
function _M:getDesc()
	local info = self:getName(t)
	if self.desc then
		info = info.."\n\n"..self.desc
	end
	if self.ranged then
		info = info.."\n\nRanged Attack:"
		info = info.."\n  Damage: "..self:getDice(self.ranged)
		info = info.."\n  Range: "..self.ranged.range
		if self.ranged.radius then
			info = info.."\n  Range: "..self.ranged.radius
		end
		if self.ranged.damage_type then
			info = info.."\n  Damage Type: "..self:getDamageType(self.ranged.damage_type)
		end
	end
	if self.melee then
		info = info.."\n\nMelee Attack:"
		info = info.."\n  Damage:"..self:getDice(self.melee)
		if self.melee.damage_type then
			info = info.."\n  Damage Type:  "..self:getDamageType(self.ranged.damage_type)
		end
	end
	if self.wielder then
		if self.wielder.defense then
			info = info.."\n\nDefense: "..self.wielder.defense
			info = info.."\n\nProf. Defense: "..self.wielder.prof_derense
		end
	end
	return info
end

function _M:tooltip(x, y)
	local str = self:getDesc({do_color=true}, game.player:getInven(self:wornInven()))
	local nb = game.level.map:getObjectTotal(x, y)
	if nb == 2 then str:add(true, "---", true, "You see one more object.")
	elseif nb > 2 then str:add(true, "---", true, "You see "..(nb-1).." more objects.")
	end
	return str
end

function _M:canStack(o)
	return engine.Object.canStack(self, o)
end