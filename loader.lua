-- =============================================
-- Team Vexyron Loader
-- Lädt API + UI automatisch
-- =============================================

print("[Vexyron] Starte Loader...")

local success, err = pcall(function()
    -- API laden
    local api = loadstring(game:HttpGet("https://raw.githubusercontent.com/DEINUSERNAME/TeamVexyron-API/main/Modules/AvatarStealer.lua"))()
    getgenv().Vexyron = api
    
    -- UI laden
    loadstring(game:HttpGet("https://raw.githubusercontent.com/DEINUSERNAME/TeamVexyron-API/main/UI/VexyronUI.lua"))()
end)

if success then
    print("[Vexyron] Erfolgreich geladen! UI sollte offen sein.")
    print("[Vexyron] Benutze Vexyron.StealAvatar('Name') falls du per Command willst.")
else
    warn("[Vexyron] Fehler beim Laden: " .. tostring(err))
end
