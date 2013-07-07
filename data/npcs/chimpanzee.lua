local ActorTalents = require("engine.interface.ActorTalents")

newEntity{ 
	define_as = "NPC_CHIMPANZEE",
	type = "Terran", subtype = "homonid",
	display = "c",
	ai = "dumb_talented_simple", ai_state = { talent_in=1, },
	name = "chimpanzee", color=colors.WHITE,
	level_range = {1, 20}, exp_worth = 1,
	base_rarity = 5,
	clade = "Hominidae",
	genus = "Pan",
	max_life = resolvers.rngavg(11,14),
	desc = [[A chimpanzee.]],
	resolvers.life()
}