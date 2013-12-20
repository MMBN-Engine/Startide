newTalentType{ type="delver", name = "delver", description = "Delver talents" }

newTalent{
	name = "Night Vision",
	type = {"delver", 1},
	points = 1,
	mode = "passive",
	on_learn = function(self, t)
		local eyes = self:getInven("EYES")[1]

		if (not eyes) or (eyes and eyes.natural) then 
			self.infravision = self.infravision + 5
			self.light_sensitive = self.light_sensitive + 1
		end
		
		self.natural_vision.infravision = self.natural_vision.infravision + 5
		self.natural_vision.light_sensitive = self.natural_vision.light_sensitive + 1  
	end,
	on_unlearn = function(self, t)
		local eyes = self:getInven("BODY")[1]

		if (not eyes) or (eyes and eyes.natural) then 
			self.invravision = self.infravision - 5
			self.light_sensitive = self.light_sensitive - 1
		end
		
		self.natural_vision.infravision = self.natural_vision.infravision - 5
		self.natural_vision.light_sensitive = self.natural_vision.light_sensitive - 1  
	end,
	info = function(self, t)
		return [[Increase infravision by +5 and light sensitivity by +1. This only works with your natural eyes.]]
	end,
}

