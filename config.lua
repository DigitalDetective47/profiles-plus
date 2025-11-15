function SMODS.current_mod.config_tab()
    return {
        n = G.UIT.ROOT,
        config = { r = 0.1, colour = G.C.BLACK, emboss = 0.05 },
        nodes = { {
            n = G.UIT.C,
            config = { minw = 7 },
            nodes = {
                -- { n = G.UIT.R, nodes = { create_toggle { label = localize("modpacks", "profile_UI"), ref_table = SMODS.Mods.ProfilesPlus.config, ref_value = "modpacks" } } },
                -- { n = G.UIT.R, config = { minh = 0.4 } },
                { n = G.UIT.R, nodes = { { n = G.UIT.T, config = { text = localize("permanent_options", "profile_UI"), scale = 0.6, colour = G.C.UI.TEXT_LIGHT } } } },
                { n = G.UIT.R, nodes = { create_toggle { label = localize("Balatro", "profile_UI"), ref_table = SMODS.Mods.ProfilesPlus.config.permanent_options, ref_value = "Balatro" } } },
                { n = G.UIT.R, nodes = { create_toggle { label = localize("more_profiles", "profile_UI"), ref_table = SMODS.Mods.ProfilesPlus.config.permanent_options, ref_value = "more_profiles" } } },
                { n = G.UIT.R, nodes = { create_toggle { label = localize("Cryptid", "profile_UI"), ref_table = SMODS.Mods.ProfilesPlus.config.permanent_options, ref_value = "Cryptid" } } },
            }
        } }
    }
end

return {
    permanent_options = { Balatro = true, more_profiles = false, Cryptid = false },
    save_order = {},
    modpacks = false,
}
