newTalentType{ type="interface", name = "interface", description = "Interface with machines" }

newTalent{
	name = "Machine Interface",
	type = {"interface", 1},
	points = 1,
	mode = "passive",
	on_learn = function(self, t)
		self.inc_stats[self.STAT_INT] = self.inc_stats[self.STAT_INT] + 1
		self:onStatChange(self.STAT_INT, 1)	end,
	on_unlearn = function(self, t)
		self.inc_stats[self.STAT_INT] = self.inc_stats[self.STAT_INT] - 1
		self:onStatChange(self.STAT_INT, -1)
	end,
	info = function(self, t)
		return [[Increases intelligence by 1 and allow interface with machines.]]
	end,
}