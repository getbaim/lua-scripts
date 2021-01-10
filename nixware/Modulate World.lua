local ffi = require('ffi')
local helper = require('ffi_helper')

local materialsystem = helper.find_interface('materialsystem.dll', 'VMaterialSystem080')
local first_material = materialsystem:get_vfunc(86, 'int(__thiscall*)(void*)')
local next_material = materialsystem:get_vfunc(87, 'int(__thiscall*)(void*, int)')
local invalid_material = materialsystem:get_vfunc(88, 'int(__thiscall*)(void*)')
local find_material = materialsystem:get_vfunc(89, 'void*(__thiscall*)(void*, int)')

local enabled = ui.add_check_box('enabled', 'lua_worldcolor_enabled', false)

local vis_modulate_world = ui.add_color_edit('modulate world', 'vis_modulate_world', true, color_t.new(255, 255, 255, 255))
local vis_modulate_props = ui.add_color_edit('modulate props', 'vis_modulate_props', true, color_t.new(255, 255, 255, 255))
local vis_modulate_models = ui.add_color_edit('modulate models', 'vis_modulate_models', true, color_t.new(255, 255, 255, 255))
local vis_modulate_sky = ui.add_color_edit('modulate sky', 'vis_modulate_sky', true, color_t.new(255, 255, 255, 255))

local forceupdate = ui.add_check_box('force update', 'lua_worldcolor_forceupdate', false)

local once = false

local r_DrawSpecificStaticProp = se.get_convar("r_DrawSpecificStaticProp")

local function on_frame_stage_notify(stage)
    if stage ~= 5 or not engine.is_in_game() or not enabled:get_value() or once then return end

    local world_color = vis_modulate_world:get_value()
    local props_color = vis_modulate_props:get_value()
    local models_color = vis_modulate_models:get_value()
    local sky_color = vis_modulate_sky:get_value()

    local i = first_material()

    while i ~= invalid_material() do
        local material = helper.get_class(find_material(i))
        local get_group = material:get_vfunc(1, "const char*(__thiscall*)(void*)")
        local modulate_alpha = material:get_vfunc(27, "void(__thiscall*)(void*, float)")
        local modulate_color = material:get_vfunc(28, "void(__thiscall*)(void*, float, float, float)")
        local group = ffi.string(get_group())

        if group:find('Sky') then 
            modulate_color(sky_color.r / 255, sky_color.g / 255, sky_color.b / 255)
        end

        if group:find('World') then
            modulate_color(world_color.r / 255, world_color.g / 255, world_color.b / 255)
            modulate_alpha(world_color.a / 255)
        end

        if group:find('StaticProp') then 
            r_DrawSpecificStaticProp:set_int(0)
            modulate_color(props_color.r / 255, props_color.g / 255, props_color.b / 255)
            modulate_alpha(props_color.a / 255)
        end

        if group:find('Model') then 
            modulate_color(models_color.r / 255, models_color.g / 255, models_color.b / 255)
            modulate_alpha(models_color.a / 255)
        end

        i = next_material(i)
    end

    once = true
end

local function on_event(event)
    if event:get_name() == 'round_prestart' then
        once = false
    end
end

local function on_paint()
    if forceupdate:get_value() then
        forceupdate:set_value(false)

        once = false
    end
end

client.register_callback('frame_stage_notify', on_frame_stage_notify)
client.register_callback('fire_game_event', on_event)
client.register_callback('paint', on_paint)
