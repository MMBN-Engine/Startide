newEntity{ 
	define_as = "BASE_HELMET", 
	slot = "HEAD", 
	type = "armor", 
	subtype="helmet", 
	display = "]", 
	color=colors.SLATE, 
	rarity = 6,
	encumber = 0,
	egos = "/data/objects/egos/helmets.lua",
	egos_chance = 20,
	name = "a generic helmet",  
} 

newEntity{ 
	base = "BASE_HELMET", 
	name = "miner's helmet", 
	level_range = {1, 10}, 
	cost = 1,  
	wielder = { lite = 4,},
}