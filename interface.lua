-- ui/interface.lua
-- Interface Rayfield para Blox Fruits Hub

return function(Modules)
    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
    
    local Window = Rayfield:CreateWindow({
        Name = "Blox Fruits Hub",
        LoadingTitle = "Carregando...",
        LoadingSubtitle = "by mushyzkx",
        ConfigurationSaving = {
            Enabled = true,
            FolderName = "BloxFruitsHub",
            FileName = "Config"
        },
        Discord = {
            Enabled = false,
            Invite = "",
            RememberJoins = false
        },
        KeySystem = false
    })
    
    -- Tab Principal
    local MainTab = Window:CreateTab("Principal", 4483345998)
    
    MainTab:CreateToggle({
        Name = "Auto Farm",
        CurrentValue = false,
        Flag = "AutoFarm",
        Callback = function(Value)
            if Value then
                Modules.AutoFarm:Start("Bandit") -- Mob padrão, pode mudar
            else
                Modules.AutoFarm:Stop()
            end
        end
    })
    
    MainTab:CreateToggle({
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
        ["Starter"] = CFrame.new(1041, 16, 1428),
        ["Jungle"] = CFrame.new(-1241, 11, 341),
        ["Pirate Village"] = CFrame.new(-1123, 4, 3850),
        ["Desert"] = CFrame.new(897, 6, 4389),
        ["Frozen Village"] = CFrame.new(1196, 27, -1224),
        ["Marine Fortress"] = CFrame.new(-4505, 20, 4260),
        ["Skylands"] = CFrame.new(-4970, 718, -2620),
        ["Prison"] = CFrame.new(4854, 5, 734),
        ["Colosseum"] = CFrame.new(-1428, 7, -3014),
        ["Magma Village"] = CFrame.new(-5246, 9, 8500),
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
            local Humanoid = game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid")
            if Humanoid then
                Humanoid.WalkSpeed = Value
            end
        end
    })
    
    Rayfield:LoadConfiguration()
end

