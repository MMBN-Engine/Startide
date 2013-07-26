newEntity{
	define_as = "GRASS",
	name = "grass", 
	display = '.', color = colors.LIGHT_GREEN, 
	back_color={r=44,g=95,b=43},
}

newEntity{
	define_as = "TREE",
	name = "tree",
	display = '#', color = colors.LIGHT_GREEN, 
	back_color={r=44,g=95,b=43},
	always_remember = true,
	does_block_move = true,
	can_pass = {pass_wall=1},
	block_sight = true,
	air_level = -20,
	dig = "GRASS",
}

newEntity{
	define_as = "FLOWER",
	name = "flower",
	display = ';', color=colors.YELLOW, back_color={r=44,g=95,b=43},
}
