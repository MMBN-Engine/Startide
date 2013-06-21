newBirthDescriptor{
	type = "class",
	name = "Soldier",
	desc =
	{
		"Soldiers shoot guns.",
	},
	copy = {
		resolvers.equip{
			{type="weapon", subtype="gun", name="rifle", ego_chance=-1000},
		},
	},
	talents_types = {
		["combat"]={true, 0},
	},
	talents = {
		[ActorTalents.T_LEAP]=1,
	},
}

newBirthDescriptor{
	type = "class",
	name = "Sniper",
	desc =
	{
		"Snipers can shoot from long range.",
	},
	copy = {
		resolvers.equip{
			{type="weapon", subtype="gun", name="rifle", ego_chance=-1000},
		},
	},
	talents_types = {
		["snipe"]={true, 0},
	},
	talents = {
		[ActorTalents.T_SNIPE]=1,
	},

}

newBirthDescriptor{
	type = "classes",
	name = "Grenadier",
	desc =
	{
		"Grenadiers throw grenades.",
	},
	copy = {
		resolvers.equip{
			{type="weapon", subtype="gun", name="pistol", ego_chance=-1000},
			{type="ammo", subtype="grenade", name="grenade", ego_chance=-1000},

		},
	},
	talents = {
	},
}

