name = "Robot Rampage"
desc = function(self, who)
	local desc = {}
	desc[#desc+1] = "The manufactory around you is going crazy, making everything in overdrive."
	desc[#desc+1] = "You around you and try and find a way out."
	
	if self:isCompleted("killed") then
		desc[#desc+1] = "You destroyed the controler. It dropped something interesting."
	end

	if self:isCompleted("left") then
		desc[#desc+1] = "You have escaped the manufactory."
	end

	return table.concat(desc, "\n")
end

on_status_change = function(self, who, status, sub)
	if sub then
		if self:isCompleted("left") then
			who:setQuestStatus(self.id, engine.Quest.DONE)
		end
	end
end

