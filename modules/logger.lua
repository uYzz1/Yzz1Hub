-- logger.lua - Funções de log para Yzz1Hub
local logger = {}

local logMessages = {}

function logger.addLogMessage(message)
    table.insert(logMessages, os.date("[%H:%M:%S] ") .. message)
    if #logMessages > 100 then
        table.remove(logMessages, 1)
    end
    print(message)
end

function logger.getLogMessages()
    return logMessages
end

return logger
