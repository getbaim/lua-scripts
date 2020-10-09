local verdana = g_Render.InitFont("Verdana", 12)
local screen_size = g_EngineClient.GetScreenSize()

local clear_button = cheat.Checkbox('clear table', false)
local size = cheat.SliderInt('size of table', 3, 16, 8)
local line_color = cheat.Color("Change my color")

local pos_x = cheat.SliderInt('position x', 0, screen_size.x, 0)
local pos_y = cheat.SliderInt('position y', 0, screen_size.y, 0)

local id = 0
local list = {}

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
    list = {}
end

local function get_table_size()
    if #list > size:GetInt() then
        return size:GetInt()
    end

    return #list
end

local function color(r, g, b, a)
    return Color.new(r / 255, g / 255, b / 255, a / 255)
end

local function rect_filled(x, y, w, h, color)
    g_Render.BoxFilled(Vector2.new(x, y), Vector2.new(x + w, y + h), color)
end

local miss_reasons = {
    'resolver',
    'spread',
    'occlusion',
    'predict'
}

local function get_damage_color(damage)
    if damage > 90 then
        return color(255, 0, 0, 255)
    elseif damage > 70 then
        return color(255, 89, 0, 255)
    elseif damage > 40 then
        return color(255, 191, 0, 255)
    elseif damage > 1 then
        return color(9, 255, 0, 255)
    else
        return color(0, 140, 255, 255)
    end
end

local function on_shot(shot)
    local ent = g_EntityList.GetClientEntity(shot.target_index)
    local player = ent:GetPlayer()

    local result = '-'
    local hitbox = get_hitbox(shot.hitgroup + 1)
    local bt = '-'

    if shot.backtrack > 0 then
        bt = shot.backtrack
    end

    if shot.reason > 0 then
        result = miss_reasons[shot.reason]
    end

    for i = size:GetInt(), 2, -1 do
        list[i] = list[i-1]
    end

    id = id + 1

    list[1] = {
        ['id'] = id,
        ['player'] = string.sub(player:GetName(), 0, 14),
        ['damage'] = shot.damage,
        ['hitbox'] = hitbox,
        ['result'] = result,
        ['bt'] = tostring(bt)
    }
end

local function on_draw()
    if clear_button:GetBool() then
        clear()

        clear_button:SetBool(false)
    end

    local size = 18 + 18 * get_table_size()

    local p_x = pos_x:GetInt()
    local p_y = pos_y:GetInt() 

    rect_filled(p_x, p_y, 295, size, color(22, 20, 26, 100))
    rect_filled(p_x, p_y, 295, 18, color(22, 20, 26, 170))
    rect_filled(p_x, p_y, 295, 2, line_color:GetColor())

    g_Render.Text('ID', Vector2.new(p_x + 7, p_y + 3), color(255, 255, 255, 255), 12, verdana)
    g_Render.Text('PLAYER', Vector2.new(p_x + 7 + 35, p_y + 3), color(255, 255, 255, 255), 12, verdana)
    g_Render.Text('DMG', Vector2.new(p_x + 7 + 114, p_y + 3), color(255, 255, 255, 255), 12, verdana)
    g_Render.Text('HITBOX', Vector2.new(p_x + 7 + 153, p_y + 3), color(255, 255, 255, 255), 12, verdana)
    g_Render.Text('REASON', Vector2.new(p_x + 7 + 210, p_y + 3), color(255, 255, 255, 255), 12, verdana)
    g_Render.Text('BT', Vector2.new(p_x + 7 + 265, p_y + 3), color(255, 255, 255, 255), 12, verdana)

    for i = 1, get_table_size(), 1 do
        local data = list[i]

        if not data then goto skip end

        local x = p_x + 10
        local y = p_y + 18 + (i - 1) * 18 + 1

        rect_filled(p_x, y - 1, 2, 17, get_damage_color(data.damage))

        local dmg = '-'

        if data.damage > 0 then
            dmg = tostring(data.damage)
        end

        g_Render.Text(tostring(data.id), Vector2.new(x - 3, y), color(255, 255, 255, 255), 12, verdana)
        g_Render.Text(data.player, Vector2.new(x + 33, y), color(255, 255, 255, 255), 12, verdana)
        g_Render.Text(dmg, Vector2.new(x + 110, y), color(255, 255, 255, 255), 12, verdana)
        g_Render.Text(data.hitbox, Vector2.new(x + 150, y), color(255, 255, 255, 255), 12, verdana)
        g_Render.Text(data.result, Vector2.new(x + 207, y), color(255, 255, 255, 255), 12, verdana)
        g_Render.Text(tostring(data.bt), Vector2.new(x + 262, y), color(255, 255, 255, 255), 12, verdana)

        ::skip::
    end
end

cheat.RegisterCallback('draw', on_draw)
cheat.RegisterCallback('registered_shot', on_shot)