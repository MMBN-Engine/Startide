load("/data/npcs/human.lua")
load("/data/npcs/chimpanzee.lua")
load("/data/npcs/gorilla.lua")

newEntity{ 
	define_as = "ELISA_VIITALA",
	type = "hominid", subtype = "human", unique = true,
	display = "p",
	ai = "dumb_talented_simple", ai_state = { talent_in=1, },
	name = "Elisa_Viitala", color=colors.VIOLET,
	max_life = 14, fixed_rating = true,
	level_range = {6, nil}, exp_worth = 1,
	clade = "Hominidae",
	genus = "Homo",
	faction = "neutral",
	can_talk = "elisa-viitala",
	desc = [[A tall woman with obvious cybernetics. She looks weary as if from a life of violence.]],
	resolvers.species()
}