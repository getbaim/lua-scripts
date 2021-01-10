

local helper = require 'ffi_helper'

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

local dlight_enable = ui.add_check_box('enable dlights', 'dlight_enable', false)
local dlight_color = ui.add_color_edit('color dlights', 'dlight_color', false, color_t.new(255, 255, 255, 255))
local dlight_radius = ui.add_slider_int('radius dlights', 'dlight_radius', 0, 250, 1)
local dlight_style = ui.add_slider_int('style dlights', 'dlight_style', 1, 11, 1)

local elight_enable = ui.add_check_box('enable elights', 'elight_enable', false)
local elight_color = ui.add_color_edit('color elights', 'elight_color', false, color_t.new(255, 255, 255, 255))
local elight_radius = ui.add_slider_int('radius elights', 'elight_radius', 0, 250, 1)
local elight_style = ui.add_slider_int('style elights', 'elight_style', 1, 11, 1)

local function on_paint()
    if not engine.is_in_game() then return end

    local players = entitylist.get_players(2)

    local dlight = {
        enable = dlight_enable:get_value(),
        color = dlight_color:get_value(),
        radius = dlight_radius:get_value(),
        style = dlight_style:get_value()
    }

    local elight = {
        enable = elight_enable:get_value(),
        color = elight_color:get_value(),
        radius = elight_radius:get_value(),
        style = elight_style:get_value()
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

