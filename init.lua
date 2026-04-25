-- // SNOWWZ HUB - BOOTLOADER // --
local user = "mushyzkx"
local repo = "init.lua" -- Nome do seu repositório no GitHub

local function Load(file)
    -- O link Raw que o Roblox consegue ler
    local url = "https://raw.githubusercontent.com/"..user.."/"..repo.."/main/"..file
    
    local success, content = pcall(game.HttpGet, game, url)
    
    if success and content ~= "" then
        print("❄️ [S-HUB] Carregando: "..file)
        local func, err = loadstring(content)
        if func then
            return func()
        else
            warn("❌ [S-HUB] Erro no código de "..file..": "..tostring(err))
        end
    else
        warn("❌ [S-HUB] Falha ao baixar "..file.." - Verifique se o arquivo existe!")
    end
end

-- // INICIANDO O HUB // --
-- Ele carrega os scripts na ordem: Lógica -> Visuais -> Interface
Load("farm_logic.lua")
Load("visual_logic.lua")
Load("ui_main.lua")

print("❄️ Snowwz Hub BETA carregado com sucesso!")
