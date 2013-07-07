local DamageType = require "engine.DamageType"

newBirthDescriptor{
	type = "base",
	name = "base",
	desc = {
	},
	experience = 1.0, 
	copy = {
		max_level = 20,
		--lite = 4,
		max_life = 25,
		--ranged = {num = 1, sides = 6, range = 4},
		--resists = { [DamageType.PHYSICAL] = 25, },
		resolvers.inventory{ id=true,
			{type = "consumable", subtype = "stimulant", name = "stamina stimulant"},
			{type = "consumable", subtype = "stimulant", name = "stamina stimulant"},
			{type = "consumable", subtype = "stimulant", name = "stamina stimulant"},
		},
		resolvers.equip{ id = true, {type = "armor", subtype = "helmet", name = "miner's helmet"} },
		resolvers.life(),
		starting_zone = "manufactory",
		starting_quest = "robot-rampage",
		starting_intro = "main",
	},
	descriptor_choices =
	{
		clade =
		{
			__ALL__ = "allow",
		},
	},
	talents_types = {
		["generic"] = {true, 0},
		["damage-reduction"] = {true, 0},
	},
	talents = {
		--[ActorTalents.T_THROW_GRENADE]=1,
		[ActorTalents.T_SHOOT]=1,
	},
}

load("/data/birth/hominidae.lua")
load("/data/birth/classes.lua")