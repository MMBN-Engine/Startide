--- Resolves equipment creation for an actor
function resolvers.equip(t)
	return {__resolver="equip", __resolve_last=true, t}
end
--- Actually resolve the equipment creation
function resolvers.calc.equip(t, e)
	print("Equipment resolver for", e.name)
	-- Iterate of object requests, try to create them and equip them
	for i, filter in ipairs(t[1]) do
		print("Equipment resolver", e.name, filter.type, filter.subtype)
		local o
		if not filter.defined then
			o = game.zone:makeEntity(game.level, "object", filter, nil, true)
		else
			o = game.zone:makeEntityByName(game.level, "object", filter.defined)
		end
		if o then
			print("Zone made us an equipment according to filter!", o:getName())

			-- Auto alloc some stats to be able to wear it
			if filter.autoreq and rawget(o, "require") and rawget(o, "require").stat then
				print("Autorequire stats")
				for s, v in pairs(rawget(o, "require").stat) do
					print(s,v)
					if e:getStat(s) < v then
						e.unused_stats = e.unused_stats - (v - e:getStat(s))
						e:incStat(s, v - e:getStat(s))
					end
				end
			end

			e:wearObject(o, true, false)

			-- Do not drop it unless it is an ego or better
			if not o.egoed and not o.unique then o.no_drop = true end
			if filter.force_drop then o.no_drop = nil end
			game.zone:addEntity(game.level, o, "object")

			--if t[1].id then o:identify(t[1].id) end
		end
	end
	-- Delete the origin field
	return nil
end

--- Resolves inventory creation for an actor
function resolvers.inventory(t)
	return {__resolver="inventory", __resolve_last=true, t}
end
--- Actually resolve the inventory creation
function resolvers.calc.inventory(t, e)
	-- Iterate of object requests, try to create them and equip them
	for i, filter in ipairs(t[1]) do
		print("Inventory resolver", e.name, filter.type, filter.subtype)
		local o
		if not filter.defined then
			o = game.zone:makeEntity(game.level, "object", filter, nil, true)
		else
			o = game.zone:makeEntityByName(game.level, "object", filter.defined)
		end
		if o then
			print("Zone made us an inventory according to filter!", o:getName())
			e:addObject(e.INVEN_INVEN, o)
			game.zone:addEntity(game.level, o, "object")

			--if t[1].id then o:identify(t[1].id) end
		end
	end
	e:sortInven()
	-- Delete the origin field
	return nil
end

--- Resolves drops creation for an actor
function resolvers.drops(t)
	return {__resolver="drops", __resolve_last=true, t}
end
--- Actually resolve the drops creation
function resolvers.calc.drops(t, e)
	t = t[1]
	if not rng.percent(t.chance or 100) then return nil end

	-- Iterate of object requests, try to create them and drops them
	for i = 1, (t.nb or 1) do
		local filter = t[rng.range(1, #t)]
		print("Drops resolver", e.name, filter.type, filter.subtype, filter.defined)
		local o
		if not filter.defined then
			o = game.zone:makeEntity(game.level, "object", filter, nil, true)
		else
			o = game.zone:makeEntityByName(game.level, "object", filter.defined)
		end
		if o then
			print("Zone made us an drop according to filter!", o:getName())
			e:addObject(e.INVEN_INVEN, o)
			game.zone:addEntity(game.level, o, "object")

		end
	end
	-- Delete the origin field
	return nil
end

--- Resolves drops creation for an actor
function resolvers.store(def)
	return {__resolver="store", def}
end
--- Actually resolve the drops creation
function resolvers.calc.store(t, e)
	t = t[1]

	e.on_move = function(self, x, y, who)
		if who.player then
			self.store:loadup(game.level, game.zone)
			self.store:interact(who)
		end
	end
	e.store = game:getStore(t)
	print("[STORE] created for entity", t, e, e.name)

	-- Delete the origin field
	return nil
end

--- Resolves chat creation for an actor
function resolvers.chatfeature(def)
	return {__resolver="chatfeature", def}
end
--- Actually resolve the drops creation
function resolvers.calc.chatfeature(t, e)
	t = t[1]

	e.on_move = function(self, x, y, who)
		if who.player then
			local Chat = require("engine.Chat")
			local chat = Chat.new(self.chat, self, who)
			chat:invoke()
		end
	end
	e.chat = t

	-- Delete the origin field
	return nil
end



local class_list = {
	thug = {
		color = colors.BLUE
	},
	goon = {
		color = colors.PURPLE
	},
}

local class_names = {"thug", "goon"}

function resolvers.class_change(t)
	return {__resolver="class_change", t}
end
function resolvers.calc.class_change(t, e)
	--local c = rng.table(t[1])
	
	local class = rng.table(class_names)
	local c = class_list[class].color

	e.color_r = c.r
	e.color_g = c.g
	e.color_b = c.b

	e.name = e.name.." "..class
end

function resolvers.ammo()
	return {__resolver="ammo", __resolve_last=true}
end
function resolvers.calc.ammo(t, e)
	e.capacity = math.floor(e.capacity)
	e.remaining = e.capacity
	return nil
end

local apply = function(descriptors, e) 
	local stats, inc_stats = {}, {}
	e.rarity = e.base_rarity	

	for i, d in ipairs(descriptors) do
		
		if d.copy then
			local copy = table.clone(d.copy, true)
			-- Append array part
			while #copy > 0 do
				local f = table.remove(copy)
				table.insert(e, f)
			end
			-- Copy normal data
			table.merge(e, copy, true)
		end
		if d.copy_add then
			local copy = table.clone(d.copy_add, true)
			-- Append array part
			while #copy > 0 do
				local f = table.remove(copy)
				table.insert(e, f)
			end
			-- Copy normal data
			table.mergeAdd(e, copy, true)
		end
		-- Change stats
		if d.stats then
			for stat, inc in pairs(d.stats) do
				stats[stat] = (stats[stat] or 0) + inc
			end
		end
		if d.inc_stats then
			for stat, inc in pairs(d.inc_stats) do
				inc_stats[stat] = (inc_stats[stat] or 0) + inc
			end
		end
		if d.talents_types then
			local tt = d.talents_types
			if type(tt) == "function" then tt = tt(self) end
			for t, v in pairs(tt) do
				local mastery
				if type(v) == "table" then
					v, mastery = v[1], v[2]
				else
					v, mastery = v, 0
				end
				e:learnTalentType(t, v)
				e.talents_types_mastery[t] = (e.talents_types_mastery[t] or 0) + mastery
			end
		end
		if d.talents then
			for tid, lev in pairs(d.talents) do
				for i = 1, lev do
					e:learnTalent(tid, true)
				end
			end
		end
		if d.body then
			e.body = d.body
			e:initBody()
		end
		if d.rarity then e.rarity = e.rarity + d.rarity end
		if d.type == "class" then
			e.name = e.name.." "..d.name
			e.color_r = d.color.r
			e.color_g = d.color.g
			e.color_b = d.color.b
		end
	end

	-- Apply stats now to not be overridden by other things
	for stat, inc in pairs(stats) do
		e:incStat(stat, inc)
	end
	for stat, inc in pairs(inc_stats) do
		e:incIncStat(stat, inc)
	end
end

-- Applys class to NPCs. Will change to egos if I can figure out how.
function resolvers.class()
	return {__resolver="class", __resolve_last=true}
end
function resolvers.calc.class(t, e)
	local Birther = require("engine.Birther")
	local class = {}

	local class_list = Birther.birth_descriptor_def.class

	while true do
		class = rng.table(class_list)
		if rng.chance(class.rarity) then break end
	end

	e = apply({class}, e)
	return e
end


function resolvers.species()
	return {__resolver="species", __resolve_last=true}
end
function resolvers.calc.species(t, e)
	local Birther = require("engine.Birther")
	--local species_name = e.name

	--if e.prefix then species_name = species_name:gsub("%U+%s+", "")  end
	--if e.suffix then species_name = species_name:gsub("%s+%U+", "")  end
	species_name = e.subtype:gsub("^%l", string.upper)
 
	local species = Birther.birth_descriptor_def.species[species_name]
	local clade = Birther.birth_descriptor_def.clade[e.clade]
	--local genus = Birther.birth_descriptor_def.genus[e.genus]

	e = apply({species, clade}, e)
	return e
end

function resolvers.color()
	return {__resolver="color",__resolve_last=true}
end
function resolvers.calc.color(t, e)
	e.color_r = rng.range(100,255)
	e.color_g = rng.range(100,255)
	e.color_b = rng.range(100,255)
	
	return nill
end