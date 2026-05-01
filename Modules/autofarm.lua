-- modules/autofarm.lua
-- Auto Farm COMPLETO estilo Redz Hub
-- Auto Quest + Teleport + Fast Attack + Auto Click

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- Anti AFK
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
    wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
end)

-- Character reload
LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
end)

-- ============================================
-- DADOS DE TODAS AS QUESTS (3 SEAS)
-- ============================================

local Quests = {
    -- SEA 1
    {Mob = "Bandit", Level = 0, Quest = "BanditQuest1", QuestPos = CFrame.new(1059, 16, 1547), MobPos = CFrame.new(1143, 16, 1634), Sea = 1},
    {Mob = "Monkey", Level = 15, Quest = "JungleQuest1", QuestPos = CFrame.new(-1598, 36, 153), MobPos = CFrame.new(-1611, 36, 146), Sea = 1},
    {Mob = "Gorilla", Level = 20, Quest = "JungleQuest2", QuestPos = CFrame.new(-1598, 36, 153), MobPos = CFrame.new(-1323, 42, -471), Sea = 1},
    {Mob = "Pirate", Level = 35, Quest = "BuggyQuest1", QuestPos = CFrame.new(-1139, 4, 3825), MobPos = CFrame.new(-1151, 16, 3840), Sea = 1},
    {Mob = "Brute", Level = 40, Quest = "BuggyQuest2", QuestPos = CFrame.new(-1139, 4, 3825), MobPos = CFrame.new(-1387, 4, 3900), Sea = 1},
    {Mob = "Desert Bandit", Level = 60, Quest = "DesertQuest1", QuestPos = CFrame.new(897, 6, 4389), MobPos = CFrame.new(932, 6, 4488), Sea = 1},
    {Mob = "Desert Officer", Level = 75, Quest = "DesertQuest2", QuestPos = CFrame.new(897, 6, 4389), MobPos = CFrame.new(1602, 6, 4372), Sea = 1},
    {Mob = "Snow Bandit", Level = 90, Quest = "SnowQuest1", QuestPos = CFrame.new(1388, 87, -1298), MobPos = CFrame.new(1356, 87, -1318), Sea = 1},
    {Mob = "Snowman", Level = 100, Quest = "SnowQuest2", QuestPos = CFrame.new(1388, 87, -1298), MobPos = CFrame.new(1294, 87, -1416), Sea = 1},
    {Mob = "Chief Petty Officer", Level = 120, Quest = "MarineQuest2", QuestPos = CFrame.new(-5036, 28, 4325), MobPos = CFrame.new(-5086, 28, 4422), Sea = 1},
    {Mob = "Sky Bandit", Level = 150, Quest = "SkyQuest1", QuestPos = CFrame.new(-4842, 718, -2623), MobPos = CFrame.new(-4973, 718, -2620), Sea = 1},
    {Mob = "Dark Master", Level = 175, Quest = "SkyQuest2", QuestPos = CFrame.new(-4842, 718, -2623), MobPos = CFrame.new(-5259, 388, -2272), Sea = 1},
    {Mob = "Prisoner", Level = 190, Quest = "PrisonQuest1", QuestPos = CFrame.new(5309, 2, 477), MobPos = CFrame.new(5310, 2, 480), Sea = 1},
    {Mob = "Dangerous Prisoner", Level = 210, Quest = "PrisonQuest2", QuestPos = CFrame.new(5309, 2, 477), MobPos = CFrame.new(5543, 2, 633), Sea = 1},
    {Mob = "Toga Warrior", Level = 250, Quest = "ColosseumQuest1", QuestPos = CFrame.new(-1576, 7, -2983), MobPos = CFrame.new(-1824, 7, -3093), Sea = 1},
    {Mob = "Gladiator", Level = 275, Quest = "ColosseumQuest2", QuestPos = CFrame.new(-1576, 7, -2983), MobPos = CFrame.new(-1274, 7, -3138), Sea = 1},
    {Mob = "Military Soldier", Level = 300, Quest = "MagmaQuest1", QuestPos = CFrame.new(-5316, 12, 8517), MobPos = CFrame.new(-5335, 12, 8571), Sea = 1},
    {Mob = "Military Spy", Level = 325, Quest = "MagmaQuest2", QuestPos = CFrame.new(-5316, 12, 8517), MobPos = CFrame.new(-5817, 12, 8767), Sea = 1},
    {Mob = "Fishman Warrior", Level = 375, Quest = "FishmanQuest1", QuestPos = CFrame.new(61122, 18, 1567), MobPos = CFrame.new(61101, 18, 1572), Sea = 1},
    {Mob = "Fishman Commando", Level = 400, Quest = "FishmanQuest2", QuestPos = CFrame.new(61122, 18, 1567), MobPos = CFrame.new(61866, 18, 1513), Sea = 1},
    {Mob = "God's Guard", Level = 450, Quest = "SkyQuest3", QuestPos = CFrame.new(-4721, 845, -1952), MobPos = CFrame.new(-4692, 845, -1952), Sea = 1},
    {Mob = "Shanda", Level = 475, Quest = "SkyQuest4", QuestPos = CFrame.new(-7679, 5545, -876), MobPos = CFrame.new(-7679, 5545, -876), Sea = 1},
    {Mob = "Royal Squad", Level = 500, Quest = "SkyQuest5", QuestPos = CFrame.new(-7679, 5545, -876), MobPos = CFrame.new(-7679, 5545, -876), Sea = 1},
    {Mob = "Royal Soldier", Level = 525, Quest = "SkyQuest6", QuestPos = CFrame.new(-7679, 5545, -876), MobPos = CFrame.new(-7679, 5545, -876), Sea = 1},
    
    -- SEA 2
    {Mob = "Raider", Level = 700, Quest = "Area1Quest1", QuestPos = CFrame.new(-429, 73, 1836), MobPos = CFrame.new(-728, 39, 2392), Sea = 2},
    {Mob = "Mercenary", Level = 725, Quest = "Area1Quest2", QuestPos = CFrame.new(-429, 73, 1836), MobPos = CFrame.new(-1022, 17, 1491), Sea = 2},
    {Mob = "Swan Pirate", Level = 775, Quest = "Area2Quest1", QuestPos = CFrame.new(87, 73, 1233), MobPos = CFrame.new(182, 73, 1250), Sea = 2},
    {Mob = "Factory Staff", Level = 800, Quest = "Area2Quest2", QuestPos = CFrame.new(87, 73, 1233), MobPos = CFrame.new(289, 73, -57), Sea = 2},
    {Mob = "Marine Lieutenant", Level = 875, Quest = "MarineQuest3", QuestPos = CFrame.new(-2440, 73, -3219), MobPos = CFrame.new(-2486, 73, -3282), Sea = 2},
    {Mob = "Marine Captain", Level = 900, Quest = "MarineQuest4", QuestPos = CFrame.new(-2440, 73, -3219), MobPos = CFrame.new(-2311, 73, -3260), Sea = 2},
    {Mob = "Zombie", Level = 950, Quest = "ZombieQuest1", QuestPos = CFrame.new(-5494, 49, -794), MobPos = CFrame.new(-5536, 49, -835), Sea = 2},
    {Mob = "Vampire", Level = 975, Quest = "ZombieQuest2", QuestPos = CFrame.new(-5494, 49, -794), MobPos = CFrame.new(-6039, 7, -1331), Sea = 2},
    {Mob = "Snow Trooper", Level = 1000, Quest = "SnowMountainQuest1", QuestPos = CFrame.new(607, 401, -5371), MobPos = CFrame.new(535, 401, -5298), Sea = 2},
    {Mob = "Winter Warrior", Level = 1050, Quest = "SnowMountainQuest2", QuestPos = CFrame.new(607, 401, -5371), MobPos = CFrame.new(1235, 401, -5177), Sea = 2},
    {Mob = "Lab Subordinate", Level = 1100, Quest = "FireSideQuest1", QuestPos = CFrame.new(-5428, 15, -5296), MobPos = CFrame.new(-5462, 15, -5837), Sea = 2},
    {Mob = "Horned Warrior", Level = 1125, Quest = "FireSideQuest2", QuestPos = CFrame.new(-5428, 15, -5296), MobPos = CFrame.new(-6403, 15, -5200), Sea = 2},
    {Mob = "Magma Ninja", Level = 1175, Quest = "FireSideQuest3", QuestPos = CFrame.new(-5428, 15, -5296), MobPos = CFrame.new(-5283, 15, -4710), Sea = 2},
    {Mob = "Lava Pirate", Level = 1200, Quest = "FireSideQuest4", QuestPos = CFrame.new(-5428, 15, -5296), MobPos = CFrame.new(-4866, 15, -4869), Sea = 2},
    {Mob = "Ship Deckhand", Level = 1250, Quest = "ShipQuest1", QuestPos = CFrame.new(911, 125, -32822), MobPos = CFrame.new(919, 125, -32722), Sea = 2},
    {Mob = "Ship Engineer", Level = 1275, Quest = "ShipQuest2", QuestPos = CFrame.new(911, 125, -32822), MobPos = CFrame.new(919, 125, -32722), Sea = 2},
    {Mob = "Ship Steward", Level = 1300, Quest = "ShipQuest3", QuestPos = CFrame.new(911, 125, -32822), MobPos = CFrame.new(919, 125, -32722), Sea = 2},
    {Mob = "Ship Officer", Level = 1325, Quest = "ShipQuest4", QuestPos = CFrame.new(911, 125, -32822), MobPos = CFrame.new(919, 125, -32722), Sea = 2},
    {Mob = "Arctic Warrior", Level = 1350, Quest = "FrostQuest1", QuestPos = CFrame.new(5668, 28, -6484), MobPos = CFrame.new(5826, 28, -6516), Sea = 2},
    {Mob = "Sea Soldier", Level = 1425, Quest = "ForgottenQuest1", QuestPos = CFrame.new(-3054, 237, -10144), MobPos = CFrame.new(-3033, 31, -9774), Sea = 2},
    
    -- SEA 3
    {Mob = "Pirate Millionaire", Level = 1500, Quest = "PiratePortQuest1", QuestPos = CFrame.new(-289, 44, 5573), MobPos = CFrame.new(-186, 22, 5581), Sea = 3},
    {Mob = "Pistol Billionaire", Level = 1525, Quest = "PiratePortQuest2", QuestPos = CFrame.new(-289, 44, 5573), MobPos = CFrame.new(-395, 22, 5846), Sea = 3},
    {Mob = "Dragon Crew Warrior", Level = 1575, Quest = "DragonCrewQuest1", QuestPos = CFrame.new(6732, 156, -725), MobPos = CFrame.new(6722, 156, -734), Sea = 3},
    {Mob = "Dragon Crew Archer", Level = 1600, Quest = "DragonCrewQuest2", QuestPos = CFrame.new(6732, 156, -725), MobPos = CFrame.new(6845, 156, -731), Sea = 3},
    {Mob = "Female Islander", Level = 1625, Quest = "DragonCrewQuest3", QuestPos = CFrame.new(6732, 156, -725), MobPos = CFrame.new(6620, 156, -582), Sea = 3},
    {Mob = "Giant Islander", Level = 1650, Quest = "DragonCrewQuest4", QuestPos = CFrame.new(6732, 156, -725), MobPos = CFrame.new(6478, 156, -785), Sea = 3},
    {Mob = "Marine Commodore", Level = 1700, Quest = "GreatTreeQuest1", QuestPos = CFrame.new(2874, 29, -6490), MobPos = CFrame.new(2865, 29, -6574), Sea = 3},
    {Mob = "Marine Rear Admiral", Level = 1725, Quest = "GreatTreeQuest2", QuestPos = CFrame.new(2874, 29, -6490), MobPos = CFrame.new(2786, 29, -6754), Sea = 3},
    {Mob = "Fishman Raider", Level = 1775, Quest = "TurtleQuest1", QuestPos = CFrame.new(-11583, 335, -8865), MobPos = CFrame.new(-11606, 335, -8893), Sea = 3},
    {Mob = "Fishman Captain", Level = 1800, Quest = "TurtleQuest2", QuestPos = CFrame.new(-11583, 335, -8865), MobPos = CFrame.new(-11158, 335, -8865), Sea = 3},
    {Mob = "Forest Pirate", Level = 1825, Quest = "TurtleQuest3", QuestPos = CFrame.new(-11583, 335, -8865), MobPos = CFrame.new(-12556, 335, -10068), Sea = 3},
    {Mob = "Mythological Pirate", Level = 1850, Quest = "TurtleQuest4", QuestPos = CFrame.new(-11583, 335, -8865), MobPos = CFrame.new(-13522, 335, -10068), Sea = 3},
    {Mob = "Jungle Pirate", Level = 1900, Quest = "TurtleQuest5", QuestPos = CFrame.new(-11583, 335, -8865), MobPos = CFrame.new(-10551, 335, -10068), Sea = 3},
    {Mob = "Musketeer Pirate", Level = 1925, Quest = "TurtleQuest6", QuestPos = CFrame.new(-11583, 335, -8865), MobPos = CFrame.new(-13266, 335, -9592), Sea = 3},
    {Mob = "Reborn Skeleton", Level = 1975, Quest = "HauntedQuest1", QuestPos = CFrame.new(-9482, 142, 5567), MobPos = CFrame.new(-9479, 142, 5567), Sea = 3},
    {Mob = "Living Zombie", Level = 2000, Quest = "HauntedQuest2", QuestPos = CFrame.new(-9482, 142, 5567), MobPos = CFrame.new(-10103, 142, 5760), Sea = 3},
    {Mob = "Demonic Soul", Level = 2025, Quest = "HauntedQuest3", QuestPos = CFrame.new(-9482, 142, 5567), MobPos = CFrame.new(-9710, 142, 6094), Sea = 3},
    {Mob = "Possessed Mummy", Level = 2050, Quest = "HauntedQuest4", QuestPos = CFrame.new(-9482, 142, 5567), MobPos = CFrame.new(-9555, 142, 6650), Sea = 3},
    {Mob = "Peanut Scout", Level = 2075, Quest = "CakeQuest1", QuestPos = CFrame.new(-1922, 38, -11834), MobPos = CFrame.new(-2068, 38, -11834), Sea = 3},
    {Mob = "Peanut President", Level = 2100, Quest = "CakeQuest2", QuestPos = CFrame.new(-1922, 38, -11834), MobPos = CFrame.new(-2156, 38, -12388), Sea = 3},
    {Mob = "Ice Cream Chef", Level = 2125, Quest = "CakeQuest3", QuestPos = CFrame.new(-1922, 38, -11834), MobPos = CFrame.new(-1819, 38, -12284), Sea = 3},
    {Mob = "Ice Cream Commander", Level = 2150, Quest = "CakeQuest4", QuestPos = CFrame.new(-1922, 38, -11834), MobPos = CFrame.new(-1819, 38, -12284), Sea = 3},
    {Mob = "Cookie Crafter", Level = 2200, Quest = "CakeQuest5", QuestPos = CFrame.new(-2022, 38, -12026), MobPos = CFrame.new(-2022, 38, -12026), Sea = 3},
    {Mob = "Cake Guard", Level = 2225, Quest = "CakeQuest6", QuestPos = CFrame.new(-2022, 38, -12026), MobPos = CFrame.new(-2022, 38, -12026), Sea = 3},
    {Mob = "Baking Staff", Level = 2250, Quest = "CakeQuest7", QuestPos = CFrame.new(-1922, 38, -11834), MobPos = CFrame.new(-1922, 38, -11834), Sea = 3},
    {Mob = "Head Baker", Level = 2275, Quest = "CakeQuest8", QuestPos = CFrame.new(-1922, 38, -11834), MobPos = CFrame.new(-1922, 38, -11834), Sea = 3},
    {Mob = "Cocoa Warrior", Level = 2300, Quest = "ChocQuest1", QuestPos = CFrame.new(231, 23, -12199), MobPos = CFrame.new(231, 23, -12199), Sea = 3},
    {Mob = "Chocolate Bar Battler", Level = 2325, Quest = "ChocQuest2", QuestPos = CFrame.new(231, 23, -12199), MobPos = CFrame.new(231, 23, -12199), Sea = 3},
    {Mob = "Sweet Thief", Level = 2350, Quest = "ChocQuest3", QuestPos = CFrame.new(231, 23, -12199), MobPos = CFrame.new(231, 23, -12199), Sea = 3},
    {Mob = "Candy Rebel", Level = 2375, Quest = "ChocQuest4", QuestPos = CFrame.new(231, 23, -12199), MobPos = CFrame.new(231, 23, -12199), Sea = 3},
    {Mob = "Candy Pirate", Level = 2400, Quest = "CandyQuest1", QuestPos = CFrame.new(-1150, 20, -14466), MobPos = CFrame.new(-1150, 20, -14466), Sea = 3},
    {Mob = "Snow Demon", Level = 2425, Quest = "CandyQuest2", QuestPos = CFrame.new(-1150, 20, -14466), MobPos = CFrame.new(-1150, 20, -14466), Sea = 3},
    {Mob = "Isle Outlaw", Level = 2450, Quest = "TikiQuest1", QuestPos = CFrame.new(-16545, 55, -173), MobPos = CFrame.new(-16545, 55, -173), Sea = 3},
    {Mob = "Island Boy", Level = 2475, Quest = "TikiQuest2", QuestPos = CFrame.new(-16545, 55, -173), MobPos = CFrame.new(-16545, 55, -173), Sea = 3},
    {Mob = "Sun-kissed Warrior", Level = 2500, Quest = "TikiQuest3", QuestPos = CFrame.new(-16545, 55, -173), MobPos = CFrame.new(-16545, 55, -173), Sea = 3},
    {Mob = "Isle Champion", Level = 2525, Quest = "TikiQuest4", QuestPos = CFrame.new(-16545, 55, -173), MobPos = CFrame.new(-16545, 55, -173), Sea = 3},
}

-- ============================================
-- FUNÇÕES DO AUTO FARM
-- ============================================

return {
    Enabled = false,
    FastAttack = true,
    FastClickSpeed = 0.01,
    SelectedSea = "All",
    
    -- Pegar nível do jogador
    GetLevel = function(self)
        local data = LocalPlayer:FindFirstChild("Data")
        local level = data and data:FindFirstChild("Level")
        return level and level.Value or 1
    end,
    
    -- Encontrar a melhor quest para o nível atual
    GetBestQuest = function(self)
        local myLevel = self:GetLevel()
        local bestQuest = nil
        local closestDiff = math.huge
        
        for _, quest in pairs(Quests) do
            if self.SelectedSea ~= "All" and quest.Sea ~= tonumber(self.SelectedSea:match("%d+")) then
                continue
            end
            
            local diff = myLevel - quest.Level
            if diff >= 0 and diff < closestDiff then
                closestDiff = diff
                bestQuest = quest
            end
        end
        
        return bestQuest
    end,
    
    -- Teleportar
    Teleport = function(self, pos)
        local HRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not HRP then return end
        
        local dist = (pos - HRP.Position).Magnitude
        if dist < 300 then
            HRP.CFrame = CFrame.new(pos)
        else
            TweenService:Create(HRP, TweenInfo.new(dist/350, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)}):Play()
            wait(dist/350 + 0.5)
        end
    end,
    
    -- Pegar quest
    TakeQuest = function(self, quest)
        self:Teleport(quest.QuestPos.Position + Vector3.new(0, 5, 0))
        wait(0.5)
        
        local args = {
            [1] = "StartQuest",
            [2] = quest.Quest,
            [3] = quest.Level
        }
        
        pcall(function()
            ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
        end)
        
        wait(0.3)
    end,
    
    -- Encontrar inimigo mais próximo da quest
    GetQuestEnemy = function(self, mobName)
        local HRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not HRP then return nil end
        
        local nearest, dist = nil, math.huge
        for _, v in pairs(Workspace.Enemies:GetChildren()) do
            if v.Name == mobName and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                local d = (v.HumanoidRootPart.Position - HRP.Position).Magnitude
                if d < dist then
                    dist = d
                    nearest = v
                end
            end
        end
        return nearest
    end,
    
    -- Fast Click / Auto Click
    FastClick = function(self)
        if not self.FastAttack then return end
        for i = 1, 5 do
            VirtualUser:CaptureController()
            VirtualUser:ClickButton1(Vector2.new(851, 158), Workspace.CurrentCamera.CFrame)
            wait(self.FastClickSpeed)
        end
    end,
    
    -- Atacar inimigo
    AttackEnemy = function(self, enemy)
        if not enemy then return end
        
        repeat
            task.wait()
            pcall(function()
                if enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                    -- Teleportar perto do inimigo
                    self:Teleport(enemy.HumanoidRootPart.Position + Vector3.new(0, 5, 0))
                    
                    -- Fast click
                    self:FastClick()
                    
                    -- Equipar arma se não estiver equipada
                    local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
                    if not tool then
                        for _, item in pairs(LocalPlayer.Backpack:GetChildren()) do
                            if item:IsA("Tool") then
                                LocalPlayer.Character.Humanoid:EquipTool(item)
                                break
                            end
                        end
                    end
                end
            end)
        until not enemy:FindFirstChild("Humanoid") or enemy.Humanoid.Health <= 0 or not self.Enabled
    end,
    
    -- LOOP PRINCIPAL DO AUTO FARM
    Start = function(self)
        self.Enabled = true
        
        while self.Enabled do
            task.wait()
            pcall(function()
                -- 1. Pegar a melhor quest para o nível atual
                local quest = self:GetBestQuest()
                if not quest then return end
                
                -- 2. Teleportar no NPC da quest e pegar
                self:TakeQuest(quest)
                
                -- 3. Farmar todos os inimigos da quest
                local killed = 0
                while killed < 6 and self.Enabled do -- 6 inimigos por quest
                    local enemy = self:GetQuestEnemy(quest.Mob)
                    if enemy then
                        self:AttackEnemy(enemy)
                        killed = killed + 1
                    else
                        -- Esperar spawn
                        wait(1)
                        -- Tentar teleportar para área dos mobs
                        self:Teleport(quest.MobPos.Position + Vector3.new(0, 30, 0))
                        wait(1)
                    end
                end
                
                -- 4. Quest completa! Volta para pegar outra
                wait(0.5)
            end)
        end
    end,
    
    Stop = function(self)
        self.Enabled = false
    end
}
