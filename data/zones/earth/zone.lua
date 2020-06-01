return {
	name = "Earth",
	level_range = {1, nil},
	max_level = 1,
	--decay = {300, 800},
	width = 481, height = 241,
	level_scheme = "fixed",
	persistent = "zone",
	all_remembered = true,
	all_lited = true,
	type = {world = true, system= "Earth"},
	generator =  {
		map = {
			class = "engine.generator.map.Static",
			map = "worlds/earth",
		},
		actor = {
			class = "engine.generator.actor.Random",
			nb_npc = {0, 0},
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
