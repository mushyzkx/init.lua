-- // SNOWWZ HUB - VISUAIS BETA // --
_G.SmoothMode = false
_G.ESP_Fruits = false

function ToggleSmoothMode(Value)
    for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Value and Enum.Material.SmoothPlastic or v.Material
        end
    end
end

-- ESP DE FRUTAS (FIXED)
spawn(function()
    while task.wait(2) do
        if _G.ESP_Fruits then
            for _, v in pairs(game.Workspace:GetChildren()) do
                if v:IsA("Tool") and v:FindFirstChild("Handle") then
                    -- Lógica de BillboardGui aqui
                end
            end
        end
    end
end)

