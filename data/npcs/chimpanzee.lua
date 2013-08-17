local ActorTalents = require("engine.interface.ActorTalents")

newEntity{ 
	define_as = "NPC_CHIMPANZEE",
	type = "hominid", subtype = "chimpanzee",
	display = "c",
	ai = "dumb_talented_simple", ai_state = { talent_in=1, },
	name = "chimpanzee", color=colors.WHITE,
	level_range = {1, 20}, exp_worth = 1,
	rarity = 5,
	clade = "Hominidae",
	genus = "Pan",
	max_life = resolvers.rngavg(11,14),
	desc = [[A chimpanzee.]],
	egos = "/data/npcs/egos/hominidae.lua",
	egos_chance = 100,
	resolvers.species()
}