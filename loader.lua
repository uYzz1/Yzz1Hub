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

-- Carregar módulos em ordem
local utils = loadstring(game:HttpGet(urls["utils"]))()
print("✅ Módulo carregado: utils")

local ui = loadstring(game:HttpGet(urls["ui"]))()
print("✅ Módulo carregado: ui")

local macros = loadstring(game:HttpGet(urls["macros"]))()
print("✅ Módulo carregado: macros")

-- Definir variáveis globais para os módulos
getgenv().Yzz1Hub_utils = utils
getgenv().Yzz1Hub_ui = ui
getgenv().Yzz1Hub_macros = macros

-- Inicializar módulos
ui.initialize(utils, macros)
macros.initialize()

-- Verificar se os módulos foram carregados corretamente
if not utils.SCRIPT_VERSION then
    warn("❌ Erro: SCRIPT_VERSION não está definido no módulo utils")
    return
end

print("📦 Versão do script: " .. utils.SCRIPT_VERSION)

-- Carregar e executar o script principal
local success, result = pcall(function()
    loadstring(game:HttpGet(urls["main"]))()
end)

if not success then
    warn("❌ Erro ao carregar o script principal: " .. tostring(result))
end