newEntity{ 
	define_as = "BASE_BULLET", 
	slot = "CLIP", 
	type = "ammo", 
	subtype="bullets", 
	display = "{", 
	color=colors.SLATE, 
	rarity = 5,
	name = "a generic bullet",
	resolvers.ammo(),
} 

newEntity{ 
	base = "BASE_BULLET", 
	name = "bullets", 
	level_range = {1, 10}, 
	cost = 1,
	capacity = resolvers.rngavg(8, 12),
	egos = "/data/objects/egos/bullets.lua",
	egos_chance = 20,
}