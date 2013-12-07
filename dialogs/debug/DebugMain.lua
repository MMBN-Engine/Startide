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

	self.key:addCommands{ __TEXTINPUT = function(c) if self.list and self.list.chars[c] then self:use(self.list[self.list.chars[c]]) end end}
	self.key:addBinds{ EXIT = function() game:unregisterDialog(self) end, }
end

function _M:on_register()
	game:onTickEnd(function() self.key:unicodeInput(true) end)
end

function _M:use(item)
	if not item then return end
	game:unregisterDialog(self)

	if item.dialog then
		local d = require("mod.dialogs.debug."..item.dialog).new()
		game:registerDialog(d)
		return
	end

	local act = item.action

	local stop = false
	if act == "godmode" then
		game.player:forceLevelup(50)
		game.player.invulnerable = 1
		game.player.esp_all = 1
		game.player.esp_range = 50
		game.player.no_breath = 1
		game.player.money = 500
		game.player.auto_id = 100
		game.state.birth.ignore_prodigies_special_reqs = true
		game.player.inc_damage.all = 100000
		game.player:incStat("str", 100) game.player:incStat("dex", 100) game.player:incStat("mag", 100) game.player:incStat("wil", 100) game.player:incStat("cun", 100) game.player:incStat("con", 100)
	elseif act == "semigodmode" then
		game.player.invulnerable = 0
		game.player.no_breath = 0
		game.player:forceLevelup(50)
		game.player.life_regen = 2000
		game.player.esp_all = 1
		game.player.esp_range = 50
		game.player.money = 500
		game.player.auto_id = 100
		game.state.birth.ignore_prodigies_special_reqs = true
		game.player.inc_damage.all = 500
		game.player:incStat("str", 100) game.player:incStat("dex", 100) game.player:incStat("mag", 100) game.player:incStat("wil", 100) game.player:incStat("cun", 100) game.player:incStat("con", 100)
	elseif act == "all_arts" then
		for i, e in ipairs(game.zone.object_list) do
			if e.unique and e.define_as ~= "VOICE_SARUMAN" and e.define_as ~= "ORB_MANY_WAYS_DEMON" then
				local a = game.zone:finishEntity(game.level, "object", e)
				a.no_unique_lore = true -- to not spam
				--a:identify(true)
				--if a.name == a.unided_name then print("=================", a.name) end
				game.zone:addEntity(game.level, a, "object", game.player.x, game.player.y)
			end
		end
	elseif act == "magic_map" then
		game.level.map:liteAll(0, 0, game.level.map.w, game.level.map.h)
		game.level.map:rememberAll(0, 0, game.level.map.w, game.level.map.h)
		for i = 0, game.level.map.w - 1 do
			for j = 0, game.level.map.h - 1 do
				local trap = game.level.map(i, j, game.level.map.TRAP)
				if trap then
					trap:setKnown(game.player, true)
					game.level.map:updateMap(i, j)
				end
			end
		end
	elseif act == "change_level" then
		game:registerDialog(GetQuantity.new("Zone: "..game.zone.name, "Level 1-"..game.zone.max_level, game.level.level, game.zone.max_level, function(qty)
			game:changeLevel(qty)
		end), 1)
	elseif act == "all_traps" then
		for _, file in ipairs(fs.list("/data/general/traps/")) do if file:find(".lua$") then
			local list = mod.class.Trap:loadList("/data/general/traps/"..file)
			for i, e in ipairs(list) do
				print("======",e.name,e.rarity)
				if e.rarity then
					local trap = game.zone:finishEntity(game.level, "trap", e)
					trap:setKnown(game.player, true)
					local x, y = util.findFreeGrid(game.player.x, game.player.y, 20, true, {[engine.Map.TRAP]=true})
					if x then
						game.zone:addEntity(game.level, trap, "trap", x, y)
					end
				end
			end
		end end
	elseif act == "remove-all" then
		local l = {}
		for uid, e in pairs(game.level.entities) do
			if not game.party:hasMember(e) then l[#l+1] = e end
		end
		for i, e in ipairs(l) do
			game.level:removeEntity(e)
		end
	elseif act == "lua" then
		local d = require("engine.DebugConsole").new()
		game:registerDialog(d)

	end

end

function _M:generateList()
	local list = {}

	list[#list+1] = {name = "Lua Consol", action = "lua"}
	list[#list+1] = {name="Change Zone", dialog="ChangeZone"}
	list[#list+1] = {name="Change Level", action="change_level"}
	list[#list+1] = {name="Reveal Map", action="magic_map"}
	-- list[#list+1] = {name="God Mode", action="godmode"}
	list[#list+1] = {name="Create all artifacts", action="all_arts"}
	list[#list+1] = {name="Grant/Alter Quests", dialog="GrantQuest"}
	list[#list+1] = {name="Summon Creature", dialog="SummonCreature"}
	list[#list+1] = {name="Create Item", dialog="CreateItem"}
	list[#list+1] = {name="Alter Faction", dialog="AlterFaction"}
	list[#list+1] = {name="Create Trap", dialog="CreateTrap"}
	list[#list+1] = {name="Remove All Creatures", action="remove-all"}
	-- list[#list+1] = {name="Demigod Mode", action="semigodmode"}

	local chars = {}
	for i, v in ipairs(list) do
		v.name = self:makeKeyChar(i)..") "..v.name
		chars[self:makeKeyChar(i)] = i
	end
	list.chars = chars

	self.list = list
end
