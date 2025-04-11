local UIHelper = require(script.Parent.ui_helper)

local HUDSetup = {}

function HUDSetup.createMainHUD()
    local CoreGui = game:GetService("CoreGui")
    local guiName = "Yzz1Hub_RedBlackHUD"
    local existingGui = CoreGui:FindFirstChild(guiName)
    if existingGui then
        existingGui:Destroy()
    end

    -- Cria o ScreenGui principal
    local screenGui = UIHelper.createInstance("ScreenGui", {
        Name = guiName,
        ResetOnSpawn = false,
        Parent = CoreGui
    })

    -- Cria o MainFrame com fundo preto e bordas arredondadas
    local mainFrame = UIHelper.createInstance("Frame", {
        Name = "MainFrame",
        Parent = screenGui,
        Size = UDim2.new(0, 650, 0, 400),
        Position = UDim2.new(0.5, -325, 0.5, -200),
        BackgroundColor3 = Color3.fromRGB(15, 15, 20),
        BorderSizePixel = 0,
        Active = true,
        Draggable = true,
    })
    local mainFrameCorner = UIHelper.createInstance("UICorner", {
        CornerRadius = UDim.new(0, 10),
        Parent = mainFrame
    })

    -- Cria a TopBar com gradiente vermelho e bordas arredondadas na parte superior
    local topBar = UIHelper.createInstance("Frame", {
        Name = "TopBar",
        Parent = mainFrame,
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = Color3.fromRGB(200, 0, 0),
        BorderSizePixel = 0,
    })
    local topBarCorner = UIHelper.createInstance("UICorner", {
        CornerRadius = UDim.new(0, 10),
        Parent = topBar
    })
    -- Adiciona um UIGradient para efeito moderno
    local topBarGradient = UIHelper.createInstance("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 50, 50)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 0, 0))
        }),
        Rotation = 45,
        Parent = topBar
    })

    UIHelper.createInstance("TextLabel", {
        Name = "Title",
        Parent = topBar,
        Position = UDim2.new(0, 15, 0, 0),
        Size = UDim2.new(0, 300, 1, 0),
        Text = "Yzz1Hub - Anime Last Stand",
        Font = Enum.Font.GothamBold,
        TextSize = 20,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    local closeButton = UIHelper.createInstance("TextButton", {
        Name = "CloseButton",
        Parent = topBar,
        Position = UDim2.new(1, -45, 0, 5),
        Size = UDim2.new(0, 30, 0, 30),
        Text = "X",
        Font = Enum.Font.GothamBold,
        TextSize = 18,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundColor3 = Color3.fromRGB(255, 50, 50),
        BorderSizePixel = 0,
    })
    local closeButtonCorner = UIHelper.createInstance("UICorner", {
        CornerRadius = UDim.new(0, 15),
        Parent = closeButton
    })
    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)

    -- Cria o SideMenu com fundo mais escuro e bordas arredondadas
    local sideMenu = UIHelper.createInstance("Frame", {
        Name = "SideMenu",
        Parent = mainFrame,
        Size = UDim2.new(0, 150, 1, -40),
        Position = UDim2.new(0, 0, 0, 40),
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        BorderSizePixel = 0,
    })
    local sideMenuCorner = UIHelper.createInstance("UICorner", {
        CornerRadius = UDim.new(0, 10),
        Parent = sideMenu
    })

    -- Cria os placeholders para as seções principais com um design moderno
    local sections = {}
    local sectionNames = {"Log", "Game", "Macro", "Webhook", "Summon", "Misc", "Player", "About"}
    for _, name in ipairs(sectionNames) do
        local section = UIHelper.createInstance("Frame", {
            Name = name .. "Section",
            Parent = mainFrame,
            Size = UDim2.new(1, -170, 1, -50),
            Position = UDim2.new(0, 160, 0, 45),
            BackgroundColor3 = Color3.fromRGB(25, 25, 35),
            BorderSizePixel = 0,
            Visible = false
        })
        local sectionCorner = UIHelper.createInstance("UICorner", {
            CornerRadius = UDim.new(0, 5),
            Parent = section
        })
        sections[name] = section
    end

    -- Exibe a seção inicial (por exemplo, Macro)
    if sections["Macro"] then
        sections["Macro"].Visible = true
    end

    return {
        ScreenGui = screenGui,
        MainFrame = mainFrame,
        TopBar = topBar,
        SideMenu = sideMenu,
        Sections = sections
    }
end

return HUDSetup