
-- =============================================
-- Vexyron AK-Style Avatar Stealer API
-- Für XENO - Advanced FE Visible Bypass
-- =============================================

local VexyronAK = {}

local function AdvancedFEBypass()
    pcall(function()
        local lp = game.Players.LocalPlayer
        sethiddenproperty(lp, "SimulationRadius", 9e9)
        sethiddenproperty(lp, "MaximumSimulationRadius", 9e9)
        
        -- Extra Network Ownership für bessere Sichtbarkeit
        if lp.Character then
            for _, part in ipairs(lp.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part:SetNetworkOwner(nil)
                end
            end
        end
    end)
end

function VexyronAK.StealAvatar(targetName)
    AdvancedFEBypass()
    
    local target = game.Players:FindFirstChild(targetName)
    if not target or not target.Character then
        warn("[Vexyron] Target nicht gefunden!")
        return nil
    end

    local lp = game.Players.LocalPlayer
    local clone = target.Character:Clone()
    clone.Name = "Vexyron_FE_" .. target.Name
    clone.Parent = workspace

    -- Full Avatar Description kopieren
    local hum = clone:FindFirstChildOfClass("Humanoid")
    if hum and target.Character:FindFirstChildOfClass("Humanoid") then
        hum:ApplyDescription(target.Character.Humanoid:GetAppliedDescription())
    end

    -- Alles klauen (Accessories, Tools, Clothing)
    for _, item in ipairs(target.Character:GetChildren()) do
        if item:IsA("Accessory") or item:IsA("Tool") or item:IsA("Shirt") or item:IsA("Pants") or item:IsA("BodyColors") then
            local clonedItem = item:Clone()
            clonedItem.Parent = clone
            if clonedItem:IsA("BasePart") then
                clonedItem:SetNetworkOwner(nil)
            end
        end
    end

    -- LocalPlayer Character ersetzen
    if lp.Character then 
        lp.Character:Destroy() 
    end
    lp.Character = clone

    print("[Vexyron] Avatar von " .. target.Name .. " erfolgreich gestohlen & FE visible gemacht!")
    return clone
end

function VexyronAK.StealAll()
    AdvancedFEBypass()
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= game.Players.LocalPlayer then
            pcall(function()
                VexyronAK.StealAvatar(plr.Name)
            end)
        end
    end
end

return VexyronAK
