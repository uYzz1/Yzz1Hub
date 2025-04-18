--[[===========================================
    Yzz1Hub Premium - Loader para Wave Executor
    Versão: 0.0.21 - Modo Local
================================================]]--

-- Verificar ambiente
if not writefile or not readfile or not loadstring then
    warn("⚠️ Este executor não é compatível com Yzz1Hub")
    return
end

-- Verificar e criar pasta para macros
if not isfolder("MacroAnimeLastStand_Yzz1Hub") then
    makefolder("MacroAnimeLastStand_Yzz1Hub")
end

-- Função principal para carregar o script
local function loadYzz1Hub()
    -- Interface de carregamento simples
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "Yzz1HubLoader"
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 100)
    frame.Position = UDim2.new(0.5, -150, 0.5, -50)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    frame.BorderSizePixel = 0
    frame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = frame
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Position = UDim2.new(0, 0, 0, 10)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.BackgroundTransparency = 1
    title.Text = "Carregando Yzz1Hub..."
    title.Parent = frame
    
    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(1, 0, 0, 20)
    status.Position = UDim2.new(0, 0, 0.5, 0)
    status.Font = Enum.Font.Gotham
    status.TextSize = 14
    status.TextColor3 = Color3.fromRGB(200, 200, 200)
    status.BackgroundTransparency = 1
    status.Text = "Verificando arquivos..."
    status.Parent = frame
    
    -- Tentar adicionar o ScreenGui ao CoreGui
    pcall(function()
        syn.protect_gui(screenGui)
        screenGui.Parent = game:GetService("CoreGui")
    end)
    
    if not screenGui.Parent then
        screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end
    
    -- Verificar se os arquivos existem localmente
    local requiredFiles = {"main.lua", "utils.lua", "macros.lua", "ui.lua"}
    local missingFiles = {}
    
    for _, file in ipairs(requiredFiles) do
        if not isfile(file) then
            table.insert(missingFiles, file)
        end
    end
    
    if #missingFiles > 0 then
        status.Text = "Arquivos não encontrados: " .. table.concat(missingFiles, ", ")
        status.TextColor3 = Color3.fromRGB(255, 100, 100)
        wait(5)
        screenGui:Destroy()
        return
    end
    
    -- Carregar o módulo principal
    status.Text = "Iniciando script..."
    local success, errorMsg = pcall(function()
        loadstring(readfile("main.lua"))()
    end)
    
    if not success then
        status.Text = "Erro ao carregar script: " .. tostring(errorMsg)
        status.TextColor3 = Color3.fromRGB(255, 100, 100)
        wait(5)
    end
    
    -- Remover a interface de carregamento após 2 segundos
    wait(2)
    screenGui:Destroy()
end

-- Iniciar o carregamento
loadYzz1Hub() 