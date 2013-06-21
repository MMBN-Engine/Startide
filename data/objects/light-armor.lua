newEntity{ 
	define_as = "BASE_LIGHT", 
	slot = "OFFHAND", 
	type = "armor", 
	subtype="light", 
	display = "[", 
	color=colors.UMBER, 
	rarity = 5,
	encumber = 0,
	name = "a generic armor",
	egos = "/data/objects/egos/light-armor.lua",
	egos_chance = 20,
} 

newEntity{ 
	base = "BASE_LIGHT", 
	name = "leather jacket", 
	level_range = {1, 10}, 
	cost = 1, 
	wielder = {
		defense = 1,
		prof_defense = 1,
	}, 
}