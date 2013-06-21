local ActorTalents = require("engine.interface.ActorTalents")

newEntity{ 
	define_as = "NPC_CHIMPANZEE",
	type = "Terran", subtype = "homonid",
	display = "c",
	ai = "dumb_talented_simple", ai_state = { talent_in=1, },
	name = "chimpanzee", color=colors.WHITE,
	level_range = {1, 20}, exp_worth = 1,
	stats = {int = 12},
	rarity = 4,
	body = { INVEN = 10, MAINHAND = 1, OFFHAND = 1, BODY = 1, HEAD = 1, CLIP = 1, },
	max_life = resolvers.rngavg(11,14),
	desc = [[A chimpanzee.]],
	resolvers.life()
}