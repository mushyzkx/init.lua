-- modules/autofarm.lua
-- Sistema de Auto Farm para Blox Fruits

return {
    Enabled = false,
    FastAttack = true,
    
    GetNearestMob = function(self, mobName)
        local Players = game:GetService("Players")
        local Workspace = game:GetService("Workspace")
        local LocalPlayer = Players.LocalPlayer
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
        local Players = game:GetService("Players")
        local TweenService = game:GetService("TweenService")
        local HRP = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        
        if not HRP then return end
        local dist = (pos - HRP.Position).Magnitude
        if dist < 300 then
            HRP.CFrame = CFrame.new(pos)
        else
            TweenService:Create(HRP, TweenInfo.new(dist/350, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)}):Play()
        end
    end,
    
    Attack = function(self)
        local VirtualUser = game:GetService("VirtualUser")
        VirtualUser:CaptureController()
        VirtualUser:ClickButton1(Vector2.new(851, 158), workspace.CurrentCamera.CFrame)
    end,
    
    Start = function(self, mobName)
        self.Enabled = true
        while self.Enabled do
            task.wait()
            pcall(function()
                local mob = self:GetNearestMob(mobName)
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

