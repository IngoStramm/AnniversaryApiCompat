# !AnniversaryApiCompat

!AnniversaryApiCompat is a tiny World of Warcraft: The Burning Crusade Classic Anniversary addon that restores legacy global addon API aliases which older addons and WeakAuras may still call.

Recent clients expose these functions under `C_AddOns`, while older code often calls globals such as `IsAddOnLoaded` or `EnableAddOn`. This addon bridges those calls when the global is missing.

## Features

- Restores legacy aliases only when the global function is missing.
- Covers common addon-management APIs such as `IsAddOnLoaded`, `EnableAddOn`, `DisableAddOn`, `LoadAddOn`, `GetAddOnInfo`, `GetAddOnMetadata`, and related dependency/load-state helpers.
- Handles old and new `GetAddOnEnableState` argument order where possible.
- Loads early because the addon folder starts with `!`.
- Does not modify WeakAuras or any other addon files.

## Installation

Download `!AnniversaryApiCompat.zip` from the latest GitHub Release and extract it into:

```text
World of Warcraft/_anniversary_/Interface/AddOns/
```

After extraction, the addon folder should be:

```text
World of Warcraft/_anniversary_/Interface/AddOns/!AnniversaryApiCompat/
```

Restart the game or reload the UI.

Do not use GitHub's green **Code > Download ZIP** button for installation. That downloads the source repository snapshot, not the packaged addon.

## Compatibility

Built for WoW TBC Classic Anniversary client:

```text
Interface: 20505
```

## Notes

This addon is intentionally small. It exists to keep older local addons and imported WeakAuras working on Anniversary clients where Blizzard moved addon APIs into `C_AddOns`.
