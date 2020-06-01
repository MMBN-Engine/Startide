newEntity{ 
	define_as = "BASE_MEDIUM", 
	type = "consumable", 
	subtype="stimulant", 
	display = "!", 
	color=colors.GREY, 
	rarity = 5,
	name = "a generic stimulant",
}

newEntity{ 
	base = "BASE_MEDIUM", 
	name = "stamina stimulant", 
	level_range = {1, 10}, 
	cost = 1,
	color = colors.RED,
	use_simple = { name = "heal",
		use = function(self, who)
			who:heal(15 + who:conMod())
			return { used= true, destroy = true, }
		end
	},
}