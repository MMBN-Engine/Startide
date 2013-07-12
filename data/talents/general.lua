newTalentType{ type="general", name = "general", description = "general talents" }

newTalent{
	short_name = "LIGHT_PROFICIENCY",
	name = "Armor Proficiency (Light)",
	type = {"general", 1},
	mode = "passive",
	points = 1,
	info = function(self, t)
		return [[The equipment bonus of light armor is added to your total.]]
	end,
}

newTalent{
	short_name = "MEDIUM_PROFICIENCY",
	name = "Armor Proficiency (Medium)",
	type = {"general", 1},
	mode = "passive",
	points = 1,
	require = {talent = {Talents.T_LIGHT_PROFICIENCY}, },
	info = function(self, t)
		return [[The equipment bonus of medium armor is added to your total.]]
	end,
}

newTalent{
	short_name = "HEAVY_PROFICIENCY",
	name = "Armor Proficiency (Heavy)",
	type = {"general", 1},
	mode = "passive",
	points = 1,
	require = {talent = {Talents.T_MEDIUM_PROFICIENCY}, },
	info = function(self, t)
		return [[The equipment bonus of heavy armor is added to your total.]]
	end,
}

newTalent{
	name = "Brawl",
	type = {"general", 1},
	points = 1,
	mode = "passive",
	on_learn = function(self, t)
		self.melee.sides = self.melee.sides + 3
	end,
	on_unlearn = function(self, t)
		self.melee.sides = self.melee.sides - 3
	end,
	info = function(self, t)
		return [[Gain +1 on unarmed attack rolls. Unarmed attacks also do 1d6 dam + strength mod.]]
	end,
}

newTalent{
	name = "Improved Brawl",
	type = {"general", 1},
	points = 1,
	mode = "passive",
	require = {level = 4, talent = {Talents.T_BRAWL}, },
	on_learn = function(self, t)
		self.melee.sides = self.melee.sides + 2
	end,
	on_unlearn = function(self, t)
		self.melee.sides = self.melee.sides - 2
	end,
	info = function(self, t)
		return [[Gain +2 on unarmed attack rolls. Unarmed attacks also do 1d8 dam + strength mod.]]
	end,
}

newTalent{
	name = "Defensive Martial Arts",
	type = {"general", 1},
	points = 1,
	mode = "passive",
	info = function(self, t)
		return [[Gain +1 on defense rolls against melee attacks.]]
	end,
}

newTalent{
	name = "Lightning Reflexes",
	type = {"general", 1},
	points = 1,
	mode = "passive",
	require = {level = 4, talent = {Talents.T_BRAWL}, },
	on_learn = function(self, t)
		self.saves.reflex = self.saves.reflex + 2
	end,
	on_unlearn = function(self, t)
		self.saves.reflex = self.saves.reflex - 2
	end,
	info = function(self, t)
		return [[Increase reflex saves by +2.]]
	end,
}
