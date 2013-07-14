-- The basic stuff used to damage a grid
setDefaultProjector(function(src, x, y, type, dam)
	local target = game.level.map(x, y, Map.ACTOR)
	if target then
		local flash = game.flash.NEUTRAL
		if target == game.player then flash = game.flash.BAD end
		if src == game.player then flash = game.flash.GOOD end

		if target.resists then
			local res = (target.resists[type] or 0) + (target.resists.all or 0)
				
			-- energy attacks can be completely negated
			if DamageType:get(type).energy then 
				dam = math.max(dam - res, 0)
			else
				dam = math.max(dam - res, 1)
			end
		end

		game.logSeen(target, flash, "%s hits %s for %s%0.2f %s damage#LAST#.", src.name:capitalize(), target.name, DamageType:get(type).text_color or "#aaaaaa#", dam, DamageType:get(type).name)
		local sx, sy = game.level.map:getTileToScreen(x, y)
		if target:takeHit(dam, src) then
			if src == game.player or target == game.player then
				game.flyers:add(sx, sy, 30, (rng.range(0,2)-1) * 0.5, -3, "Kill!", {255,0,255})
			end
		else
			if src == game.player then
				game.flyers:add(sx, sy, 30, (rng.range(0,2)-1) * 0.5, -3, tostring(-math.ceil(dam)), {0,255,0})
			elseif target == game.player then
				game.flyers:add(sx, sy, 30, (rng.range(0,2)-1) * 0.5, -3, tostring(-math.ceil(dam)), {255,0,0})
			end
		end
		return dam
	end
	return 0
end)

newDamageType{
	name = "physical", type = "PHYSICAL", 
}

newDamageType{
	name = "acid", type = "ACID", text_color = "#GREEN#", energy = true,
}

newDamageType{
	name = "cold", type = "COLD", text_color = "#1133F3#", energy = true,
}

newDamageType{
	name = "electricity", type = "ELECTRICITY", text_color = "#ROYAL_BLUE#", energy = true,
}

newDamageType{
	name = "fire", type = "FIRE", text_color = "#LIGHT_RED#", energy = true,
}

newDamageType{
	name = "sonic", type = "SONIC", text_color = "#WHITE#", energy = true,
}