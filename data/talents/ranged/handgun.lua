newTalentType{ type = "handgun", name = "ranged (handgun)", description = "Handgun weapon talents" }

newTalent{
	name = "Handgun Proficiency",
	type = {"handgun", 1},
	points = 1,
	mode = "passive",
	info = function(self, t)
		return [[You may use handguns without penalty.]]
	end,
}

newTalent{
	name = "Handgun Focus",
	type = {"handgun", 1},
	require = {talent = {Talents.T_HANDGUN_PROFICIENCY}, },
	points = 1,
	mode = "passive",
	info = function(self, t)
		return [[Attacks with handguns have a +1 attack bonus.]]
	end,
}

newTalent{
	name = "Handgun Specialization",
	type = {"handgun", 1},
	require = {level = 4, talent = {Talents.T_HANDGUN_FOCUS}, },
	points = 1,
	mode = "passive",
	info = function(self, t)
		return [[Attacks with handguns do +2 damage.]]
	end,
}

newTalent{
	name = "Greater Handgun Specialization",
	type = {"handgun", 1},
	require = {level = 8, talent = {Talents.T_HANDGUN_SPECIALIZATION}, },
	points = 1,
	mode = "passive",
	info = function(self, t)
		return [[Attacks with handguns do an additional +2 damage.]]
	end,
}

newTalent{
	short_name = "T_HANDGUN_CRITICAL",
	name = "Handgun Improved Critial",
	type = {"handgun", 1},
	require = {level = 8, talent = {Talents.T_HANDGUN_PROFICIENCY}, },
	points = 1,
	mode = "passive",
	info = function(self, t)
		return [[Increase threat range by +1 for handguns.]]
	end,
}