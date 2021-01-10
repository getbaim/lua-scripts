local rectangle = renderer.rectangle

local is_enabled = ui.new_checkbox('VISUALS', 'Other ESP', 'Heartmarker')

local function draw_heart(x, y, r, g, b, a)
	rectangle(x + 2, y + 14, 2, 2, 0, 0, 0, a)
	rectangle(x, y + 12, 2, 2, 0, 0, 0, a)
	rectangle(x - 2, y + 10, 2, 2, 0, 0, 0, a)
	rectangle(x - 4, y + 4, 2, 6, 0, 0, 0, a)
	rectangle(x - 2, y + 2, 2, 2, 0, 0, 0, a)
	rectangle(x, y, 2, 2, 0, 0, 0, a)
	rectangle(x + 2, y, 2, 2, 0, 0, 0, a)
	rectangle(x + 4, y + 2, 2, 2, 0, 0, 0, a)
	rectangle(x + 6, y, 2, 2, 0, 0, 0, a)
	rectangle(x + 8, y, 2, 2, 0, 0, 0, a)
	rectangle(x + 10, y + 2, 2, 2, 0, 0, 0, a)
	rectangle(x + 12, y + 4, 2, 6, 0, 0, 0, a)
	rectangle(x + 10, y + 10, 2, 2, 0, 0, 0, a)
	rectangle(x + 8, y + 12, 2, 2, 0, 0, 0, a)
	rectangle(x + 6, y + 14, 2, 2, 0, 0, 0, a)
	rectangle(x + 4, y + 16, 2, 2, 0, 0, 0, a)
	rectangle(x - 2, y + 4, 2, 6, r, g, b, a)
	rectangle(x, y + 2, 4, 2, r, g, b, a)
	rectangle(x, y + 6, 4, 6, r, g, b, a)
	rectangle(x + 2, y + 4, 2, 2, r, g, b, a)
	rectangle(x + 2, y + 12, 2, 2, r, g, b, a)
	rectangle(x + 4, y + 4, 2, 12, r, g, b, a)
	rectangle(x + 6, y + 2, 4, 10, r, g, b, a)
	rectangle(x + 6, y + 12, 2, 2, r, g, b, a)
    rectangle(x + 10, y + 4, 2, 6, r, g, b, a)
	rectangle(x, y + 4, 2, 2, 254, 199, 199, a)
end

local hearts_saved = {}
local hearts = {}

local function on_fire(e)
    table.insert(hearts_saved, {
        id = e.id,
        position = { x = e.x, y = e.y, z = e.z },
    })
end

local function on_hit(e)
    for i = 1, #hearts_saved do
        if hearts_saved[i] == nil then return end

        if hearts_saved[i].id == e.id then
            local time = globals.realtime()

            table.insert(hearts, {
                position = hearts_saved[i].position,
                damage = e.damage,
                start_time = time,
                frame_time = time
            })

            table.remove(hearts_saved, i)
        end
    end
end

local function on_miss(e)
    for i = 1, #hearts_saved do
        if hearts_saved[i] == nil then return end
        if hearts_saved[i].id == e.id then
            table.remove(hearts_saved, i)
        end
    end
end

local function on_render()
    if not ui.get(is_enabled) then return end

    local realtime = globals.realtime()

    for i = 1, #hearts do
        if hearts[i] == nil then return end
        local heart = hearts[i]

        local x, y = renderer.world_to_screen(heart.position.x, heart.position.y, heart.position.z)
        local alpha = math.floor(255 - 255 * (realtime - heart.start_time))

        if realtime - heart.start_time >= 1 then
            alpha = 0
        end

        if x ~= nil and y ~= nil then
            if heart.damage <= 15 then
                draw_heart(x - 5, y - 5, 60, 255, 0, alpha)
            elseif heart.damage <= 30 then
                draw_heart(x - 5, y - 5, 255, 251, 0, alpha)
            elseif heart.damage <= 60 then
                draw_heart(x - 5, y - 5, 255, 140, 0, alpha)
            else
                draw_heart(x - 5, y - 5, 254, 19, 19, alpha)
            end
        end

        heart.position.z = heart.position.z + (realtime - heart.frame_time) * 50
        heart.frame_time = realtime

        if realtime - heart.start_time >= 1 then
            table.remove(hearts, i)
        end
    end
end

client.set_event_callback('aim_fire', on_fire)
client.set_event_callback('aim_hit', on_hit)
client.set_event_callback('aim_miss', on_miss)
client.set_event_callback('paint', on_render)
