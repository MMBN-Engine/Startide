require "engine.class"
local Base = require "engine.interface.ActorLevel"

--- Interface to add leveling capabilities to actors
-- Defines the exp property, which is the current experience, level which is the current level and exp_worth which is a multiplier
-- to the monster level default exp
module(..., package.seeall, class.inherit(Base))

function _M:init(t)
	self.exp = t.exp or 0
	self.exp_mod = t.exp_mod or 1
	self.exp_worth = t.exp_worth or 1
	self.level = self.level or 1
	self.start_level = self.start_level or 1

	if not t.level_range or self._actor_level_init then return end

	if t.level_range then
		self.level = 1
		self.start_level = t.level_range[1]
		self.max_level = t.level_range[2]
	else
		self.level = 1
		self.start_level = t.level or 1
	end

	if (self.prefix or self.suffix) and not self.egoed then
		self.level = 0
	end

	self._actor_level_init = true
end
