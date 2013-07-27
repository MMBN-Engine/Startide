require "engine.class"
require "engine.Dialog"
local System = require "mod.class.System"

module(..., package.seeall, class.inherit(engine.Dialog))

function _M:init(actor)
	self.actor = actor

	engine.Dialog.init(self, "Change Zone", math.max(game.w * 0.85, 800), math.max(game.h * 0.85, 600))

	self:generateList()

	self.sel = 1
	self.scroll = 1
	self.max = math.floor((self.ih - 65) / self.font_h) - 1

	self:keyCommands(nil, {
		MOVE_UP = function() self.sel = util.boundWrap(self.sel - 1, 1, #self.list) self.scroll = util.scroll(self.sel, self.scroll, self.max) self.changed = true end,
		MOVE_DOWN = function() self.sel = util.boundWrap(self.sel + 1, 1, #self.list) self.scroll = util.scroll(self.sel, self.scroll, self.max) self.changed = true end,
		ACCEPT = function() self:change() end,
		EXIT = function() game:unregisterDialog(self) end,
	})
	self:mouseZones{
		{ x=0, y=0, w=game.w, h=game.h, mode={button=true}, norestrict=true, fct=function(button) if button ~= "none" then self.key:triggerVirtual("EXIT") end end},
		{ x=2, y=65, w=350, h=self.font_h*self.max, fct=function(button, x, y, xrel, yrel, tx, ty)
			self.changed = true
			self.sel = util.bound(self.scroll + math.floor(ty / self.font_h), 1, #self.list)
			if button == "left" then self:change() end
			self.changed = true
		end },
	}
end

function _M:generateList()

	-- Makes up the list
	local list = {}, {}
	for i, s in ipairs(self.actor.system) do
		local system = System:getSystem(s)
		
		list[#list+1] = { name = system.name, id = system.id, color = {0, 220,0}}		
		
		local worlds = System:getWorlds(s)
		-- Find all zones in the system
		for j, w in ipairs(worlds) do
			list[#list+1] = { name="    "..w.name, zone = w.starting_zone, color = colors.WHITE} 
		end
	end

	self.list = list
end

function _M:change()
	if self.list[self.sel].id then
		return nil
	else
		game:changeLevel(1, self.list[self.sel].zone)
	end
end

function _M:drawDialog(s)
	-- Description part
	self:drawHBorder(s, self.iw / 2, 2, self.ih - 4)

	-- Zone list
	--self:drawWBorder(s, 2, 60, 200)
	self:drawSelectionList(s, 2, 10, self.font_h, self.list, self.sel, "name", self.scroll, self.max)
	
	self.changed = false
end

