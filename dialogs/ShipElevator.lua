require "engine.class"
require "engine.ui.Dialog"
local List = require "engine.ui.List"
local GetQuantity = require "engine.dialogs.GetQuantity"

module(..., package.seeall, class.inherit(engine.ui.Dialog))

function _M:init()
	self:generateList()
	engine.ui.Dialog.init(self, "Elevator", 1, 1)

	local list = List.new{width=400, height=500, scrollbar=true, list=self.list, fct=function(item) self:use(item) end}

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

	game:changeLevel(1, item.name)
end

function _M:generateList()
	local list = {}

	for i, dir in ipairs(fs.list("/data/zones/")) do
		local f = loadfile("/data/zones/"..dir.."/zone.lua")
		if f then
			setfenv(f, {})
			local ok, z = pcall(f)
			if ok and z.type and z.type.ship_floor then
				list[#list+1] = {name=z.name, zone=dir, min=1, max=z.max_level}
			end
		end
	end
	table.sort(list, function(a,b) return a.ship_floor < b.ship_floor end)

	local chars = {}
	for i, v in ipairs(list) do
		v.name = v.name
		chars[self:makeKeyChar(i)] = i
	end
	list.chars = chars

	self.list = list
end

