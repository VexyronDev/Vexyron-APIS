-- =============================================
-- Vexyron AK-Style Avatar Stealer API (MEGA GEFIXT)
-- Für XENO - Advanced FE Visible Bypass
-- =============================================

local VexyronAK = {}

local function AdvancedFEBypass()
    pcall(function()
        local lp = game.Players.LocalPlayer
        if lp then
            sethiddenproperty(lp, "SimulationRadius", 9e9)
            sethiddenproperty(lp, "MaximumSimulationRadius", 9e9)
        end
    end)
end

function VexyronAK.StealAvatar(targetName)
    AdvancedFEBypass()
    
    -- Prüfen ob Spieler existiert
    local target = game.Players:FindFirstChild(targetName)
    if not target then
        warn("[Vexyron] ❌ Spieler '" .. targetName .. "' nicht gefunden!")
        return nil
    end
    
    -- Prüfen ob Character existiert
    if not target.Character then
        warn("[Vexyron] ❌ " .. target.Name .. " hat keinen Character!")
        return nil
    end
    
    -- Prüfen ob Humanoid existiert
    local targetHumanoid = target.Character:FindFirstChildOfClass("Humanoid")
    if not targetHumanoid then
        warn("[Vexyron] ❌ " .. target.Name .. " hat kein Humanoid!")
        return nil
    end

    local lp = game.Players.LocalPlayer
    if not lp then
        warn("[Vexyron] ❌ LocalPlayer nicht gefunden!")
        return nil
    end
    
    -- KLONE MIT PCALL SCHUTZ
    local clone = nil
    local success, err = pcall(function()
        clone = target.Character:Clone()
    end)
    
    if not success or not clone then
        warn("[Vexyron] ❌ Clone fehlgeschlagen: " .. tostring(err))
        return nil
    end
    
    clone.Name = "Vexyron_FE_" .. target.Name
    clone.Parent = workspace
    
    if not clone.Parent then
        warn("[Vexyron] ❌ Clone konnte nicht zu Workspace hinzugefügt werden!")
        return nil
    end

    -- Full Avatar Description kopieren
    local hum = clone:FindFirstChildOfClass("Humanoid")
    if hum and targetHumanoid then
        pcall(function()
            hum:ApplyDescription(targetHumanoid:GetAppliedDescription())
        end)
    end

    -- Accessories, Tools, Clothing klauen
    for _, item in ipairs(target.Character:GetChildren()) do
        if item:IsA("Accessory") or item:IsA("Tool") or item:IsA("Shirt") or item:IsA("Pants") or item:IsA("BodyColors") then
            pcall(function()
                local clonedItem = item:Clone()
                if clonedItem then
                    clonedItem.Parent = clone
                end
            end)
        end
    end

    -- LocalPlayer Character ersetzen
    pcall(function()
        if lp.Character then 
            lp.Character:Destroy() 
        end
    end)
    
    lp.Character = clone

    print("[Vexyron] ✅ Avatar von " .. target.Name .. " erfolgreich gestohlen!")
    return clone
end

function VexyronAK.StealAll()
    AdvancedFEBypass()
    local count = 0
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= game.Players.LocalPlayer then
            local result = VexyronAK.StealAvatar(plr.Name)
            if result then
                count = count + 1
            end
            wait(0.5)
        end
    end
    print("[Vexyron] ✅ " .. count .. " Avatare erfolgreich gestohlen!")
end

return VexyronAK
