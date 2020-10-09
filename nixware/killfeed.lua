ui.add_slider_int('length', 'killfeed_length', 0, 100, 7)
ui.add_checkbox('rgb border', 'killfeed_rgb_border', false)

local FONT_SIZE = 16

local font = {
    verdana = renderer.setup_font("C:/windows/fonts/verdana.ttf", FONT_SIZE, 0),
    astrium = renderer.setup_font('C:/nixware/fonts/astriumwep.ttf', FONT_SIZE, 0)
}

local screen = engine.get_screen_size()

local icons = {
    ['ssg08'] = 'a',
    ['awp'] = 'Z',
    ['scar20'] = 'Y',
    ['g3sg1'] = 'X',
    ['deagle'] = 'A',
    ['glock'] = 'D',
    ['elite'] = 'B',
    ['p250'] = 'F',
    ['tec9'] = 'H',
    ['usp_silencer'] = 'G',
    ['cz75a'] = 'I',
    ['revolver'] = 'J',
    ['taser'] = 'h',
    ['knife'] = '1',
    ['fiveseven'] = 'C',
    ['hkp2000'] = 'E',
    ['sg556'] = 'V',
    ['m4a1'] = 'S',
    ['ak47'] = 'W',
    ['galilar'] = 'Q',
    ['m4a1_silencer'] = 'T',
    ['famas'] = 'R',
    ['aug'] = 'U'
}

local function get_icon(weapon_name)
    if icons[weapon_name] then
        return icons[weapon_name]
    else return 'u' end
end

local log = {}

local gui = {
    rect_filled = function (x, y, w, h, color)
        renderer.rect_filled(vec2_t.new(x,y), vec2_t.new(x+w,y+h), color)
    end,

    rect_outline = function (x, y, w, h, color)
         renderer.rect(vec2_t.new(x,y), vec2_t.new(x+w,y+h), color)
    end,

    draw_text = function (text, font, x, y, color)
        renderer.text(tostring(text), font, vec2_t.new(x, y), FONT_SIZE, color)
    end
}

local function clear()
    log = {}
end

local function get_feed_size()
    return ui.get_int('killfeed_length')
end

local function is_rgb()
    return ui.get_bool('killfeed_rgb_border')
end

local function hsv2rgb(h, s, v)
    local r, g, b

    local i = math.floor(h * 6);
    local f = h * 6 - i;
    local p = v * (1 - s);
    local q = v * (1 - f * s);
    local t = v * (1 - (1 - f) * s);

    i = i % 6

    if i == 0 then r, g, b = v, t, p
    elseif i == 1 then r, g, b = q, v, p
    elseif i == 2 then r, g, b = p, v, t
    elseif i == 3 then r, g, b = p, q, v
    elseif i == 4 then r, g, b = t, p, v
    elseif i == 5 then r, g, b = v, p, q
    end

    return color_t.new(r * 255, g * 255, b * 255, 200)
end

local rainbow = 0.0

local function on_paint()
    rainbow = rainbow + (globalvars.get_frame_time() * 0.1)

    if rainbow > 1.0 then
        rainbow = 0.0
    end

    for i = 1, get_feed_size(), 1 do
        local data = log[i]

        if data then
            local length_self = renderer.get_text_size(font.verdana, FONT_SIZE, data.self)
            local length_name = renderer.get_text_size(font.verdana, FONT_SIZE, data.name)
            local length_weapon = renderer.get_text_size(font.astrium, FONT_SIZE, get_icon(data.weapon))

            local length = length_self.x + length_name.x + length_weapon.x + 30

            if data.is_headshot then
                length = length + 10
            end

            local y = 50 + 36 * i
            local x = screen.x - length - 10

            gui.rect_filled(x, y, length, 27, color_t.new(0, 0, 0, 170))

            if is_rgb() then
                gui.rect_outline(x, y, length, 27, hsv2rgb(rainbow, 1, 1))
            else
                gui.rect_outline(x, y, length, 27, color_t.new(255, 0, 0, 200))
            end

            gui.draw_text(data.self, font.verdana, x + 6, y + 4, color_t.new(0, 130, 255, 255))
            gui.draw_text(get_icon(data.weapon), font.astrium, x + length_self.x + 10, y + 5, color_t.new(200, 200, 200, 255))

            if data.is_headshot then
                gui.draw_text('s', font.astrium, x + length_self.x + 10 + length_weapon.x + 3, y + 4, color_t.new(200, 200, 200, 255))
            end

            if data.is_headshot then
                gui.draw_text(data.name, font.verdana, x + length_self.x + 10 + length_weapon.x + 23, y + 4, color_t.new(230, 230, 23, 255))
            else
                gui.draw_text(data.name, font.verdana, x + length_self.x + 10 + length_weapon.x + 5, y + 4, color_t.new(230, 230, 23, 255))
            end
        end
    end
end

local function on_event(event)
    if event:get_name() == 'round_start' then
        engine.execute_client_cmd('cl_drawhud_force_deathnotices -1')

        clear()

        return
    end

    if event:get_name() ~= "player_death" then
        return
    end

    local attacker = engine.get_player_for_user_id(event:get_int("attacker", 0))
    local target = engine.get_player_for_user_id(event:get_int("userid", 0))
    local me = engine.get_local_player()
    local weapon_name = event:get_string('weapon', '')
    local is_hs = event:get_bool('headshot', false)

    if me ~= attacker or me == target then
        return
    end

    for i = get_feed_size(), 2, -1 do
        log[i] = log[i-1]
    end

    log[1] = {
        self = engine.get_player_info(me).name,
        name = engine.get_player_info(target).name,
        weapon = weapon_name,
        is_headshot = is_hs
    }
end

client.register_callback('paint', on_paint)
client.register_callback('fire_game_event', on_event)

client.register_callback('unload', function ()
    engine.execute_client_cmd('cl_drawhud_force_deathnotices 1')
end)

engine.execute_client_cmd('cl_drawhud_force_deathnotices -1')
