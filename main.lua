-- ============================================
-- BLOX FRUITS HUB | mushyzkx/init.lua
-- Rayfield UI | Modular | Delta Executor
-- ============================================

-- Anti AFK
local VirtualUser = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- URL base do repositório
local RepoURL = "https://raw.githubusercontent.com/mushyzkx/init.lua/main/"

-- Carregar módulos
print("🔧 Carregando módulos...")

local AutoFarm = loadstring(game:HttpGet(RepoURL .. "modules/autofarm.lua"))()
local UI = loadstring(game:HttpGet(RepoURL .. "ui/interface.lua"))()

-- Tabela de módulos para a UI
local Modules = {
    AutoFarm = AutoFarm,
}

-- Iniciar interface
print("🎨 Iniciando Rayfield UI...")
UI(Modules)

print("✅ Blox Fruits Hub carregado com sucesso!")
print("📦 Módulos: AutoFarm")
print("🎨 UI: Rayfield")

