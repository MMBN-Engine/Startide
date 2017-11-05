load("/data/talents/interface.lua")
load("/data/talents/gorilla.lua")
load("/data/talents/human.lua")
load("/data/talents/damage-reduction.lua")
load("/data/talents/ranged/ranged.lua")
load("/data/talents/general.lua")
load("/data/talents/hacking.lua")
load("/data/talents/delver.lua")

newTalentType{ type="generic", name = "generic", description = "Generic talents" }

newTalent{
	name = "Shoot",
	type = {"generic", 1},
	points = 1,
	on_pre_use = function(self, t) 
		if not self:hasRangedWeapon() then 
			game.logPlayer(self, "You need to wield a gun to shoot.")
			return false
		 end 

		return true 
	end,
	action = function(self, t)
		self:rangedTarget(target, t)
	end,
	info = function(self, t)
		return "Shoots a gun."
	end,
}