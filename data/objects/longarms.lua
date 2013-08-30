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
	egos = "/data/objects/egos/handguns.lua",
	egos_chance = 20,
	name = "a generic longarm",
	ammo = "bullets", 
} 

newEntity{ 
	base = "BASE_LONGARM", 
	name = "carbine", 
	level_range = {1, 10}, 
	cost = 1, 
	ranged = { num = 1, sides = 8, range = 6 }, 
}

newEntity{ 
	base = "BASE_LONGARM", 
	name = "rifle", 
	level_range = {5, 15}, 
	cost = 1, 
	ranged = { num = 2, sides = 8, range = 6 }, 
}

newEntity{ 
	base = "BASE_LONGARM", 
	name = "machine gun", 
	level_range = {10, 20}, 
	cost = 1, 
	ranged = { num = 2, sides = 12, range = 6 }, 
}