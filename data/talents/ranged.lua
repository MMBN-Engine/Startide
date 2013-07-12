newTalentType{ type = "ranged", name = "ranged", description = "Ranged weapon talents" }

newTalent{
	name = "Handgun Proficiency",
	type = {"ranged", 1},
	points = 1,
	mode = "passive",
	info = function(self, t)
		return [[You may use handguns without penalty.]]
	end,
}

newTalent{
	name = "Handgun Focus",
	type = {"ranged", 1},
	require = {talent = {Talents.T_HANDGUN_PROFICIENCY}, },
	points = 1,
	mode = "passive",
	info = function(self, t)
		return [[Attacks with handguns have a +1 attack bonus.]]
	end,
}

newTalent{
	name = "Handgun Specialization",
	type = {"ranged", 1},
	require = {level = 4, talent = {Talents.T_HANDGUN_FOCUS}, },
	points = 1,
	mode = "passive",
	info = function(self, t)
		return [[Attacks with handguns do +2 damage.]]
	end,
}

newTalent{
	name = "Greater Handgun Specialization",
	type = {"ranged", 1},
	require = {level = 8, talent = {Talents.T_HANDGUN_SPECIALIZATION}, },
	points = 1,
	mode = "passive",
	info = function(self, t)
		return [[Attacks with handguns do an additional +2 damage.]]
	end,
}

newTalent{
	short_name = "T_HANDGUN_CRITICAL",
	name = "Improved Critial (Handgun)",
	name = "Handgun Improved Critial",
	type = {"ranged", 1},
	require = {level = 8, talent = {Talents.T_HANDGUN_PROFICIENCY}, },
	points = 1,
	mode = "passive",
	info = function(self, t)
		return [[Increase threat range by +1 for handguns.]]
	end,
}

newTalent{
	name = "Longarm Proficiency",
	type = {"ranged", 1},
	points = 1,
	mode = "passive",
	info = function(self, t)
		return [[You may use longarms without penalty.]]
	end,
}

newTalent{
	name = "Longarm Focus",
	type = {"ranged", 1},
	require = {talent = {Talents.T_LONGARM_PROFICIENCY}, },
	points = 1,
	mode = "passive",
	info = function(self, t)
		return [[Attacks with longarms have a +1 attack bonus.]]
	end,
}

newTalent{
	name = "Longarm Specialization",
	type = {"ranged", 1},
	require = {level = 4, talent = {Talents.T_LONGARM_FOCUS}, },
	points = 1,
	mode = "passive",
	info = function(self, t)
		return [[Attacks with longarms do +2 damage.]]
	end,
}

newTalent{
	short_name = "T_LONGARM_CRITICAL",
	name = "Improved Critial (Longarm)",
	type = {"ranged", 1},
	require = {level = 8, talent = {Talents.T_LONGARM_PROFICIENCY}, },
	points = 1,
	mode = "passive",
	info = function(self, t)
		return [[Increase threat range by +1 for longarms.]]
	end,
}

newTalent{
	name = "Greater Longarm Specialization",
	type = {"ranged", 1},
	require = {level = 8, talent = {Talents.T_LONGARM_SPECIALIZATION}, },
	points = 1,
	mode = "passive",
	info = function(self, t)
		return [[Attacks with handguns do an additional +2 damage.]]
	end,
}

newTalent{
	name = "Far Shot",
	type = {"ranged", 1},
	points = 1,
	on_pre_use = function(self, t) 
		if not self:hasRangedWeapon() then 
			game.logPlayer(self, "You require a gun for this talent.") 
			return false
		 end 

		return true 
	end,
	action = function(self, t)
		local tg = {range = self:hasRangedWeapon().ranged.range + 2}
		self:rangedTarget(target, t, tg)
	end,
	info = function(self, t)
		return [[Shoot with ranged weapons, increasing range by +2.]]
	end,
}

newTalent{
	name = "Point Blank Shot",
	type = {"ranged", 1},
	points = 1,
	on_pre_use = function(self, t) 
		if not self:hasRangedWeapon() then 
			game.logPlayer(self, "You require a gun for this talent.") 
			return false
		 end 

		return true 
	end,
	action = function(self, t)
		local tg = {range = 2, atk = 1, bonus = 1}
		self:rangedTarget(target, t, tg)
	end,
	info = function(self, t)
		return [[Shoot with ranged weapons at range of 2 with +1 attack and +1 damage.]]
	end,
}

newTalent{
	name = "Sniper Shot",
	type = {"ranged", 1},
	points = 1,
	on_pre_use = function(self, t) 
		if not self:hasRangedWeapon() then 
			game.logPlayer(self, "You require a gun for this talent.") 
			return false
		 end 

		return true 
	end,
	action = function(self, t)
		local tg = {crit = 1}
		self:rangedTarget(target, t, tg)
		self:setEffect(self.EFF_DEFENSE, 1, {power = -5})
	end,
	info = function(self, t)
		return [[Increases critical hit threshold by +1, by reduces defense by -5 for one turn.]]
	end,
}

newTalent{
	name = "Precise Shot",
	type = {"ranged", 1},
	points = 1,
	on_learn = function(self, t)
		self.ranged_bonus = self.ranged_bonus + 1
	end,
	on_unlearn = function(self, t)
		self.ranged_bonus = self.ranged_bonus - 1
	end,
	info = function(self, t)
		return [[Increase damage with ranged weapons by +1.]]
	end,
}
