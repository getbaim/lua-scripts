local playerslist = {}
local names = { 'none' }

local safepoints = { [0] = 'none', 'default', 'prefer', 'force' }
local hitscan = { 'head', 'chest', 'pelvis', 'stomach', 'legs', 'foot' }

local function update()
    local players = entitylist.get_players(0)

    for i = 1, #players do
        local player = players[i]
        local player_index = player:get_index()
        local player_info = engine.get_player_info(player_index)

        playerslist[player_info.name] = {
            index = player_index,
            friend = false,
            autowall = true,
            resolver = true,
            
            override_hitscan = false,
            hitscan = {
                head = false,
                chest = false,
                pelvis = false,
                stomach = false,
                legs = false,
                foot = false
            },

            max_misses = 0,
            safe_point = 0,
        }

        table.insert(names, player_info.name)
    end
end

if engine.is_connected() and engine.is_in_game() then
    update()
else
    client.unload_script('playerlist.lua')

    return
end

local selected = false
local name = nil

ui.add_combo('player', 'playerlist_array', names, 0)
ui.add_checkbox('resolver', 'playerlist_resolver', false)
ui.add_checkbox('autowall', 'playerlist_autowall', false)
ui.add_checkbox('friend', 'playerlist_friend', false)
ui.add_combo('override safe points', 'playerlist_safepoints', safepoints, 0)
ui.add_slider_int('override max misses', 'playerlist_max_misses', 0, 5, 0)
ui.add_checkbox('override hitscan', 'playerlist_override_hitscan', false)

for key, value in pairs(hitscan) do
    ui.add_checkbox(value, 'playerlist_hitscan_' .. value, false)
    ui.set_bool('playerlist_hitscan_' .. value, false)
end

ui.set_int('playerlist_array', 0)
ui.set_bool('playerlist_resolver', ui.get_bool('ragebot_resolver'))
ui.set_bool('playerlist_autowall', ui.get_bool('ragebot_wall_penetration'))
ui.set_bool('playerlist_friend', false)
ui.set_int('playerlist_safepoints', 0)
ui.set_int('playerlist_max_misses', 0)
ui.set_bool('playerlist_override_hitscan', false)

local function on_create_move()
    for i = 1, #names do
        local name = names[i]

        if name ~= 'none' then
            local player = playerslist[name]

            if player.friend then
                ragebot.ignore_player(player.index)
            end

            ragebot.override_desync_correction(player.index, player.resolver)
            ragebot.override_wall_penetration(player.index, player.autowall)

            if player.safe_point > 0 then
                ragebot.override_safe_point(player.index, player.safe_point - 1)
            end

            if player.max_misses > 0 then
                ragebot.override_max_misses(player.index, player.max_misses)
            end

            if player.override_hitscan then
                for i = 1, #hitscan do
                    ragebot.override_hitscan(player.index, i - 1, player.hitscan[hitscan[i]])
                end
            end
        end
    end
end

local function on_paint() 
    local playerlist_index = ui.get_int('playerlist_array')

    if playerlist_index == 0 then
        name = nil
        selected = false

        return
    end

    local _name = names[playerlist_index + 1]
    local player = playerslist[_name]

    if _name ~= name then
        name = _name
        selected = false
    end

    if selected and _name == name then
        player.resolver = ui.get_bool('playerlist_resolver')
        player.autowall = ui.get_bool('playerlist_autowall')
        player.friend = ui.get_bool('playerlist_friend')
        player.safe_point = ui.get_int('playerlist_safepoints')
        player.max_misses = ui.get_int('playerlist_max_misses')
        player.override_hitscan = ui.get_bool('playerlist_override_hitscan')

        for key, value in pairs(hitscan) do
            player.hitscan[value] = ui.get_bool('playerlist_hitscan_' .. value)
        end

        return
    end

    ui.set_bool('playerlist_resolver', player.resolver)
    ui.set_bool('playerlist_autowall', player.autowall)
    ui.set_bool('playerlist_friend', player.friend)
    ui.set_int('playerlist_safepoints', player.safe_point)
    ui.set_int('playerlist_max_misses', player.max_misses)
    ui.set_bool('playerlist_override_hitscan', player.override_hitscan)

    for key, value in pairs(hitscan) do
        ui.set_bool('playerlist_hitscan_' .. value, player.hitscan[value])
    end

    selected = true
end

client.register_callback('create_move', on_create_move)
client.register_callback('paint_d3d', on_paint)