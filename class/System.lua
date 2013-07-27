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
	assert(t.id, "no system id")
	assert(t.name, "no system name")
	--assert(t.starting_zone, "no starting zone")
	
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