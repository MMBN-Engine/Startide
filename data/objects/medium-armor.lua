newEntity{ 
	define_as = "BASE_MEDIUM", 
	slot = "BODY", 
	type = "armor", 
	subtype="medium",
	require = { size = 3,},
	display = "[", 
	color=colors.GREY, 
	rarity = 5,
	encumber = 0,
	name = "a generic armor",
	egos = "data/objects/egos/medium-armor.lua",
	egos_chance = 20,
}

newEntity{ 
	base = "BASE_MEDIUM", 
	name = "tactical vest", 
	level_range = {1, 10}, 
	cost = 1, 
	wielder = {
		defense = 2,
		prof_defense = 4,
	}, 
} 