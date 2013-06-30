newTalentType{ type="human", name = "human", description = "Human talents" }

newTalent{
	name = "Mental Fortitude",
	type = {"human", 1},
	points = 1,
	mode = "passive",
	on_learn = function(self, t)
		self.saves.mental = self.saves.mental + 1
	end,
	on_unlearn = function(self, t)
		self.saves.mental = self.saves.mental - 1
	end,
	info = function(self, t)
		return [[Increase mental save by +1.]]
	end,
}

newTalent{
	name = "Improved Mental Fortitude",
	type = {"human", 1},
	points = 1,
	mode = "passive",
	require = { talent = { Talents.T_MENTAL_FORTITUDE }, },
	on_learn = function(self, t)
		self.saves.mental = self.saves.mental + 1
	end,
	on_unlearn = function(self, t)
		self.saves.mental = self.saves.mental - 1
	end,
	info = function(self, t)
		return [[Increase mental save by +1.]]
	end,
}

newTalent{
	name = "Advanced Mental Fortitude",
	type = {"human", 1},
	points = 1,
	mode = "passive",
	require = { talent = { Talents.T_IMPROVED_MENTAL_FORTITUDE }, },
	on_learn = function(self, t)
		self.saves.mental = self.saves.mental + 1
	end,
	on_unlearn = function(self, t)
		self.saves.mental = self.saves.mental - 1
	end,
	info = function(self, t)
		return [[Increase mental save by +1.]]
	end,
}