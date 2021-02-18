local materialsystem_find_materials, ui_get = materialsystem.find_materials, ui.get

local molotov_mat = {
    'particle/fire_burning_character',
    'particle/fire_explosion_1',
    'particle/fire_particle_2',
    'particle/fire_particle_4',
    'particle/fire_particle_8'
}

local enable = ui.new_checkbox('Visuals', 'Other ESP', 'Wireframe molotov')

local function set_wireframe(value)
    for i = 1, #molotov_mat do
        local materials = materialsystem_find_materials(molotov_mat[i])
    
        for j = 1, #materials do
            materials[j]:set_material_var_flag(28, value)
        end
    end
end

local cache = false

client.set_event_callback('net_update_end', function ()
    if cache ~= ui_get(enable) then
        set_wireframe(ui_get(enable))

        cache = ui_get(enable)
    end
end)

client.set_event_callback('round_prestart', function ()
    cache = not cache
end)