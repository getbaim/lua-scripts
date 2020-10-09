ui.add_keybind("autopeek key", "misc_autopeek_bind", 0, 2)
ui.add_combo("render type", "misc_autopeek_render_type", { '3d', '2d (fps)' }, 0)

local m_iHealth = se.get_netvar("DT_BasePlayer", "m_iHealth")
local m_vecOrigin = se.get_netvar("DT_BaseEntity", "m_vecOrigin")
local m_vecVelocity = {
    [0] = se.get_netvar("DT_BasePlayer", "m_vecVelocity[0]"),
    [1] = se.get_netvar("DT_BasePlayer", "m_vecVelocity[1]")
}

local data = nil

local is_shot = false
local is_toggled = false

local function draw_line(s_x, s_y, e_x, e_y, color)
    renderer.line(vec2_t.new(s_x, s_y), vec2_t.new(e_x, e_y), color)
end

local function draw_ground_circle_3d(vec3, radius, color)
    local width = 1
    local percentage = 1

    local screen_x_line_old, screen_y_line_old

    for rot = 0, percentage * 360, 3 do
        local rot_temp = math.rad(rot)

        local lineX, lineY, lineZ = radius * math.cos(rot_temp) + vec3.x, radius * math.sin(rot_temp) + vec3.y, vec3.z
        local distance = 256

        local fraction, entindex_hit = trace.line(-1, -1, vec3_t.new(lineX, lineY, lineZ+distance/2), vec3_t.new(lineX, lineY, lineZ-distance/2))

        if fraction > 0 and 1 > fraction then
            lineZ = lineZ+distance/2-(distance * fraction)
        end

        local screen = se.world_to_screen(vec3_t.new(lineX, lineY, lineZ))

        if screen.x ~=nil and screen_x_line_old ~= nil then
            for i=1, width do
                local i=i-1
                draw_line(screen.x, screen.y-i, screen_x_line_old, screen_y_line_old-i, color)
            end
            if outline then
                local outline_a = a/255*160
                draw_line(screen.x, screen.y-width, screen_x_line_old, screen_y_line_old-width, color)
                draw_line(screen.x, screen.y+1, screen_x_line_old, screen_y_line_old+1, color)
            end
        end
        screen_x_line_old, screen_y_line_old = screen.x, screen.y
    end
end

local function on_paint()
    if not is_toggled then return end

    local pos = se.world_to_screen(data)

    if not is_shot then
        if ui.get_int('misc_autopeek_render_type') == 0 then
            draw_ground_circle_3d(data, 25, color_t.new(0, 0, 0, 110))
        else
            renderer.circle(pos, 25, 25, true, color_t.new(0, 0, 0, 110))
        end
    else
        if ui.get_int('misc_autopeek_render_type') == 0 then
            draw_ground_circle_3d(data, 25, color_t.new(0, 255, 0, 50))
        else

            renderer.circle(pos, 25, 25, true, color_t.new(0, 255, 0, 50))
        end
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

    if ui.get_bind_state("misc_autopeek_bind") and not is_toggled then
        is_toggled = true
        is_shot = false

        data = vec3
    elseif not ui.get_bind_state("misc_autopeek_bind") and is_toggled then
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
       
        if velocity == 0 and globalvars.get_current_time() - time > 0.1 then
            is_shot = false
        end
    end
end

client.register_callback("fire_game_event", on_shot)
client.register_callback("create_move", main)
client.register_callback("paint", on_paint)

