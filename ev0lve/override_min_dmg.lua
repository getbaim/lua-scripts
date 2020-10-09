local mindmg_override = gui.get_slider('rage', 'min_dmg')

local data = {
    [0] = { enabled = false, value = 0, slider = gui.new_slider('General', 'general', 0, 0, 100, 1) },
    [1] = { enabled = false, value = 0, slider = gui.new_slider('Pistol', 'pistol', 0, 0, 100, 1) },
    [2] = { enabled = false, value = 0, slider = gui.new_slider('Heavy pistol', 'heavy_pistol', 0, 0, 100, 1) },
    [3] = { enabled = false, value = 0, slider = gui.new_slider('Automatic', 'automatic', 0, 0, 100, 1) },
    [4] = { enabled = false, value = 0, slider = gui.new_slider('AWP', 'awp', 0, 0, 100, 1) },
    [5] = { enabled = false, value = 0, slider = gui.new_slider('Scout', 'scout', 0, 0, 100, 1) },
    [6] = { enabled = false, value = 0, slider = gui.new_slider('Auto', 'auto', 0, 0, 100, 1) }
}

local function get_damage()
	local value = mindmg_override:get_value()
	
	if value then return value
	elseif not value or value == nil then return 100 end
end

local enable = gui.new_checkbox('Override', 'enable', false)
enable:set_callback(function ()
	if not mindmg_override:get_value() or mindmg_override:get_value() == nil or not mindmg_override then return end
    local group = utils.get_active_weapon_group()
		
	if not group then return end
	if group == nil or group == 7 then return end
	
    gui.set_weapon_group('rage', group)
    if data[group].enabled then
        mindmg_override:set_value(data[group].value)
        data[group].enabled = false
    else
        data[group].value = mindmg_override:get_value()
        mindmg_override:set_value(data[group].slider:get_value())
        data[group].enabled = true
    end
end)

local reset = false

renderer.new_font('mindamage_font', 'Verdana', 30, 800, flag.new(fontflags.antialias, fontflags.dropshadow))
function on_paint()
	if not mindmg_override:get_value() or mindmg_override:get_value() == nil or not mindmg_override then return end

    local group = utils.get_active_weapon_group()
	
    if not utils.get_active_weapon_group() then return end
    if group == nil or group == 7 then return end

    if not engine_client.is_ingame() then
        if not reset then
            for i = 0, 6 do
                mindmg_override:set_value(data[i].value)
                data[i].enabled = false
            end

            reset = true
        end

        return
    else
        reset = false
    end

    local w, h = renderer.get_screen_size()
	
	if group or data[group] or data[group].enabled then
		gui.set_weapon_group('rage', group)
		renderer.text(25, h - 230, data[group].enabled and color.new(25, 255, 25) or color.new(255, 25, 25), 'DMG ' .. tostring(get_damage()), fonts.mindamage_font)
	end
end



