newEntity{ 
	define_as = "BASE_JUNK", 
	slot = "MAINHAND", 
	type = "weapon", 
	subtype="improvised", 
	display = "/", 
	color=colors.SLATE, 
	rarity = 5,
	name = "a generic weapon",  
} 

newEntity{ 
	base = "BASE_JUNK", 
	name = "crowbar", 
	level_range = {1, 10}, 
	cost = 1, 
	melee = { num = 1, sides = 8 }, 
}

newEntity{
	base = "BASE_JUNK",
	name = "pipe",
	level_range = {1, 10},
	cost = 1,
	melee = { num = 2, sides = 4}
}

newEntity{
	base = "BASE_JUNK",
	name = "wrench",
	level_range = {1, 10},
	cost = 1,
	melee = { num = 1, sides = 3, bonus = 3}
}