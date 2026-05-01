-- ui/interface.lua
-- Interface Rayfield com Auto Farm All Seas

return function(Modules)
    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
    
    local Window = Rayfield:CreateWindow({
        Name = "Blox Fruits Hub - All Seas",
        LoadingTitle = "Carregando...",
        LoadingSubtitle = "by mushyzkx",
        ConfigurationSaving = {
            Enabled = true,
            FolderName = "BloxFruitsHub",
            FileName = "Config"
        },
        KeySystem = false
    })
    
    -- Tab Auto Farm
    local FarmTab = Window:CreateTab("Auto Farm", 4483345998)
    
    FarmTab:CreateToggle({
        Name = "Auto Farm (Auto Select)",
        CurrentValue = false,
        Flag = "AutoFarm",
        Callback = function(Value)
            if Value then
                Modules.AutoFarm:Start()
            else
                Modules.AutoFarm:Stop()
            end
        end
    })
    
    FarmTab:CreateDropdown({
        Name = "Select Sea",
        CurrentOption = "All",
        Options = {"All", "Sea 1", "Sea 2", "Sea 3"},
        Flag = "SelectSea",
        Callback = function(Option)
            Modules.AutoFarm.SelectedSea = Option
        end
    })
    
    FarmTab:CreateToggle({
        Name = "Fast Attack",
        CurrentValue = true,
        Flag = "FastAttack",
        Callback = function(Value)
            Modules.AutoFarm.FastAttack = Value
        end
    })
    
    -- Tab Teleport
    local TpTab = Window:CreateTab("Teleport", 4483345998)
    
    local Islands = {
        ["Sea 1 - Starter"] = CFrame.new(1041, 16, 1428),
        ["Sea 1 - Jungle"] = CFrame.new(-1241, 11, 341),
        ["Sea 1 - Pirate Village"] = CFrame.new(-1123, 4, 3850),
        ["Sea 1 - Desert"] = CFrame.new(897, 6, 4389),
        ["Sea 1 - Frozen Village"] = CFrame.new(1196, 27, -1224),
        ["Sea 1 - Marine Fortress"] = CFrame.new(-4505, 20, 4260),
        ["Sea 1 - Skylands"] = CFrame.new(-4970, 718, -2620),
        ["Sea 1 - Prison"] = CFrame.new(4854, 5, 734),
        ["Sea 1 - Colosseum"] = CFrame.new(-1428, 7, -3014),
        ["Sea 1 - Magma Village"] = CFrame.new(-5246, 9, 8500),
        
        ["Sea 2 - Kingdom of Rose"] = CFrame.new(-394, 120, -3400),
        ["Sea 2 - Green Zone"] = CFrame.new(-2200, 80, -800),
        ["Sea 2 - Graveyard"] = CFrame.new(-5500, 50, 800),
        ["Sea 2 - Snow Mountain"] = CFrame.new(600, 400, -2000),
        ["Sea 2 - Hot and Cold"] = CFrame.new(-5500, 15, -4000),
        ["Sea 2 - Cursed Ship"] = CFrame.new(900, 125, -33000),
        
        ["Sea 3 - Port Town"] = CFrame.new(-300, 80, 6500),
        ["Sea 3 - Hydra Island"] = CFrame.new(5200, 650, 100),
        ["Sea 3 - Great Tree"] = CFrame.new(2300, 50, -6500),
        ["Sea 3 - Floating Turtle"] = CFrame.new(-12000, 350, -8500),
    }
    
    for name, cf in pairs(Islands) do
        TpTab:CreateButton({
            Name = "TP: " .. name,
            Callback = function()
                Modules.AutoFarm:Teleport(cf.Position)
            end
        })
    end
    
    -- Tab Config
    local ConfigTab = Window:CreateTab("Config", 4483345998)
    
    ConfigTab:CreateSlider({
        Name = "WalkSpeed",
        Range = {16, 500},
        Increment = 1,
        Suffix = "Speed",
        CurrentValue = 16,
        Flag = "WalkSpeed",
        Callback = function(Value)
            local Humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
            if Humanoid then
                Humanoid.WalkSpeed = Value
            end
        end
    })
    
    Rayfield:LoadConfiguration()
end
