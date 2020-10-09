local kills = 0

local sounds = {
    [2] = 'cook/doublekill.wav',
    [3] = 'cook/multikill.wav',
    [4] = 'cook/smiyc.wav',
    [5] = 'cook/ultrakill.wav'
}

local function play_sound(sound)
	engine.execute_client_cmd("play " .. sound)
end

local function on_event(event)
    if event:get_name() == "round_start" then
        kills = 0
    end

    local attacker = engine.get_player_for_user_id(event:get_int("attacker", 0))
    local target = engine.get_player_for_user_id(event:get_int("userid", 0))
    local me = engine.get_local_player()

    if event:get_name() == "player_death" and me == attacker and me ~= target then
        kills = kills + 1

        local is_headshot = event:get_bool("headshot", false)

        if sounds[kills] then
			play_sound(sounds[kills])

            return
        end

        if is_headshot then
            play_sound('cook/hs.wav')

            return
        end
    end
end

client.register_callback("fire_game_event", on_event)
