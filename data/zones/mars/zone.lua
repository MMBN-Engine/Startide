return {
	name = "Mars",
	level_range = {1, nil},
	max_level = 1,
	--decay = {300, 800},
	width = 256, height = 128,
	level_scheme = "fixed",
	persistent = "zone",
	all_remembered = true,
	all_lited = true,
	elevator = "mars",
	generator =  {
		map = {
			class = "engine.generator.map.Static",
			map = "worlds/mars",
		},
		actor = {
		},
		object = { 
		},
	},
	levels =
	{
	},
}
