-- =============================================
-- Vexyron AK-Style Avatar Stealer API (GEFIXT)
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
        
        if lp and lp.Character then
            for _, part in ipairs(lp.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    pcall(function()
                        part:SetNetworkOwner(nil)
                    end)
                end
            end
        end
    end)
end

function VexyronAK.StealAvatar(targetName)
    AdvancedFEBypass()
    
    -- PRÜFEN OB SPIELER EXISTIERT
    local target = game.Players:FindFirstChild(targetName)
    if not target then
        warn("[Vexyron] Spieler '" .. targetName .. "' nicht gefunden!")
        return nil
    end
    
    -- PRÜFEN OB CHARACTER GELADEN IST
    if not target.Character or not target.Character:FindFirstChildOfClass("Humanoid") then
        warn("[Vexyron] " .. target.Name .. " hat noch keinen Character geladen!")
        return nil
    end

    local lp = game.Players.LocalPlayer
    if not lp then
        warn("[Vexyron] LocalPlayer nicht gefunden!")
        return nil
    end
    
    local targetChar = target.Character
    local clone = targetChar:Clone()
    clone.Name = "Vexyron_FE_" .. target.Name
    clone.Parent = workspace

    -- Full Avatar Description kopieren
    local hum = clone:FindFirstChildOfClass("Humanoid")
    if hum and targetChar:FindFirstChildOfClass("Humanoid") then
        pcall(function()
            hum:ApplyDescription(targetChar.Humanoid:GetAppliedDescription())
        end)
    end

    -- Alles klauen (Accessories, Tools, Clothing)
    for _, item in ipairs(targetChar:GetChildren()) do
        if item:IsA("Accessory") or item:IsA("Tool") or item:IsA("Shirt") or item:IsA("Pants") or item:IsA("BodyColors") then
            pcall(function()
                local clonedItem = item:Clone()
                clonedItem.Parent = clone
                if clonedItem:IsA("BasePart") then
                    clonedItem:SetNetworkOwner(nil)
                end
            end)
        end
    end

    -- LocalPlayer Character ersetzen
    if lp.Character then 
        pcall(function()
            lp.Character:Destroy() 
        end)
    end
    lp.Character = clone

    print("[Vexyron] ✅ Avatar von " .. target.Name .. " erfolgreich gestohlen & FE visible gemacht!")
    return clone
end

function VexyronAK.StealAll()
    AdvancedFEBypass()
    local count = 0
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= game.Players.LocalPlayer then
            local success = pcall(function()
                VexyronAK.StealAvatar(plr.Name)
                count = count + 1
            end)
            if not success then
                warn("[Vexyron] Konnte " .. plr.Name .. " nicht stealen")
            end
        end
    end
    print("[Vexyron] ✅ " .. count .. " Avatare gestohlen!")
end

return VexyronAK
