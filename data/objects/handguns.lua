newEntity{ 
	define_as = "BASE_HANDGUN", 
	slot = "MAINHAND", 
	type = "weapon", 
	subtype="handgun", 
	display = "}", 
	color=colors.SLATE, 
	rarity = 5,
	encumber = 0,
	name = "a generic handgun",
	ammo = "bullets", 
} 

newEntity{ 
	base = "BASE_HANDGUN", 
	name = "revolver", 
	level_range = {1, 10}, 
	cost = 1, 
	ranged = { num = 1, sides = 6, range = 4 }, 
}

newEntity{ 
	base = "BASE_HANDGUN", 
	name = "pistol", 
	level_range = {5, 15}, 
	cost = 1, 
	ranged = { num = 2, sides = 6, range = 4 }, 
}

newEntity{ 
	base = "BASE_HANDGUN", 
	name = "machine pistol", 
	level_range = {10, 20}, 
	cost = 1, 
	ranged = { num = 2, sides = 8, range = 4 }, 
}	