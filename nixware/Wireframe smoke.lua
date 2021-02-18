local bit = require 'bit'
local ffi = require 'ffi'
local helper = require 'ffi_helper'

local client_register_callback, engine_is_in_game, ffi_string, ui_add_checkbox, helper_find_interface, helper_get_class = client.register_callback, engine.is_in_game, ffi.string, ui.add_check_box, helper.find_interface, helper.get_class

local smoke_wireframe = ui_add_checkbox('smoke wireframe', 'vis_smoke_wf', false)
local molotov_wireframe = ui_add_checkbox('molotov wireframe', 'vis_molotov_wf', false)
local update = ui_add_checkbox('force update', 'lua_forceupdate_wf', false)

local matsys = helper_find_interface('materialsystem.dll', 'VMaterialSystem080')
local first_material = matsys:get_vfunc(86, 'int(__thiscall*)(void*)')
local next_material = matsys:get_vfunc(87, 'int(__thiscall*)(void*, int)')
local invalid_material = matsys:get_vfunc(88, 'int(__thiscall*)(void*)')
local find_material = matsys:get_vfunc(89, 'void*(__thiscall*)(void*, int)')

local smoke_mat = {
    'particle/vistasmokev1/vistasmokev1_fire',
	'particle/vistasmokev1/vistasmokev1_smokegrenade',
	'particle/vistasmokev1/vistasmokev1_emods',
    
	--'particle/vistasmokev1/vistasmokev1_emods_impactdust'
}

local molotov_mat = {
    'particle/fire_burning_character',
    'particle/fire_explosion_1',
    'particle/fire_particle_2',
    'particle/fire_particle_4',
    'particle/fire_particle_8'
}

local MaterialVarFlags_t = {
    MATERIAL_VAR_DEBUG					  = bit.lshift(1, 0),
	MATERIAL_VAR_NO_DEBUG_OVERRIDE		  = bit.lshift(1, 1),
	MATERIAL_VAR_NO_DRAW				  = bit.lshift(1, 2),
	MATERIAL_VAR_USE_IN_FILLRATE_MODE	  = bit.lshift(1, 3),
	MATERIAL_VAR_VERTEXCOLOR			  = bit.lshift(1, 4),
	MATERIAL_VAR_VERTEXALPHA			  = bit.lshift(1, 5),
	MATERIAL_VAR_SELFILLUM				  = bit.lshift(1, 6),
	MATERIAL_VAR_ADDITIVE				  = bit.lshift(1, 7),
	MATERIAL_VAR_ALPHATEST				  = bit.lshift(1, 8),
	MATERIAL_VAR_MULTIPASS				  = bit.lshift(1, 9),
	MATERIAL_VAR_ZNEARER				  = bit.lshift(1, 10),
	MATERIAL_VAR_MODEL					  = bit.lshift(1, 11),
	MATERIAL_VAR_FLAT					  = bit.lshift(1, 12),
	MATERIAL_VAR_NOCULL					  = bit.lshift(1, 13),
	MATERIAL_VAR_NOFOG					  = bit.lshift(1, 14),
	MATERIAL_VAR_IGNOREZ				  = bit.lshift(1, 15),
	MATERIAL_VAR_DECAL					  = bit.lshift(1, 16),
	MATERIAL_VAR_ENVMAPSPHERE			  = bit.lshift(1, 17),
	MATERIAL_VAR_NOALPHAMOD				  = bit.lshift(1, 18),
	MATERIAL_VAR_ENVMAPCAMERASPACE	      = bit.lshift(1, 19),
	MATERIAL_VAR_BASEALPHAENVMAPMASK	  = bit.lshift(1, 20),
	MATERIAL_VAR_TRANSLUCENT              = bit.lshift(1, 21),
	MATERIAL_VAR_NORMALMAPALPHAENVMAPMASK = bit.lshift(1, 22),
	MATERIAL_VAR_NEEDS_SOFTWARE_SKINNING  = bit.lshift(1, 23),
	MATERIAL_VAR_OPAQUETEXTURE			  = bit.lshift(1, 24),
	MATERIAL_VAR_ENVMAPMODE				  = bit.lshift(1, 25),
	MATERIAL_VAR_SUPPRESS_DECALS		  = bit.lshift(1, 26),
	MATERIAL_VAR_HALFLAMBERT			  = bit.lshift(1, 27),
	MATERIAL_VAR_WIREFRAME                = bit.lshift(1, 28),
	MATERIAL_VAR_ALLOWALPHATOCOVERAGE     = bit.lshift(1, 29),
	MATERIAL_VAR_IGNORE_ALPHA_MODULATION  = bit.lshift(1, 30),
}

local once = false

local function includes(list, val)
    for i = 1, #list do
        if list[i] == val then
            return true
        end
    end

    return false
end

local function edit_material()
    local i = first_material()

    while i ~= invalid_material() do
        local mat = helper_get_class(find_material(i))

        local get_name = mat:get_vfunc(0, 'const char*(__thiscall*)(void*)')
        local set_material_flag = mat:get_vfunc(29, 'void(__thiscall*)(void*, int, bool)')

        local name = ffi_string(get_name())

        if includes(smoke_mat, name) then
            set_material_flag(MaterialVarFlags_t.MATERIAL_VAR_WIREFRAME, smoke_wireframe:get_value())
        end

        for i = 1, #molotov_mat do
            if name:find(molotov_mat[i]) then
                set_material_flag(MaterialVarFlags_t.MATERIAL_VAR_WIREFRAME, molotov_wireframe:get_value())
            end
        end

        i = next_material(i)
    end
end

local function on_frame_stage_notify(stage)
    if stage ~= 5 then return end

    if update:get_value() then
        edit_material()

        update:set_value(false)
    end

    if not engine_is_in_game() or once then
        return
    end

    edit_material()

    once = true
end

client_register_callback('frame_stage_notify', on_frame_stage_notify)
client_register_callback('fire_game_event', function (e)
    if e:get_name() == 'round_prestart' then
        once = false
    end
end)
