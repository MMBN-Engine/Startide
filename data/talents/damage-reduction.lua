newTalentType{ type = "damage-reduction", name = "damage-reduction", description = "Reduces damage taken" }

-- Maybe change these to be based on Con mod later?
newTalent{
	name = "Acid Resistance",
	type = {"damage-reduction", 1},
	points = 1,
	mode = "passive",
	on_learn = function(self, t)
		self.resists[DamageType.ACID] = (self.resists[DamageType.ARCANE] or 0) + 2
	end,
	on_unlearn = function(self, t)
		self.resists[DamageType.ARCANE] = (self.resists[DamageType.ARCANE] or 0) - 2
	end,
	info = function(self, t)
		return [[You gain +2 acid resistance.]]
	end,
}

newTalent{
	name = "Cold Resistance",
	type = {"damage-reduction", 1},
	points = 1,
	mode = "passive",
	on_learn = function(self, t)
		self.resists[DamageType.ACID] = (self.resists[DamageType.ARCANE] or 0) + 2
	end,
	on_unlearn = function(self, t)
		self.resists[DamageType.ARCANE] = (self.resists[DamageType.ARCANE] or 0) - 2
	end,
	info = function(self, t)
		return [[You gain +2 cold resistance.]]
	end,
}

newTalent{
	name = "Electricity Resistance",
	type = {"damage-reduction", 1},
	points = 1,
	mode = "passive",
	on_learn = function(self, t)
		self.resists[DamageType.ACID] = (self.resists[DamageType.ARCANE] or 0) + 2
	end,
	on_unlearn = function(self, t)
		self.resists[DamageType.ARCANE] = (self.resists[DamageType.ARCANE] or 0) - 2
	end,
	info = function(self, t)
		return [[You +2 electricity resistance.]]
	end,
}

newTalent{
	name = "Fire Resistance",
	type = {"damage-reduction", 1},
	points = 1,
	mode = "passive",
	on_learn = function(self, t)
		self.resists[DamageType.ACID] = (self.resists[DamageType.FIRE] or 0) + 2
	end,
	on_unlearn = function(self, t)
		self.resists[DamageType.FIRE] = (self.resists[DamageType.FIRE] or 0) - 2
	end,
	info = function(self, t)
		return [[You gain +2 fire resistance.]]
	end,
}

newTalent{
	name = "Sonic Resistance",
	type = {"damage-reduction", 1},
	points = 1,
	mode = "passive",
	on_learn = function(self, t)
		self.resists[DamageType.ACID] = (self.resists[DamageType.SONIC] or 0) + 2
	end,
	on_unlearn = function(self, t)
		self.resists[DamageType.SONIC] = (self.resists[DamageType.SONIC] or 0) - 2
	end,
	info = function(self, t)
		return [[You gain +2 sonic resistance.]]
	end,
}

newTalent{
	name = "Damage Reduction I",
	type = {"damage-reduction", 2},
	points = 1,
	mode = "passive",
	on_learn = function(self, t)
		self.resists.all = (self.resists.all or 0) + 1
	end,
	on_unlearn = function(self, t)
		self.resists.all = (self.resists.all or 0) - 1
	end,
	info = function(self, t)
		return [[Increase damage reduction by +1.]]
	end,
}

newTalent{
	name = "Damage Reduction II",
	type = {"damage-reduction", 2},
	points = 1,
	mode = "passive",
	require = { talent = {Talents.T_DAMAGE_REDUCTION_I }, },
	on_learn = function(self, t)
		self.resists.all = (self.resists.all or 0) + 1
	end,
	on_unlearn = function(self, t)
		self.resists.all = (self.resists.all or 0) - 1
	end,
	info = function(self, t)
		return [[Increase damage reduction by +1.]]
	end,
}

newTalent{
	name = "Damage Reduction III",
	type = {"damage-reduction", 2},
	points = 1,
	mode = "passive",
	require = { talent = {Talents.T_DAMAGE_REDUCTION_II }, },
	on_learn = function(self, t)
		self.resists.all = (self.resists.all or 0) + 1
	end,
	on_unlearn = function(self, t)
		self.resists.all = (self.resists.all or 0) - 1
	end,
	info = function(self, t)
		return [[Increase damage reduction by +1.]]
	end,
}