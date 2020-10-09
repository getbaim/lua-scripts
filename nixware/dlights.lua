local helper = require('ffi_helper')

local m_vecOrigin = se.get_netvar("DT_BaseEntity", "m_vecOrigin")

ffi.cdef[[
    typedef struct _vec3_t {
        float x,y,z;
    } vec3_t;

    typedef struct _color_t {
        unsigned char r, g, b;
        signed char exponent;
    } color_t;

    typedef struct _dlight_t {
        int flags;
        vec3_t origin;
        float radius;
        color_t color;
        float die;
        float decay;
        float minlight;
        int key;
        int style;
        vec3_t direction;
        float innerAngle;
        float outerAngle;
    } dlight_t;
]]

local effects = helper.find_interface('engine.dll', 'VEngineEffects001')
local alloc_dlight = effects:get_vfunc(4, 'dlight_t*(__thiscall*)(void*, int)')
local alloc_elight = effects:get_vfunc(5, 'dlight_t*(__thiscall*)(void*, int)')

local function draw(settings, elight)
    local light = elight and alloc_elight(settings.index) or alloc_dlight(settings.index)

    light.key = settings.index
    light.color.r = settings.color.r
    light.color.g = settings.color.g
    light.color.b = settings.color.b
    light.color.exponent = 5
    light.flags = (not elight and 0x2 or 0x0)
    light.style = settings.style
    light.direction.x = settings.pos.x
    light.direction.y = settings.pos.y
    light.direction.z = settings.pos.z
    light.origin.x = settings.pos.x
    light.origin.y = settings.pos.y
    light.origin.z = settings.pos.z 
    light.radius = settings.radius
    light.die = globalvars.get_current_time() + 0.1
    light.decay = settings.radius / 5
end

ui.add_checkbox('enable dlights', 'dlight_enable', false)
ui.add_color_edit('color dlights', 'dlight_color', false, color_t.new(255, 255, 255, 255))
ui.add_slider_int('radius dlights', 'dlight_radius', 0, 250, 1)
ui.add_slider_int('style dlights', 'dlight_style', 1, 11, 1)

ui.add_checkbox('enable elights', 'elight_enable', false)
ui.add_color_edit('color elights', 'elight_color', false, color_t.new(255, 255, 255, 255))
ui.add_slider_int('radius elights', 'elight_radius', 0, 250, 1)
ui.add_slider_int('style elights', 'elight_style', 1, 11, 1)

local function on_paint()
    if not engine.is_in_game() then return end

    local players = entitylist.get_players(2)

    local dlight = {
        enable = ui.get_bool('dlight_enable'),
        color = ui.get_color('dlight_color'),
        radius = ui.get_int('dlight_radius'),
        style = ui.get_int('dlight_style')
    }

    local elight = {
        enable = ui.get_bool('elight_enable'),
        color = ui.get_color('elight_color'),
        radius = ui.get_int('elight_radius'),
        style = ui.get_int('elight_style')
    } 

    for i = 1, #players do
        local player = players[i]

        if player:is_dormant() then
            goto skip
        end
        
        local pos = player:get_prop_vector(m_vecOrigin)
        local index = player:get_index()

        if dlight.enable then
            draw({
                index = index,
                color = dlight.color,
                style = dlight.style,
                pos = pos,
                radius = dlight.radius
            }, false)
        end

        if elight.enable then
            draw({
                index = index,
                color = elight.color,
                style = elight.style,
                pos = pos,
                radius = elight.radius
            }, true)
        end

        ::skip::
    end
end

client.register_callback('paint', on_paint)
