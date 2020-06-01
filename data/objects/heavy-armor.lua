newEntity{ 
	define_as = "BASE_HEAVY", 
	slot = "BODY", 
	type = "armor", 
	subtype="heavy", 
	require = { size = 3,},
	display = "[", 
	color=colors.DARK_GREY, 
	rarity = 12,
	egos = "/data/objects/egos/heavy-armor.lua",
	egos_chance = 20,
	name = "a generic armor",
} 	

newEntity{ 
	base = "BASE_HEAVY", 
	name = "special response vest", 
	level_range = {1, 10}, 
	cost = 1, 
	wielder = {
		defense = 3,
		prof_defense = 3,
	}, 
} 