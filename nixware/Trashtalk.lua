local messages = {
    {
        "get good. get nixware",
        "owned by nixware"
    },
    {
        "Think you could do better? Not without www.EZFrags.co.uk",
        "If I was cheating, I'd use www.EZFrags.co.uk",
        "I'm not using www.EZFrags.co.uk, you're just bad",
        "Visit www.EZFrags.co.uk for the finest public & private CS:GO cheats",
        "Stop being a noob! Get good with www.EZFrags.co.uk",
        "You just got pwned by www.EZFrags.co.uk, the #1 CS:GO cheat"
    }
}

local misc_killsay = ui.add_combo_box("kill spam", "misc_killsay", {
    "none",
    "nixware",
    "ezfrags",
    "1"
}, 0)

local misc_killsay_name = ui.add_check_box("include name", "misc_killsay_name", false)

client.register_callback("fire_game_event", function (event)
    local index = misc_killsay:get_value()

    if index == 0 then
        return
    end

    if event:get_name() == "player_death" then
        local attacker = engine.get_player_for_user_id(event:get_int("attacker", 0))
        local dead = engine.get_player_for_user_id(event:get_int("userid", 0))
        local me = engine.get_local_player()

        if attacker == me and dead ~= me then
            local target = engine.get_player_info(dead)
            local text = ""

            if misc_killsay_name:get_value() then
                text = target.name .. ", "
            end

            text = messages[index] and messages[index][math.random(1, #messages[index])] or text .. '1'

            engine.execute_client_cmd("say " .. text)
        end
    end
end)
