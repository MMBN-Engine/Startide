require "engine.class"
require "engine.ui.Dialog"
local List = require "engine.ui.List"
local GetQuantity = require "engine.dialogs.GetQuantity"

module(..., package.seeall, class.inherit(engine.ui.Dialog))

function _M:init()
	self:generateList()
	engine.ui.Dialog.init(self, "Debug/Cheat! It's BADDDD!", 1, 1)

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

--	if not item.hasit then
	game.player:removeQuest(item.quest)
	game.player:grantQuest(item.quest)
--	else
--	game:registerDialog(GetQuantity.new("Quest: "..item.name, "Level "..item.min.."-"..item.max, 1, item.max, function(qty)
--		game:changeLevel(qty, item.zone)
--	end), 1)
--	end
end

function _M:generateList()
	local list = {}

	for i, file in ipairs(fs.list("/data/quests/")) do
		if file:find(".lua$") then
			local n = file:gsub(".lua$", "")
			list[#list+1] = {name=n, quest=n, hasit=game.player:hasQuest(n)}
		end
	end
	table.sort(list, function(a,b) return a.name < b.name end)

	local chars = {}
	for i, v in ipairs(list) do
		v.name = v.name
		chars[self:makeKeyChar(i)] = i
	end
	list.chars = chars

	self.list = list
end
