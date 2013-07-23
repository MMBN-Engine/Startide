local Stats = require "engine.interface.ActorStats"

newEffect{
	name = "DEFENSE",
	desc = "Lowered defense",
	type = "physical",
	status = "detrimental",
	parameters = { power=1 },
	activate = function(self, eff)
		eff.tmpid = self:addTemporaryValue("defense", eff.power)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("defense", eff.tmpid)
	end,
}

newEffect{
	name = "HACKED",
	desc = "Hacked",
	type = "mental",
	status = "detrimental",
	decrease = 0,
	parameters = { dam = 2, DC_ongoing = 18 },
	on_gain = function(self, err) return "#Target# has been hacked!.", "+Hacked" end,
	on_lose = function(self, err) return "#Target# is no longer hacked.", "-Hacked" end,
	activate = function(self, eff)
		eff.intid = self:addTemporaryValue("inc_stats", {[Stats.STAT_INT]=-eff.dam})
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("inc_stats", eff.intid)
	end,
}

newEffect{
	name = "HACKRESIST",
	desc = "Hack resist",
	type = "mental",
	status = "detrimental",
	parameters = { power=1 },
	on_merge = function(self, old_eff, new_eff)
		-- Merge the mana
		new_eff.DC = new_eff.DC + old_eff.DC
		
		return new_eff
	end,
}
