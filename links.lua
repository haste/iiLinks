local frame = CreateFrame"Frame"
frame:RegisterEvent'PLAYER_LOGIN'
frame:SetScript('OnEvent', function()
	local origs = {}

	local type = type
	local _Insert = ChatFrameEditBox.Insert

	local AddMessage = function(self, text,...)
		if(type(text) == "string") then
			text = text:gsub("|H(.-)|h%[(.-)%]|h", "|H%1|h%2|h")
		end

		return origs[self](self, text, ...)
	end

	_G.ChatFrameEditBox.Insert = function(self, str, ...)
		if(type(str) == "string") then
			str = str:gsub("|H(.-)|h[%[]?(.-)[%]]?|h", "|H%1|h[%2]|h")
		end

		return _Insert(self, str, ...)
	end

	for i=1, NUM_CHAT_WINDOWS do
		if(i ~= 2) then
			local cf = _G["ChatFrame"..i]
			origs[cf] = cf.AddMessage
			cf.AddMessage = AddMessage
		end
	end

	frame:SetScript('OnEvent', nil)
	frame:UnregisterEvent'PLAYER_LOGIN'
end)
