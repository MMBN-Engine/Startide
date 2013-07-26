-- Defines definitions for sytems, this will group worlds for the hangar dialog
-- Maybe can be extended later

require "engine.class"

local Entity = require "engine.Entity"

module(..., package.seeall, class.make)

_M.systems_def = {}

local INFINITY = -1

--- Defines system
-- Static!
function _M:loadDefinition(file, env)
	local f, err = util.loadfilemods(file, setmetatable(env or {
		INFINITY = INFINITY,
		newSystem = function(t) self:newSystem(t) end,
		load = function(f) self:loadDefinition(f, getfenv(2)) end
	}, {__index=_G}))
	if not f and err then error(err) end
	f()
end

--- Defines a new ingredient
-- Static!
function _M:newSystem(t)
	assert(t.id, "no system id")
	assert(t.name, "no system name")
	assert(t.zones, "no system zones")
	
	self.systems_def[t.name] = t
	self[t.id] = t.id
end


function _M:init(t)
	self.system = {}
end