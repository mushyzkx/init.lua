-- ============================================
-- BLOX FRUITS HUB | mushyzkx/init.lua
-- Delta Executor | Keyless
-- ============================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HRP = Character:WaitForChild("HumanoidRootPart")

-- Anti AFK
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
    wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
end)

-- Character reload
LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
    Humanoid = char:WaitForChild("Humanoid")
    HRP = char:WaitForChild("HumanoidRootPart")
end)

-- Teleport function
function Tp(pos)
    if not HRP then return end
    local dist = (pos - HRP.Position).Magnitude
    if dist < 300 then
        HRP.CFrame = CFrame.new(pos)
    else
        TweenService:Create(HRP, TweenInfo.new(dist/350, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)}):Play()
    end
end

-- Get nearest enemy
function GetEnemy()
    local nearest, dist = nil, math.huge
    for _, v in pairs(Workspace.Enemies:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
            local d = (v.HumanoidRootPart.Position - HRP.Position).Magnitude
            if d < dist then
                dist = d
                nearest = v
            end
        end
    end
    return nearest
end

-- Auto Farm
local AutoFarm = false
function DoFarm()
    while AutoFarm do
        task.wait()
        pcall(function()
            local enemy = GetEnemy()
            if enemy then
                Tp(enemy.HumanoidRootPart.Position + Vector3.new(0, 30, 0))
                repeat
                    task.wait()
                    if enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
                        Tp(enemy.HumanoidRootPart.Position + Vector3.new(0, 5, 0))
                        VirtualUser:CaptureController()
                        VirtualUser:ClickButton1(Vector2.new(851, 158), Workspace.CurrentCamera.CFrame)
                    end
                until not enemy:FindFirstChild("Humanoid") or enemy.Humanoid.Health <= 0 or not AutoFarm
            end
        end)
    end
end

-- UI (OrionLib)
local Orion = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()
local Window = Orion:MakeWindow({Name = "Blox Fruits Hub", HidePremium = false, SaveConfig = true, ConfigFolder = "BFHub"})

local Main = Window:MakeTab({Name = "Main", Icon = "rbxassetid://4483345998"})
Main:AddToggle({Name = "Auto Farm", Default = false, Callback = function(v)
    AutoFarm = v
    if v then DoFarm() end
end})

Main:AddSlider({Name = "WalkSpeed", Min = 16, Max = 300, Default = 16, Callback = function(v)
    if Humanoid then Humanoid.WalkSpeed = v end
end})

Main:AddSlider({Name = "JumpPower", Min = 50, Max = 300, Default = 50, Callback = function(v)
    if Humanoid then Humanoid.JumpPower = v end
end})

-- Teleport Tab
local TpTab = Window:MakeTab({Name = "Teleport", Icon = "rbxassetid://4483345998"})
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
    ["Underwater City"] = CFrame.new(61122, 18, 1567),
    ["Fountain City"] = CFrame.new(5129, 59, 4105),
}

for name, cf in pairs(Islands) do
    TpTab:AddButton({Name = "TP: " .. name, Callback = function() Tp(cf.Position) end})
end

Orion:Init()
print("✅ Blox Fruits Hub loaded!")
