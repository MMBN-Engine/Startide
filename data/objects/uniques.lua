local DamageType = require "engine.DamageType"

newEntity{ 
	define_as = "PLASMA_CANNON", 
	slot = "MAINHAND",
	slot_forbid = "OFFHAND", 
	type = "weapon", 
	subtype = "exotic", 
	display = "}", 
	color = colors.ORANGE, 
	name = "plasma cannon",
	rarity = 15,
	encumber = 0,
	unique = true,
	ranged = { 
		num = 1, 
		sides = 3, 
		range = 5, 
		radius = 1,	
		damage_type = DamageType.FIRE,
	},
	max_charge = 8,
	min_charge = 1,
	never_miss = true,
	no_crit = true,
	can_act = true,
	--particle = "plasma",
	charging = false,
	on_wear = function(self, who)
		game.logPlayer(who, "The cannon begins to charge with a slight hum.")
		self.charging = true
	end,
	on_takeoff = function(self, who)
		game.logPlayer(who, "The humming stops.")
		self.ranged.num = 1
		self.charging = false
	end,
	act = function(self)
		self:useEnergy()
		if not self.charging then return end
		if self.ranged.num < self.max_charge then
			self.ranged.num = self.ranged.num + 1
		end
	end,
	desc = [[One of the last remaining weapons from the Resource and Relocation Wars on Old Earth.]],
}