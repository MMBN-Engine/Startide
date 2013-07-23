newTalentType{ type = "hacking", name = "hacking", description = "Hack brains!" }

newTalent{
	name = "Hack",
	type = {"hacking", 1},
	points = 1,
	getTalentRange = function(self, t)
		return 1
	end,
	getTalentDamage = function(self, t)
		local dam = {num = 1, sides = 3}
		return self:damageRoll(dam)
	end,
	getTalentDC = function(self, t)
		return 10 + self:intMod() + self.level
	end,
	action = function(self, t)
		local tg = {type="hit", range = t.getTalentRange(self, t), talent=t} 
		local x, y = self:getTarget(tg) 
		if not x or not y then return nil end 
		self:project(tg, x, y, DamageType.HACK, {dam = t.getTalentDamage(self, t), DC = t.getTalentDC(self, t)})
	end,
	info = function(self, t)
		return ([[Attempts to hack the target with a DC of %d. The target will suffer 1d4 of temporary Intelligence damage and will suffer a -2 defense penalty when you attack it. Failure will result in in -5 to the DC each time.]]):format(t.getTalentDC(self, t))
	end,
}

newTalent{
	name = "Back Hack",
	type = {"hacking", 1},
	mode = "passive",
	points = 1,
	info = function(self, t)
		return [[When you make a save against a hack attempt from any source, you have a chance of hacking your attacker. The hack will have the same DC as the original hack plus a -5 modifier.]]
	end,
}