-- modules/autofarm.lua
-- Auto Farm para TODOS os Seas do Blox Fruits

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

-- Todos os mobs de todos os Seas
local AllMobs = {
    -- SEA 1 (Level 0-700)
    {Name = "Bandit", Level = 5, Sea = 1},
    {Name = "Monkey", Level = 15, Sea = 1},
    {Name = "Gorilla", Level = 20, Sea = 1},
    {Name = "Pirate", Level = 35, Sea = 1},
    {Name = "Brute", Level = 40, Sea = 1},
    {Name = "Desert Bandit", Level = 60, Sea = 1},
    {Name = "Desert Officer", Level = 70, Sea = 1},
    {Name = "Snow Bandit", Level = 90, Sea = 1},
    {Name = "Snowman", Level = 100, Sea = 1},
    {Name = "Chief Petty Officer", Level = 120, Sea = 1},
    {Name = "Sky Bandit", Level = 150, Sea = 1},
    {Name = "Dark Master", Level = 175, Sea = 1},
    {Name = "Prisoner", Level = 190, Sea = 1},
    {Name = "Dangerous Prisoner", Level = 210, Sea = 1},
    {Name = "Toga Warrior", Level = 250, Sea = 1},
    {Name = "Gladiator", Level = 275, Sea = 1},
    {Name = "Military Soldier", Level = 300, Sea = 1},
    {Name = "Military Spy", Level = 325, Sea = 1},
    {Name = "Fishman Warrior", Level = 375, Sea = 1},
    {Name = "Fishman Commando", Level = 400, Sea = 1},
    {Name = "God's Guard", Level = 450, Sea = 1},
    {Name = "Shanda", Level = 475, Sea = 1},
    {Name = "Royal Squad", Level = 500, Sea = 1},
    {Name = "Royal Soldier", Level = 525, Sea = 1},
    
    -- SEA 2 (Level 700-1500)
    {Name = "Raider", Level = 700, Sea = 2},
    {Name = "Mercenary", Level = 725, Sea = 2},
    {Name = "Swan Pirate", Level = 775, Sea = 2},
    {Name = "Factory Staff", Level = 800, Sea = 2},
    {Name = "Marine Lieutenant", Level = 875, Sea = 2},
    {Name = "Marine Captain", Level = 900, Sea = 2},
    {Name = "Zombie", Level = 950, Sea = 2},
    {Name = "Vampire", Level = 975, Sea = 2},
    {Name = "Snow Trooper", Level = 1000, Sea = 2},
    {Name = "Winter Warrior", Level = 1050, Sea = 2},
    {Name = "Lab Subordinate", Level = 1100, Sea = 2},
    {Name = "Horned Warrior", Level = 1125, Sea = 2},
    {Name = "Magma Ninja", Level = 1175, Sea = 2},
    {Name = "Lava Pirate", Level = 1200, Sea = 2},
    {Name = "Ship Deckhand", Level = 1250, Sea = 2},
    {Name = "Ship Engineer", Level = 1275, Sea = 2},
    {Name = "Ship Steward", Level = 1300, Sea = 2},
    {Name = "Ship Officer", Level = 1325, Sea = 2},
    {Name = "Arctic Warrior", Level = 1350, Sea = 2},
    {Name = "Sea Soldier", Level = 1425, Sea = 2},
    
    -- SEA 3 (Level 1500+)
    {Name = "Pirate Millionaire", Level = 1500, Sea = 3},
    {Name = "Pistol Billionaire", Level = 1525, Sea = 3},
    {Name = "Dragon Crew Warrior", Level = 1575, Sea = 3},
    {Name = "Dragon Crew Archer", Level = 1600, Sea = 3},
    {Name = "Female Islander", Level = 1625, Sea = 3},
    {Name = "Giant Islander", Level = 1650, Sea = 3},
    {Name = "Marine Commodore", Level = 1700, Sea = 3},
    {Name = "Marine Rear Admiral", Level = 1725, Sea = 3},
    {Name = "Fishman Raider", Level = 1775, Sea = 3},
    {Name = "Fishman Captain", Level = 1800, Sea = 3},
    {Name = "Forest Pirate", Level = 1825, Sea = 3},
    {Name = "Mythological Pirate", Level = 1850, Sea = 3},
    {Name = "Jungle Pirate", Level = 1900, Sea = 3},
    {Name = "Musketeer Pirate", Level = 1925, Sea = 3},
    {Name = "Reborn Skeleton", Level = 1975, Sea = 3},
    {Name = "Living Zombie", Level = 2000, Sea = 3},
    {Name = "Demonic Soul", Level = 2025, Sea = 3},
    {Name = "Possessed Mummy", Level = 2050, Sea = 3},
    {Name = "Peanut Scout", Level = 2075, Sea = 3},
    {Name = "Peanut President", Level = 2100, Sea = 3},
    {Name = "Ice Cream Chef", Level = 2125, Sea = 3},
    {Name = "Ice Cream Commander", Level = 2150, Sea = 3},
    {Name = "Cookie Crafter", Level = 2200, Sea = 3},
    {Name = "Cake Guard", Level = 2225, Sea = 3},
    {Name = "Baking Staff", Level = 2250, Sea = 3},
    {Name = "Head Baker", Level = 2275, Sea = 3},
    {Name = "Cocoa Warrior", Level = 2300, Sea = 3},
    {Name = "Chocolate Bar Battler", Level = 2325, Sea = 3},
    {Name = "Sweet Thief", Level = 2350, Sea = 3},
    {Name = "Candy Rebel", Level = 2375, Sea = 3},
    {Name = "Candy Pirate", Level = 2400, Sea = 3},
    {Name = "Snow Demon", Level = 2425, Sea = 3},
    {Name = "Isle Outlaw", Level = 2450, Sea = 3},
    {Name = "Island Boy", Level = 2475, Sea = 3},
    {Name = "Sun-kissed Warrior", Level = 2500, Sea = 3},
    {Name = "Isle Champion", Level = 2525, Sea = 3},
}

return {
    Enabled = false,
    FastAttack = true,
    SelectedSea = "All",
    SelectedMob = nil,
    
    GetPlayerLevel = function(self)
        local data = LocalPlayer:FindFirstChild("Data")
        local level = data and data:FindFirstChild("Level")
        return level and level.Value or 1
    end,
    
    GetBestMob = function(self)
        local myLevel = self:GetPlayerLevel()
        local bestMob = nil
        local closestDiff = math.huge
        
        for _, mob in pairs(AllMobs) do
            if self.SelectedSea ~= "All" and mob.Sea ~= tonumber(self.SelectedSea:match("%d+")) then
                continue
            end
            
            local diff = math.abs(mob.Level - myLevel)
            if diff < closestDiff and mob.Level <= myLevel + 50 then
                closestDiff = diff
                bestMob = mob
            end
        end
        
        return bestMob
    end,
    
    GetNearestMob = function(self, mobName)
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
    
    Teleport = function(self, pos)
        local HRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not HRP then return end
        
        local dist = (pos - HRP.Position).Magnitude
        if dist < 300 then
            HRP.CFrame = CFrame.new(pos)
        else
            TweenService:Create(HRP, TweenInfo.new(dist/350, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)}):Play()
        end
    end,
    
    Attack = function(self)
        VirtualUser:CaptureController()
        VirtualUser:ClickButton1(Vector2.new(851, 158), Workspace.CurrentCamera.CFrame)
    end,
    
    Start = function(self, mobName)
        self.Enabled = true
        
        while self.Enabled do
            task.wait()
            pcall(function()
                local targetMob = mobName or (self.SelectedMob and self.SelectedMob.Name) or (self:GetBestMob() and self:GetBestMob().Name)
                if not targetMob then return end
                
                local mob = self:GetNearestMob(targetMob)
                if mob then
                    self:Teleport(mob.HumanoidRootPart.Position + Vector3.new(0, 30, 0))
                    
                    repeat
                        task.wait()
                        if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                            self:Teleport(mob.HumanoidRootPart.Position + Vector3.new(0, 5, 0))
                            if self.FastAttack then
                                self:Attack()
                            end
                        end
                    until not mob:FindFirstChild("Humanoid") or mob.Humanoid.Health <= 0 or not self.Enabled
                end
            end)
        end
    end,
    
    Stop = function(self)
        self.Enabled = false
    end
}
