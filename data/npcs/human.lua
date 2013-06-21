local ActorTalents = require("engine.interface.ActorTalents")

newEntity{ 
	define_as = "NPC_HUMAN",
	type = "Terran", subtype = "hominid",
	display = "p",
	ai = "dumb_talented_simple", ai_state = { talent_in=1, },
	name = "human", color=colors.WHITE,
	max_life = resolvers.rngavg(11,15),
	level_range = {1, 20}, exp_worth = 1,
	stats = {int = 12},
	body = { INVEN = 10, MAINHAND = 1, OFFHAND = 1, BODY = 1, HEAD = 1, CLIP = 1, },
	-- Light armor training
	rarity = 4,
	desc = [[A human.]],
	resolvers.life()
}

--\198\165
--\225\185\149
--\225\185\151
--\255\181\189
--\234\157\145
--\234\157\147
