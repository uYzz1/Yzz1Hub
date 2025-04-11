local UIHelper = {}

-- Cria uma instância e aplica propriedades
function UIHelper.createInstance(className, properties)
    local inst = Instance.new(className)
    for k, v in pairs(properties or {}) do
        inst[k] = v
    end
    return inst
end

-- Cria um TextLabel com configuração padrão
function UIHelper.createLabel(parent, text, pos, size)
    local label = UIHelper.createInstance("TextLabel", {
        Parent = parent,
        Text = text,
        Position = pos,
        Size = size,
        Font = Enum.Font.GothamSemibold,
        TextSize = 14,
        TextColor3 = Color3.new(1, 1, 1),
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    return label
end

-- Cria um botão customizado
function UIHelper.createButton(parent, text, pos, size, callback)
    local btn = UIHelper.createInstance("TextButton", {
        Parent = parent,
        Text = text,
        Position = pos,
        Size = size or UDim2.new(0, 160, 0, 30),
        Font = Enum.Font.Gotham,
        TextSize = 14,
        TextColor3 = Color3.new(1, 1, 1),
        BackgroundColor3 = Color3.fromRGB(150, 0, 0), -- Cor vermelha como padrão
        BorderSizePixel = 0
    })
    if callback then
        btn.MouseButton1Click:Connect(callback)
    end
    return btn
end

-- Cria um toggle simples (sem animações complexas)
function UIHelper.createToggle(parent, text, pos, callback)
    local container = UIHelper.createInstance("Frame", {
        Parent = parent,
        Position = pos,
        Size = UDim2.new(0, 160, 0, 30),
        BackgroundTransparency = 1
    })
    local label = UIHelper.createLabel(container, text, UDim2.new(0, 0, 0, 0), UDim2.new(0, 120, 1, 0))
    local toggleFrame = UIHelper.createInstance("Frame", {
        Parent = container,
        Position = UDim2.new(1, -44, 0.5, -12),
        Size = UDim2.new(0, 44, 0, 24),
        BackgroundColor3 = Color3.fromRGB(60, 60, 80),
        BorderSizePixel = 0
    })
    local state = false
    container.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            state = not state
            toggleFrame.BackgroundColor3 = state and Color3.fromRGB(90, 150, 90) or Color3.fromRGB(60,60,80)
            if callback then
                callback(state)
            end
        end
    end)
    return {
        Container = container,
        getState = function() return state end,
        setState = function(val)
            state = val
            toggleFrame.BackgroundColor3 = state and Color3.fromRGB(90, 150, 90) or Color3.fromRGB(60,60,80)
        end
    }
end

-- Cria um TextBox customizado
function UIHelper.createTextBox(parent, placeholder, pos, size)
    local textBox = UIHelper.createInstance("TextBox", {
        Parent = parent,
        PlaceholderText = placeholder,
        Position = pos,
        Size = size or UDim2.new(0, 200, 0, 30),
        Text = "",
        Font = Enum.Font.Gotham,
        TextSize = 13,
        TextColor3 = Color3.new(1, 1, 1),
        BackgroundColor3 = Color3.fromRGB(50, 40, 80),
        BorderSizePixel = 0
    })
    return textBox
end

-- Cria um Dropdown básico
function UIHelper.createDropdown(parent, options, pos, size, callback)
    local container = UIHelper.createInstance("Frame", {
        Parent = parent,
        Position = pos,
        Size = size or UDim2.new(0, 200, 0, 30),
        BackgroundColor3 = Color3.fromRGB(50, 40, 80),
        BorderSizePixel = 0
    })
    local selectedLabel = UIHelper.createLabel(container, options[1] or "Select...", UDim2.new(0, 10, 0, 0), UDim2.new(1, -30, 1, 0))
    local dropdownVisible = false
    local dropdownFrame = UIHelper.createInstance("Frame", {
        Parent = container,
        Position = UDim2.new(0, 0, 1, 0),
        Size = UDim2.new(1, 0, 0, #options * 30),
        BackgroundColor3 = Color3.fromRGB(60,50,90),
        BorderSizePixel = 0,
        Visible = false
    })
    for i, option in ipairs(options) do
        local optionBtn = UIHelper.createButton(dropdownFrame, option, UDim2.new(0,0,0,(i-1)*30), UDim2.new(1,0,0,30), function()
            selectedLabel.Text = option
            dropdownFrame.Visible = false
            dropdownVisible = false
            if callback then
                callback(option)
            end
        end)
    end
    container.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dropdownVisible = not dropdownVisible
            dropdownFrame.Visible = dropdownVisible
        end
    end)
    return {
        Container = container,
        getValue = function() return selectedLabel.Text end,
        setValue = function(val) selectedLabel.Text = val end
    }
end

-- Cria um ScrollingFrame customizado
function UIHelper.createScrollFrame(parent, pos, size)
    local sf = UIHelper.createInstance("ScrollingFrame", {
        Parent = parent,
        Position = pos,
        Size = size,
        BackgroundColor3 = Color3.fromRGB(35,35,45),
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = Color3.fromRGB(90,60,150)
    })
    return sf
end

return UIHelper