require "engine.class"
local ActorAI = require "engine.interface.ActorAI"
local Faction = require "engine.Faction"
local Birther = require "engine.Birther"
require "mod.class.Actor"

module(..., package.seeall, class.inherit(mod.class.Actor, engine.interface.ActorAI))

function _M:init(t, no_default)
	mod.class.Actor.init(self, t, no_default)
	ActorAI.init(self, t)
end

function _M:act()
	-- Do basic actor stuff
	if not mod.class.Actor.act(self) then return end

	-- Compute FOV, if needed
	self:computeFOV(self.sight or 20)

	-- Let the AI think .... beware of Shub !
	-- If AI did nothing, use energy anyway
	self:doAI()
	if not self.energy.used then self:useEnergy() end
end

--- Called by ActorLife interface
-- We use it to pass aggression values to the AIs
function _M:onTakeHit(value, src)
	if not self.ai_target.actor and src.targetable then
		self.ai_target.actor = src
	end

	return mod.class.Actor.onTakeHit(self, value, src)
end

function _M:tooltip()
	local str = mod.class.Actor.tooltip(self)
	return str..([[

Target: %s
UID: %d]]):format(
	self.ai_target.actor and self.ai_target.actor.name or "none",
	self.uid)
end

-- Assign class and such to NPCs
-- Idealy would be done with egos, but egos as they are turn NPCs
-- into gods with max stats and boatloads of life, don't know how to fix
function _M:classify()
	return function(e)
		e[#e+1] = resolvers.class()
		--local species_name = e.name:gsub("^%l", string.upper) 
		--local species = Birther.birth_descriptor_def.species[species_name]
		--local clade = Birther.birth_descriptor_def.clade[e.clade]
		--local genus = Birther.birth_descriptor_def.genus[e.genus]

		--local class_list = Birther.birth_descriptor_def.class
		
		--for i, c in ipairs(class_list) do
		--	e[#e+1] = self:apply({clade, species, c}, e)
		--end

	end
end

function _M:apply(descriptors, e)
	local stats, inc_stats = {}, {}
	e.rarity = e.base_rarity	

	for i, d in ipairs(descriptors) do
		
		if d.copy then
			local copy = table.clone(d.copy, true)
			-- Append array part
			while #copy > 0 do
				local f = table.remove(copy)
				table.insert(e, f)
			end
			-- Copy normal data
			table.merge(e, copy, true)
		end
		if d.copy_add then
			local copy = table.clone(d.copy_add, true)
			-- Append array part
			while #copy > 0 do
				local f = table.remove(copy)
				table.insert(e, f)
			end
			-- Copy normal data
			table.mergeAdd(e, copy, true)
		end
		-- Change stats
		if d.stats then
			for stat, inc in pairs(d.stats) do
				stats[stat] = (stats[stat] or 0) + inc
			end
		end
		if d.inc_stats then
			for stat, inc in pairs(d.inc_stats) do
				inc_stats[stat] = (inc_stats[stat] or 0) + inc
			end
		end
		if d.talents_types then
			local tt = d.talents_types
			if type(tt) == "function" then tt = tt(self) end
			for t, v in pairs(tt) do
				local mastery
				if type(v) == "table" then
					v, mastery = v[1], v[2]
				else
					v, mastery = v, 0
				end
				e:learnTalentType(t, v)
				e.talents_types_mastery[t] = (e.talents_types_mastery[t] or 0) + mastery
			end
		end
		if d.talents then
			for tid, lev in pairs(d.talents) do
				for i = 1, lev do
					e:learnTalent(tid, true)
				end
			end
		end
		if d.body then
			e.body = d.body
			e:initBody()
		end
		if d.rarity then e.rarity = e.rarity + d.rarity end
		if d.type == "class" then
			e.name = e.name.." "..d.name
			e.color_r = d.color.r
			e.color_g = d.color.g
			e.color_b = d.color.b
		end
	end

	-- Apply stats now to not be overridden by other things
	for stat, inc in pairs(stats) do
		e:incStat(stat, inc)
	end
	for stat, inc in pairs(inc_stats) do
		e:incIncStat(stat, inc)
	end
end