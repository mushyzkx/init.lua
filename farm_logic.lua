local LP = game.Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local TS = game:GetService("TweenService")

_G.AutoFarm = false
_G.TweenSpeed = 220

-- // TABELA COMPLETA DE MISSÕES - SEA 1 // --
local function GetQuest()
    local lvl = LP.Data.Level.Value
    
    if lvl >= 0 and lvl < 10 then
        return "BanditQuest1", "Bandit", CFrame.new(1059, 16, 1548), 1
    elseif lvl >= 10 and lvl < 15 then
        return "BanditQuest1", "Monkey", CFrame.new(-1601, 37, 153), 1 -- Monkey
    elseif lvl >= 15 and lvl < 30 then
        return "MonkeyQuest1", "Monkey", CFrame.new(-1601, 37, 153), 1
    elseif lvl >= 30 and lvl < 60 then
        return "MonkeyQuest1", "Gorilla", CFrame.new(-1210, 28, -492), 2
    elseif lvl >= 60 and lvl < 90 then
        return "SnowQuest", "Snow Bandit", CFrame.new(1385, 15, -1322), 1
    elseif lvl >= 90 and lvl < 120 then
        return "SnowQuest", "Snowman", CFrame.new(1385, 15, -1322), 2
    elseif lvl >= 120 and lvl < 150 then
        return "BuggyQuest1", "Brute", CFrame.new(-1141, 4, 3831), 1
    elseif lvl >= 150 and lvl < 175 then
        return "DesertQuest", "Desert Bandit", CFrame.new(894, 6, 4390), 1
    elseif lvl >= 175 and lvl < 225 then
        return "DesertQuest", "Desert Officer", CFrame.new(894, 6, 4390), 2
    elseif lvl >= 225 and lvl < 250 then
        return "MarineQuest2", "Military Detective", CFrame.new(-4855, 22, 4338), 1
    elseif lvl >= 250 and lvl < 300 then
        return "MarineQuest2", "Military Officer", CFrame.new(-4855, 22, 4338), 2
    elseif lvl >= 300 and lvl < 325 then
        return "SkyQuest", "Sky Bandit", CFrame.new(-4839, 716, -2619), 1
    elseif lvl >= 325 and lvl < 375 then
        return "SkyQuest", "Dark General", CFrame.new(-4839, 716, -2619), 2
    elseif lvl >= 375 and lvl < 400 then
        return "UnderwaterQuest", "Fishman Warrior", CFrame.new(61122, 18, 1565), 1
    elseif lvl >= 400 and lvl < 450 then
        return "UnderwaterQuest", "Fishman Commando", CFrame.new(61122, 18, 1565), 2
    elseif lvl >= 450 and lvl < 475 then
        return "LavaQuest", "Magma Ninja", CFrame.new(-5242, 8, 8516), 1
    elseif lvl >= 475 and lvl < 525 then
        return "LavaQuest", "Lava Pirate", CFrame.new(-5242, 8, 8516), 2
    elseif lvl >= 525 and lvl < 550 then
        return "ImpelQuest", "Shipwright", CFrame.new(5221, 5, 743), 1
    elseif lvl >= 550 and lvl < 625 then
        return "ImpelQuest", "Great Shipwright", CFrame.new(5221, 5, 743), 2
    elseif lvl >= 625 and lvl < 700 then
        return "SkyExp1Quest", "Shanda", CFrame.new(-7859, 5545, -381), 1
    else
        return "SkyExp1Quest", "Shanda", CFrame.new(-7859, 5545, -381), 1 -- Limite Sea 1
    end
end

-- // FUNÇÃO DE AUTO-EQUIPAR // --
-- Tenta equipar o primeiro item do inventário (Melee ou Sword)
local function AutoEquip()
    if not LP.Character:FindFirstChildOfClass("Tool") then
        for _, v in pairs(LP.Backpack:GetChildren()) do
            if v:IsA("Tool") and (v.ToolTip == "Melee" or v.ToolTip == "Sword") then
                LP.Humanoid:EquipTool(v)
                break
            end
        end
    end
end

-- // FUNÇÃO DE MOVIMENTO // --
function ToTarget(CF)
    if not LP.Character or not LP.Character:FindFirstChild("HumanoidRootPart") then return end
    local dist = (CF.Position - LP.Character.HumanoidRootPart.Position).Magnitude
    if dist > 15 then
        local tween = TS:Create(LP.Character.HumanoidRootPart, TweenInfo.new(dist/_G.TweenSpeed, Enum.EasingStyle.Linear), {CFrame = CF})
        tween:Play()
    else
        LP.Character.HumanoidRootPart.CFrame = CF
    end
end

-- // LOOP PRINCIPAL // --
spawn(function()
    while task.wait(0.1) do
        if _G.AutoFarm then
            pcall(function()
                local qName, mName, qPos, qID = GetQuest()
                local questGui = LP.PlayerGui.Main.Quest
                
                AutoEquip() -- Garante que está com a arma na mão
                
                if not questGui.Visible then
                    ToTarget(qPos)
                    if (LP.Character.HumanoidRootPart.Position - qPos.Position).Magnitude < 20 then
                        RS.Remotes.CommF_:InvokeServer("StartQuest", qName, qID)
                    end
                else
                    local enemy = nil
                    for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if v.Name == mName and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            enemy = v
                            break
                        end
                    end

                    if enemy then
                        repeat task.wait()
                            if not _G.AutoFarm or not enemy.Parent or enemy.Humanoid.Health <= 0 then break end
                            -- Farm de cima (evita levar dano)
                            LP.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0)
                            
                            -- Clique de ataque
                            game:GetService("VirtualUser"):CaptureController()
                            game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                        until not enemy.Parent
                    else
                        ToTarget(qPos * CFrame.new(0, 50, 0)) -- Espera o spawn lá no alto
                    end
                end
            end)
        end
    end
end)
