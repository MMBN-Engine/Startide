local DamageType = require "engine.DamageType"

newEntity{
	name = "incendiary ", prefix=true, instant_resolve=true,
	level_range = {1, 20},
	rarity = 15,
	cost = 1,
	project = {
		[DamageType.FIRE] = {num = 1, sides = 6},
	},
}

newEntity{
	name = "explosive ", prefix=true, instant_resolve=true,
	level_range = {1, 20},
	rarity = 15,
	cost = 1,
	burst = {
		[DamageType.FIRE] = {num = 1, sides = 10},
	}
}

newEntity{
	name = "smart ", prefix=true, instant_resolve=true,
	level_range = {1, 20},
	rarity = 15,
	cost = 1,
	wielder = {
		ranged_attack = resolvers.dice(1,4),
	},
}

newEntity{
	name = "hollow-point ", prefix=true, instant_resolve=true,
	level_range = {1, 20},
	rarity = 15,
	cost = 1,
	wielder = {
		ranged_bonus = resolvers.dice(1,2),
	}
}