-- Módulo de Interface para Yzz1Hub
local ui = {}

-- Dependências
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Variáveis locais
local MainFrame
local MainGUI
local sections = {}
local selectedSection = "Macro"
local selectedTheme = "Dark"
local listMacros

-- Referência para outros módulos (serão definidos na inicialização)
local utils, macros

-- Variáveis globais para referência entre funções
ui.logScroll = nil
ui.updateLogDisplay = nil

-- Inicializa o módulo
function ui.initialize(utilsModule, macrosModule)
    utils = utilsModule
    macros = macrosModule
    
    -- Configurar tema
    ui.applyTheme(selectedTheme)
end

-- Aplica um tema
function ui.applyTheme(theme)
    selectedTheme = theme
    
    local themes = {
        Dark = {
            background = Color3.fromRGB(30, 30, 40),
            sidebar = Color3.fromRGB(20, 20, 25),
            text = Color3.fromRGB(255, 255, 255),
            accent = Color3.fromRGB(90, 60, 150),
            button = Color3.fromRGB(90, 60, 150),
            highlight = Color3.fromRGB(110, 80, 180)
        },
        Light = {
            background = Color3.fromRGB(240, 240, 245),
            sidebar = Color3.fromRGB(220, 220, 230),
            text = Color3.fromRGB(50, 50, 60),
            accent = Color3.fromRGB(100, 80, 200),
            button = Color3.fromRGB(100, 80, 200),
            highlight = Color3.fromRGB(130, 100, 220)
        },
        Purple = {
            background = Color3.fromRGB(40, 30, 60),
            sidebar = Color3.fromRGB(30, 20, 45),
            text = Color3.fromRGB(240, 230, 255),
            accent = Color3.fromRGB(120, 80, 220),
            button = Color3.fromRGB(120, 80, 220),
            highlight = Color3.fromRGB(150, 100, 255)
        }
    }
    
    local currentTheme = themes[theme] or themes.Dark
    
    -- Aplicar tema aos elementos da interface
    if MainFrame then
        MainFrame.BackgroundColor3 = currentTheme.background
        -- Aplicar a outros elementos
    end
end

-- Cria a interface principal
function ui.createMainUI()
    -- Verificar se já existe uma GUI anterior e removê-la
    if CoreGui:FindFirstChild("Yzz1HubPremium") then
        CoreGui:FindFirstChild("Yzz1HubPremium"):Destroy()
    end
    
    MainGUI = Instance.new("ScreenGui")
    MainGUI.Name = "Yzz1HubPremium"
    MainGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    MainGUI.ResetOnSpawn = false
    
    pcall(function()
        syn.protect_gui(MainGUI)
        MainGUI.Parent = CoreGui
    end)
    
    if not MainGUI.Parent then
        MainGUI.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end
    
    -- Criar o frame principal
    MainFrame = Instance.new("Frame", MainGUI)
    MainFrame.Size = UDim2.new(0, 700, 0, 450)
    MainFrame.Position = UDim2.new(0.5, -350, 0.5, -225)
    MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    
    -- Arredondar os cantos
    local UICorner = Instance.new("UICorner", MainFrame)
    UICorner.CornerRadius = UDim.new(0, 12)
    
    -- Adicionar sombra
    local DropShadow = Instance.new("ImageLabel", MainFrame)
    DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
    DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    DropShadow.Size = UDim2.new(1, 35, 1, 35)
    DropShadow.BackgroundTransparency = 1
    DropShadow.Image = "rbxassetid://6015897843"
    DropShadow.ImageColor3 = Color3.new(0, 0, 0)
    DropShadow.ImageTransparency = 0.5
    DropShadow.ScaleType = Enum.ScaleType.Slice
    DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)
    DropShadow.ZIndex = -1
    
    -- Criar a barra lateral
    local Sidebar = Instance.new("Frame", MainFrame)
    Sidebar.Size = UDim2.new(0, 130, 1, 0)
    Sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    Sidebar.BorderSizePixel = 0
    
    local SidebarCorner = Instance.new("UICorner", Sidebar)
    SidebarCorner.CornerRadius = UDim.new(0, 12)
    
    -- Título do script
    local Title = Instance.new("TextLabel", Sidebar)
    Title.Size = UDim2.new(1, 0, 0, 60)
    Title.BackgroundTransparency = 1
    Title.Text = "Yzz1Hub"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 24
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    -- Versão do script
    local Version = Instance.new("TextLabel", Sidebar)
    Version.Size = UDim2.new(1, 0, 0, 20)
    Version.Position = UDim2.new(0, 0, 0, 50)
    Version.BackgroundTransparency = 1
    Version.Text = "v" .. utils.SCRIPT_VERSION
    Version.Font = Enum.Font.Gotham
    Version.TextSize = 14
    Version.TextColor3 = Color3.fromRGB(180, 180, 180)
    
    -- Cria as seções principais
    ui.createSections()
    
    -- Cria a barra de navegação
    ui.createNavigation(Sidebar)
    
    -- Inicializa com a seção padrão
    ui.selectSection(selectedSection)
    
    return MainGUI
end

-- Cria as seções da interface
function ui.createSections()
    -- Seção de Macros
    local macroSection = ui.createSection("Macro")
    
    -- Botões de controle para macros
    local startBtn = ui.createButton(macroSection, "Iniciar Gravação", 20, 20, 160, function()
        macros.startRecording()
    end)
    
    local stopBtn = ui.createButton(macroSection, "Parar Gravação", 190, 20, 160, function()
        macros.stopRecording()
    end)
    
    -- Input para nome do macro
    local nameInput = Instance.new("TextBox", macroSection)
    nameInput.Size = UDim2.new(0, 160, 0, 30)
    nameInput.Position = UDim2.new(0, 20, 0, 70)
    nameInput.PlaceholderText = "Nome do Macro"
    nameInput.Text = ""
    nameInput.Font = Enum.Font.Gotham
    nameInput.TextSize = 14
    nameInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameInput.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    nameInput.BorderSizePixel = 0
    
    local cornerName = Instance.new("UICorner", nameInput)
    cornerName.CornerRadius = UDim.new(0, 8)
    
    -- Botão para salvar
    local saveBtn = ui.createButton(macroSection, "Salvar Macro", 190, 70, 160, function()
        macros.saveMacro(nameInput.Text)
    end)
    
    -- Lista de macros
    local macroListLabel = Instance.new("TextLabel", macroSection)
    macroListLabel.Size = UDim2.new(0, 300, 0, 30)
    macroListLabel.Position = UDim2.new(0, 20, 0, 120)
    macroListLabel.Text = "Macros Salvos"
    macroListLabel.Font = Enum.Font.GothamBold
    macroListLabel.TextSize = 16
    macroListLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    macroListLabel.TextXAlignment = Enum.TextXAlignment.Left
    macroListLabel.BackgroundTransparency = 1
    
    local macroListFrame = Instance.new("Frame", macroSection)
    macroListFrame.Size = UDim2.new(0, 530, 0, 250)
    macroListFrame.Position = UDim2.new(0, 20, 0, 160)
    macroListFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    macroListFrame.BorderSizePixel = 0
    
    local cornerMacroList = Instance.new("UICorner", macroListFrame)
    cornerMacroList.CornerRadius = UDim.new(0, 10)
    
    -- Criar ScrollingFrame para a lista de macros
    listMacros = Instance.new("ScrollingFrame", macroListFrame)
    listMacros.Size = UDim2.new(1, -10, 1, -10)
    listMacros.Position = UDim2.new(0, 5, 0, 5)
    listMacros.BackgroundTransparency = 1
    listMacros.ScrollBarThickness = 4
    listMacros.ScrollBarImageColor3 = Color3.fromRGB(120, 90, 200)
    listMacros.CanvasSize = UDim2.new(0, 0, 0, 0)
    listMacros.AutomaticCanvasSize = Enum.AutomaticSize.Y
    
    -- Adiciona variáveis globais que podem ser acessadas por outros módulos
    _G.listMacros = listMacros
end

-- Cria uma seção na interface
function ui.createSection(name)
    local section = Instance.new("Frame", MainFrame)
    section.Size = UDim2.new(1, -140, 1, -40)
    section.Position = UDim2.new(0, 130, 0, 30)
    section.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    section.BorderSizePixel = 0
    section.Visible = false
    
    -- Cantos arredondados
    local corner = Instance.new("UICorner", section)
    corner.CornerRadius = UDim.new(0, 12)
    
    sections[name] = section
    return section
end

-- Cria a navegação lateral
function ui.createNavigation(sidebar)
    local startY = 100
    local buttonHeight = 40
    
    local sectionButtons = {
        {name = "Macro", icon = "rbxassetid://7733715400"},
        {name = "Auto Farm", icon = "rbxassetid://7733774602"},
        {name = "Configurações", icon = "rbxassetid://7734053495"}
    }
    
    for i, section in ipairs(sectionButtons) do
        local btn = Instance.new("TextButton", sidebar)
        btn.Size = UDim2.new(1, -20, 0, buttonHeight)
        btn.Position = UDim2.new(0, 10, 0, startY + (i-1) * (buttonHeight + 5))
        btn.Text = section.name
        btn.Font = Enum.Font.GothamSemibold
        btn.TextSize = 14
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
        btn.BorderSizePixel = 0
        btn.TextXAlignment = Enum.TextXAlignment.Left
        
        -- Padding interno
        local padding = Instance.new("UIPadding", btn)
        padding.PaddingLeft = UDim.new(0, 40)
        
        -- Cantos arredondados
        local corner = Instance.new("UICorner", btn)
        corner.CornerRadius = UDim.new(0, 8)
        
        -- Ícone
        local icon = Instance.new("ImageLabel", btn)
        icon.Size = UDim2.new(0, 20, 0, 20)
        icon.Position = UDim2.new(0, 10, 0.5, -10)
        icon.BackgroundTransparency = 1
        icon.Image = section.icon
        icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
        
        -- Função de clique
        btn.MouseButton1Click:Connect(function()
            ui.selectSection(section.name)
        end)
        
        -- Hover effect
        btn.MouseEnter:Connect(function()
            btn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        end)
        
        btn.MouseLeave:Connect(function()
            if selectedSection ~= section.name then
                btn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
            end
        end)
    end
end

-- Seleciona uma seção para exibir
function ui.selectSection(name)
    selectedSection = name
    
    -- Esconde todas as seções
    for sectionName, section in pairs(sections) do
        section.Visible = (sectionName == name)
    end
    
    -- Atualiza a UI da barra lateral
    for _, btn in pairs(MainFrame.Sidebar:GetChildren()) do
        if btn:IsA("TextButton") and btn.Text == name then
            btn.BackgroundColor3 = Color3.fromRGB(70, 60, 110)
        elseif btn:IsA("TextButton") then
            btn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
        end
    end
end

-- Cria um botão padrão
function ui.createButton(parent, text, posX, posY, sizeX, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0, sizeX or 160, 0, 34)
    btn.Position = UDim2.new(0, posX, 0, posY)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.BackgroundColor3 = Color3.fromRGB(90, 60, 150)
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    
    -- Padding interno
    local padding = Instance.new("UIPadding", btn)
    padding.PaddingTop = UDim.new(0, 6)
    padding.PaddingBottom = UDim.new(0, 6)
    padding.PaddingLeft = UDim.new(0, 12)
    padding.PaddingRight = UDim.new(0, 12)
    
    -- Cantos arredondados
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 10)
    
    -- Efeitos visuais ao interagir
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(110, 80, 200)
        btn:TweenSize(UDim2.new(0, sizeX + 4, 0, 38), "Out", "Quad", 0.18, true)
    end)
    
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(90, 60, 150)
        btn:TweenSize(UDim2.new(0, sizeX, 0, 34), "Out", "Quad", 0.18, true)
    end)
    
    if callback then
        btn.MouseButton1Click:Connect(callback)
    end
    
    return btn
end

return ui 