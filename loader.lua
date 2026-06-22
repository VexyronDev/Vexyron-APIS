-- Team Vexyron Loader
print("[Vexyron] Starte Loader...")

local success, err = pcall(function()
    -- API laden
    local api = loadstring(game:HttpGet("https://raw.githubusercontent.com/VexyronDev/Vexyron-APIS/main/Modules/AvatarStealer.lua"))()
    getgenv().Vexyron = api
    
    -- UI laden
    loadstring(game:HttpGet("https://raw.githubusercontent.com/VexyronDev/Vexyron-APIS/main/UI/VexyronUI.lua"))()
end)

if success then
    print("[Vexyron] Erfolgreich geladen! UI sollte offen sein.")
else
    warn("[Vexyron] Fehler beim Laden: " .. tostring(err))
end
