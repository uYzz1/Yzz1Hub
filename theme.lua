-- Módulo de Temas para Yzz1Hub
local theme = {}

-- Temas disponíveis
theme.themes = {
    Dark = {
        background = Color3.fromRGB(30, 30, 40),
        sidebar = Color3.fromRGB(20, 20, 25),
        content = Color3.fromRGB(35, 35, 45),
        text = Color3.fromRGB(255, 255, 255),
        subtext = Color3.fromRGB(180, 180, 180),
        accent = Color3.fromRGB(90, 60, 150),
        button = Color3.fromRGB(90, 60, 150),
        buttonHover = Color3.fromRGB(110, 80, 180),
        toggle = Color3.fromRGB(90, 60, 150),
        input = Color3.fromRGB(50, 50, 65),
        inputBorder = Color3.fromRGB(80, 80, 100),
        dropdown = Color3.fromRGB(50, 50, 65),
        dropdownOption = Color3.fromRGB(60, 60, 75)
    },
    
    Light = {
        background = Color3.fromRGB(240, 240, 245),
        sidebar = Color3.fromRGB(220, 220, 230),
        content = Color3.fromRGB(230, 230, 235),
        text = Color3.fromRGB(50, 50, 60),
        subtext = Color3.fromRGB(100, 100, 110),
        accent = Color3.fromRGB(100, 80, 200),
        button = Color3.fromRGB(100, 80, 200),
        buttonHover = Color3.fromRGB(130, 100, 220),
        toggle = Color3.fromRGB(100, 80, 200),
        input = Color3.fromRGB(210, 210, 220),
        inputBorder = Color3.fromRGB(180, 180, 190),
        dropdown = Color3.fromRGB(210, 210, 220),
        dropdownOption = Color3.fromRGB(200, 200, 210)
    },
    
    Purple = {
        background = Color3.fromRGB(40, 30, 60),
        sidebar = Color3.fromRGB(30, 20, 45),
        content = Color3.fromRGB(45, 35, 70),
        text = Color3.fromRGB(240, 230, 255),
        subtext = Color3.fromRGB(200, 190, 230),
        accent = Color3.fromRGB(120, 80, 220),
        button = Color3.fromRGB(120, 80, 220),
        buttonHover = Color3.fromRGB(150, 100, 255),
        toggle = Color3.fromRGB(120, 80, 220),
        input = Color3.fromRGB(60, 45, 85),
        inputBorder = Color3.fromRGB(90, 70, 130),
        dropdown = Color3.fromRGB(60, 45, 85),
        dropdownOption = Color3.fromRGB(70, 55, 100)
    },
    
    Blue = {
        background = Color3.fromRGB(25, 30, 45),
        sidebar = Color3.fromRGB(20, 25, 35),
        content = Color3.fromRGB(30, 35, 55),
        text = Color3.fromRGB(230, 240, 255),
        subtext = Color3.fromRGB(180, 200, 230),
        accent = Color3.fromRGB(60, 100, 200),
        button = Color3.fromRGB(60, 100, 200),
        buttonHover = Color3.fromRGB(80, 120, 230),
        toggle = Color3.fromRGB(60, 100, 200),
        input = Color3.fromRGB(40, 50, 70),
        inputBorder = Color3.fromRGB(70, 90, 130),
        dropdown = Color3.fromRGB(40, 50, 70),
        dropdownOption = Color3.fromRGB(50, 60, 90)
    }
}

-- Tema padrão
theme.currentTheme = "Dark"

-- Função para obter o tema atual
function theme.getCurrentTheme()
    return theme.themes[theme.currentTheme]
end

-- Função para definir o tema
function theme.setTheme(themeName)
    if theme.themes[themeName] then
        theme.currentTheme = themeName
        return true
    end
    return false
end

-- Função para aplicar o tema a um elemento específico
function theme.applyToElement(element, themeProperty)
    local currentTheme = theme.getCurrentTheme()
    
    if element and currentTheme[themeProperty] then
        element.BackgroundColor3 = currentTheme[themeProperty]
        return true
    end
    
    return false
end

-- Função para aplicar o tema de texto a um elemento
function theme.applyTextColor(element, isSubtext)
    local currentTheme = theme.getCurrentTheme()
    
    if element then
        element.TextColor3 = isSubtext and currentTheme.subtext or currentTheme.text
        return true
    end
    
    return false
end

-- Função para obter uma cor do tema atual
function theme.getColor(colorName)
    local currentTheme = theme.getCurrentTheme()
    return currentTheme[colorName]
end

-- Função para criar e aplicar um gradiente
function theme.applyGradient(element, startColor, endColor, rotation)
    if not element then return false end
    
    local currentTheme = theme.getCurrentTheme()
    local start = startColor and currentTheme[startColor] or Color3.fromRGB(70, 50, 120)
    local finish = endColor and currentTheme[endColor] or Color3.fromRGB(50, 40, 80)
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, start),
        ColorSequenceKeypoint.new(1, finish)
    })
    gradient.Rotation = rotation or 45
    gradient.Parent = element
    
    return gradient
end

return theme 