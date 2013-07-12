local DamageType = require "engine.DamageType"

newEntity{
	name = "precise ", prefix=true, instant_resolve=true,
	keywords = {bright=true},
	level_range = {1, 20},
	rarity = 15,
	cost = 1,
	ranged = {
		bonus = resolvers.dice(1,2),
	},
}

newEntity{
	name = "sighted ", prefix=true, instant_resolve=true,
	keywords = {bright=true},
	level_range = {1, 20},
	rarity = 25,
	cost = 1,
	wielder = {
		ranged_attack = resolvers.dice(1,4),
	},
}

newEntity{
	name = " with LED", suffix=true, instant_resolve=true,
	keywords = {bright=true},
	level_range = {1, 20},
	rarity = 15,
	cost = 1,
	wielder = {
		lite = resolvers.dice(1,2),
	},
}