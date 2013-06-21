newChat{ id = "system",
	text = [[Choose region.]],
	answers = {
		{[[Mercury]],},
		{[[Venus]],},
		{[[Mars]]},
		{[[Earth]], jump = "earth"},
		{[[Jupiter]]},
		{[[Saturn]]},
		{[[Uranus]]},
		{[[Neptune]]},
		{[[Cancel]]},
	},
}

newChat{ id = "earth",
	text = [[Choose world.]],
	answers = {
		{[[Earth]],},
		{[[Luna]],},
		{[[Go back]], jump = "system"},
	},
}

return "system"