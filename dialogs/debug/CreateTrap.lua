require "engine.class"
local Dialog = require "engine.ui.Dialog"
local List = require "engine.ui.List"
local GetQuantity = require "engine.dialogs.GetQuantity"

module(..., package.seeall, class.inherit(Dialog))

function _M:init()
	self:generateList()
	Dialog.init(self, "Create Trap", 1, 1)

	local list = List.new{width=400, height=500, list=self.list, fct=function(item) self:use(item) end}

	self:loadUI{
		{left=0, top=0, ui=list},
	}
	self:setupUI(true, true)

	self.key:addCommands{ __TEXTINPUT = function(c)
		for i = list.sel + 1, #self.list do
			local v = self.list[i]
			if v.name:sub(1, 1):lower() == c:lower() then list:select(i) return end
		end
		for i = 1, list.sel do
			local v = self.list[i]
			if v.name:sub(1, 1):lower() == c:lower() then list:select(i) return end
		end
	end}
	self.key:addBinds{ EXIT = function() game:unregisterDialog(self) end, }
end

function _M:on_register()
	game:onTickEnd(function() self.key:unicodeInput(true) end)
end

function _M:use(item)
	if not item then return end
	game:unregisterDialog(self)

	if item.unique then
		local n = game.zone:finishEntity(game.level, "trap", item.e)
		n:identify(true)
		game.zone:addEntity(game.level, n, "trap", game.player.x, game.player.y)
	else
		local n = game.zone:finishEntity(game.level, "trap", item.e)
		n:setKnown(game.player, true)
		game.zone:addEntity(game.level, n, "trap", game.player.x, game.player.y)
	end
end

function _M:generateList()
	local list = {}

	for i, e in ipairs(game.zone.trap_list) do
		if e.name and e.rarity then
			list[#list+1] = {name=e.name, unique=e.unique, e=e}
		end
	end
	table.sort(list, function(a,b)
		if a.unique and not b.unique then return true
		elseif not a.unique and b.unique then return false end
		return a.name < b.name
	end)

	local chars = {}
	for i, v in ipairs(list) do
		v.name = v.name
		chars[self:makeKeyChar(i)] = i
	end
	list.chars = chars

	self.list = list
end
