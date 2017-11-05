require "engine.class"
require "engine.Dialog"

module(..., package.seeall, class.inherit(engine.Dialog))

function _M:init(actor, on_finish)
	self.actor = actor
	self.actor_dup = actor:clone()
	engine.Dialog.init(self, "Talents Levelup: "..actor.name, math.max(game.w * 0.85, 800), math.max(game.h * 0.85, 600))

	self.actor.__hidden_talent_types = self.actor.__hidden_talent_types or {}
	self.actor.__increased_talent_types = self.actor.__increased_talent_types or {}

	self:generateList()

	self.talents_changed = {}

	self.sel = 1
	self.scroll = 1
	self.max = math.floor((self.ih - 65) / self.font_h) - 1

	self:keyCommands({
		__TEXTINPUT = function(c)
			if not self.list[self.sel] or not self.list[self.sel].type then return end
			if c == "+" then
				self.actor.__hidden_talent_types[self.list[self.sel].type] = false
				self:generateList()
				self.changed = true
			end
			if c == "-" then
				self.actor.__hidden_talent_types[self.list[self.sel].type] = true
				self:generateList()
				self.changed = true
			end
		end,
	}, {
		MOVE_UP = function() self.sel = util.boundWrap(self.sel - 1, 1, #self.list) self.scroll = util.scroll(self.sel, self.scroll, self.max) self.changed = true end,
		MOVE_DOWN = function() self.sel = util.boundWrap(self.sel + 1, 1, #self.list) self.scroll = util.scroll(self.sel, self.scroll, self.max) self.changed = true end,
		MOVE_LEFT = function() self:learn(false) self.changed = true end,
		MOVE_RIGHT = function() self:learn(true) self.changed = true end,
		ACCEPT = "EXIT",
		EXIT = function() game:unregisterDialog(self) end,
	})
	self:mouseZones{
		{ x=0, y=0, w=game.w, h=game.h, mode={button=true}, norestrict=true, fct=function(button) if button ~= "none" then self.key:triggerVirtual("EXIT") end end},
		{ x=2, y=65, w=350, h=self.font_h*self.max, fct=function(button, x, y, xrel, yrel, tx, ty)
			self.changed = true
			self.sel = util.bound(self.scroll + math.floor(ty / self.font_h), 1, #self.list)
			if button == "left" then self:learn(true)
			elseif button == "right" then self:learn(false)
			end
			self.changed = true
		end },
	}
end

function _M:generateList()
	self.actor.__show_special_talents = self.actor.__show_special_talents or {}

	-- Makes up the list
	local list, known = {}, {}
	for i, tt in ipairs(self.actor.talents_types_def) do
		if not tt.hide and not (self.actor.talents_types[tt.type] == nil) then
			local cat = tt.type:gsub("/.*", "")
			local ttknown = self.actor:knowTalentType(tt.type)
			list[#list+1] = { name = cat:capitalize(), type=tt.type, color={0,200,0}}
			if ttknown then
				known[#known+1] = {name="known", color={0,200,0}}
			else
				known[#known+1] = {name="0/1", color={128,128,128}}
			end

			-- Find all talents of this school
			if (self.actor.__hidden_talent_types[tt.type] == nil and ttknown) or (self.actor.__hidden_talent_types[tt.type] ~= nil and not self.actor.__hidden_talent_types[tt.type]) then
				for j, t in ipairs(tt.talents) do
					if not t.hide or self.actor.__show_special_talents[t.id] then
																		list[#list+1] = { name="    "..t.name, talent=t.id, color=not ttknown and {128,128,128} }
						if self.actor:getTalentLevelRaw(t.id) == t.points then
							known[#known+1] = {name="known", color=ttknown and {0,255,0} or {128,128,128}}
						else
							if not self.actor:canLearnTalent(t) then
								known[#known+1] = {name=self.actor:getTalentLevelRaw(t.id).."/"..t.points, color=ttknown and {255,0,0} or {128,128,128}}
							else
								known[#known+1] = {name=self.actor:getTalentLevelRaw(t.id).."/"..t.points, color = not ttknown and {128,128,128}}
							end
						end
					end
				end
			end
		end
	end
	self.list = list
	self.list_known = known
end

function _M:finish()
	-- Go through all sustained spells
	local reset = {}
	for tid, act in pairs(self.actor.sustain_talents) do
		if act then
			local t = self.actor:getTalentFromId(tid)
			if self.actor:getTalentLevelRaw(tid) ~= self.actor_dup:getTalentLevelRaw(tid) then
				if t.no_sustain_autoreset then
					game.logPlayer(self.actor, "#LIGHT_BLUE#Warning: You have increased your level in %s, but it cannot be auto-reactivated. The new level will only be used when you re-use it.", t.name)
				else
					reset[#reset+1] = tid
				end
			end
		end
	end
	for i, tid in ipairs(reset) do
		local old = self.actor.energy.value
		self.actor:useTalent(tid)
		self.actor.energy.value = old
		self.actor.talents_cd[tid] = nil
		self.actor:useTalent(tid)
		self.actor.energy.value = old
	end
end

function _M:learn(v)
	if self.list[self.sel].type then
--		self:learnType(self.list[self.sel].type, v)
		return nil
	else
		self:learnTalent(self.list[self.sel].talent, v)
	end
end

function _M:checkDeps()
	for t_id, _ in pairs(self.talents_changed) do
		local t = self.actor:getTalentFromId(t_id)
		if not self.actor:canLearnTalent(t, 0) and self.actor:knowTalent(t) then return false, t.name end
	end
	return true
end

function _M:learnTalent(t_id, v)
	local t = self.actor:getTalentFromId(t_id)
	if v then
		if self.actor.unused_talents < 1 then
			self:simplePopup("Not enough talent points", "You have no class talent points left!")
			return
		end
		if not self.actor:canLearnTalent(t) then
			self:simplePopup("Cannot learn talent", "Prerequisites not met!")
			return
		end
		if self.actor:getTalentLevelRaw(t_id) >= t.points then
			self:simplePopup("Already known", "You already fully know this talent!")
			return
		end
		self.actor:learnTalent(t_id)
		self.actor.unused_talents = self.actor.unused_talents - 1
		self.talents_changed[t_id] = true
	else
		if not self.actor:knowTalent(t_id) then
			self:simplePopup("Impossible", "You do not know this talent!")
			return
		end
		if self.actor_dup:getTalentLevelRaw(t_id) == self.actor:getTalentLevelRaw(t_id) then
			self:simplePopup("Impossible", "You cannot unlearn talents!")
			return
		end
		self.actor:unlearnTalent(t_id)
		local ok, dep_miss = self:checkDeps()
		if ok then
			self.actor.unused_talents = self.actor.unused_talents + 1
		else
			self:simplePopup("Impossible", "You can not unlearn this talent because of talent: "..dep_miss)
			self.actor:learnTalent(t_id)
			return
		end
	end
	self:generateList()
end

function _M:drawDialog(s)
	-- Description part
	self:drawHBorder(s, self.iw / 2, 2, self.ih - 4)

	local talentshelp = ([[Keyboard: #00FF00#up key/down key#FFFFFF# to select a stat; #00FF00#right key#FFFFFF# to learn; #00FF00#left key#FFFFFF# to unlearn; #00FF00#+#FFFFFF# to expand a category; #00FF00#-#FFFFFF# to reduce a category.
Mouse: #00FF00#Left click#FFFFFF# to learn; #00FF00#right click#FFFFFF# to unlearn.
]]):splitLines(self.iw / 2 - 10, self.font)

	local lines, helplines, reqlines = nil, {}, nil
	if self.list[self.sel].type then
		local str = ""
		str = str .. "#00FFFF#Talent Category\n"
		str = str .. "#00FFFF#A talent category allows you to learn talents of this category.\n\n"
		helplines = str:splitLines(self.iw / 2 - 10, self.font)
		lines = self.actor:getTalentTypeFrom(self.list[self.sel].type).description:splitLines(self.iw / 2 - 10, self.font)
	else
		local t = self.actor:getTalentFromId(self.list[self.sel].talent)

		local str = ""
		local what
		what = "class talent"
		str = str .. "#00FFFF#Talent\n"
		str = str .. "#00FFFF#A class talent allows you to perform new combat moves and improve your character. You gain one point every level. You may also find trainers that allow you to learn more.\n\n"
		helplines = str:splitLines(self.iw / 2 - 10, self.font)

		lines = self.actor:getTalentFullDescription(t):splitLines(self.iw / 2 - 10, self.font)
		local req = self.actor:getTalentReqDesc(self.list[self.sel].talent, 1):toTString()
		local req = tostring(self.actor:getTalentReqDesc(self.list[self.sel].talent, 1))
		reqlines = req:splitLines(self.iw / 2 - 10, self.font)

	end
	local h = 2
	for i = 1, #talentshelp do
		s:drawColorStringBlended(self.font, talentshelp[i], self.iw / 2 + 5, h)
		h = h + self.font:lineSkip()
	end

	h = h + self.font:lineSkip()
	self:drawWBorder(s, self.iw / 2 + self.iw / 6, h - 0.5 * self.font:lineSkip(), self.iw / 6)
	for i = 1, #helplines do
		s:drawColorStringBlended(self.font, helplines[i], self.iw / 2 + 5, h)
		h = h + self.font:lineSkip()
	end

	if reqlines and lines then
		h = h + self.font:lineSkip()
		self:drawWBorder(s, self.iw / 2 + self.iw / 6, h - 0.5 * self.font:lineSkip(), self.iw / 6)
		for i = 1, #reqlines do
			s:drawColorStringBlended(self.font, reqlines[i], self.iw / 2 + 5, h)
			h = h + self.font:lineSkip()
		end

		for i = 1, #lines do
			s:drawColorStringBlended(self.font, lines[i], self.iw / 2 + 5, 2 + h)
			h = h + self.font:lineSkip()
		end
	end

	-- Talents
	s:drawColorStringBlended(self.font, "Talents points left: #00FF00#"..self.actor.unused_talents, 2, 2 + self.font_h)
	self:drawWBorder(s, 2, 60, 200)

	self:drawSelectionList(s, 2, 65, self.font_h, self.list, self.sel, "name"     , self.scroll, self.max)
	self:drawSelectionList(s, self.iw / 2 - 70, 65, self.font_h, self.list_known, self.sel, "name", self.scroll, self.max)

	self.changed = false
end
