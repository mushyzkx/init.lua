-- // SERVICES & GLOBALS // --
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local TS = game:GetService("TweenService")
local WS = game:GetService("Workspace")
local VU = game:GetService("VirtualUser")
local LP = Players.LocalPlayer

-- // CONFIGURAÇÕES (Variáveis que sua UI vai controlar) // --
_G.Settings = {
    AutoFarmLevel = false,
    AutoFarmBoss = false,
    AutoChest = false,
    AutoStoreFruit = false,
    FruitESP = false,
    StatsPoint = "Melee", -- Opções: Melee, Defense, Sword, Blox Fruit
    TweenSpeed = 220
}

-- // FUNÇÕES AUXILIARES // --
local function GetLevel() return LP.Data.Level.Value end
local function GetHRP() return LP.Character:WaitForChild("HumanoidRootPart") end

-- // 1. AUTO STATS (Distribui pontos automaticamente) // --
task.spawn(function()
    while task.wait(1) do
        if _G.Settings.AutoFarmLevel then
            local points = LP.Data.StatsPoints.Value
            if points > 0 then
                RS.Remotes.CommF_:InvokeServer("AddStats", _G.Settings.StatsPoint, points)
            end
        end
    end
end)

-- // 2. DEVIL FRUIT FEATURES (Sniper & Auto Store) // --
task.spawn(function()
    while task.wait(5) do
        if _G.Settings.AutoStoreFruit then
            for _, item in pairs(LP.Backpack:GetChildren()) do
                if item:IsA("Tool") and string.find(item.Name, "Fruit") then
                    RS.Remotes.CommF_:InvokeServer("StoreFruit", item.Name, item)
                end
            end
        end
    end
end)

-- // 3. AUTO CHEST LOOTER (Coleta baús próximos) // --
local function AutoChest()
    for _, v in pairs(WS:GetChildren()) do
        if v.Name:find("Chest") and v:IsA("Part") then
            GetHRP().CFrame = v.CFrame
            task.wait(0.2)
        end
    end
end

-- // 4. MOVIMENTO OTIMIZADO // --
local function ToTarget(cf)
    local dist = (cf.Position - GetHRP().Position).Magnitude
    local tween = TS:Create(GetHRP(), TweenInfo.new(dist/_G.Settings.TweenSpeed, Enum.EasingStyle.Linear), {CFrame = cf})
    tween:Play()
    return tween
end

-- // 5. LÓGICA DE ATAQUE (Noclip + Auto Click) // --
local function FastAttack(target)
    pcall(function()
        for _, v in pairs(LP.Character:GetChildren()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
        GetHRP().CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, 11, 0)
        VU:Button1Down(Vector2.new(0,0))
    end)
end

-- // LOOP PRINCIPAL (Auto Quest + Farm Level) // --
task.spawn(function()
    while task.wait(0.1) do
        if _G.Settings.AutoFarmLevel then
            pcall(function()
                -- Aqui entra aquela tabela de Quests que fizemos do 1 ao 700
                -- Exemplo simplificado:
                local qName, mName, qPos, qID = GetQuestData(GetLevel()) 
                
                local questGui = LP.PlayerGui.Main.Quest
                if not questGui.Visible then
                    ToTarget(qPos)
                    if (GetHRP().Position - qPos.Position).Magnitude < 20 then
                        RS.Remotes.CommF_:InvokeServer("StartQuest", qName, qID)
                    end
                else
                    local enemy = WS.Enemies:FindFirstChild(mName)
                    if enemy and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                        FastAttack(enemy)
                    else
                        ToTarget(qPos * CFrame.new(0, 50, 0))
                    end
                end
            end)
        end
    end
end)
