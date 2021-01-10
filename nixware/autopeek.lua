local misc_autopeek_bind = ui.add_key_bind("autopeek key", "misc_autopeek_bind", 0, 2)
local misc_autopeek_render_type = ui.add_combo_box("render type", "misc_autopeek_render_type", { '3d circle', '2d circle' }, 0)
local radius = ui.add_slider_int('radius', 'misc_autopeek_radius', 1, 30, 20)
local first_color = ui.add_color_edit('first color', 'misc_autopeek_firstclr', true, color_t.new(0, 0, 0, 110))
local second_color = ui.add_color_edit('second color', 'misc_autopeek_secondclr', true, color_t.new(0, 255, 0, 110))
local animation = ui.add_check_box('animation', 'misc_autopeek_animation', true)
local is_filled = ui.add_check_box('filled', 'misc_autopeek_filled', true)

local m_iHealth = se.get_netvar("DT_BasePlayer", "m_iHealth")
local m_vecOrigin = se.get_netvar("DT_BaseEntity", "m_vecOrigin")
local m_vecVelocity = {
    [0] = se.get_netvar("DT_BasePlayer", "m_vecVelocity[0]"),
    [1] = se.get_netvar("DT_BasePlayer", "m_vecVelocity[1]")
}

local data = nil

local is_shot = false
local is_toggled = false

local function draw_circle_3d(pos, points, radius, clr, filled, filled_clr)
    local step = math.pi * 2 / points

    local vec_points = {}

    local z = pos.z

    local traceline = trace.line(-1, -1, vec3_t.new(pos.x, pos.y, pos.z+256/2), vec3_t.new(pos.x, pos.y, pos.z-256/2))

    if traceline.fraction > 0 and 1 > traceline.fraction then
        z = z+256/2-(256 * traceline.fraction)
    end

    for i = 0.0, math.pi * 2.0, step do
        local start = vec3_t.new(
            radius * math.cos(i) + pos.x,
            radius * math.sin(i) + pos.y,
            z
        )

        local start2d = se.world_to_screen(start)

        if start2d then
            table.insert(vec_points, start2d)
        end
    end

    if filled then
        renderer.filled_polygon(vec_points, filled_clr)
    end

    for i = 1, #vec_points, 1 do
        local point = vec_points[i]
        local next_point = vec_points[i + 1] and vec_points[i + 1] or vec_points[1]

        renderer.line(point, next_point, clr)
    end
end

local _radius = 0

local function clamp(value, min, max)
    if value > max then return max end
    if value < min then return min end
    return value
end

local function on_paint()
    local max_radius = radius:get_value()
    
    if animation:get_value() and is_toggled then
        _radius = clamp(_radius + 1, 0, max_radius)
    elseif not animation:get_value() and is_toggled then
        _radius = max_radius
    end

    if _radius == 0 then return end

    if not is_toggled and animation:get_value() then
        _radius = clamp(_radius - 1, 0, max_radius)
    elseif not is_toggled and not animation:get_value() then
        _radius = 0
    end

    local pos = se.world_to_screen(data)

    if pos.x == nil or pos.y == nil then return end

    local color = is_shot and second_color:get_value() or first_color:get_value()

    if misc_autopeek_render_type:get_value() == 0 then
        draw_circle_3d(data, 100, _radius, color, is_filled:get_value(), color)
    else
        renderer.circle(pos, _radius, 25, is_filled:get_value(), color)
    end
end 

local time = nil

local function on_shot(event)
    local target = engine.get_player_for_user_id(event:get_int("userid", 0))
    local me = engine.get_local_player()

    if event:get_name() == "weapon_fire" and me == target then
        is_shot = true

        time = globalvars.get_current_time()
    end
end

local function main(user)
    local me = entitylist.get_entity_by_index(engine.get_local_player())

    if me:get_prop_int(m_iHealth) < 1 then
        return
    end

    local vec3 = me:get_prop_vector(m_vecOrigin)
    local current_pos = vec3

    if misc_autopeek_bind:is_active() and not is_toggled then
        is_toggled = true
        is_shot = false

        data = vec3
    elseif not misc_autopeek_bind:is_active() and is_toggled then
        is_toggled = false
        is_shot = false
    end

    if is_shot and is_toggled then
        local vec_forward = {
            x = current_pos.x - data.x,
            y = current_pos.y - data.y,
            z = current_pos.z - data.z
        }

        local yaw = engine.get_view_angles().yaw

        local t_velocity = {
            x = vec_forward.x * math.cos(yaw / 180 * math.pi) + vec_forward.y * math.sin(yaw / 180 * math.pi),
            y = vec_forward.y * math.cos(yaw / 180 * math.pi) - vec_forward.x * math.sin(yaw / 180 * math.pi),
            z = vec_forward.z
        }

        user.forwardmove = -t_velocity.x * 20
        user.sidemove = t_velocity.y * 20

        velocity = math.sqrt(me:get_prop_float(m_vecVelocity[0]) ^ 2 + me:get_prop_float(m_vecVelocity[1]) ^ 2);

        if velocity < 3 and globalvars.get_current_time() - time > 0.5 then
            is_shot = false
        end
    end
end

client.register_callback("fire_game_event", on_shot)
client.register_callback("create_move", main)
client.register_callback("paint", on_paint)
