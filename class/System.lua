-- Defines definitions for sytems, this will group worlds for the hangar dialog
-- Maybe can be extended later

require "engine.class"

local Entity = require "engine.Entity"

module(..., package.seeall, class.make)

_M.systems_def = {}
_M.worlds_def = {}

local INFINITY = -1

--- Defines system
-- Static!
function _M:loadDefinition(file, env)
	local f, err = util.loadfilemods(file, setmetatable(env or {
		INFINITY = INFINITY,
		newSystem = function(t) self:newSystem(t) end,
		newWorld = function(t) self:newWorld(t) end,
		load = function(f) self:loadDefinition(f, getfenv(2)) end
	}, {__index=_G}))
	if not f and err then error(err) end
	f()
end

--- Defines a new system
-- Static!
function _M:newSystem(t)
	assert(t.id, "no system id")
	assert(t.name, "no system name")
	
	self.systems_def[t.id] = t
	self.systems_def[t.id].worlds = {}
	--self[t.id] = t.id
end

--- Defines a new world, so we don't have to worry about loading zone files
-- Static!
function _M:newWorld(t)
	assert(t.id, "no world id")
	assert(t.name, "no world name")
	assert(t.system, "no world system name")		
	
	self.worlds_def[t.id] = t
	--self[t.id] = t.id	

	-- Register in the system
	table.insert(self.systems_def[t.system].worlds, t)
end

function _M:init(t)
	self.system = {}
end

function _M:getSystem(id)
	return self.systems_def[id]
end

function _M:getWorlds(id)
	return self.systems_def[id].worlds
end

function _M:getZone(id)		
	local w = self.worlds_def[id]
	
	-- retrieve the size of the map
	local map = loadfile("/data/maps/worlds/"..string.lower(w.id)..".lua")
	setfenv(map, setmetatable(
		{defineTile = function(char, grid, obj, actor, trap, status, spot)end},
		{__index=_G})
	)	
	map = map():split("\n")

	-- Add the zone 
	return engine.Zone.new(string.lower(w.id), 
	{	
		name = w.name,
		level_range = {1, nil},
		max_level = 1,
		width = #(map[1]), height = #map,
		level_scheme = "fixed",
		persistent = "zone",
		all_remembered = true,
		all_lited = true,
		type = {world = true, system = w.system},
		generator =  {
			map = {
				class = "engine.generator.map.Static",
				map = "worlds/"..string.lower(w.id),
			},
			actor = {
				class = "engine.generator.actor.Random",
				nb_npc = {0, 0},
			},
			object = { 
				class = "engine.generator.object.Random", 
				nb_object = {0, 0},
			},
		},
		npc_list = {},
		grid_list = engine.Grid:loadList("/data/grids/worlds.lua"),
		object_list = {},
		trap_list = {}
	})
end

function _M:loadMap(file, is_inline)
	local t = {}
	local g = self:getLoader(t)
	local ret, err

	file = "/data/maps/"..file..".lua"
	ret, err = self:loadLuaInEnv(g, file)
	if not ret then 
		if err then error(err) end
		ret = {[[.]]}
	end
	if type(ret) == "string" then ret = ret:split("\n") end

	local ret = loadfile("/data/maps/"..file..".lua")
	ret = ret:split("\n")
	
	local m = { w=#(ret[1]), h=#ret }

	-- Read the map
	if type(ret[1]) == "string" then
		for j, line in ipairs(ret) do
			local i = 1
			for c in line:gmatch(".") do
				populate(i, j, c)
				i = i + 1
			end
		end
	else
		for j, line in ipairs(ret) do
			for i, c in ipairs(line) do
				populate(i, j, c)
			end
		end
	end

	m.startx = util.bound(g.startx or math.floor(m.w / 2), 0, m.w-1)
	m.starty = util.bound(g.starty or math.floor(m.h / 2), 0, m.h-1)
	m.endx = util.bound(g.endx or math.floor(m.w / 2), 0, m.w-1)
	m.endy = util.bound(g.endy or math.floor(m.h / 2), 0, m.h-1)

	if rotate == "flipx" then
		m.startx = m.w - m.startx - 1
		m.endx   = m.w - m.endx - 1
	elseif rotate == "flipy" then
		m.starty = m.h - m.starty - 1
		m.endy   = m.h - m.endy - 1
	elseif rotate == "90" then --counter-clockwise rotation
		m.startx, m.starty = m.starty, m.w - m.startx - 1
		m.endx, m.endy = m.endy, m.w - m.endx - 1
		m.w, m.h = m.h, m.w
	elseif rotate == "180" then
		m.startx, m.starty = m.w - m.startx - 1, m.h - m.starty - 1
		m.endx, m.endy = m.w - m.endx - 1, m.h - m.endy - 1
	elseif rotate == "270" then
		m.startx, m.starty = m.h - m.starty - 1, m.startx
		m.endx, m.endy = m.h - m.endy - 1, m.endx
		m.w, m.h = m.h, m.w
	end
	self.gen_map = m
	self.tiles = t
	self.rotate = rotate
	self.map.w = m.w
	self.map.h = m.h
	print("[STATIC MAP] size", m.w, m.h, "rotate:", rotate)
end

