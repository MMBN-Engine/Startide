require "engine.class"
local Base = require "engine.interface.ActorInventory"
local ShowEquipInven = require "mod.dialogs.ShowEquipInven"

--- Interface to add leveling capabilities to actors
-- Defines the exp property, which is the current experience, level which is the current level and exp_worth which is a multiplier
-- to the monster level default exp
module(..., package.seeall, class.inherit(Base))

function _M:addSlot(inven_id, num)
	if not self.inven[self["INVEN_"..inven_id]] then
		self.inven[self["INVEN_"..inven_id]] = {max=num, worn=self.inven_def[self["INVEN_"..inven_id]].is_worn, id=self["INVEN_"..inven_id], name=inven_id}
	else
		self.inven_id[self["INVEN_"..inven_id]].max = self.inven[self["INVEN_"..inven_id]] + num
	end
end

--- Show combined equipment/inventory dialog
-- @param inven the inventory (from self:getInven())
-- @param filter nil or a function that filters the objects to list
-- @param action a function called when an object is selected
function _M:showEquipInven(title, filter, type, action, on_select)
	local d = ShowEquipInven.new(title, self, filter, type, action, on_select)
	game:registerDialog(d)
	return d
end

--- Call when an object is worn
function _M:onWear(o)
	-- Apply wielder properties
	o.wielded = {}
	o:check("on_wear", self)
	if o.wielder then
		for k, e in pairs(o.wielder) do
			o.wielded[k] = self:addTemporaryValue(k, e)
		end
	end
	if o.cyber_wielder and self:knowTalent(self.T_COMBAT_INTERFACE) then
		for k, e in pairs(o.cyber_wielder) do
			o.wielded[k] = self:addTemporaryValue(k, e)
		end
	end
end

--- Can we wear this item?
function _M:canWearObject(o, try_slot)
	local req = rawget(o, "require")

	-- Check prerequisites
	if req then
		-- Obviously this requires the ActorStats interface
		if req.stat then
			for s, v in pairs(req.stat) do
				if self:getStat(s) < v then return nil, "not enough stat" end
			end
		end
		if req.level and self.level < req.level then
			return nil, "not enough levels"
		end
		if req.talent then
			for _, tid in ipairs(req.talent) do
				if type(tid) == "table" then
					if self:getTalentLevelRaw(tid[1]) < tid[2] then return nil, "missing dependency" end
				else
					if not self:knowTalent(tid) then return nil, "missing dependency" end
				end
			end
		end
		if req.size and not (self.size == req.size) then
			if self.size > req.size then
				return nil, "too large"
			end
			if self.size < req.size then
				return nil, "too small"
			end
		end
	end

	-- Check forbidden slot
	if o.slot_forbid then
		local inven = self:getInven(o.slot_forbid)
		-- If the object cant coexist with that inventory slot and it exists and is not empty, refuse wearing
		if inven and #inven > 0 then
			return nil, "cannot use currently due to an other worn object"
		end
	end

	-- Check that we are not the forbidden slot of any other worn objects
	for id, inven in pairs(self.inven) do
		if self.inven_def[id].is_worn and (not self.inven_def[id].infos or not self.inven_def[id].infos.etheral) then
			for i, wo in ipairs(inven) do
				print("fight: ", o.name, wo.name, "::", wo.slot_forbid, try_slot or o.slot)
				if wo.slot_forbid and wo.slot_forbid == (try_slot or o.slot) then
					print(" impossible => ", o.name, wo.name, "::", wo.slot_forbid, try_slot or o.slot)
					return nil, "cannot use currently due to an other worn object"
				end
			end
		end
	end

	return true
end