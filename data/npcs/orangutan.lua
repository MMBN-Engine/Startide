local ActorTalents = require("engine.interface.ActorTalents")

newEntity{ 
	define_as = "NPC_ORANGUTAN",
	type = "hominid", subtype = "orangutan",
	display = "o",
	ai = "dumb_talented_simple", ai_state = { talent_in=1, },
	name = "orangutan", color=colors.WHITE,
	level_range = {1, 20}, exp_worth = 1,
	rarity = 8,
	max_life = resolvers.rngavg(13,16),
	clade = "Hominidae",
	genus = "orangutan",
	desc = [[An orangutan.]],
	egos = "/data/npcs/egos/hominidae.lua",
	egos_chance = 100,
	resolvers.species()
}
