newChat{ id="welcome",
	text = [[#LIGHT_GREEN#Choose destination.]],
	answers = {
		{"My shuttle",
			action = function(npc, player) game:registerDialog(require("mod.dialogs.ShuttleControl").new(player)) end
		},
		{"The surface",
			action = function(npc, player) game:changeLevel(1, game.zone.elevator) end
		},
		{"Leave"},
	}
}

return "welcome"
