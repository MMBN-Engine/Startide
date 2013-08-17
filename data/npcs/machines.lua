local ActorTalents = require("engine.interface.ActorTalents")

newEntity{ 
	define_as = "NPC_LOADING_BOT",
	type = "machine", subtype = "machine",
	display = "x",
	ai = "dumb_talented_simple", ai_state = { talent_in=1, },
	name = "loading bot", color=colors.RED,
	level_range = {1, 4}, exp_worth = 1,
	rarity = 4,
	size = 5,
	stats = { str=15, dex=6, int= 3, con = 14 },
	max_life = resolvers.rngavg(5,9),
	life_rating = 5,
	melee = {num = 1, sides = 4},
	desc = [[A machine with large loading forks. It was made for manual work.]],
}

newEntity{
	define_as = "NPC_SECURITY_BOT",
	name = "security bot", color=colors.BLUE,
	type = "machine", subtype = "machine",
	display = "x",
	ai = "dumb_talented_simple", ai_state = { talent_in=1, },
	level_range = {1, 4}, exp_worth = 1,
	rarity = 6,
	size = 3,
	life_rating = 5,
	max_life = resolvers.rngavg(5,9),
	stats = { str=8, dex=12, int= 3, con = 14 },
	ranged = {num = 1, sides = 3, range = 4, no_ammo = true,},
	talents = {
		[ActorTalents.T_SHOOT] = 1,
	}, 
	desc = [[Armed with rubber bullets, it was designed more for crowd control than subduing an individual.]],
}