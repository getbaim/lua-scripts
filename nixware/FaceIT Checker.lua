local panorama = require 'panorama'

local check = ui.add_check_box('check', 'faceit_checker', false)

local function callback()
    local entities = entitylist.get_players(2)
    local data = '""'

    for i = 1, #entities do
        local plr = engine.get_player_info(entities[i]:get_index())

        if plr.steam_id64 ~= '0' then
            data = data .. string.format(',"%s:%s"', plr.steam_id64, plr.name)
        end
    end

    panorama.eval(string.format([[
        let data = [%s].filter(e => e.length > 1)

        for (var user of data) {
            let [id, name] = user.split(':');

            $.AsyncWebRequest('https://faceitfinder.com/en/profile/' + id, {
                success: (body) => {
                    let metaDescription = body.match(/<meta name="description" content="([^"]+)">/i)[1]

                    if (metaDescription !== 'Find your FaceIt account by Steam profile link. Check FaceIt ELO and stats.') {
                        $.Msg(metaDescription);

                        GameInterfaceAPI.ConsoleCommand('say_team ' + metaDescription);
                    } else {
                        $.Msg('Faceit issue [' + id + ']');
                    }
                }
            })
        }
    ]], data))
end

local function on_paint()
    if check:get_value() then
        check:set_value(false)
        callback()
    end
end

client.register_callback('paint', on_paint)
