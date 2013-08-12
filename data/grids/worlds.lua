newEntity{
	define_as = "OCEAN",
	type = "floor", subtype = "water",
	name = "ocean",
	display = '~', color=colors.BLUE, 	back_color=colors.DARK_BLUE,
	always_remember = true,
}

newEntity{
	define_as = "SHALLOWS",
	type = "floor", subtype = "water",
	name = "ocean",
	display = '~', color=colors.AQUAMARINE, 	back_color=colors.DARK_BLUE,
	always_remember = true,
}

newEntity{
	define_as = "LAND",
	type = "floor", subtype = "water",
	name = "land",
	display = '.', color = colors.DARK_GREEN, 	back_color=colors.GREEN,
	always_remember = true,
}

newEntity{
	define_as = "CITY", 
	notice = true, 
	change_level=1, 
	display='*', 
	color={r=255, g=255, b=255}, 
	back_color=colors.DARK_GREEN,
}