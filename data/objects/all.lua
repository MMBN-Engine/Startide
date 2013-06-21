local loadIfNot = function(f)
	if loaded[f] then return end
	load(f, entity_mod)
end

loadIfNot("/data/objects/bullets.lua")
loadIfNot("/data/objects/cybernetics.lua")
loadIfNot("/data/objects/handguns.lua")
loadIfNot("/data/objects/heavy-armor.lua")
loadIfNot("/data/objects/junk.lua")
loadIfNot("/data/objects/light-armor.lua")
loadIfNot("/data/objects/longarms.lua")
loadIfNot("/data/objects/medium-armor.lua")
loadIfNot("/data/objects/powered-armor.lua")
loadIfNot("/data/objects/stimulants.lua")
loadIfNot("/data/objects/helmets.lua")