-- Módulo de Configurações para Yzz1Hub
local settings = {}

-- Serviços do Roblox
local HttpService = game:GetService("HttpService")

-- Dependências
local utils -- Será definido na inicialização

-- Pastas e arquivos
local SETTINGS_FOLDER = "MacroAnimeLastStand_Yzz1Hub"
local SETTINGS_FILE = "settings.json"

-- Configuração padrão
settings.default = {
    -- Interface
    theme = "Dark",
    logLimit = 100,
    
    -- Auto farm
    autoPlace = false,
    autoUpgrade = false,
    autoSell = false,
    selectedUnit = "",
    
    -- Macros
    disableConfirmation = false,
    autoSaveMacros = true,
    
    -- Outros
    webhookUrl = "",
    notifications = true
}

-- Configurações atuais
settings.current = {}

-- Inicializa o módulo
function settings.initialize(utilsModule)
    utils = utilsModule
    
    -- Criar pasta se não existir
    if not isfolder(SETTINGS_FOLDER) then
        makefolder(SETTINGS_FOLDER)
    end
    
    -- Carregar configurações ou usar padrão
    settings.load()
end

-- Salva as configurações
function settings.save()
    local success, errorMsg = pcall(function()
        local json = HttpService:JSONEncode(settings.current)
        writefile(SETTINGS_FOLDER .. "/" .. SETTINGS_FILE, json)
    end)
    
    if success then
        if utils then
            utils.addLogMessage("✅ Configurações salvas com sucesso!")
        end
        return true
    else
        if utils then
            utils.addLogMessage("❌ Erro ao salvar configurações: " .. tostring(errorMsg))
        end
        return false
    end
end

-- Carrega as configurações
function settings.load()
    -- Verificar se o arquivo existe
    if not isfile(SETTINGS_FOLDER .. "/" .. SETTINGS_FILE) then
        settings.current = table.clone(settings.default)
        settings.save()
        return settings.current
    end
    
    -- Tentar carregar o arquivo
    local success, result = pcall(function()
        local json = readfile(SETTINGS_FOLDER .. "/" .. SETTINGS_FILE)
        return HttpService:JSONDecode(json)
    end)
    
    if success then
        -- Mesclar as configurações carregadas com as padrões
        settings.current = settings.mergeSettings(settings.default, result)
        if utils then
            utils.addLogMessage("✅ Configurações carregadas com sucesso!")
        end
    else
        -- Usar configurações padrão em caso de erro
        settings.current = table.clone(settings.default)
        if utils then
            utils.addLogMessage("❌ Erro ao carregar configurações. Usando padrões.")
        end
    end
    
    return settings.current
end

-- Mescla as configurações, garantindo que todos os campos padrão existam
function settings.mergeSettings(default, loaded)
    local merged = {}
    
    -- Copiar valores padrão
    for key, value in pairs(default) do
        merged[key] = value
    end
    
    -- Sobrescrever com valores carregados
    for key, value in pairs(loaded) do
        if default[key] ~= nil then -- Verificar se a chave existe no padrão
            merged[key] = value
        end
    end
    
    return merged
end

-- Obtém uma configuração específica
function settings.get(key)
    return settings.current[key]
end

-- Define uma configuração específica
function settings.set(key, value)
    if settings.current[key] ~= value then
        settings.current[key] = value
        settings.save()
    end
end

-- Reseta as configurações para o padrão
function settings.reset()
    settings.current = table.clone(settings.default)
    settings.save()
    if utils then
        utils.addLogMessage("⚠️ Configurações resetadas para o padrão")
    end
end

-- Exporta as configurações para compartilhar
function settings.export()
    local success, result = pcall(function()
        return HttpService:JSONEncode(settings.current)
    end)
    
    if success then
        -- Copiar para a área de transferência se possível
        if setclipboard then
            setclipboard(result)
            if utils then
                utils.addLogMessage("📋 Configurações copiadas para a área de transferência")
            end
        end
        
        return result
    else
        if utils then
            utils.addLogMessage("❌ Erro ao exportar configurações")
        end
        return nil
    end
end

-- Importa configurações de um JSON
function settings.import(json)
    if not json or type(json) ~= "string" then
        if utils then
            utils.addLogMessage("❌ Formato de configuração inválido")
        end
        return false
    end
    
    local success, result = pcall(function()
        return HttpService:JSONDecode(json)
    end)
    
    if success and type(result) == "table" then
        settings.current = settings.mergeSettings(settings.default, result)
        settings.save()
        if utils then
            utils.addLogMessage("✅ Configurações importadas com sucesso")
        end
        return true
    else
        if utils then
            utils.addLogMessage("❌ Erro ao importar configurações: Formato inválido")
        end
        return false
    end
end

return settings 