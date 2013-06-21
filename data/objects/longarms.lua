newEntity{ 
	define_as = "BASE_LONGARM", 
	slot = "MAINHAND",
	slot_forbid = "OFFHAND", 
	type = "weapon", 
	subtype="longarm", 
	display = "}", 
	color=colors.DARK_GREY, 
	rarity = 5,
	encumber = 0,
	name = "a generic longarm",
	ammo = "bullets", 
} 

newEntity{ 
	base = "BASE_HANDGUN", 
	name = "carbine", 
	level_range = {1, 10}, 
	cost = 1, 
	ranged = { num = 1, sides = 8, range = 6 }, 
}

newEntity{ 
	base = "BASE_HANDGUN", 
	name = "rifle", 
	level_range = {5, 15}, 
	cost = 1, 
	ranged = { num = 2, sides = 8, range = 6 }, 
}

newEntity{ 
	base = "BASE_HANDGUN", 
	name = "machine gun", 
	level_range = {10, 20}, 
	cost = 1, 
	ranged = { num = 2, sides = 12, range = 6 }, 
}

-- Maybe move these to own type later?
newEntity{ 
	base = "BASE_HANDGUN", 
	name = "shot gun", 
	level_range = {1, 10}, 
	cost = 1, 
	ranged = { num = 3, sides = 4, range = 4 }, 
}

newEntity{ 
	base = "BASE_HANDGUN", 
	name = "sawed off shot gun", 
	level_range = {1, 10}, 
	cost = 1, 
	ranged = { num = 4, sides = 4, range = 3 }, 
}