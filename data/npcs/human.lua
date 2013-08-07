newEntity{ 
	define_as = "NPC_HUMAN",
	type = "Terran", subtype = "hominid",
	display = "p",
	ai = "dumb_talented_simple", ai_state = { talent_in=1, },
	name = "human", color=colors.WHITE,
	max_life = resolvers.rngavg(11,15),
	level_range = {1, 20}, exp_worth = 1,
	base_rarity = 3,
	rarity = 3,
	clade = "Hominidae",
	genus = "Homo",
	desc = [[A human.]],
	egos = "/data/npcs/egos/hominidae.lua",
	egos_chance = 100,
	resolvers.species()
}

--\198\165
--\225\185\149
--\225\185\151
--\255\181\189
--\234\157\145
--\234\157\147
