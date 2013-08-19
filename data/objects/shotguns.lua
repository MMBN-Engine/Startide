newEntity{ 
	define_as = "BASE_SHOTGUN", 
	slot = "MAINHAND",
	slot_forbid = "OFFHAND", 
	type = "weapon", 
	subtype="shotgun", 
	display = "}", 
	color=colors.DARK_GREY, 
	rarity = 8,
	encumber = 0,
	egos = "/data/objects/egos/handguns.lua",
	egos_chance = 20,
	name = "a generic longarm",
	ammo = "shells", 
} 

newEntity{ 
	base = "BASE_SHOTGUN", 
	name = "shotgun", 
	level_range = {1, 10}, 
	cost = 1, 
	ranged = { num = 3, sides = 4, range = 4 }, 
}

newEntity{ 
	base = "BASE_SHOTGUN", 
	name = "sawed-off shotgun", 
	level_range = {1, 10}, 
	cost = 1, 
	ranged = { num = 4, sides = 4, range = 3 }, 
}