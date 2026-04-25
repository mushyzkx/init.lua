-- // SNOWWZ HUB - MOTOR DE FARM // --
_G.AutoFarm = false
_G.SelectWeapon = "Melee"
_G.FarmMode = "Up" -- Opções: Up, Orbit, Star

local LP = game.Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")

-- [LÓGICA DE QUESTS 1-2800]
function GetQuest()
    local lvl = LP.Data.Level.Value
    local pID = game.PlaceId
    -- Aqui entra aquela tabela que corrigimos de todos os mares
    if pID == 2753915549 then -- Sea 1
        if lvl < 15 then return "BanditQuest1", "Bandit", CFrame.new(1059, 16, 1548) end
    end
    -- ... adicione os outros mares aqui
end

-- [LOOP DE ATAQUE]
spawn(function()
    while task.wait(0.1) do
        if _G.AutoFarm and LP.Character then
            pcall(function()
                local tool = LP.Backpack:FindFirstChild(_G.SelectWeapon) or LP.Character:FindFirstChild(_G.SelectWeapon)
                if tool then LP.Humanoid:EquipTool(tool) end
                RS.Remotes.CommF_:InvokeServer("Attack", "Main")
            end)
        end
    end
end)
