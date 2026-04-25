local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Snowwz Hub | BETA VERSION ❄️",
   LoadingTitle = "Carregando Snowwz Hub...",
   LoadingSubtitle = "by mushyzkx",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "SnowwzHubConfig",
      FileName = "Config"
   },
   KeySystem = false -- Defina como true se quiser colocar senha
})

-- // ABA DE FARM // --
local TabFarm = Window:CreateTab("Auto Farm 🚜", 4483362458) -- Ícone de trator

TabFarm:CreateSection("Farm Principal")

TabFarm:CreateToggle({
   Name = "Auto Farm Level",
   CurrentValue = false,
   Flag = "ToggleFarm", 
   Callback = function(Value)
       _G.AutoFarm = Value
   end,
})

TabFarm:CreateDropdown({
   Name = "Modo de Farm",
   Options = {"Up", "Orbit", "Star"},
   CurrentOption = "Up",
   Flag = "FarmMode",
   Callback = function(Option)
       _G.FarmMode = Option
   end,
})

TabFarm:CreateSlider({
   Name = "Velocidade do Tween",
   Range = {100, 350},
   Increment = 10,
   Suffix = " Speed",
   CurrentValue = 220,
   Flag = "TweenSpeed",
   Callback = function(Value)
       _G.TweenSpeed = Value
   end,
})

-- // ABA VISUAL // --
local TabVisual = Window:CreateTab("Visual & FPS 👁️", 4483345998)

TabVisual:CreateToggle({
   Name = "ESP Fruits (Flags)",
   CurrentValue = false,
   Callback = function(Value)
       _G.ESP_Fruits = Value
   end,
})

TabVisual:CreateButton({
   Name = "Smooth Mode (Boost FPS)",
   Callback = function()
       if ToggleSmooth then
           ToggleSmooth(true)
           Rayfield:Notify({Title = "S-HUB", Content = "Texturas removidas para melhor performance!"})
       end
   end,
})

-- // ABA STATUS // --
local TabStatus = Window:CreateTab("Status 📈")
local LvlLabel = TabStatus:CreateLabel("Level: Carregando...")

spawn(function()
    while task.wait(1) do
        local lp = game.Players.LocalPlayer
        if lp and lp:FindFirstChild("Data") then
            LvlLabel:Set("Level: " .. tostring(lp.Data.Level.Value))
        end
    end
end)

Rayfield:Notify({
   Title = "Snowwz Hub Carregado!",
   Content = "Aproveite o farm, mestre! ❄️",
   Duration = 5,
   Image = 4483345998,
   Actions = {
      Ignore = {
         Name = "Entendido!",
         Callback = function() print("User acknowledged") end
      },
   },
})
