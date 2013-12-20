newTalentType{ type="delver", name = "delver", description = "Delver talents" }

newTalent{
	name = "Night Vision",
	type = {"human", 1},
	points = 1,
	mode = "passive",
	on_learn = function(self, t)
		self.invravision = self.infravision + 5
		self.light_sensitive = self.light_sensitive + 1 
	end,
	on_unlearn = function(self, t)
		self.invravision = self.infravision - 5
		self.light_sensitive = self.light_sensitive - 1
	end,
	info = function(self, t)
		return [[Increase infravision by +5 and light sensitivity by +1.]]
	end,
}

