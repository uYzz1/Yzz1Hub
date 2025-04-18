-- Módulo de Macros para Yzz1Hub
local macros = {}

-- Dependências
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Variáveis locais
local macroData = {}
local isRecording = false
local lastDetectedUnit = nil
local unitQueue = {}
local autoPlaceEnabled = false
local autoUpgradeEnabled = false
local autoSellEnabled = false

-- Referência para utils (será definida na inicialização)
local utils

-- Inicializa o módulo
function macros.initialize()
    -- Tentar obter o módulo utils
    local success, result = pcall(function()
        return loadstring(readfile("utils.lua"))()
    end)
    
    if success then
        utils = result
    else
        utils = {
            addLogMessage = function(msg) 
                print("Log: " .. msg) 
            end
        }
        warn("Erro ao carregar módulo utils no módulo de macros")
    end
    
    macros.updateMacroList()
end

-- Atualiza a lista de macros
function macros.updateMacroList()
    if not listMacros then return end
    
    -- Limpar lista atual
    for _, item in pairs(listMacros:GetChildren()) do
        if item:IsA("TextButton") then
            item:Destroy()
        end
    end
    
    -- Listar arquivos na pasta
    local files = listfiles("MacroAnimeLastStand_Yzz1Hub")
    local macroFiles = {}
    
    for _, file in ipairs(files) do
        if file:match("%.json$") then
            local fileName = file:match("[^/\\]+%.json$")
            fileName = fileName:gsub("%.json$", "")
            table.insert(macroFiles, fileName)
        end
    end
    
    -- Criar botões para cada macro
    for i, fileName in ipairs(macroFiles) do
        local btn = macros.createMacroButton(fileName, i)
        btn.Parent = listMacros
    end
    
    if #macroFiles == 0 then
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -10, 0, 30)
        label.Position = UDim2.new(0, 5, 0, 5)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.fromRGB(200, 200, 200)
        label.Text = "Nenhum macro encontrado"
        label.Font = Enum.Font.Gotham
        label.TextSize = 14
        label.Parent = listMacros
    end
end

-- Inicia a gravação de um macro
function macros.startRecording()
    macroData = {}
    isRecording = true
    unitQueue = {}
    utils.addLogMessage("🔴 Gravação iniciada! Coloque unidades para gravar.")
end

-- Para a gravação de um macro
function macros.stopRecording()
    isRecording = false
    utils.addLogMessage("⏹️ Gravação parada. " .. #macroData .. " posições gravadas.")
end

-- Salva um macro
function macros.saveMacro(name)
    if name == "" then
        utils.addLogMessage("❌ Erro: Por favor, digite um nome para o macro!")
        return false
    end
    
    local success, errorMsg = pcall(function()
        local json = HttpService:JSONEncode(macroData)
        writefile("MacroAnimeLastStand_Yzz1Hub/" .. name .. ".json", json)
    end)
    
    if success then
        utils.addLogMessage("✅ Macro '" .. name .. "' salvo com sucesso! " .. #macroData .. " posições.")
        macros.updateMacroList()
        return true
    else
        utils.addLogMessage("❌ Erro ao salvar macro: " .. tostring(errorMsg))
        return false
    end
end

-- Carrega um macro
function macros.loadMacro(name)
    local success, result = pcall(function()
        local content = readfile("MacroAnimeLastStand_Yzz1Hub/" .. name .. ".json")
        return HttpService:JSONDecode(content)
    end)
    
    if success then
        macroData = result
        utils.addLogMessage("✅ Macro '" .. name .. "' carregado! " .. #macroData .. " posições.")
        return true
    else
        utils.addLogMessage("❌ Erro ao carregar macro: " .. tostring(result))
        return false
    end
end

-- Cria um botão para um macro
function macros.createMacroButton(name, index)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 34)
    button.Position = UDim2.new(0, 5, 0, (index - 1) * 40 + 5)
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    button.Text = name
    button.Font = Enum.Font.GothamSemibold
    button.TextSize = 14
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Padding interno
    local padding = Instance.new("UIPadding", button)
    padding.PaddingLeft = UDim.new(0, 10)
    
    -- Cantos arredondados
    local corner = Instance.new("UICorner", button)
    corner.CornerRadius = UDim.new(0, 6)
    
    -- Botões de ação
    local loadBtn = Instance.new("TextButton", button)
    loadBtn.Size = UDim2.new(0, 60, 0, 26)
    loadBtn.Position = UDim2.new(1, -130, 0.5, -13)
    loadBtn.BackgroundColor3 = Color3.fromRGB(80, 120, 200)
    loadBtn.Text = "Carregar"
    loadBtn.Font = Enum.Font.GothamBold
    loadBtn.TextSize = 12
    loadBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    local execBtn = Instance.new("TextButton", button)
    execBtn.Size = UDim2.new(0, 60, 0, 26)
    execBtn.Position = UDim2.new(1, -65, 0.5, -13)
    execBtn.BackgroundColor3 = Color3.fromRGB(80, 200, 120)
    execBtn.Text = "Executar"
    execBtn.Font = Enum.Font.GothamBold
    execBtn.TextSize = 12
    execBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    -- Cantos para os botões
    local loadCorner = Instance.new("UICorner", loadBtn)
    loadCorner.CornerRadius = UDim.new(0, 6)
    local execCorner = Instance.new("UICorner", execBtn)
    execCorner.CornerRadius = UDim.new(0, 6)
    
    -- Eventos
    loadBtn.MouseButton1Click:Connect(function()
        macros.loadMacro(name)
    end)
    
    execBtn.MouseButton1Click:Connect(function()
        macros.executeMacro(name)
    end)
    
    return button
end

-- Executa um macro
function macros.executeMacro(name)
    local success = macros.loadMacro(name)
    if not success then return end
    
    utils.addLogMessage("▶️ Executando macro '" .. name .. "'...")
    
    -- Executa as ações do macro
    for i, action in ipairs(macroData) do
        task.spawn(function()
            task.wait(action.delay or 0)
            -- Coloca a unidade na posição especificada
            local args = {
                [1] = action.unitId,
                [2] = Vector3.new(action.posX, action.posY, action.posZ)
            }
            game:GetService("ReplicatedStorage").Remotes.PlaceUnit:FireServer(unpack(args))
            utils.addLogMessage("🔹 [" .. i .. "/" .. #macroData .. "] Unidade colocada: " .. action.unitName)
        end)
    end
end

return macros 