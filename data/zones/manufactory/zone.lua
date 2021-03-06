return {
	name = "Manufactory",
	level_range = {1, 4},
	max_level = 3,
	--decay = {300, 800},
	width = 50, height = 50,
	type = {ship_floor = 10},
	level_scheme = "fixed",
	actor_adjust_level = function(zone, level, e) return zone.base_level + level.level - 1 + rng.range(-1,2) end,
	persistent = "zone",
	generator =  {
		map = {
			class = "engine.generator.map.Roomer",
			nb_rooms = 10,
			rooms = {"simple", "pilar"},
			lite_room_chance = 100,
			['.'] = "FLOOR",
			['#'] = "WALL",
			up = "UP",
			down = "DOWN",
			door = "DOOR",
		},
		actor = {
			class = "engine.generator.actor.Random",
			nb_npc = {8, 15},
			guardian = "NPC_MANUFACTORY",
		},
		object = { 
			class = "engine.generator.object.Random", 
			nb_object = {20, 30},
		},
	},
	levels =
	{
		[1] = {
			generator = { map = {
				up = "FLOOR",
			}, },
		},
		[3] = {
			generator = { map = {
				force_last_stair = true,
				down = "EXIT",
			}, },
		},
	},
	on_leave = function(lev, old_lev, newzone)
		game.player:resolveSource():setQuestStatus("starter-zones", engine.Quest.COMPLETED, "killed")
	end,

}
