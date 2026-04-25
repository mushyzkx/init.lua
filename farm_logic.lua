local LP = game.Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local TS = game:GetService("TweenService")

_G.AutoFarm = false
_G.TweenSpeed = 220

-- // SISTEMA DE SELEÇÃO AUTOMÁTICA DE QUEST // --
local function GetQuest()
    local lvl = LP.Data.Level.Value
    
    -- SEA 1
    if lvl < 10 then return "BanditQuest1", "Bandit", CFrame.new(1059, 16, 1548), 1
    elseif lvl < 15 then return "BanditQuest1", "Bandit", CFrame.new(1059, 16, 1548), 1
    elseif lvl < 30 then return "MonkeyQuest1", "Monkey", CFrame.new(-1601, 37, 153), 1
    -- SEA 2 (Exemplo)
    elseif lvl >= 700 and lvl < 725 then return "RaiderQuest1", "Raider", CFrame.new(-424, 73, 1836), 1
    -- SEA 3 (Exemplo)
    elseif lvl >= 1500 and lvl < 1525 then return "PiratePortQuest1", "Pirate Millionaire", CFrame.new(-290, 15, 5521), 1
    end
    
    -- DICA: Para adicionar todos, basta seguir o padrão:
    -- elseif lvl < [PRÓXIMO_LEVEL] then return "[NOME_DA_QUEST]", "[NOME_DO_NPC]", CFrame.new(X, Y, Z), 1
end

-- // MOTOR DE MOVIMENTAÇÃO (TWEEN) // --
function ToTarget(CF)
    if not LP.Character or not LP.Character:FindFirstChild("HumanoidRootPart") then return end
    local dist = (CF.Position - LP.Character.HumanoidRootPart.Position).Magnitude
    if dist < 5 then return end
    
    local tween = TS:Create(LP.Character.HumanoidRootPart, TweenInfo.new(dist/_G.TweenSpeed, Enum.EasingStyle.Linear), {CFrame = CF})
    tween:Play()
    repeat task.wait() until (LP.Character.HumanoidRootPart.Position - CF.Position).Magnitude < 12 or not _G.AutoFarm
end

-- // LOOP UNIVERSAL // --
spawn(function()
    while task.wait(0.1) do
        if _G.AutoFarm then
            local qName, mName, qPos, qID = GetQuest()
            local questGui = LP.PlayerGui.Main.Quest
            
            -- Verifica se já tem a missão certa
            if not questGui.Visible or not string.find(questGui.Container.QuestTitle.Title.Text, mName) then
                -- Se tiver a missão errada, cancela
                if questGui.Visible then
                    RS.Remotes.CommF_:InvokeServer("AbandonQuest")
                end
                -- Vai buscar a nova missão
                ToTarget(qPos)
                if (LP.Character.HumanoidRootPart.Position - qPos.Position).Magnitude < 20 then
                    task.wait(0.5)
                    RS.Remotes.CommF_:InvokeServer("StartQuest", qName, qID)
                end
            else
                -- Procura o NPC da Quest no mapa
                local enemy = nil
                for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if v.Name == mName and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        enemy = v
                        break
                    end
                end

                if enemy then
                    -- Farmando o bicho (Fica em cima dele)
                    repeat task.wait()
                        if not _G.AutoFarm or not enemy.Parent then break end
                        LP.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0)
                        
                        -- Ataque Automático
                        game:GetService("VirtualUser"):CaptureController()
                        game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                    until enemy.Humanoid.Health <= 0
                else
                    -- Se o bicho não spawnou, vai para o local de spawn dele
                    -- Aqui você pode usar uma posição de safe zone ou o centro da ilha
                end
            end
        end
    end
end)
