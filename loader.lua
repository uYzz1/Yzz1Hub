-- Verificar ambiente
if not game:IsLoaded() then game.Loaded:Wait() end

-- URLs dos módulos
local urls = {
    ["utils"] = "https://raw.githubusercontent.com/uYzz1/Yzz1Hub/main/utils.lua",
    ["ui"] = "https://raw.githubusercontent.com/uYzz1/Yzz1Hub/main/ui.lua",
    ["macros"] = "https://raw.githubusercontent.com/uYzz1/Yzz1Hub/main/macros.lua",
    ["components"] = "https://raw.githubusercontent.com/uYzz1/Yzz1Hub/main/components.lua",
    ["theme"] = "https://raw.githubusercontent.com/uYzz1/Yzz1Hub/main/theme.lua",
    ["autofarm"] = "https://raw.githubusercontent.com/uYzz1/Yzz1Hub/main/autofarm.lua",
    ["settings"] = "https://raw.githubusercontent.com/uYzz1/Yzz1Hub/main/settings.lua",
    ["main"] = "https://raw.githubusercontent.com/uYzz1/Yzz1Hub/main/main.lua"
}

-- Criar pasta para macros
if not isfolder("MacroAnimeLastStand_Yzz1Hub") then
    makefolder("MacroAnimeLastStand_Yzz1Hub")
end

-- Função para carregar um módulo
local function loadModule(name)
    print("🔄 Tentando carregar módulo: " .. name)
    
    -- Baixar o conteúdo
    local success, content = pcall(function()
        return game:HttpGet(urls[name])
    end)
    
    if not success then
        warn("❌ Erro ao baixar módulo " .. name .. ": " .. tostring(content))
        return nil
    end
    print("📥 Conteúdo do módulo " .. name .. " baixado com sucesso")
    
    -- Compilar o módulo
    local func, err = loadstring(content)
    if not func then
        warn("❌ Erro ao compilar módulo " .. name .. ": " .. tostring(err))
        return nil
    end
    print("📝 Módulo " .. name .. " compilado com sucesso")
    
    -- Executar o módulo
    local success, result = pcall(func)
    if not success then
        warn("❌ Erro ao executar módulo " .. name .. ": " .. tostring(result))
        return nil
    end
    
    -- Verificar se o resultado é uma tabela
    if type(result) ~= "table" then
        warn("❌ Módulo " .. name .. " não retornou uma tabela válida")
        return nil
    end
    
    print("✅ Módulo " .. name .. " carregado com sucesso")
    return result
end

-- Limpar variáveis globais anteriores
getgenv().Yzz1Hub_utils = nil
getgenv().Yzz1Hub_ui = nil
getgenv().Yzz1Hub_macros = nil
getgenv().Yzz1Hub_components = nil
getgenv().Yzz1Hub_theme = nil
getgenv().Yzz1Hub_autofarm = nil
getgenv().Yzz1Hub_settings = nil

-- Carregar utils primeiro
print("🔄 Iniciando carregamento do módulo utils...")
local utils = loadModule("utils")
if not utils then
    warn("❌ Falha crítica ao carregar módulo utils")
    return
end

-- Verificar utils antes de prosseguir
if type(utils) ~= "table" then
    warn("❌ Módulo utils não é uma tabela válida")
    return
end

if not utils.SCRIPT_VERSION then
    warn("❌ SCRIPT_VERSION não encontrado no módulo utils")
    return
end

-- Definir utils globalmente
getgenv().Yzz1Hub_utils = utils
print("📦 Versão do script: " .. utils.SCRIPT_VERSION)

-- Carregar componentes e tema
print("🔄 Iniciando carregamento do módulo components...")
local components = loadModule("components")
if not components then
    warn("❌ Falha ao carregar módulo components")
    return
end

print("🔄 Iniciando carregamento do módulo theme...")
local theme = loadModule("theme")
if not theme then
    warn("❌ Falha ao carregar módulo theme")
    return
end

-- Carregar UI e macros
print("🔄 Iniciando carregamento do módulo ui...")
local ui = loadModule("ui")
if not ui then
    warn("❌ Falha ao carregar módulo ui")
    return
end

print("🔄 Iniciando carregamento do módulo macros...")
local macros = loadModule("macros")
if not macros then
    warn("❌ Falha ao carregar módulo macros")
    return
end

-- Carregar autofarm e settings
print("🔄 Iniciando carregamento do módulo autofarm...")
local autofarm = loadModule("autofarm")
if not autofarm then
    warn("❌ Falha ao carregar módulo autofarm")
    return
end

print("🔄 Iniciando carregamento do módulo settings...")
local settings = loadModule("settings")
if not settings then
    warn("❌ Falha ao carregar módulo settings")
    return
end

-- Definir variáveis globais para todos os módulos
getgenv().Yzz1Hub_components = components
getgenv().Yzz1Hub_theme = theme
getgenv().Yzz1Hub_ui = ui
getgenv().Yzz1Hub_macros = macros
getgenv().Yzz1Hub_autofarm = autofarm
getgenv().Yzz1Hub_settings = settings

-- Verificar se todos os módulos estão disponíveis globalmente
if not (getgenv().Yzz1Hub_utils and getgenv().Yzz1Hub_ui and getgenv().Yzz1Hub_macros) then
    warn("❌ Nem todos os módulos foram definidos globalmente")
    return
end

-- Inicializar módulos
print("🔄 Inicializando módulos...")
settings.initialize(utils)
autofarm.initialize(utils)
ui.initialize(utils, macros, components, theme, autofarm, settings)
macros.initialize(utils, settings)

-- Carregar e executar o script principal
print("🔄 Carregando script principal...")
local success, result = pcall(function()
    local mainContent = game:HttpGet(urls["main"])
    print("📥 Script principal baixado, executando...")
    loadstring(mainContent)()
end)

if not success then
    warn("❌ Erro ao carregar o script principal: " .. tostring(result))
end