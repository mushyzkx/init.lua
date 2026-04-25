-- // SNOWWZ HUB - BOOTLOADER // --
local user = "mushyzkx" -- COLOQUE SEU USUARIO AQUI
local repo = "SnowwzHub" -- COLOQUE O NOME DO SEU REPOSITORIO AQUI

local function Load(file)
    local url = "https://raw.githubusercontent.com/"..user.."/"..repo.."/main/"..file
    local success, content = pcall(game.HttpGet, game, url)
    if success then
        loadstring(content)()
    else
        warn("❌ Erro ao baixar "..file)
    end
end

-- Ordem de carregamento (Lógica -> Visual -> Interface)
Load("farm_logic.lua")
Load("visual_logic.lua")
Load("ui_main.lua")

