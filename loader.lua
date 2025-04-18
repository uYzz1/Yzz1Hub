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

-- Criar tela de carregamento
local LoadingScreen = Instance.new("ScreenGui")
LoadingScreen.Name = "Yzz1HubLoading"
LoadingScreen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LoadingScreen.DisplayOrder = 999

pcall(function()
    if syn and syn.protect_gui then
        syn.protect_gui(LoadingScreen)
    end
    LoadingScreen.Parent = game:GetService("CoreGui")
end)

if not LoadingScreen.Parent then
    LoadingScreen.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
end

-- Background escuro
local Background = Instance.new("Frame")
Background.Name = "Background"
Background.Size = UDim2.new(1, 0, 1, 0)
Background.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Background.BackgroundTransparency = 0.2
Background.Parent = LoadingScreen

-- Container central
local Container = Instance.new("Frame")
Container.Name = "Container"
Container.Size = UDim2.new(0, 500, 0, 300)
Container.Position = UDim2.new(0.5, -250, 0.5, -150)
Container.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
Container.BorderSizePixel = 0
Container.Parent = LoadingScreen

-- Arredondar cantos
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 16)
UICorner.Parent = Container

-- Sombra
local Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
Shadow.Size = UDim2.new(1, 40, 1, 40)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://6015897843"
Shadow.ImageColor3 = Color3.new(0, 0, 0)
Shadow.ImageTransparency = 0.6
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(49, 49, 450, 450)
Shadow.ZIndex = -1
Shadow.Parent = Container

-- Logo
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 100)
Title.Position = UDim2.new(0, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Text = "YZZ1 HUB"
Title.TextSize = 48
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Parent = Container

-- Gradiente para o título
local TitleGradient = Instance.new("UIGradient")
TitleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 80, 220)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 160, 255))
})
TitleGradient.Parent = Title

-- Brilho do título
local Glow = Instance.new("ImageLabel")
Glow.Name = "Glow"
Glow.AnchorPoint = Vector2.new(0.5, 0.5)
Glow.Position = UDim2.new(0.5, 0, 0.25, 0)
Glow.Size = UDim2.new(0.8, 0, 0.4, 0)
Glow.BackgroundTransparency = 1
Glow.Image = "rbxassetid://6015897843"
Glow.ImageColor3 = Color3.fromRGB(120, 80, 220)
Glow.ImageTransparency = 0.7
Glow.Parent = Container

-- Subtítulo
local Subtitle = Instance.new("TextLabel")
Subtitle.Name = "Subtitle"
Subtitle.Size = UDim2.new(1, 0, 0, 30)
Subtitle.Position = UDim2.new(0, 0, 0, 140)
Subtitle.BackgroundTransparency = 1
Subtitle.Font = Enum.Font.Gotham
Subtitle.Text = "Premium Script"
Subtitle.TextSize = 20
Subtitle.TextColor3 = Color3.fromRGB(180, 180, 180)
Subtitle.Parent = Container

-- Barra de progresso - Container
local ProgressBarBackground = Instance.new("Frame")
ProgressBarBackground.Name = "ProgressBarBackground"
ProgressBarBackground.Size = UDim2.new(0.8, 0, 0, 10)
ProgressBarBackground.Position = UDim2.new(0.1, 0, 0.7, 0)
ProgressBarBackground.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
ProgressBarBackground.BorderSizePixel = 0
ProgressBarBackground.Parent = Container

-- Arredondar cantos da barra de progresso
local ProgressBarCorner = Instance.new("UICorner")
ProgressBarCorner.CornerRadius = UDim.new(0, 5)
ProgressBarCorner.Parent = ProgressBarBackground

-- Barra de progresso - Preenchimento
local ProgressBarFill = Instance.new("Frame")
ProgressBarFill.Name = "ProgressBarFill"
ProgressBarFill.Size = UDim2.new(0, 0, 1, 0)
ProgressBarFill.BackgroundColor3 = Color3.fromRGB(120, 80, 220)
ProgressBarFill.BorderSizePixel = 0
ProgressBarFill.Parent = ProgressBarBackground

-- Arredondar cantos do preenchimento
local ProgressBarFillCorner = Instance.new("UICorner")
ProgressBarFillCorner.CornerRadius = UDim.new(0, 5)
ProgressBarFillCorner.Parent = ProgressBarFill

-- Gradiente para a barra de progresso
local ProgressBarGradient = Instance.new("UIGradient")
ProgressBarGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 80, 220)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 100, 240))
})
ProgressBarGradient.Parent = ProgressBarFill

-- Status de carregamento
local StatusText = Instance.new("TextLabel")
StatusText.Name = "StatusText"
StatusText.Size = UDim2.new(1, 0, 0, 30)
StatusText.Position = UDim2.new(0, 0, 0.8, 0)
StatusText.BackgroundTransparency = 1
StatusText.Font = Enum.Font.Gotham
StatusText.Text = "Inicializando..."
StatusText.TextSize = 16
StatusText.TextColor3 = Color3.fromRGB(200, 200, 200)
StatusText.Parent = Container

-- Função para carregar um módulo e atualizar a UI
local function loadModule(name, index, totalModules)
    -- Atualizar status
    StatusText.Text = "Carregando módulo: " .. name
    
    -- Calcular progresso
    local progressStages = totalModules + 2 -- +2 para inicialização e finalização
    local progress = index / progressStages
    ProgressBarFill:TweenSize(UDim2.new(progress, 0, 1, 0), "Out", "Quad", 0.3, true)
    
    -- Baixar o conteúdo
    local success, content = pcall(function()
        return game:HttpGet(urls[name])
    end)
    
    if not success then
        StatusText.Text = "Erro ao carregar " .. name
        task.wait(1.5)
        return nil
    end
    
    -- Compilar o módulo
    local func, err = loadstring(content)
    if not func then
        StatusText.Text = "Erro ao compilar " .. name
        task.wait(1.5)
        return nil
    end
    
    -- Executar o módulo
    local success, result = pcall(func)
    if not success then
        StatusText.Text = "Erro ao executar " .. name
        task.wait(1.5)
        return nil
    end
    
    -- Verificar se o resultado é uma tabela
    if type(result) ~= "table" then
        StatusText.Text = "Formato inválido para " .. name
        task.wait(1.5)
        return nil
    end
    
    -- Pequena pausa para animar
    task.wait(0.1)
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

-- Quantidade total de módulos para calcular o progresso
local totalModules = 7 -- utils, ui, macros, components, theme, autofarm, settings

-- Inicialização - Primeiro passo
StatusText.Text = "Preparando ambiente..."
ProgressBarFill:TweenSize(UDim2.new(0.05, 0, 1, 0), "Out", "Quad", 0.3, true)
task.wait(0.5)

-- Carregar utils primeiro
StatusText.Text = "Carregando módulo base..."
ProgressBarFill:TweenSize(UDim2.new(0.1, 0, 1, 0), "Out", "Quad", 0.3, true)
local utils = loadModule("utils", 1, totalModules)
if not utils then
    StatusText.Text = "Falha crítica ao carregar módulo utils"
    task.wait(3)
    LoadingScreen:Destroy()
    return
end

-- Definir utils globalmente
getgenv().Yzz1Hub_utils = utils

-- Carregar componentes e tema
local components = loadModule("components", 2, totalModules)
if not components then
    StatusText.Text = "Falha ao carregar módulo components"
    task.wait(3)
    LoadingScreen:Destroy()
    return
end

local theme = loadModule("theme", 3, totalModules)
if not theme then
    StatusText.Text = "Falha ao carregar módulo theme"
    task.wait(3)
    LoadingScreen:Destroy()
    return
end

-- Carregar settings para que esteja disponível para outros módulos
local settings = loadModule("settings", 4, totalModules)
if not settings then
    StatusText.Text = "Falha ao carregar módulo settings"
    task.wait(3)
    LoadingScreen:Destroy()
    return
end

-- Inicializar settings primeiro para que as configurações estejam disponíveis
settings.initialize(utils)

-- Carregar autofarm
local autofarm = loadModule("autofarm", 5, totalModules)
if not autofarm then
    StatusText.Text = "Falha ao carregar módulo autofarm"
    task.wait(3)
    LoadingScreen:Destroy()
    return
end

-- Carregar ui
local ui = loadModule("ui", 6, totalModules)
if not ui then
    StatusText.Text = "Falha ao carregar módulo ui"
    task.wait(3)
    LoadingScreen:Destroy()
    return
end

-- Carregar macros por último
local macros = loadModule("macros", 7, totalModules)
if not macros then
    StatusText.Text = "Falha ao carregar módulo macros"
    task.wait(3)
    LoadingScreen:Destroy()
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
    StatusText.Text = "Falha: módulos não definidos corretamente"
    task.wait(3)
    LoadingScreen:Destroy()
    return
end

-- Inicializar módulos na ordem correta
StatusText.Text = "Inicializando módulos..."
ProgressBarFill:TweenSize(UDim2.new(0.9, 0, 1, 0), "Out", "Quad", 0.3, true)
task.wait(0.5)

-- Inicializar autofarm e macros com as dependências corretas
autofarm.initialize(utils)
macros.initialize(utils, settings)

-- Inicializar UI por último já que depende de todos os outros
ui.initialize(utils, macros, components, theme, autofarm, settings)

-- Carregar e executar o script principal
StatusText.Text = "Finalizando..."
ProgressBarFill:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Quad", 0.3, true)
task.wait(0.5)

-- Tela de conclusão
StatusText.Text = "Carregado com sucesso!"
task.wait(1)

-- Remover tela de carregamento
LoadingScreen:TweenPosition(UDim2.new(0, 0, -1, 0), "Out", "Quad", 0.5, true)
task.wait(0.6)

-- Executar o script principal
local success, result = pcall(function()
    local mainContent = game:HttpGet(urls["main"])
    loadstring(mainContent)()
end)

if not success then
    -- Se falhar, exibir mensagem discreta
    local errorGui = Instance.new("ScreenGui")
    errorGui.Name = "Yzz1HubError"
    
    pcall(function()
        if syn and syn.protect_gui then
            syn.protect_gui(errorGui)
        end
        errorGui.Parent = game:GetService("CoreGui")
    end)
    
    if not errorGui.Parent then
        errorGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end
    
    local errorLabel = Instance.new("TextLabel")
    errorLabel.Size = UDim2.new(0, 300, 0, 50)
    errorLabel.Position = UDim2.new(0.5, -150, 0, -60)
    errorLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    errorLabel.BorderSizePixel = 0
    errorLabel.Font = Enum.Font.Gotham
    errorLabel.TextSize = 14
    errorLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    errorLabel.Text = "Erro ao inicializar YZZ1 HUB"
    errorLabel.Parent = errorGui
    
    local errorCorner = Instance.new("UICorner")
    errorCorner.CornerRadius = UDim.new(0, 8)
    errorCorner.Parent = errorLabel
    
    errorLabel:TweenPosition(UDim2.new(0.5, -150, 0, 20), "Out", "Quad", 0.5, true)
    task.wait(5)
    errorLabel:TweenPosition(UDim2.new(0.5, -150, 0, -60), "Out", "Quad", 0.5, true)
    task.wait(0.6)
    errorGui:Destroy()
end

-- Remover a tela de carregamento após tudo estar concluído
task.wait(0.1)
LoadingScreen:Destroy()