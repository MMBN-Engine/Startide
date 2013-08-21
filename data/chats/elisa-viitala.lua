
local function human(npc, player)
	if player and player.subtype == "human" then return true 
	else return false end
end

local function not_human(npc, player)
	if player and player.subtype ~= "human" then return true 	else return false end
end

newChat{ id="welcome",
	text = function(npc, player) 
		if player.subtype == "human" then			
			return [[#LIGHT_GREEN#*You exchange pleasantries*
#WHITE#So what brings you to Mars, traveler?]]
		else
			return [[#LIGHT_GREEN#*She stares at you cooly*
#WHITE#May I help you?]]
		end 
	end,
	answers = {
		--{"I'm looking for work.", jump = "work", },
		{"I'm sightseeing.", jump = "tourist", },
		{"I need to go. Sorry for bothering you."},
	}
}

newChat{ id="work",
	text = function(npc, player) 
		if player.subtype == "human" then							return [[I may be able to help, what kind of work?]]
		else
			return [[What kind of work?]]
		end 
	end,
	answers = {
		{"I used to be a military contractor.", jump = "military",},
		-- Others later?
		{"I need to go. Sorry for bothering you."},
	}
}

newChat{ id="tourist",
	text = function(npc, player) 
		if player.subtype == "human" then							return [[Mars is a beautiful world. I'm a third generation colonist, so I could give you advice on what to see if you wish.]]
		else
			return [[I see.]]
		end 
	end,
	answers = {
		{"I'd like to see some of the Rover Heritage Sites.", jump = "rover", cond = human},
		{"I'm going to visit the Pascale Memorial.", jump = "pascale", cond = human}, 
		{"Thank you, but I'd rather explore on my own.", cond = human},
		{"[Leave]", cond = not_human},
	}
}

newChat{ id="rover",
	text = [[Excelent choice! Personally I'd recommend the Curiosity Museum, but there are many other great sites to explore. There are also many Mars Heritage sites in Huygens City if that interests you.]],
	answers = {
		{"Thank you for the advice, I'll check it out." },
	}
}

newChat{ id="pascale",
	text = [[Just keep in mind that Pascale wasn't as heroic as modern day society would like to think. There's two sides to any coins.]],
	answers = {
		{"What do you mean?", jump = "mean", },
		{"I'll keep that in mind.", },
	}
}

newChat{ id="mean",
	text = [[Her actions directly lead to the strife we are currently experiencing.]],
	answers = {
		{"Her actions? She fought tirelessly for uplift and machine rights. I think I'd best be going.",  },
		{"Yes, history can be subtle. There are unintented consequences to every action." },
	}
}

return "welcome"
