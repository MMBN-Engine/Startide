-- TODO: Needs an implant to wear - implant gives necessary feat
-- Forbid using all other slots
-- Build in ammo?
-- Gives talents?
-- Maybe be a unique?

newEntity{ 
	define_as = "BASE_HEAVY", 
	slot = "BODY", 
	type = "armor", 
	subtype="heavy", 
	display = "[", 
	color=colors.DARK_GREY, 
	rarity = 5,
	encumber = 0,
	name = "a generic armor",
} 	

newEntity{ 
	base = "BASE_HEAVY", 
	name = "special response vest", 
	level_range = {1, 10}, 
	cost = 1, 
	wielder = {
		defense = 3,
		prof_defense = 7,
	}, 
} 