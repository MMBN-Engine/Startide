newBirthDescriptor{
	type = "class",
	name = "thug",
	desc =
	{
		"Thugly.",
	},
	copy = {
	},
	talents_types = {
	},
	copy = {
		resolvers.equip{ id = true, {type = "weapon", subtype = "improvised"} },
	},
	color = colors.BLUE,
	rarity = 2,
	inc_stats = { str = -2, int = -3},
	talents = {
	},
}

newBirthDescriptor{
	type = "class",
	name = "bruiser",
	desc =
	{
		"Bruiserly.",
	},
	copy = {
	},
	talents_types = {
	},
	copy = {
		resolvers.equip{ id = true, {type = "weapon", subtype = "improvised"} },
	},
	color = colors.PURPLE,
	rarity = 4,
	inc_stats = { str = 1 },
	talents = {
		[ActorTalents.T_DEFENSIVE_MARTIAL_ARTS] = 1,
	},
}