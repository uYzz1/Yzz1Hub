-- main.lua - Loader principal do Yzz1Hub modularizado
local modulesPath = "modules/"

local logger = loadfile(modulesPath.."logger.lua")()
local settings = loadfile(modulesPath.."settings.lua")()
local utils = loadfile(modulesPath.."utils.lua")()
local macro = loadfile(modulesPath.."macro.lua")()
local sniffer = loadfile(modulesPath.."sniffer.lua")()
local gui = loadfile(modulesPath.."gui.lua")()

-- Inicialização dos módulos principais
sniffer.init()
logger.addLogMessage("[MAIN] Yzz1Hub modularizado carregado! Versão: " .. settings.VERSION)

-- Inicialização da interface gráfica
if gui and gui.init then gui.init() end

-- Inicialização de outros módulos (macro, etc) pode ser feita aqui

return true
