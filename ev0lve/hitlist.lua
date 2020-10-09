renderer.new_font("verdana", "Verdana", 12, 500, flag.new(fontflags.outline, fontflags.dropshadow, fontflags.antialias))

local screen_w, screen_h = engine_client.get_screen_size()

local is_enable = gui.new_checkbox("enable", "misc_hitlist", false)
local pos_x = gui.new_slider("position x", "misc_hitlist_pos_x", 0, 0, screen_w, 1)
local pos_y = gui.new_slider("position y", "misc_hitlist_pos_y", 0, 0, screen_h, 1)
local clear = gui.new_checkbox("clear log", "misc_hitlist_clear", false)

local id = 0
local data = {}

local hue = 0

local hitboxes = {
    "body",
    "head",
    "chest",
    "stomach",
    "left arm",
    "right arm",
    "left leg",
    "right leg",
    "neck",
    "?",
    "gear",
}

local function get_size()
    if #data > 8 then
        return 8
    end

    return #data
end

function on_shot_fired(shot)
    if not is_enable:get_value() then
        return
    end

    for i = 8, 2, -1 do 
        data[i] = data[i-1]
    end

    local target = shot.target
    local reason = shot.result
    local damage = shot.server_damage
    local bt = shot.backtrack

    if reason == "hit" then
        reason = "-"
    end

    if damage == 0 then
        damage = "-"
    end

    if bt == 0 then
        bt = "-"
    end

    id = id + 1

    data[1] = {
        id = id,
        player = string.sub(engine_client.get_player_info(target).name, 0, 9),
        hitbox = hitboxes[shot.server_hitgroup + 1],
        damage = damage,
        reason = reason,
        bt = bt
    }
end

local function on_object(mx, my, pos_x, pos_y, w, h)
    return mx <= pos_x + w and mx >= pos_x and my <= pos_y + h and my >= pos_y
end

local is_drag = false

function on_paint()
    if clear:get_value() then
        clear:set_value(false)

        id = 0
        data = {}
    end

    if not is_enable:get_value() then
        return
    end

    local size = 18 + 18 * get_size()

    if gui.is_menu_open() then
        local mx, my = input_handler.get_cursor_pos()
        local key_pressed = input_handler.is_key_pressed(1)

        if on_object(mx, my, pos_x:get_value(), pos_y:get_value(), 295, size) and key_pressed then
            is_drag = true
        elseif not key_pressed then
            is_drag = false
        end

        if is_drag then
            pos_x:set_value(mx - 295 / 2)
            pos_y:set_value(my - 15)
        end
    end

    local x = pos_x:get_value()
    local y = pos_y:get_value()

    local color = utils.hsv_to_rgb(hue, 1, 1)

    if hue >= 360 then
        hue = 0
    end

    renderer.rect_filled(x, y, x + 295, y + 18, color.new(22, 20, 26, 210))
    renderer.rect_filled(x, y, x + 295, y + size, color.new(22, 20, 26, 130))
    renderer.rect_filled(x, y, x + 295, y + 2, color.new(color.r, color.g, color.b, color.a))

    local white = color.new(255, 255, 255)

    renderer.text(x + 7, y + 3, white, "ID", fonts.verdana)
    renderer.text(x + 7 + 35, y + 3, white, "PLAYER", fonts.verdana)
    renderer.text(x + 7 + 95, y + 3, white, "HITBOX", fonts.verdana)
    renderer.text(x + 7 + 153, y + 3, white, "DAMAGE", fonts.verdana)
    renderer.text(x + 7 + 210, y + 3, white, "REASON", fonts.verdana)
    renderer.text(x + 7 + 265, y + 3, white, "BT", fonts.verdana)


    for i = 1, get_size(), 1 do
        local shot = data[i]

        if shot then
            local pitch = x + 10
            local yaw = y + 18 + (i - 1) * 18 + 1

            local shot_color

            if shot.reason == '-' then
                shot_color = color.new(0, 255, 0)
            else
                shot_color = color.new(255, 0, 0)
            end

            renderer.rect_filled(x, yaw - 1, x + 2, yaw + 17, shot_color)
            renderer.text(pitch - 3, yaw, white, tostring(shot.id), fonts.verdana)
            renderer.text(pitch + 33, yaw, white, shot.player, fonts.verdana)
            renderer.text(pitch + 92, yaw, white, shot.hitbox, fonts.verdana)
            renderer.text(pitch + 150, yaw, white, tostring(shot.damage), fonts.verdana)
            renderer.text(pitch + 207, yaw, white, shot.reason, fonts.verdana)
            renderer.text(pitch + 262, yaw, white, tostring(shot.bt), fonts.verdana)
        end
    end

    hue = hue + 0.5
end