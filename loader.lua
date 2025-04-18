-- Verificar ambiente
if not game:IsLoaded() then game.Loaded:Wait() end

-- URLs dos módulos
local urls = {
    ["utils"] = "https://raw.githubusercontent.com/uYzz1/Yzz1Hub/main/utils.lua",
    ["ui"] = "https://raw.githubusercontent.com/uYzz1/Yzz1Hub/main/ui.lua",
    ["macros"] = "https://raw.githubusercontent.com/uYzz1/Yzz1Hub/main/macros.lua",
    ["main"] = "https://raw.githubusercontent.com/uYzz1/Yzz1Hub/main/main.lua"
}

-- Criar pasta para macros
if not isfolder("MacroAnimeLastStand_Yzz1Hub") then
    makefolder("MacroAnimeLastStand_Yzz1Hub")
end

-- Função para carregar um módulo
local function loadModule(name)
    local success, content = pcall(function()
        return game:HttpGet(urls[name])
    end)
    
    if not success then
        warn("❌ Erro ao baixar módulo " .. name .. ": " .. tostring(content))
        return nil
    end
    
    local func, err = loadstring(content)
    if not func then
        warn("❌ Erro ao compilar módulo " .. name .. ": " .. tostring(err))
        return nil
    end
    
    local success, result = pcall(func)
    if not success then
        warn("❌ Erro ao executar módulo " .. name .. ": " .. tostring(result))
        return nil
    end
    
    return result
end

-- Carregar módulos em ordem
local utils = loadModule("utils")
if not utils then
    warn("❌ Falha ao carregar módulo utils")
    return
end

-- Definir utils globalmente primeiro
getgenv().Yzz1Hub_utils = utils

-- Verificar SCRIPT_VERSION
if not utils.SCRIPT_VERSION then
    warn("❌ SCRIPT_VERSION não encontrado no módulo utils")
    return
end

print("📦 Versão do script: " .. utils.SCRIPT_VERSION)

-- Carregar UI e macros
local ui = loadModule("ui")
if not ui then
    warn("❌ Falha ao carregar módulo ui")
    return
end

local macros = loadModule("macros")
if not macros then
    warn("❌ Falha ao carregar módulo macros")
    return
end

-- Definir variáveis globais para os outros módulos
getgenv().Yzz1Hub_ui = ui
getgenv().Yzz1Hub_macros = macros

-- Inicializar módulos
ui.initialize(utils, macros)
macros.initialize()

-- Carregar e executar o script principal
local success, result = pcall(function()
    loadstring(game:HttpGet(urls["main"]))()
end)

if not success then
    warn("❌ Erro ao carregar o script principal: " .. tostring(result))
end