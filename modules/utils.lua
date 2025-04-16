-- utils.lua - Funções utilitárias para Yzz1Hub
local utils = {}

function utils.isfile(path)
    local suc = pcall(function() return readfile(path) end)
    return suc
end

return utils
