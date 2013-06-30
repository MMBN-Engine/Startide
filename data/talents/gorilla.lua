newTalentType{ type="gorilla", name = "gorilla", description = "Gorilla talents" }

newTalent{
	name = "Melee Smash",
	type = {"gorilla", 1},
	points = 1,
	mode = "passive",
	on_learn = function(self, t)
		self.melee_bonus = self.melee_bonus + 1
	end,
	on_unlearn = function(self, t)
		self.melee_bonus = self.melee_bonus - 1
	end,
	info = function(self, t)
		return [[Increase melee damage by +1.]]
	end,
}

newTalent{
	name = "Improved Melee Smash",
	type = {"gorilla", 1},
	points = 1,
	mode = "passive",
	require = { talent = { Talents.T_MELEE_SMASH }, },
	on_learn = function(self, t)
		self.melee_bonus = self.melee_bonus + 1
	end,
	on_unlearn = function(self, t)
		self.melee_bonus = self.melee_bonus - 1
	end,
	info = function(self, t)
		return [[Increase melee damage by +1.]]
	end,
}

newTalent{
	name = "Advanced Melee Smash",
	type = {"gorilla", 1},
	points = 1,
	mode = "passive",
	require = { talent = { Talents.T_IMPROVED_MELEE_SMASH }, },
	on_learn = function(self, t)
		self.melee_bonus = self.melee_bonus + 1
	end,
	on_unlearn = function(self, t)
		self.melee_bonus = self.melee_bonus - 1
	end,
	info = function(self, t)
		return [[Increase melee damage by +1.]]
	end,
}