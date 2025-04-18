-- Módulo de Utilidades para Yzz1Hub
local utils = {}

-- Variáveis compartilhadas
utils.SCRIPT_VERSION = "0.0.21"
utils.logMessages = {}
utils.webhookUrl = ""

-- Adiciona uma mensagem ao log
function utils.addLogMessage(message)
    table.insert(utils.logMessages, os.date("[%H:%M:%S] ") .. message)
    
    -- Limitar o número máximo de mensagens no log (opcional)
    if #utils.logMessages > 100 then
        table.remove(utils.logMessages, 1)
    end
    
    -- Se a UI já foi criada, atualizar o log visual
    if utils.updateLogDisplay then
        utils.updateLogDisplay()
    end
end

-- Conecta eventos do jogo
function utils.connectGameEvents()
    -- Exemplo de conexão de eventos
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        game:GetService("VirtualUser"):Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        wait(1)
        game:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        utils.addLogMessage("Anti-AFK ativado")
    end)
end

-- Salva configurações
function utils.saveSettings(settings)
    local success, errorMsg = pcall(function()
        local json = game:GetService("HttpService"):JSONEncode(settings)
        writefile("MacroAnimeLastStand_Yzz1Hub/settings.json", json)
    end)
    
    if success then
        utils.addLogMessage("✅ Configurações salvas com sucesso!")
        return true
    else
        utils.addLogMessage("❌ Erro ao salvar configurações: " .. tostring(errorMsg))
        return false
    end
end

-- Carrega configurações
function utils.loadSettings()
    if not isfile("MacroAnimeLastStand_Yzz1Hub/settings.json") then
        return {
            theme = "Dark",
            autoPlace = false,
            autoUpgrade = false,
            autoSell = false
        }
    end
    
    local success, result = pcall(function()
        local json = readfile("MacroAnimeLastStand_Yzz1Hub/settings.json")
        return game:GetService("HttpService"):JSONDecode(json)
    end)
    
    if success then
        return result
    else
        utils.addLogMessage("❌ Erro ao carregar configurações. Usando padrões.")
        return {
            theme = "Dark",
            autoPlace = false,
            autoUpgrade = false,
            autoSell = false
        }
    end
end

return utils 