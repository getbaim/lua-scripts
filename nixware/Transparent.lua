local m_bIsScoped = 0x3928 -- https://github.com/frk1/hazedumper/blob/master/csgo.hpp

local visuals_models_local_color = ui.get_color_edit('visuals_models_local_color_')
local visuals_models_local_material_color = ui.get_color_edit('visuals_models_local_material_color')

local cache = {
    chams = visuals_models_local_color:get_value(),
    material = visuals_models_local_material_color:get_value()
}

local transparent = ui.add_slider_int('transparent in scope', 'vis_transparent_in_scope', 1, 100, 25)

local function clamp(val, min, max)
    if val > max then return max end
    if val < min then return min end
    return val
end

local function on_create_move()
    local me = entitylist.get_local_player()

    if not me or not me:is_alive() then
        return
    end

    if me:get_prop_bool(m_bIsScoped) then
        local alpha = clamp(math.floor(255 / 100 * (100 - transparent:get_value()) + 0.5), 1, 255)

        visuals_models_local_color:set_value(color_t.new(cache.chams.r, cache.chams.g, cache.chams.b, alpha))
        visuals_models_local_material_color:set_value(color_t.new(cache.material.r, cache.material.g, cache.material.b, alpha))
    else
        visuals_models_local_color:set_value(cache.chams)
        visuals_models_local_material_color:set_value(cache.material)
    end
end

client.register_callback('create_move', on_create_move)
client.register_callback('on_unload', function ()
    visuals_models_local_color:set_value(cache.chams)
    visuals_models_local_material_color:set_value(cache.material)
end)


