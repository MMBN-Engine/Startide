local System = require "mod.class.System"

newChat{ id="welcome",
	text = [[#LIGHT_GREEN#Choose destination.]],
	answers = {
		{"My shuttle",
			action = function(npc, player) game:changeLevel(1, "hanger") end
		},
		{"The surface",
			action = function(npc, player) game:changeLevel(1, System:getZone(game.zone.elevator)) end
		},
		{"Leave"},
	}
}

return "welcome"
