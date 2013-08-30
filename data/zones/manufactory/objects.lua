load("/data/objects/junk.lua")
load("/data/objects/all.lua")

newEntity{ 
	define_as = "OBJ_MACHINE_INTERFACE", 
	name = "machine interface", 
	level_range = {1, 10},
	type = "implant",
	subtype = "cybernetic",
	display = "-",
	encumber = 0, 
	cost = 1,
	color = colors.LIGHT_BLUE,
	use_simple = { 
		name = "power name", 
		use = function(self,who)
			who:learnTalentType("interface", true)
			who:learnTalent(self.T_COMBAT_INTERFACE, true, 1)
			return { used= true, destroy = true, }
		end 
	},
}
