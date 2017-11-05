newTalentType{ type = "longarm", name = "ranged (longarm)", description = "Longarm weapon talents" }

newTalent{
	name = "Longarm Proficiency",
	type = {"longarm", 1},
	points = 1,
	mode = "passive",
	info = function(self, t)
		return [[You may use longarms without penalty.]]
	end,
}

newTalent{
	name = "Longarm Focus",
	type = {"longarm", 1},
	require = {talent = {Talents.T_LONGARM_PROFICIENCY}, },
	points = 1,
	mode = "passive",
	info = function(self, t)
		return [[Attacks with longarms have a +1 attack bonus.]]
	end,
}

newTalent{
	name = "Longarm Specialization",
	type = {"longarm", 1},
	require = {level = 4, talent = {Talents.T_LONGARM_FOCUS}, },
	points = 1,
	mode = "passive",
	info = function(self, t)
		return [[Attacks with longarms do +2 damage.]]
	end,
}

newTalent{
	short_name = "T_LONGARM_CRITICAL",
	name = "Longarm Improved Critial",
	type = {"longarm", 1},
	require = {level = 8, talent = {Talents.T_LONGARM_PROFICIENCY}, },
	points = 1,
	mode = "passive",
	info = function(self, t)
		return [[Increase threat range by +1 for longarms.]]
	end,
}

newTalent{
	name = "Greater Longarm Specialization",
	type = {"longarm", 1},
	require = {level = 8, talent = {Talents.T_LONGARM_SPECIALIZATION}, },
	points = 1,
	mode = "passive",
	info = function(self, t)
		return [[Attacks with longarms do an additional +2 damage.]]
	end,
}