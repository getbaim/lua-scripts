local FOLDER = io.popen('cd'):read('*l') .. '\\nix\\images\\paimon_gif'
local frames = {}

local misc_paimon_scale = ui.add_slider_int('scale', 'misc_paimon_scale', 1, 10, 2)

for file in io.popen([[dir "]] ..  FOLDER .. [[" /b]]):lines() do
    if string.find(file, '.png') then
        print(FOLDER .. '/' .. file)

        table.insert(frames, renderer.setup_texture(FOLDER .. '/' .. file))
    end
end

print('frames: ' .. tostring(#frames))

local alpha = 0
local counter = 0
local next_frame = 0
local pos = { x = 0, y = 0 }
local screen = engine.get_screen_size()

local function render_image(image, x, y, w, h)
    renderer.texture(image, vec2_t.new(x, y), vec2_t.new(x + w, y + h), color_t.new(255, 255, 255, alpha))
end

local function clamp(value, min, max)
    if value > max then return max end
    if value < min then return min end
    return value
end

client.register_callback('paint', function ()
    if #frames == 0 then return end

    if not ui.is_visible() and alpha > 0 then
        alpha = clamp(alpha - 5, 0, 255)
    end

    if ui.is_visible() and alpha < 255 then
        alpha = clamp(alpha + 5, 0, 255)
    end

    if not ui.is_visible() and alpha < 1 then
        return
    end

    local cursor = renderer.get_cursor_pos()

    if ui.is_visible() then
        pos.x = cursor.x + 50
        pos.y = cursor.y - 150
    end

    local time = math.floor(globalvars.get_current_time() * 1000)

    if next_frame - time > 30 then
        next_frame = 0
    end

    if next_frame - time < 1 then
        counter = counter + 1

        next_frame = time + 30
    end

    local frame = frames[(counter % #frames) + 1]
    local scale = clamp(misc_paimon_scale:get_value(), 1, 10)

    local w = math.floor(397 / scale)
    local h = math.floor(465 / scale)

    render_image(
        frame, 
        clamp(pos.x, 0, screen.x - w),
        clamp(pos.y, 0, screen.y - h),
        w, 
        h
    )
end)

