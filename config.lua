function SMODS.current_mod.config_tab()
    ---@type 1 | 2 | 3
    local mod_default_current_option
    if SMODS.Mods.ProfilesPlus.config.mod_default then
        mod_default_current_option = 1
    elseif SMODS.Mods.ProfilesPlus.config.mod_default == false then
        mod_default_current_option = 2
    else
        mod_default_current_option = 3
    end
    return {
        n = G.UIT.ROOT,
        config = { r = 0.1, colour = G.C.BLACK, emboss = 0.05, align = "m" },
        nodes = { {
            n = G.UIT.C,
            nodes = {
                { n = G.UIT.R, config = { align = "m" }, nodes = { { n = G.UIT.T, config = { text = localize("permanent_options", "profile_UI"), scale = 0.6, colour = G.C.UI.TEXT_LIGHT } } } },
                { n = G.UIT.R, config = { align = "m" }, nodes = { create_toggle { label = localize("Balatro", "profile_UI"), ref_table = SMODS.Mods.ProfilesPlus.config.permanent_options, ref_value = "Balatro", w = 0 } } },
                { n = G.UIT.R, config = { align = "m" }, nodes = { create_toggle { label = localize("more_profiles", "profile_UI"), ref_table = SMODS.Mods.ProfilesPlus.config.permanent_options, ref_value = "more_profiles", w = 0 } } },
                { n = G.UIT.R, config = { align = "m" }, nodes = { create_toggle { label = localize("Cryptid", "profile_UI"), ref_table = SMODS.Mods.ProfilesPlus.config.permanent_options, ref_value = "Cryptid", w = 0 } } },
                { n = G.UIT.R, config = { minh = 0.4 } },
                { n = G.UIT.R, config = { align = "m" }, nodes = { { n = G.UIT.T, config = { text = localize("modpack_header", "profile_UI"), scale = 0.6, colour = G.C.UI.TEXT_LIGHT } } } },
                { n = G.UIT.R, config = { align = "m" }, nodes = { create_toggle { label = localize("modpacks", "profile_UI"), ref_table = SMODS.Mods.ProfilesPlus.config, ref_value = "enable_modpacks" } } },
                { n = G.UIT.R, config = { align = "m" }, nodes = { create_toggle { label = localize("forget", "profile_UI"), ref_table = SMODS.Mods.ProfilesPlus.config, ref_value = "forget" } } },
                { n = G.UIT.R, config = { align = "m" }, nodes = { { n = G.UIT.T, config = { text = localize("mod_default", "profile_UI"), scale = 0.4, colour = G.C.UI.TEXT_LIGHT } } } },
                { n = G.UIT.R, config = { align = "m" }, nodes = { create_option_cycle { options = localize("mod_default_options", "profile_UI"), current_option = mod_default_current_option, opt_callback = "set_mod_default", w = 5 } } },
            }
        } }
    }
end

return {
    permanent_options = { Balatro = true, more_profiles = false, Cryptid = false },
    save_order = {},
    enable_modpacks = false,
    forget = false,
    mod_default = nil,
    modpacks = {}
}
