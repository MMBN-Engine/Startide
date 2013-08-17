local ActorTalents = require("engine.interface.ActorTalents")

newEntity{ 
	define_as = "NPC_GORILLA",
	type = "hominid", subtype = "gorilla",
	display = "g",
	ai = "dumb_talented_simple", ai_state = { talent_in=1, },
	name = "gorilla", color=colors.WHITE,
	level_range = {1, 20}, exp_worth = 1,
	rarity = 8,
	max_life = resolvers.rngavg(15,18),
	clade = "Hominidae",
	genus = "Gorilla",
	desc = [[A gorilla.]],
	egos = "/data/npcs/egos/hominidae.lua",
	egos_chance = 100,
	resolvers.species()
}