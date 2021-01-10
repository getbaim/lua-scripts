

local background_alpha = 0
local snowflake_alpha = 0

local screen = engine.get_screen_size()

local new_checkbox = ui.add_check_box

local background_enabled = new_checkbox('background', 'snowflake_background', true)
local in_game = new_checkbox('show in game', 'snowflake_ingame', false)

local function clamp(min, max, val)
    if val > max then return max end
    if val < min then return min end
    return val
end

local function draw_line(x, y, x1, y1, r, g, b, a)
    renderer.line(vec2_t.new(x, y), vec2_t.new(x1, y1), color_t.new(r, g, b, a))
end

local function draw_rect(x, y, w, h, r, g, b, a)
    renderer.rect_filled(vec2_t.new(x, y), vec2_t.new(x + w, y + h), color_t.new(r, g, b, a))
end

local function draw_snowflake(x, y, size)
    local base = 4 + size

    draw_line(x - base, y - base, x + base + 1, y + base + 1, 255, 255, 255, snowflake_alpha - 75)
    draw_line(x + base, y - base, x - base, y + base, 255, 255, 255, snowflake_alpha - 75)

    base = 5 + size

    draw_line(x - base, y, x + base + 1, y, 255, 255, 255, snowflake_alpha - 75)
    draw_line(x, y - base, x, y + base + 1, 255, 255, 255, snowflake_alpha - 75)
end

local snowflakes = {}
local time = 0
local stored_time = 0

local function on_render()
    local show_in_game = in_game:get_value()

    if background_enabled:get_value() then
        if ui.is_visible() and background_alpha ~= 255 then
            background_alpha = clamp(0, 255, background_alpha + 10)
            snowflake_alpha = clamp(0, 255, snowflake_alpha + 10)
        end

        if not ui.is_visible() and background_alpha ~= 0 then
            background_alpha = clamp(0, 255, background_alpha - 10)
            snowflake_alpha = clamp(0, 255, snowflake_alpha - 10)
        end

        if ui.is_visible() or background_alpha ~= 0 then
            draw_rect(0, 0, screen.x, screen.y, 0, 0, 0, background_alpha - 90)
        end
    end

    if not show_in_game and not ui.is_visible() then
        return
    end

    if show_in_game then
        snowflake_alpha = 255
    end

    local frametime = globalvars.get_frame_time()

    time = time + frametime

    if #snowflakes < 128 then
        if time > stored_time then
            stored_time = time

            table.insert(snowflakes, {
                math.random(10, screen.x - 10),
                1,
                math.random(1, 3),
                math.random(-60, 60) / 100,
                math.random(-3, 0)
            })
        end
    end

    local fps = 1 / frametime

    for i = 1, #snowflakes do
        local snowflake = snowflakes[i]
        local x, y, vspeed, hspeed, size = snowflake[1], snowflake[2], snowflake[3], snowflake[4], snowflake[5]

        if screen.y <= y then
            snowflake[1] = math.random(10, screen.x - 10)
            snowflake[2] = 1
            snowflake[3] = math.random(1, 3)
            snowflake[4] = math.random(-60, 60) / 100
            snowflake[5] = math.random(-3, 0)
        end

        draw_snowflake(x, y, size)

        snowflake[2] = snowflake[2] + vspeed / fps * 100
        snowflake[1] = snowflake[1] + hspeed / fps * 100
    end
end

client.register_callback('paint', on_render)

