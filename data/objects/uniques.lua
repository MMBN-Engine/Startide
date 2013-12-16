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
	rarity = 200,
	encumber = 0,
	--unique = true,
	level_range = {10, 20},
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

newEntity{ 
	define_as = "SLEEPLESS_EYEs", 
	type = "implant", 
	subtype = "eye", 
	display = "-", 
	color = colors.GREEN, 
	name = "sleepless eyes",
	rarity = 150,
	encumber = 0,
	--unique = true,
	level_range = {1, 7},
	use_simple = { 
		name = "power name", 
		use = function(self,who)
			who.infravision = 10
			who.blind_immune = true
			return { used= true, destroy = true, }
		end 
	},
	desc = [[A varient of an old military design, these implant allow for improved night vision and provide defense against blinding.]],
}

newEntity{ 
	base = "BASE_HANDGUN", 
	name = "neuropistol", 
	level_range = {1, 5}, 
	cost = 1,
	color = colors.CADET_BLUE,
	--unique = true, 
	ranged = { num = 2, sides = 4, range = 8 },
	rarity = 150,
	cyber_wielder = {
		ranged_atk = 4,
		ranged_bonus = 2,
	},
	desc = [[An old weapon from an obscure war in the Outer System, it can only be fully utilized by someone with combat implants.]],
}
