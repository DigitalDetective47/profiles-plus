## 1.1.3 Thunderstore Release
Added Thunderstore metadata

## 1.1.2 Profile Duplication Fix
Fixed an extra instance of a profile from appearing at the end of the profile list when resetting a profile.

## 1.1.1 Mod Icon Update
Mod icon now appears even when mod is disabled.
Hopefully fixes [#4](https://github.com/DigitalDetective47/profiles-plus/issues/4)

## 1.1.0 Extra Modlist Options
Added the following settings:
- **Forget Uninstalled Mods**: Removes mods you've removed from your Mods folder from all of your modpacks to save space. Later reinstalling the same mod, its settings on your profiles will be remembered only if this option is *disabled*.
- **Setting for New Mods**: The setting to use for newly installed mods on an existing profile.
  - **Enabled**: New mods will always be enabled.
  - **Disabled**: New mods will always be disabled.
  - **Use Previous Setting**: New mods won't be enabled or disabled.  
When switching profiles, the mod will carry over its state from the current profile.  
When loading a new mod for the first time, it will record whether the mod is on Lovely's blocklist (or has a `.lovelyignore`)

## 1.0.1 Crash fix
merged [#2](https://github.com/DigitalDetective47/profiles-plus/pull/2)

## 1.0.0 Initial Release
Initial release