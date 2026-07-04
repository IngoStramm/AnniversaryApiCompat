local addonApi = _G.C_AddOns

if addonApi then
  local function isAddonReference(value)
    return value ~= nil and addonApi.GetAddOnInfo and addonApi.GetAddOnInfo(value) ~= nil
  end

  local function restoreGlobal(name)
    if not _G[name] and addonApi[name] then
      _G[name] = function(...)
        return addonApi[name](...)
      end
    end
  end

  restoreGlobal("DisableAddOn")
  restoreGlobal("DisableAllAddOns")
  restoreGlobal("DoesAddOnExist")
  restoreGlobal("EnableAddOn")
  restoreGlobal("EnableAllAddOns")
  restoreGlobal("GetAddOnDependencies")
  restoreGlobal("GetAddOnInfo")
  restoreGlobal("GetAddOnMetadata")
  restoreGlobal("GetAddOnOptionalDependencies")
  restoreGlobal("GetNumAddOns")
  restoreGlobal("IsAddOnLoadable")
  restoreGlobal("IsAddOnLoaded")
  restoreGlobal("IsAddOnLoadOnDemand")
  restoreGlobal("LoadAddOn")

  if not _G.GetAddOnEnableState and addonApi.GetAddOnEnableState then
    _G.GetAddOnEnableState = function(first, second)
      if second ~= nil and not isAddonReference(first) and isAddonReference(second) then
        return addonApi.GetAddOnEnableState(second, first)
      end

      return addonApi.GetAddOnEnableState(first, second)
    end
  end
end

local function installColorPickerCompat()
  local colorPicker = _G.ColorPickerFrame

  if not colorPicker or colorPicker.AnniversaryApiCompatInstalled then
    return
  end

  colorPicker.AnniversaryApiCompatInstalled = true

  local fallback = function() end

  local function normalizeCallbacks()
    if type(colorPicker.swatchFunc) ~= "function" or colorPicker.swatchFunc == fallback then
      colorPicker.swatchFunc = type(colorPicker.func) == "function" and colorPicker.func or fallback
    end

    if colorPicker.hasOpacity and type(colorPicker.opacityFunc) ~= "function" then
      colorPicker.opacityFunc = fallback
    end

    if type(colorPicker.cancelFunc) ~= "function" then
      colorPicker.cancelFunc = fallback
    end
  end

  colorPicker:HookScript("OnShow", normalizeCallbacks)

  if colorPicker.SetupColorPickerAndShow then
    hooksecurefunc(colorPicker, "SetupColorPickerAndShow", normalizeCallbacks)
  end
end

installColorPickerCompat()

local frame = CreateFrame and CreateFrame("Frame")
if frame then
  frame:RegisterEvent("PLAYER_LOGIN")
  frame:SetScript("OnEvent", installColorPickerCompat)
end
