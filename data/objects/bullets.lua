newEntity{ 
	define_as = "BASE_BULLET", 
	slot = "CLIP", 
	type = "ammo", 
	subtype="bullets", 
	display = "{", 
	color=colors.SLATE, 
	rarity = 5,
	encumber = 0,
	name = "bullets",
	resolvers.ammo(),
} 

newEntity{ 
	base = "BASE_BULLET", 
	name = "small clip", 
	level_range = {1, 10}, 
	cost = 1,
	capacity = resolvers.rngavg(5, 12),
}