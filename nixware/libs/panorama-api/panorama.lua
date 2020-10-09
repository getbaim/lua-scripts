local helper = require('ffi_helper')

ffi.cdef[[
    typedef const char*(__thiscall* get_panel_id_t)(void*, void); // 9
    typedef void*(__thiscall* get_parent_t)(void*); // 25
]]

local panorama_engine = helper.find_interface("panorama.dll", "PanoramaUIEngine001")
local access_ui_engine = panorama_engine:get_vfunc(11, "void*(__thiscall*)(void*, void)")

local uiengine = helper.get_class(access_ui_engine())
local run_script = uiengine:get_vfunc(113, "int (__thiscall*)(void*, void*, char const*, char const*, int, int, bool, bool)")
local is_valid_panel_ptr = uiengine:get_vfunc(36, "bool(__thiscall*)(void*, void*)")
local get_last_target_panel = uiengine:get_vfunc(56, "void*(__thiscall*)(void*)")


local get_panel_id = uiengine:get_vfunc(56, "void*(__thiscall*)(void*)")
local get_parent = uiengine:get_vfunc(56, "void*(__thiscall*)(void*)")

local function get_panel_id(panelptr)
    local vtbl = panelptr[0] or error("panelptr is nil", 2)
    local func = vtbl[9] or error("panelptr_vtbl is nil", 2)
    local fn = ffi.cast("get_panel_id_t", func)
    return ffi.string(fn(panelptr))
end

local function get_parent(panelptr)
    local vtbl = panelptr[0] or error("panelptr is nil", 2)
    local func = vtbl[25] or error("panelptr_vtbl is nil", 2)
    local fn = ffi.cast("get_parent_t", func)
    return fn(panelptr)
end

local iterations = 0
local function get_root(isingame)
    local itr = get_last_target_panel() 
    if itr == nil then 
        return
    end
    local ret = nil
    local panelptr = nil
    while itr ~= nil and is_valid_panel_ptr(itr) do 

        panelptr = ffi.cast("void***", itr)
        
        if not isingame then 
            if get_panel_id(panelptr) == "CSGOMainMenu" then 
                ret = itr
                break
            end
        else 
            if get_panel_id(panelptr) == "CSGOHud" then 
                ret = itr
                break
            end
        end

        itr = get_parent(panelptr) or error("Couldn't get parent..", 2)
        iterations = iterations + 1
    end
    iterations = 0
    return ret
end

local rootpanel = get_root(engine.is_in_game()) or error("Couldn't get root panel..", 2)

local function eval(code, custompanel)
    if not is_valid_panel_ptr(rootpanel) then 
        rootpanel = get_root(engine.is_in_game()) or error("Couldn't get root panel..", 2)
    end
    run_script(rootpanel, ffi.string(code), "panorama/layout/base_mainmenu.xml", 8, 10, false, false)
end

return {
    eval = eval
}
