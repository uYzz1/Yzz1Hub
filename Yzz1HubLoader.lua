-- Yzz1HubLoader.lua: Baixa todos os módulos do GitHub e executa o main.lua localmente
local files = {
    ["main.lua"] = "https://raw.githubusercontent.com/uYzz1/Yzz1Hub/main/main.lua",
    ["modules/logger.lua"] = "https://raw.githubusercontent.com/uYzz1/Yzz1Hub/main/modules/logger.lua",
    ["modules/settings.lua"] = "https://raw.githubusercontent.com/uYzz1/Yzz1Hub/main/modules/settings.lua",
    ["modules/utils.lua"] = "https://raw.githubusercontent.com/uYzz1/Yzz1Hub/main/modules/utils.lua",
    ["modules/macro.lua"] = "https://raw.githubusercontent.com/uYzz1/Yzz1Hub/main/modules/macro.lua",
    ["modules/sniffer.lua"] = "https://raw.githubusercontent.com/uYzz1/Yzz1Hub/main/modules/sniffer.lua",
    ["modules/gui.lua"] = "https://raw.githubusercontent.com/uYzz1/Yzz1Hub/main/modules/gui.lua",
}

for path, url in pairs(files) do
    local content = game:HttpGet(url)
    if path:find("/") then
        local folder = path:match("(.+)/")
        if not isfolder(folder) then makefolder(folder) end
    end
    writefile(path, content)
end

loadfile("main.lua")()
