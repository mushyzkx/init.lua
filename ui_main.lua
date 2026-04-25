-- // SNOWWZ HUB - LOADER OFICIAL // --
local user = "mushyzkx"
local repo = "init.lua" -- Nome do seu repositório conforme o print

local function Load(file)
    -- O link raw correto baseado no seu print
    local url = "https://raw.githubusercontent.com/"..user.."/"..repo.."/main/"..file
    local success, content = pcall(game.HttpGet, game, url)
    
    if success and content ~= "" then
        print("✅ Módulo carregado: "..file)
        return loadstring(content)()
    else
        warn("❌ Erro ao baixar "..file.." - Verifique o nome do arquivo!")
    end
end

-- CARREGANDO A ESTRUTURA
Load("farm_logic.lua")
Load("visual_logic.lua")
Load("ui_main.lua") -- Certifique-se de criar este arquivo também!

