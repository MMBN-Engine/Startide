local ActorTalents = require("engine.interface.ActorTalents")

newEntity{ 
	define_as = "NPC_GORILLA",
	type = "Terran", subtype = "hominid",
	display = "g",
	ai = "dumb_talented_simple", ai_state = { talent_in=1, },
	name = "human", color=colors.WHITE,
	level_range = {1, 20}, exp_worth = 1,
	stats = {int = 12},
	rarity = 4,
	max_life = resolvers.rngavg(11,14),
	body = { INVEN = 10, MAINHAND = 1, OFFHAND = 1, BODY = 1, HEAD = 1, CLIP = 1, },
	desc = [[A gorilla.]],
	talents = {[ActorTalents.T_BRAWL]=1,},
	resolvers.life()
}