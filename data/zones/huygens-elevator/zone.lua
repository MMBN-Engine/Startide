return {
	name = "Huygens Elevator",
	level_range = {1, nil},
	max_level = 1,
	--decay = {300, 800},
	width = 50, height = 50,
	level_scheme = "fixed",
	persistent = "zone",
	all_remembered = true,
	all_lited = true,
	elevator = "mars",
	generator =  {
		map = {
			class = "engine.generator.map.Static",
			map = "mars-observation-deck",
		},
		actor = {
			class = "engine.generator.actor.Random",
			nb_npc = {80, 90},
			filters = { {ego_filter = {properties = {"elevator"},},},},
			post_generation = function(e) e.faction = "water-lair" end,
		},
		object = { 
			class = "engine.generator.object.Random", 
			nb_object = {0, 0},
		},
	},
	levels =
	{
	},
}
