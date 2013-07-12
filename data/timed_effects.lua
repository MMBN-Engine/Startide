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
	end,}
