

--[[
    # Author: linius#0001
    # Description: hitlist window like b1g cheats
--]]

local font_verdana = renderer.setup_font("C:/windows/fonts/verdana.ttf", 12, 16)
local screen = engine.get_screen_size()

ui.add_checkbox("clear table", "hitlog_clear", false)

ui.add_slider_int("position x", "hitlog_pos_x", 0, screen.x, 111)
ui.add_slider_int("position y", "hitlog_pos_y", 0, screen.y, 383)

local utils = {
    to_rgba = function (params)
        return params[1], params[2], params[3], params[4]
    end,

    hsv2rgb = function (h, s, v, a)
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

        return { r * 255, g * 255, b * 255, a * 255 }
    end
}

local gui = {
    rect_filled = function(x, y, w, h, color)
        renderer.rect_filled(vec2_t.new(x,y), vec2_t.new(x+w,y+h), color_t.new(utils.to_rgba(color)))
    end,

    draw_text = function (x, y, text)
        renderer.text(tostring(text), font_verdana, vec2_t.new(x,y), 12, color_t.new(255, 255, 255, 255))
    end
}

local id = 0
local hitlog = {}

local hitboxes = {
    'generic',
    'head',
    'chest',
    'stomach',
    'left arm',
    'right arm',
    'left leg',
    'right leg',
    'body'
}

local function get_hitbox(index)
    if hitboxes[index] then
        return hitboxes[index]
    else
        return "generic"
    end
end

local function clear()
    id = 0
    hitlog = {}
end

local function get_damage_color(damage)
    if damage > 90 then
        return { 255, 0, 0, 255 }
    elseif damage > 70 then
        return { 255, 89, 0, 255 }
    elseif damage > 40 then
        return { 255, 191, 0, 255 }
    elseif damage > 1 then
        return { 9, 255, 0, 255 }
    else
        return { 0, 140, 255, 255 }
    end
end

local function get_size()
    if #hitlog > 8 then
        return 8
    end

    return #hitlog
end

local rainbow = 0.0
local is_drag = false

local function on_object(mx, my, pos_x, pos_y, w, h)
    return mx <= pos_x + w and mx >= pos_x and my <= pos_y + h and my >= pos_y
end

local function on_paint()
    if ui.get_bool("hitlog_clear") then
        clear()
        ui.set_bool("hitlog_clear", false)
    end

    rainbow = rainbow + (globalvars.get_frame_time() * 0.1)
    if rainbow > 1.0 then
        rainbow = 0.0
    end

    local pos_x = ui.get_int('hitlog_pos_x')
    local pos_y = ui.get_int('hitlog_pos_y')

    local size = 18 + 18 * get_size()

    if ui.is_visible() then
        local cursor = renderer.get_cursor_pos()
        local key_pressed = client.is_key_pressed(1)

        if on_object(cursor.x, cursor.y, pos_x, pos_y, 295, size) and key_pressed then
            is_drag = true
        elseif not key_pressed then
            is_drag = false
        end

        if is_drag then
            pos_x = cursor.x - 295 / 2
            pos_y = cursor.y - 15

            ui.set_int('hitlog_pos_x', pos_x)
            ui.set_int('hitlog_pos_y', pos_y)
        end
    end

    gui.rect_filled(pos_x, pos_y, 295, size, { 22, 20, 26, 100 })
    gui.rect_filled(pos_x, pos_y, 295, 18, { 22, 20, 26, 170 })
    gui.rect_filled(pos_x, pos_y, 295, 2, utils.hsv2rgb(rainbow, 1, 1, 1))

    gui.draw_text(pos_x + 7, pos_y + 3, "ID")
    gui.draw_text(pos_x + 7 + 35, pos_y + 3, "PLAYER")
    gui.draw_text(pos_x + 7 + 114, pos_y + 3, "DMG")
    gui.draw_text(pos_x + 7 + 153, pos_y + 3, "HITBOX")
    gui.draw_text(pos_x + 7 + 210, pos_y + 3, "REASON")
    gui.draw_text(pos_x + 7 + 265, pos_y + 3, "BT")

    for i = 1, get_size(), 1 do
        local data = hitlog[i]

        if data then
            local pitch = pos_x + 10
            local yaw = pos_y + 18 + (i - 1) * 18 + 1

            gui.rect_filled(pos_x, yaw - 1, 2, 17, get_damage_color(data.damage))
            gui.draw_text(pitch - 3, yaw, data.id)
            gui.draw_text(pitch + 33, yaw, data.player)
            gui.draw_text(pitch + 110, yaw, data.damage)
            gui.draw_text(pitch + 152, yaw, data.hitbox)
            gui.draw_text(pitch + 207, yaw, data.result)
            gui.draw_text(pitch + 262, yaw, data.bt)
        end
    end
end

se.register_event('player_hurt')

local cache = {
    target_name = '-',
    damage = 0,
}

local function on_shot(shot)
    if shot.manual then
        return
    end

    local hitbox = get_hitbox(shot.server_hitgroup + 1)
    local r_hitbox = get_hitbox(shot.hitbox + 1)
    local result = '-'
    local bt = shot.backtrack

    local box = '-'

    if shot.result ~= 'hit' then
        result = shot.result
    end

    if shot.server_hitgroup == 0 and shot.result ~= 'hit' then
        box = r_hitbox
    else
        box = hitbox
    end

    for i = 8, 2, -1 do
        hitlog[i] = hitlog[i-1]
    end

    id = id + 1

    local target = string.sub(engine.get_player_info(shot.target:get_index()).name, 0, 12)

    hitlog[1] = {
        ["id"] = id,
        ["player"] = target,
        ["damage"] = shot.server_damage,
        ["hitbox"] = box,
        ["result"] = result,
        ["bt"] = bt
    }
end

client.register_callback("shot_fired", on_shot)
client.register_callback("paint", on_paint)

