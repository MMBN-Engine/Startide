return {
	name = "Old ruins",
	level_range = {1, 4},
	max_level = 10,
	decay = {300, 800},
	width = 50, height = 50,
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
			nb_npc = {20, 30},
		},
		object = { 
			class = "engine.generator.object.Random", 
			nb_object = {20, 30},
		},
	},
	levels =
	{
	},
}
