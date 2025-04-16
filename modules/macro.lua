-- macro.lua - Gravação, execução e gerenciamento de macros
local macro = {}

macro.macroData = {}

function macro.saveMacro(filename, data)
    writefile(filename, game:GetService('HttpService'):JSONEncode(data))
end

function macro.loadMacro(filename)
    if isfile(filename) then
        local content = readfile(filename)
        return game:GetService('HttpService'):JSONDecode(content)
    end
    return nil
end

return macro
