newEntity{ 
	define_as = "BASE_SHELL", 
	slot = "SHELL", 
	type = "ammo", 
	subtype="shells", 
	display = "{", 
	color=colors.SLATE, 
	rarity = 10,
	name = "a generic shell",
	resolvers.ammo(),
} 

newEntity{ 
	base = "BASE_SHELL", 
	name = "shells", 
	level_range = {1, 10}, 
	cost = 1,
	capacity = resolvers.rngavg(2, 4),
	egos = "/data/objects/egos/bullets.lua",
	egos_chance = 20,
}