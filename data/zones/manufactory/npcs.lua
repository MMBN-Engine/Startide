load("/data/npcs/machines.lua")

newEntity{ 
	define_as = "NPC_MANUFACTORY",
	type = "Terran", subtype = "machine",
	display = "x",
	ai = "dumb_talented_simple", ai_state = { talent_in=1, },
	name = "manufactory control", color=colors.VIOLET,
	level_range = {5, nil}, exp_worth = 1,
	size = 5,
	life_rating = 12, fixed_rating = true,
	stats = { str=15, dex=6, int= 3, con = 14 },
	body = {INVEN = 1,},
	max_life = 10,
	melee = {num = 1, sides = 4},
	desc = [[The manufactory control machine.]],
	resolvers.life(),
	resolvers.drops{ chance = 100, nb = 1,
		{type = "implant", subtype = "cybernetic", defined = "OBJ_MACHINE_INTERFACE"} 
	},
	on_die = function(self, who)
		game.player:setQuestStatus("robot-rampage", engine.Quest.COMPLETED, "killed")
	end
}