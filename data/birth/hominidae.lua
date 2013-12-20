newBirthDescriptor{
	type = "clade",
	name = "Hominidae",
	desc =
	{
	},
	descriptor_choices =
	{
		species =
		{
			__ALL__ = "disallow",
			Human = "allow",
			Delver = function() return profile.mod.allow_build.delver and "allow" or "disallow" end,
			Chimpanzee = "allow",
			Gorilla = "allow",
			Orangutan = function() return profile.mod.allow_build.orangutan and "allow" or "disallow" end,
		},
	},
	copy = {
		type = "hominid",
	},
	body = { INVEN = 10, MAINHAND = 1, OFFHAND = 1, BODY = 1, HEAD = 1, CLIP = 1, },
}

newBirthDescriptor{
	type = "species",
	name = "Human",
	desc =
	{
		"Homo sapiens.",
		"Humans are from the planet Earth.",
		"#GOLD#Stat modifiers:",
		"#LIGHT_BLUE# * +0 Strength, +0 Dexterity",
		"#LIGHT_BLUE# * +2 Intelligence, +0 Constitution",
		"#GOLD#Talents:",
		"#LIGHT_BLUE# * Armor Proficiency (Light)",
	},
	stats = { str=0, dex=0, int = 2, con=0 },
	copy = {
		subtype = "human",
	},
	talents_types = {
		["human"] = {true, 0},
	},
	talents = {
		[ActorTalents.T_LIGHT_PROFICIENCY] = 1,
	},
}

newBirthDescriptor{
	type = "species",
	name = "Delver",
	desc =
	{
		"Homo speluncus.",
		"Originally engineered to work in low light environments by Desantis Space, they eventually developed a freestanding culture of their own.",
		"#GOLD#Stat modifiers:",
		"#LIGHT_BLUE# * +0 Strength, +0 Dexterity",
		"#LIGHT_BLUE# * +2 Intelligence, +0 Constitution",
		"#GOLD#Talents:",
		"#LIGHT_BLUE# * Armor Proficiency (Light)",
		"#GOLD#Special:",
		"#LIGHT_BLUE# * 10 infravision",
		"#LIGHT_BLUE# * Light Sensitive: +1",
	},
	stats = { str=0, dex=0, int = 2, con=0 },
	copy = {
		subtype = "human",
		infravision = 10,
		light_sensive = 1,
	},
	talents_types = {
		["human"] = {true, 0},
		["delver"] = {true, 0},
	},
	talents = {
		[ActorTalents.T_LIGHT_PROFICIENCY] = 1,
	},
}

newBirthDescriptor{
	type = "species",
	name = "Chimpanzee",
	desc =
	{
		"Pan loquens.",
		"Uplifted by humans, chimps are much like their",
		"elder cousins.",
		"#GOLD#Stat modifiers:",
		"#LIGHT_BLUE# * +2 Strength, -2 Dexterity",
		"#LIGHT_BLUE# * +0 Intelligence, +0 Constitution",
		"#GOLD#Talents:",
	},
	stats = { str=2, dex=-2, int = 0, con=0 },
	copy = {
		subtype = "chimpanzee",
	},
	talents_types = {
		--["chimpanzee"] = {true, 0},
	},
	talents = {
	},
}

newBirthDescriptor{
	type = "species",
	name = "Gorilla",
	desc =
	{
		"Gorilla arcis",
		"Gorillas are reknown for their great strength, but face a great deal of social stigma.",
		"#GOLD#Stat modifiers:",
		"#LIGHT_BLUE# * +4 Strength, -3 Dexterity",
		"#LIGHT_BLUE# * -1 Intelligence, +2 Constitution",
		"#GOLD#Talents:",
		"#LIGHT_BLUE# * Brawl",
	},
	stats = { str=4, dex=-3, int = -1, con=2 },
	copy = {
		subtype = "gorilla",
	},
	talents_types = {
		["gorilla"] = {true, 0},
	},
	talents = {
		[ActorTalents.T_BRAWL]=1,
	},
}

newBirthDescriptor{
	type = "species",
	name = "Orangutan",
	desc =
	{
		"#GOLD#Stat modifiers:",
		"#LIGHT_BLUE# * +3 Strength, -2 Dexterity",
		"#LIGHT_BLUE# * +-1 Intelligence, +1 Constitution",
		"#GOLD#Talents:",
	},
	stats = { str=3, dex=-2, int = -1, con=1 },
	copy = {
		subtype = "orangutan",
	},
	talents_types = {
		--["orangutan"] = {true, 0},
	},
	talents = {
	},
}