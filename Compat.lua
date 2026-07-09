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

local function createLegacyBigWigsAnchor(name)
  local anchor = _G[name]

  if anchor then
    return anchor
  end

  anchor = CreateFrame("Frame", name, UIParent)
  anchor:SetSize(1, 1)
  anchor:SetClampedToScreen(false)
  anchor:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 9999, 9999)
  anchor:Hide()

  return anchor
end

if CreateFrame and UIParent then
  createLegacyBigWigsAnchor("BigWigsAnchor")
  createLegacyBigWigsAnchor("BigWigsEmphasizeAnchor")
end
