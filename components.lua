-- Módulo de Componentes de UI para Yzz1Hub
local components = {}

-- Serviços do Roblox
local TweenService = game:GetService("TweenService")

-- Cria um rótulo de texto
function components.createLabel(parent, text, posY, size)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, size or 300, 0, 20)
    label.Position = UDim2.new(0, 10, 0, posY)
    label.Text = text
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 14
    label.TextColor3 = Color3.new(1, 1, 1)
    label.BackgroundTransparency = 1
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = parent
    return label
end

-- Cria um botão estilizado
function components.createButton(parent, text, posX, posY, sizeX, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, sizeX or 160, 0, 34)
    btn.Position = UDim2.new(0, posX, 0, posY)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.BackgroundColor3 = Color3.fromRGB(90, 60, 150)
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    btn.Parent = parent
    
    -- Padding interno
    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 6)
    padding.PaddingBottom = UDim.new(0, 6)
    padding.PaddingLeft = UDim.new(0, 12)
    padding.PaddingRight = UDim.new(0, 12)
    padding.Parent = btn
    
    -- Cantos arredondados
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = btn
    
    -- Contorno
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(160, 120, 255)
    stroke.Thickness = 2
    stroke.Transparency = 0.15
    stroke.Parent = btn
    
    -- Gradiente sutil
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 80, 200)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(90, 60, 150))
    })
    gradient.Rotation = 45
    gradient.Parent = btn
    
    -- Efeitos visuais ao interagir
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(110, 80, 200)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn:TweenSize(UDim2.new(0, (sizeX or 160) + 6, 0, 38), "Out", "Quad", 0.18, true)
    end)
    
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(90, 60, 150)
        btn.TextColor3 = Color3.fromRGB(240, 240, 255)
        btn:TweenSize(UDim2.new(0, sizeX or 160, 0, 34), "Out", "Quad", 0.18, true)
    end)
    
    btn.MouseButton1Down:Connect(function()
        btn:TweenSize(UDim2.new(0, (sizeX or 160) + 2, 0, 32), "Out", "Quad", 0.09, true)
    end)
    
    btn.MouseButton1Up:Connect(function()
        btn:TweenSize(UDim2.new(0, (sizeX or 160) + 6, 0, 38), "Out", "Quad", 0.13, true)
    end)
    
    if callback then
        btn.MouseButton1Click:Connect(callback)
    end
    
    return btn
end

-- Cria um toggle (interruptor) estilizado
function components.createToggle(parent, text, posX, posY, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(0, 160, 0, 30)
    container.Position = UDim2.new(0, posX, 0, posY)
    container.BackgroundTransparency = 1
    container.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 120, 1, 0)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.Text = text
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 14
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.BackgroundTransparency = 1
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local toggleBackground = Instance.new("Frame")
    toggleBackground.Size = UDim2.new(0, 44, 0, 24)
    toggleBackground.Position = UDim2.new(1, -44, 0.5, -12)
    toggleBackground.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    toggleBackground.BorderSizePixel = 0
    toggleBackground.Parent = container

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = toggleBackground

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 20, 0, 20)
    knob.Position = UDim2.new(0, 2, 0.5, -10)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.BorderSizePixel = 0
    knob.Parent = toggleBackground

    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1, 0)
    knobCorner.Parent = knob

    -- Estado do toggle
    local enabled = false
    
    -- Função para atualizar visualmente o toggle
    local function updateToggle()
        if enabled then
            toggleBackground.BackgroundColor3 = Color3.fromRGB(90, 60, 150)
            knob:TweenPosition(UDim2.new(0, 22, 0.5, -10), "Out", "Quad", 0.2, true)
        else
            toggleBackground.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
            knob:TweenPosition(UDim2.new(0, 2, 0.5, -10), "Out", "Quad", 0.2, true)
        end
    end
    
    -- Função para definir o estado
    local function setEnabled(value)
        enabled = value
        updateToggle()
        if callback then
            callback(enabled)
        end
    end
    
    -- Função para obter o estado atual
    local function getEnabled()
        return enabled
    end
    
    -- Clique para alternar o estado
    toggleBackground.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            setEnabled(not enabled)
        end
    end)
    
    knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            setEnabled(not enabled)
        end
    end)
    
    -- Retornar o objeto com métodos
    return {
        container = container,
        setEnabled = setEnabled,
        getEnabled = getEnabled,
        SetValue = setEnabled  -- Alias para compatibilidade
    }
end

-- Cria um input de texto
function components.createTextInput(parent, placeholder, posX, posY, sizeX, callback)
    local input = Instance.new("TextBox")
    input.Size = UDim2.new(0, sizeX or 200, 0, 34)
    input.Position = UDim2.new(0, posX, 0, posY)
    input.PlaceholderText = placeholder
    input.Text = ""
    input.Font = Enum.Font.Gotham
    input.TextSize = 14
    input.TextColor3 = Color3.fromRGB(255, 255, 255)
    input.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    input.BorderSizePixel = 0
    input.Parent = parent
    
    -- Cantos arredondados
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = input
    
    -- Contorno
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(80, 80, 100)
    stroke.Thickness = 1
    stroke.Transparency = 0.5
    stroke.Parent = input
    
    -- Padding
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 10)
    padding.PaddingRight = UDim.new(0, 10)
    padding.Parent = input
    
    -- Efeitos visuais
    input.Focused:Connect(function()
        stroke.Color = Color3.fromRGB(120, 80, 200)
        stroke.Thickness = 2
        stroke.Transparency = 0.2
    end)
    
    input.FocusLost:Connect(function(enterPressed)
        stroke.Color = Color3.fromRGB(80, 80, 100)
        stroke.Thickness = 1
        stroke.Transparency = 0.5
        
        if enterPressed and callback then
            callback(input.Text)
        end
    end)
    
    return input
end

-- Cria um dropdown de seleção
function components.createDropdown(parent, title, options, posX, posY, sizeX, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(0, sizeX or 200, 0, 34)
    container.Position = UDim2.new(0, posX, 0, posY)
    container.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    container.BorderSizePixel = 0
    container.ClipsDescendants = true
    container.Parent = parent
    
    -- Cantos arredondados
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = container
    
    -- Título/Valor selecionado
    local selectedLabel = Instance.new("TextLabel")
    selectedLabel.Size = UDim2.new(1, -30, 1, 0)
    selectedLabel.Position = UDim2.new(0, 0, 0, 0)
    selectedLabel.Text = title
    selectedLabel.Font = Enum.Font.Gotham
    selectedLabel.TextSize = 14
    selectedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    selectedLabel.BackgroundTransparency = 1
    selectedLabel.TextXAlignment = Enum.TextXAlignment.Left
    selectedLabel.Parent = container
    
    -- Padding
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 10)
    padding.Parent = selectedLabel
    
    -- Botão de seta
    local arrowButton = Instance.new("TextButton")
    arrowButton.Size = UDim2.new(0, 30, 1, 0)
    arrowButton.Position = UDim2.new(1, -30, 0, 0)
    arrowButton.Text = "▼"
    arrowButton.Font = Enum.Font.Gotham
    arrowButton.TextSize = 14
    arrowButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    arrowButton.BackgroundTransparency = 1
    arrowButton.Parent = container
    
    -- Opções
    local optionsContainer = Instance.new("Frame")
    optionsContainer.Size = UDim2.new(1, 0, 0, #options * 30)
    optionsContainer.Position = UDim2.new(0, 0, 1, 0)
    optionsContainer.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
    optionsContainer.BorderSizePixel = 0
    optionsContainer.Visible = false
    optionsContainer.Parent = container
    
    -- Layout para as opções
    local listLayout = Instance.new("UIListLayout")
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Parent = optionsContainer
    
    -- Variáveis para controle
    local isOpen = false
    local selectedOption = nil
    
    -- Função para abrir/fechar o dropdown
    local function toggleDropdown()
        isOpen = not isOpen
        if isOpen then
            container:TweenSize(UDim2.new(0, sizeX or 200, 0, 34 + #options * 30), "Out", "Quad", 0.2, true)
            arrowButton.Text = "▲"
            optionsContainer.Visible = true
        else
            container:TweenSize(UDim2.new(0, sizeX or 200, 0, 34), "Out", "Quad", 0.2, true)
            arrowButton.Text = "▼"
            optionsContainer.Visible = false
        end
    end
    
    -- Adicionar opções
    for i, option in ipairs(options) do
        local optionButton = Instance.new("TextButton")
        optionButton.Size = UDim2.new(1, 0, 0, 30)
        optionButton.Text = option
        optionButton.Font = Enum.Font.Gotham
        optionButton.TextSize = 14
        optionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        optionButton.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
        optionButton.BackgroundTransparency = 0
        optionButton.BorderSizePixel = 0
        optionButton.TextXAlignment = Enum.TextXAlignment.Left
        optionButton.Parent = optionsContainer
        
        -- Padding
        local optionPadding = Instance.new("UIPadding")
        optionPadding.PaddingLeft = UDim.new(0, 10)
        optionPadding.Parent = optionButton
        
        -- Hover effect
        optionButton.MouseEnter:Connect(function()
            optionButton.BackgroundColor3 = Color3.fromRGB(80, 80, 95)
        end)
        
        optionButton.MouseLeave:Connect(function()
            optionButton.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
        end)
        
        -- Click
        optionButton.MouseButton1Click:Connect(function()
            selectedLabel.Text = option
            selectedOption = option
            toggleDropdown()
            if callback then
                callback(option)
            end
        end)
    end
    
    -- Eventos para abrir/fechar
    arrowButton.MouseButton1Click:Connect(toggleDropdown)
    
    return {
        container = container,
        getValue = function() return selectedOption end,
        setValue = function(value)
            for _, v in ipairs(options) do
                if v == value then
                    selectedLabel.Text = value
                    selectedOption = value
                    if callback then
                        callback(value)
                    end
                    break
                end
            end
        end
    }
end

return components 