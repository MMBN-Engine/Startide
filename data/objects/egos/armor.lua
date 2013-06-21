local DamageType = require "engine.DamageType"

newEntity{
	name = "insulated ", prefix=true, instant_resolve=true,
	keywords = {bright=true},
	level_range = {1, 20},
	rarity = 15,
	cost = 1,
	wielder = {
		resists = {[DamageType.ELECTRICITY] = resolvers.dice(1,2)},
	},
}

newEntity{
	name = "heated ", prefix=true, instant_resolve=true,
	keywords = {bright=true},
	level_range = {1, 20},
	rarity = 25,
	cost = 1,
	wielder = {
		resists = {[DamageType.COLD] = resolvers.dice(1,2)},
	},
}

newEntity{
	name = "fire-proof ", prefix=true, instant_resolve=true,
	keywords = {bright=true},
	level_range = {1, 20},
	rarity = 15,
	cost = 1,
	wielder = {
		resists = {[DamageType.FIRE] = resolvers.dice(1,2)},
	},
}

newEntity{
	name = "polycarbonate ", prefix=true, instant_resolve=true,
	keywords = {bright=true},
	level_range = {1, 20},
	rarity = 15,
	cost = 1,
	wielder = {
		resists = {[DamageType.ACID] = resolvers.dice(1,2)},
	},
}