newChat{ id = "welcome",
	text = [[#LIGHT_GREEN#*A medical machine stands before you*.
#WHITE#How may I be of service?]],
	answers = {
		{[[Heal me.]], action = function(npc, player) 						player.life = player.max_life
				player:useEnergy(game.energy_to_act)
			end,
		},
		{[[Change my implants.]], action = function(npc, player) 
				if player.no_inventory_access then return end
			local d
			d = player:showEquipInven("Inventory", nil, "implant", function(o, inven, item, button, event)
				if not o then return end
				local ud = require("mod.dialogs.UseItem").new(event == "button", player, o, item, inven, "implant", function(_, _, _, stop)
					d:generate()
					d:generateList()
					if stop then game:unregisterDialog(d) end
				end)
				game:registerDialog(ud)
			end)
			end,
		},
		{[[Nevermind.]],},
	},
}

return "welcome"