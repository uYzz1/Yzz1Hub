-- gui.lua - Interface gráfica do Yzz1Hub
local gui = {}
local logger = loadfile("modules/logger.lua")()

-- Funções utilitárias de criação de elementos
function gui.createFrame(parent, size, position, color, zindex)
    local frame = Instance.new("Frame", parent)
    frame.Size = size or UDim2.new(1,0,1,0)
    frame.Position = position or UDim2.new(0,0,0,0)
    frame.BackgroundColor3 = color or Color3.fromRGB(20,20,30)
    frame.BorderSizePixel = 0
    frame.ZIndex = zindex or 1
    return frame
end

function gui.createTextLabel(parent, text, size, position, font, textSize, color, bgTransparency, align)
    local label = Instance.new("TextLabel", parent)
    label.Size = size or UDim2.new(1,0,1,0)
    label.Position = position or UDim2.new(0,0,0,0)
    label.Text = text or ""
    label.Font = font or Enum.Font.Gotham
    label.TextSize = textSize or 13
    label.TextColor3 = color or Color3.new(1,1,1)
    label.BackgroundTransparency = bgTransparency or 1
    label.TextXAlignment = align or Enum.TextXAlignment.Left
    label.BackgroundColor3 = Color3.fromRGB(20,20,30)
    return label
end

function gui.createButton(parent, text, posX, posY, width, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0, width or 160, 0, 30)
    btn.Position = UDim2.new(0, posX, 0, posY)
    btn.Text = text
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 13
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BackgroundColor3 = Color3.fromRGB(60,50,90)
    btn.BorderSizePixel = 0
    btn.ZIndex = 2
    btn.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
    return btn
end

function gui.createToggle(parent, text, posX, posY, callback)
    local container = Instance.new("Frame", parent)
    container.Size = UDim2.new(0, 160, 0, 30)
    container.Position = UDim2.new(0, posX, 0, posY)
    container.BackgroundTransparency = 1
    local label = gui.createTextLabel(container, text, UDim2.new(0, 120, 1, 0), UDim2.new(0, 0, 0, 0), Enum.Font.Gotham, 13, Color3.new(1,1,1), 1, Enum.TextXAlignment.Left)
    local toggleBtn = Instance.new("TextButton", container)
    toggleBtn.Size = UDim2.new(0, 30, 0, 30)
    toggleBtn.Position = UDim2.new(1, -30, 0, 0)
    toggleBtn.Text = "OFF"
    toggleBtn.Font = Enum.Font.Gotham
    toggleBtn.TextSize = 13
    toggleBtn.TextColor3 = Color3.new(1,1,1)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(80,60,90)
    toggleBtn.BorderSizePixel = 0
    toggleBtn.ZIndex = 2
    local enabled = false
    toggleBtn.MouseButton1Click:Connect(function()
        enabled = not enabled
        toggleBtn.Text = enabled and "ON" or "OFF"
        if callback then callback(enabled) end
    end)
    return container
end

function gui.createDropdown(parent, options, posX, posY, sizeX, callback)
    local container = Instance.new("Frame", parent)
    container.Size = UDim2.new(0, sizeX or 200, 0, 30)
    container.Position = UDim2.new(0, posX, 0, posY)
    container.BackgroundColor3 = Color3.fromRGB(50, 40, 80)
    container.BorderSizePixel = 0
    local selected = gui.createTextLabel(container, options[1] or "Select...", UDim2.new(1, -30, 1, 0), UDim2.new(0, 10, 0, 0), Enum.Font.Gotham, 13, Color3.new(1,1,1), 1, Enum.TextXAlignment.Left)
    local arrow = gui.createTextLabel(container, "▼", UDim2.new(0, 20, 1, 0), UDim2.new(1, -25, 0, 0), Enum.Font.Gotham, 13, Color3.new(1,1,1), 1, Enum.TextXAlignment.Left)
    local dropFrame = Instance.new("Frame", container)
    dropFrame.Size = UDim2.new(1, 0, 0, #options * 30)
    dropFrame.Position = UDim2.new(0, 0, 1, 0)
    dropFrame.BackgroundColor3 = Color3.fromRGB(60, 50, 90)
    dropFrame.BorderSizePixel = 0
    dropFrame.Visible = false
    dropFrame.ZIndex = 10
    for i, option in ipairs(options) do
        local optionBtn = Instance.new("TextButton", dropFrame)
        optionBtn.Size = UDim2.new(1, 0, 0, 30)
        optionBtn.Position = UDim2.new(0, 0, 0, (i-1) * 30)
        optionBtn.Text = option
        optionBtn.Font = Enum.Font.Gotham
        optionBtn.TextSize = 13
        optionBtn.TextColor3 = Color3.new(1,1,1)
        optionBtn.BackgroundColor3 = Color3.fromRGB(60,50,90)
        optionBtn.BorderSizePixel = 0
        optionBtn.ZIndex = 10
        optionBtn.MouseButton1Click:Connect(function()
            selected.Text = option
            dropFrame.Visible = false
            if callback then callback(option) end
        end)
    end
    selected.MouseEnter:Connect(function() dropFrame.Visible = true end)
    selected.MouseLeave:Connect(function() dropFrame.Visible = false end)
    return container
end

function gui.createTextBox(parent, placeholder, posX, posY, width)
    local box = Instance.new("TextBox", parent)
    box.Size = UDim2.new(0, width or 200, 0, 30)
    box.Position = UDim2.new(0, posX, 0, posY)
    box.PlaceholderText = placeholder or ""
    box.Font = Enum.Font.Gotham
    box.TextSize = 13
    box.TextColor3 = Color3.new(1,1,1)
    box.BackgroundColor3 = Color3.fromRGB(60,50,90)
    box.BorderSizePixel = 0
    box.ZIndex = 2
    return box
end

function gui.init()
    -- Aqui você pode montar toda a interface padrão do Yzz1Hub usando as funções acima
    logger.addLogMessage("[GUI] Interface gráfica inicializada!")
end

return gui
