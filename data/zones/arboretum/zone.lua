return {
	name = "Arboretum",
	level_range = {1, 4},
	max_level = 3,
	--decay = {300, 800},
	width = 50, height = 50,
	--type = {ship_floor = 9},
	level_scheme = "fixed",
	actor_adjust_level = function(zone, level, e) return zone.base_level + level.level - 1 + rng.range(-1,2) end,
	persistent = "zone",
	generator =  {
		map = {
			class = "engine.generator.map.Forest",
			edge_entrances = {4,6},
			zoom = 7,
			sqrt_percent = 30,
			sqrt_percent2 = 25,
			floor = function() if rng.chance(20) then return "FLOWER" else return "GRASS" end end,
			wall = "TREE",
			up = "UP",
			down = "DOWN",
			door = "DOOR",
		},
		actor = {
			class = "engine.generator.actor.Random",
			nb_npc = {8, 15},
			--guardian = "",
		},
		object = { 
			class = "engine.generator.object.Random", 
			nb_object = {20, 30},
		},
	},
	levels =
	{
		[3] = {
			generator = { map = {
				down = "EXIT",
			}, },
		},
	},
}
