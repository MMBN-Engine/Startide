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

--This is here because NPCs were generating with non-integer
--life and not at maxlife. It there's a less clunky way to fix
--it I'll remove this
function resolvers.life()
	return {__resolver="life", __resolve_last=true}
end
function resolvers.calc.life(t, e)
	e.max_life = math.floor(e.max_life)
	e.life = e.max_life
	return nil
end

function resolvers.ammo()
	return {__resolver="ammo", __resolve_last=true}
end
function resolvers.calc.ammo(t, e)
	e.capacity = math.floor(e.capacity)
	e.remaining = e.capacity
	return nil
end