-- =============================================
-- Team Vexyron - Simple UI (XENO)
-- Nur Text-Buttons + Input, kein Schnickschnack
-- =============================================

local VexyronAPI = getgenv().Vexyron
local player = game.Players.LocalPlayer

-- GUI erstellen
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VexyronUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Hauptframe
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 340, 0, 300)
MainFrame.Position = UDim2.new(0.5, -170, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Titel
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 55)
Title.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
Title.Text = "TEAM VEXYRON"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

-- Subtitle
local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1, 0, 0, 30)
SubTitle.Position = UDim2.new(0, 0, 0, 55)
SubTitle.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
SubTitle.Text = "Avatar Stealer v2.0"
SubTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
SubTitle.TextScaled = true
SubTitle.Font = Enum.Font.Gotham
SubTitle.Parent = MainFrame

-- Input
local Input = Instance.new("TextBox")
Input.Size = UDim2.new(0.85, 0, 0, 45)
Input.Position = UDim2.new(0.075, 0, 0.32, 0)
Input.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
Input.BorderSizePixel = 0
Input.TextColor3 = Color3.new(1, 1, 1)
Input.PlaceholderText = "Spielername eingeben..."
Input.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
Input.Text = ""
Input.Font = Enum.Font.Gotham
Input.TextSize = 18
Input.Parent = MainFrame

-- Steal Button
local StealBtn = Instance.new("TextButton")
StealBtn.Size = UDim2.new(0.85, 0, 0, 50)
StealBtn.Position = UDim2.new(0.075, 0, 0.48, 0)
StealBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
StealBtn.BorderSizePixel = 0
StealBtn.Text = "🔄 STEAL AVATAR"
StealBtn.TextColor3 = Color3.new(1, 1, 1)
StealBtn.TextScaled = true
StealBtn.Font = Enum.Font.GothamBold
StealBtn.Parent = MainFrame

-- Steal All Button
local StealAllBtn = Instance.new("TextButton")
StealAllBtn.Size = UDim2.new(0.85, 0, 0, 50)
StealAllBtn.Position = UDim2.new(0.075, 0, 0.68, 0)
StealAllBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
StealAllBtn.BorderSizePixel = 0
StealAllBtn.Text = "👥 STEAL ALL"
StealAllBtn.TextColor3 = Color3.new(1, 1, 1)
StealAllBtn.TextScaled = true
StealAllBtn.Font = Enum.Font.GothamBold
StealAllBtn.Parent = MainFrame

-- Status Label (unten)
local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, 0, 0, 25)
Status.Position = UDim2.new(0, 0, 0.91, 0)
Status.BackgroundColor3 = Color3.fromRGB(0, 0, 0, 0)
Status.Text = "Bereit"
Status.TextColor3 = Color3.fromRGB(150, 255, 150)
Status.TextScaled = true
Status.Font = Enum.Font.Gotham
Status.Parent = MainFrame

-- Button Funktionen
StealBtn.MouseButton1Click:Connect(function()
local name = Input.Text
if name and name ~= "" then
Status.Text = "Steale " .. name .. "..."
Status.TextColor3 = Color3.fromRGB(255, 255, 0)
local success, result = pcall(function()
return VexyronAPI.StealAvatar(name)
end)
if success and result then
Status.Text = "✅ " .. name .. " gestohlen!"
Status.TextColor3 = Color3.fromRGB(0, 255, 0)
else
Status.Text = "❌ Fehler bei " .. name
Status.TextColor3 = Color3.fromRGB(255, 0, 0)
end
else
Status.Text = "⚠️ Bitte Namen eingeben!"
Status.TextColor3 = Color3.fromRGB(255, 200, 0)
end
end)

StealAllBtn.MouseButton1Click:Connect(function()
Status.Text = "Steale alle..."
Status.TextColor3 = Color3.fromRGB(255, 255, 0)
pcall(function()
VexyronAPI.StealAll()
end)
Status.Text = "✅ Alle gestohlen!"
Status.TextColor3 = Color3.fromRGB(0, 255, 0)
end)

print("[Vexyron] UI geladen! Viel Spaß, King 👑")
