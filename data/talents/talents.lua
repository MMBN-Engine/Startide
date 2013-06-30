load("/data/talents/interface.lua")
load("/data/talents/gorilla.lua")
load("/data/talents/human.lua")
load("/data/talents/damage-reduction.lua")

newTalentType{ type="generic", name = "generic", description = "Generic talents" }

newTalent{
	name = "Shoot",
	type = {"generic", 1},
	points = 1,
	on_pre_use = function(self, t) 
		if not self:hasRangedWeapon() then 
			game.logPlayer(self, "You need to wield a gun to shoot.")
			return false
		 end 

		return true 
	end,
	action = function(self, t)
		self:rangedTarget(target, t)
	end,
	info = function(self, t)
		return "Shoots a gun."
	end,
}

newTalent{
	name = "Handgun Proficiency",
	type = {"generic", 1},
	points = 1,
	mode = "passive",
	info = function(self, t)
		return [[You may use handguns without penalty.]]
	end,
}

newTalent{
	name = "Handgun Focus",
	type = {"generic", 1},
	require = {talent = {Talents.T_HANDGUN_PROFICIENCY}, },
	points = 1,
	mode = "passive",
	info = function(self, t)
		return [[Attacks with handguns have a +1 attack bonus.]]
	end,
}

newTalent{
	name = "Handgun Specialization",
	type = {"generic", 1},
	require = {level = 4, talent = {Talents.T_HANDGUN_FOCUS}, },
	points = 1,
	mode = "passive",
	info = function(self, t)
		return [[Attacks with handguns do +2 damage.]]
	end,
}

newTalent{
	name = "Longarm Proficiency",
	type = {"generic", 1},
	points = 1,
	mode = "passive",
	info = function(self, t)
		return [[You may use longarms without penalty.]]
	end,
}

newTalent{
	name = "Longarm Focus",
	type = {"generic", 1},
	require = {talent = {Talents.T_LONGARM_PROFICIENCY}, },
	points = 1,
	mode = "passive",
	info = function(self, t)
		return [[Attacks with longarms have a +1 attack bonus.]]
	end,
}

newTalent{
	name = "Longarm Specialization",
	type = {"generic", 1},
	require = {level = 4, talent = {Talents.T_LONGARM_FOCUS}, },
	points = 1,
	mode = "passive",
	info = function(self, t)
		return [[Attacks with longarms do +2 damage.]]
	end,
}

newTalent{
	short_name = "LIGHT_PROFICIENCY",
	name = "Armor Proficiency (Light)",
	type = {"generic", 1},
	mode = "passive",
	points = 1,
	info = function(self, t)
		return [[The equipment bonus of light armor is added to your total.]]
	end,
}

newTalent{
	short_name = "MEDIUM_PROFICIENCY",
	name = "Armor Proficiency (Medium)",
	type = {"generic", 1},
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
	type = {"generic", 1},
	mode = "passive",
	points = 1,
	require = {talent = {Talents.T_MEDIUM_PROFICIENCY}, },
	info = function(self, t)
		return [[The equipment bonus of heavy armor is added to your total.]]
	end,
}

newTalent{
	name = "Brawl",
	type = {"generic", 1},
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
	type = {"generic", 1},
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
	type = {"generic", 1},
	points = 1,
	mode = "passive",
	info = function(self, t)
		return [[Gain +1 on defense rolls against melee attacks.]]
	end,
}

newTalent{
	name = "Far Shot",
	type = {"generic", 1},
	points = 1,
	on_pre_use = function(self, t) 
		if not self:hasRangedWeapon() then 
			game.logPlayer(self, "You require a gun for this talent.") 
			return false
		 end 

		return true 
	end,
	action = function(self, t)
		local tg = {range = self:hasRangedWeapon().ranged.range + 2}
		self:rangedTarget(target, t, tg)
	end,
	info = function(self, t)
		return [[Shoot with ranged weapons, increasing range by +2.]]
	end,
}

newTalent{
	name = "Point Blank Shot",
	type = {"generic", 1},
	points = 1,
	on_pre_use = function(self, t) 
		if not self:hasRangedWeapon() then 
			game.logPlayer(self, "You require a gun for this talent.") 
			return false
		 end 

		return true 
	end,
	action = function(self, t)
		local tg = {range = 2, atk = 1, bonus = 1}
		self:rangedTarget(target, t, tg)
	end,
	info = function(self, t)
		return [[Shoot with ranged weapons at range of 2 with +1 attack and +1 damage.]]
	end,
}
