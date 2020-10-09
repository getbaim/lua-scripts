local kills = 0

local sounds = {
    [2] = 'cook/doublekill.wav',
    [3] = 'cook/multikill.wav',
    [4] = 'cook/smiyc.wav',
    [5] = 'cook/ultrakill.wav'
}

cheat.RegisterCallback("events", function(event)
	if event:GetName() == "round_start" then
		kills = 0
	end
	
	if event:GetName() ~= "player_death" then
		return
	end
	
	local attacker = event:GetInt("attacker", 0)
	local target = event:GetInt("userid", 0)
	local me = g_EngineClient.GetPlayerInfo(g_EngineClient.GetLocalPlayer()).userId
	local is_headshot = event:GetBool("headshot", false)
	
	if attacker == me and me ~= target then
		kills = kills + 1
		
		if sounds[kills] then
			g_EngineClient.ExecuteClientCmd("play " .. sounds[kills])
			
			return
		end
		
		if is_headshot then
			g_EngineClient.ExecuteClientCmd("play cook/hs.wav")
			
			return
		end
	end
end)