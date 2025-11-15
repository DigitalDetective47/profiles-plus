---@type table<string, integer>
local save_order_reverse_cache = {}
---perform a cached reverse lookup on `SMODS.Mods.ProfilesPlus.config.save_order`
---@param value string
---@return integer? key returns `nil` if the requested value could not be found
function SMODS.Mods.ProfilesPlus.save_order_reverse(value)
    ---@type integer
    local cached_key = save_order_reverse_cache[value]
    if SMODS.Mods.ProfilesPlus.config.save_order[cached_key] == value then
        return cached_key
    end
    for k, v in ipairs(SMODS.Mods.ProfilesPlus.config.save_order) do
        if v == value then
            save_order_reverse_cache[value] = k
            return k
        end
    end
    sendErrorMessage(value .. " could not be found in save order.", "ProfilesPlus.save_order_reverse")
end

---@return string[]
function SMODS.Mods.ProfilesPlus.get_options()
    ---@type string[]
    local ret = SMODS.shallow_copy(SMODS.Mods.ProfilesPlus.config.save_order)
    table.insert(ret, "New")
    ---@type { id: string, setting: string}[]
    local permanent_options = { { id = "1", setting = "Balatro" }, { id = "2", setting = "Balatro" }, { id = "3", setting = "Balatro" },
        { id = "4", setting = "more_profiles" }, { id = "5", setting = "more_profiles" }, { id = "6", setting = "more_profiles" }, { id = "7", setting = "more_profiles" }, { id = "8", setting = "more_profiles" }, { id = "9", setting = "more_profiles" }, { id = "10", setting = "more_profiles" },
        { id = "M1", setting = "Cryptid" }, { id = "M2", setting = "Cryptid" }, { id = "M3", setting = "Cryptid" } }
    ---@type integer
    local ret_index = 1
    for _, entry in ipairs(permanent_options) do
        if ret[ret_index] == entry.id then
            ret_index = ret_index + 1
        elseif love.filesystem.getInfo(entry.id .. '/profile.jkr') or SMODS.Mods.ProfilesPlus.config.permanent_options[entry.setting] then
            table.insert(ret, ret_index, entry.id)
            ret_index = ret_index + 1
        end
    end
    return ret
end

function SMODS.Mods.ProfilesPlus.set_modpack()
    SMODS.Mods.ProfilesPlus.config.modpacks[G.SETTINGS.profile] = SMODS.Mods.ProfilesPlus.config.modpacks
    [G.SETTINGS.profile] or {}
    for id, mod in pairs(SMODS.Mods) do
        SMODS.Mods.ProfilesPlus.config.modpacks[G.SETTINGS.profile][id] = not mod.disabled
    end
    SMODS.save_mod_config(SMODS.Mods.ProfilesPlus)
end

if G.SETTINGS.profile:sub(1, 3) == "pp_" and not SMODS.Mods.ProfilesPlus.save_order_reverse(G.SETTINGS.profile) then
    table.insert(SMODS.Mods.ProfilesPlus.config.save_order, G.SETTINGS.profile)
end
for index = #SMODS.Mods.ProfilesPlus.config.save_order, 1, -1 do
    if not love.filesystem.getInfo(SMODS.Mods.ProfilesPlus.config.save_order[index] .. '/profile.jkr') then
        table.remove(SMODS.Mods.ProfilesPlus.config.save_order, index)
    end
end
SMODS.Mods.ProfilesPlus.set_modpack()

local profile_option_hook = G.UIDEF.profile_option
function G.UIDEF.profile_option(_profile)
    G.PROFILES[_profile] = G.PROFILES[_profile] or {}
    return profile_option_hook(_profile)
end

---@param args { from_key: integer, from_val: string, to_key: integer, to_val: string, cycle_config: { [string]: any } }
function G.FUNCS.scroll_profiles(args)
    G.focused_profile = args.to_val or "New"
    ---@type UIElement
    local profile_swapper = G.OVERLAY_MENU:get_UIE_by_ID("profile_swapper")
    profile_swapper.config.object:remove()
    profile_swapper.config.object = UIBox {
        definition = G.UIDEF.profile_option(args.to_val == "New" and "pp_" .. math.random(0, 2 ^ 32 - 1) or G.focused_profile),
        config = { parent = profile_swapper } }
    G.OVERLAY_MENU:recalculate()
end

---@return UIBox
function G.UIDEF.profile_select()
    G.focused_profile = G.focused_profile or G.SETTINGS.profile or "1"
    ---@type string[]
    local options = SMODS.Mods.ProfilesPlus.get_options()
    ---@type integer?
    local current_option = nil
    for index, id in ipairs(options) do
        if id == G.focused_profile then
            current_option = index
            break
        end
    end
    if not current_option then
        sendErrorMessage("Current profile is not in the options switcher!", "ProfilesPlus profile selector")
    end
    ---@type UIElement
    local profile_swapper = { n = G.UIT.O, config = { id = "profile_swapper" } }
    profile_swapper.config.object = UIBox { definition = G.UIDEF.profile_option(G.focused_profile), config = { parent = profile_swapper } }
    return create_UIBox_generic_options { padding = 0,
        contents = { {
            n = G.UIT.C,
            config = { align = "cm", padding = 0, draw_layer = 1, minw = 4 },
            nodes = {
                { n = G.UIT.R, config = { align = "cm", id = "profile_option_cycle" }, nodes = {
                    create_option_cycle { options = options, current_option = current_option, opt_callback = "scroll_profiles", w = 3 } } },
                { n = G.UIT.R, config = { align = "cm" }, nodes = { profile_swapper } },
            }
        } }
    }
end
