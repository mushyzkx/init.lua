-- ============================================
-- BLOX FRUITS HUB | mushyzkx/init.lua
-- Redz Hub Style: Auto Quest + Fast Click + Teleport
-- Delta Executor | Keyless
-- ============================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Anti AFK
local VirtualUser = game:GetService("VirtualUser")
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- URL base do repositório
local RepoURL = "https://raw.githubusercontent.com/mushyzkx/init.lua/main/"

-- Carregar módulos
print("🔧 Carregando Auto Farm...")
local AutoFarm = loadstring(game:HttpGet(RepoURL .. "modules/autofarm.lua"))()

print("🎨 Carregando Interface...")
local UI = loadstring(game:HttpGet(RepoURL .. "ui/interface.lua"))()

-- Iniciar
UI({AutoFarm = AutoFarm})

print("✅ Blox Fruits Hub - Redz Style carregado!")
print("🎯 Features: Auto Quest | Fast Click | Teleport | All Seas")
