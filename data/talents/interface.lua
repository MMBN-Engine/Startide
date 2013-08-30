newTalentType{ type="combat interface", name = "interface", description = "Interface with weapons" }

newTalent{
	name = "Combat Interface",
	type = {"combat interface", 1},
	points = 1,
	mode = "passive",
	on_learn = function(self, t)
		self:incStat(stat.STAT_INT, 1)
		self:addSlot("COMBAT_SOFTWARE", 2)
	end,
	on_unlearn = function(self, t)
		self:incStat(stat.STAT_INT, -1)
		self:addSlot("COMBAT_SOFTWARE", -2)
	end,
	info = function(self, t)
		return [[Increases intelligence by 1 and gives two combat program slots.]]
	end,
}

newTalent{
	name = "Improved Combat Interface",
	type = {"combat interface", 2},
	points = 1,
	mode = "passive",
	on_learn = function(self, t)
		self:addSlot("COMBAT_SOFTWARE", 1)
	end,
	on_unlearn = function(self, t)
		self:addSlot("COMBAT_SOFTWARE", -1)
	end,
	info = function(self, t)
		return [[You improve your combat algorithms, allow the use of an aditional combat program.]]
	end,
}

newTalent{
	name = "Advanced Combat Interface",
	type = {"combat interface", 3},
	points = 1,
	mode = "passive",
	on_learn = function(self, t)
		self:addSlot("COMBAT_SOFTWARE", 1)
	end,
	on_unlearn = function(self, t)
		self:addSlot("COMBAT_SOFTWARE", -1)
	end,
	info = function(self, t)
		return [[You improve your combat algorithms, allow the use of an aditional combat program.]]
	end,
}