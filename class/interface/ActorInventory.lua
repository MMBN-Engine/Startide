require "engine.class"
local Base = require "engine.interface.ActorInventory"

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
