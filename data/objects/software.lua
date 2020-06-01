newEntity{ 
	define_as = "BASE_SOFTARE", 
	slot = "COMBAT_SOFTWARE", 
	type = "software", 
	subtype="combat", 
	display = "?", 
	color=colors.WHITE, 
	rarity = 10,
	name = "a generic program",
} 

newEntity{ 
	base = "BASE_SOFTWARE", 
	name = "long-range combat protocols", 
	level_range = {1, 20}, 
	cost = 1,
	weilder = {
		ranged_atk = resolvers.dice(1,4),
		ranged_bonus = dice(1,2),
	}
}

newEntity{ 
	base = "BASE_SOFTWARE", 
	name = "anatomy analysis protocols", 
	level_range = {1, 20}, 
	cost = 1,
	weilder = {
		crit = 1,
	}
}