local ActorTalents = require("engine.interface.ActorTalents")

newEntity{ 
	define_as = "NPC_GORILLA",
	type = "Terran", subtype = "hominid",
	display = "o",
	ai = "dumb_talented_simple", ai_state = { talent_in=1, },
	name = "orangutan", color=colors.WHITE,
	level_range = {1, 20}, exp_worth = 1,
	base_rarity = 8,
	max_life = resolvers.rngavg(13,16),
	clade = "Hominidae",
	genus = "orangutan",
	desc = [[An orangutan.]],
}
