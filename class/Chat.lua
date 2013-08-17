require "engine.class"
require "mod.dialogs.Chat"
local Base = require "engine.Chat"

--- Handle chats between the player and NPCs
module(..., package.seeall, class.inherit(Base))

--- Invokes a chat
-- @param id the id of the first chat to run, if nil it will use the default one
function _M:invoke(id)
	if self.npc.onChat then self.npc:onChat() end
	if self.player.onChat then self.player:onChat() end

	local d = mod.dialogs.Chat.new(self, id or self.default_id)
	game:registerDialog(d)
	return d
end