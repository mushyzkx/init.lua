-- ============================================
-- BLOX FRUITS HUB | mushyzkx/init.lua
-- Rayfield UI | Delta Executor
-- ============================================

-- Anti AFK
local VirtualUser = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- URL base
local RepoURL = "https://raw.githubusercontent.com/mushyzkx/init.lua/main/"

-- Carregar módulos
local AutoFarm = loadstring(game:HttpGet(RepoURL .. "modules/autofarm.lua"))()
local UI = loadstring(game:HttpGet(RepoURL .. "ui/interface.lua"))()

-- Iniciar
UI({AutoFarm = AutoFarm})

print("✅ Blox Fruits Hub carregado!")
