-- Defines grammar rules for random species generation
-- Replacement rules take the form "@str@"

require "engine.class"

local Entity = require "engine.Entity"

module(..., package.seeall, class.make)

-- Gender replacements are predefined
_M.replacement_rules = {
	["@noun@"] = function(g)
		return g.noun
	end,
	["@pronoun@"] = function(g)
		return g.pronoun
	end,
	["@possesive@"] = function(g)
		return g.possesive
	end
}

_M.adjective_list = {}
_M.gender_def = {}
local fast_cache = {}
setmetatable(fast_cache, {__mode="v"})

local INFINITY = -1

--- Defines system
-- Static!
function _M:loadDefinition(file, env)
	local f, err = util.loadfilemods(file, setmetatable(env or {
		INFINITY = INFINITY,
		defineAdjectives = function(t) self:defineAdjectives(t) end,
		newReplacementRule = function(t) self:newReplacementRule(t) end,
		newGender = function(t) self:newGender(t) end,
		load = function(f) self:loadDefinition(f, getfenv(2)) end
	}, {__index=_G}))
	if not f and err then error(err) end
	f()
end

--- Defines a new system
-- Static!
function _M:defineAdjectives(t)
	self.adjective_list = t
end

function _M:newReplacementRule(t)
	--assert(t.id, "no system id")
	assert(t.name, "no type name")
	
	self.type_def[t.id] = t
end

function _M:newGender(t)
	assert(t.noun, "no gender noun")
	assert(t.pronoun, "no geneder pronoun")	
	assert(t.possesive, "no geneder possesive")
	
	self.gender_def[t.noun] = t
end

-- Chose a random adjective_list
function _M:randomAdjective()
	return rng.table(self.adjective_list)
end

-- Choses a random gender from the defined genders
function _M:randomGender()
	-- Generates the list of keys
	local keyset={}
	local n=0
	for k,v in pairs(self.gender_def) do
		n=n+1
		keyset[n]=k
	end

	return self.gender_def[rng.table(keyset)]
end

-- Returns string for replacement key with gender g
function _M:Replace(key, g)
	local rule = self.replacement_rules[key]
	
	if not rule then 
		print("[Grammar]  rule"..key.." not defined") 
		return key
	else
		return rule(g)
	end
end

-- Generates a random description from the grammar rules
function _M:getRandomDescription()
	local g = self:randomGender()	
	local noun = g.noun
	
	local adj = self:randomAdjective()
	
	local str = "A "..adj.." @noun@."
	
	return str:gsub("@%a+@", function(s) return self:Replace(s,g) end)
end

