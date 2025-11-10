if not SMODS.current_mod.config.save_order.reverse[tostring(G.SETTINGS.profile)] then
    table.insert(SMODS.current_mod.config.save_order, G.SETTINGS.profile)
    SMODS.current_mod.config.save_order.reverse[tostring(G.SETTINGS.profile)] = #SMODS.current_mod.config.save_order
    SMODS.save_mod_config(SMODS.current_mod)
end

local profile_option_hook = G.UIDEF.profile_option
function G.UIDEF.profile_option(_profile)
    G.PROFILES[_profile] = G.PROFILES[_profile] or {}
    return profile_option_hook(_profile)
end

---@param args { from_key: integer, from_val: string, to_key: integer, to_val: string, cycle_config: { [string]: any } }
function G.FUNCS.scroll_profiles(args)
    G.focused_profile = tonumber(args.to_val) or "New"
    ---@type UIElement
    local profile_swapper = G.OVERLAY_MENU:get_UIE_by_ID("profile_swapper")
    profile_swapper.config.object:remove()
    profile_swapper.config.object = UIBox {
        definition = G.UIDEF.profile_option(args.to_val == "New" and math.random(128, 2 ^ 32 - 1) or G.focused_profile),
        config = { parent = profile_swapper } }
    G.OVERLAY_MENU:recalculate()
end

---@return UIBox
function G.UIDEF.profile_select()
    G.focused_profile = G.focused_profile or G.SETTINGS.profile or 1
    ---@type string[]
    local options = {}
    for index, id in ipairs(SMODS.Mods.ProfilesPlus.config.save_order) do
        options[index] = tostring(id)
    end
    table.insert(options, "New")
    ---@type UIElement
    local profile_swapper = { n = G.UIT.O, config = { id = "profile_swapper" } }
    profile_swapper.config.object = UIBox { definition = G.UIDEF.profile_option(G.focused_profile), config = { parent = profile_swapper } }
    return create_UIBox_generic_options { padding = 0,
        contents = { {
            n = G.UIT.C,
            config = { align = "cm", padding = 0, draw_layer = 1, minw = 4 },
            nodes = {
                { n = G.UIT.R, config = { align = "cm", id = "profile_option_cycle" }, nodes = {
                    create_option_cycle { options = options, current_option = SMODS.Mods.ProfilesPlus.config.save_order.reverse[tostring(G.focused_profile)], opt_callback = "scroll_profiles" } } },
                { n = G.UIT.R, config = { align = "cm" }, nodes = { profile_swapper } },
            }
        } }
    }
end
