-- sniffer.lua - Hook/sniffer para upgrades e placements
local sniffer = {}
local logger = require(script.Parent.modules.logger)
local settings = require(script.Parent.modules.settings)

function sniffer.init()
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        if checkcaller() then
            return oldNamecall(self, ...)
        end
        local method = getnamecallmethod and getnamecallmethod() or ""
        if method == "FireServer" or method == "InvokeServer" then
            local remoteName = tostring(self)
            if remoteName:lower():find("upgrade") then
                local args = {...}
                local argType = typeof(args[1])
                local function debugArgs(args)
                    local t = {}
                    for i, v in ipairs(args) do
                        t[#t+1] = tostring(v) .. " (" .. typeof(v) .. ")"
                    end
                    return table.concat(t, ", ")
                end
                logger.addLogMessage("[DEBUG] Args do upgrade: " .. debugArgs(args))
                if argType == "Instance" and args[1] and args[1].Parent == workspace.Towers then
                    local unitName = args[1].Name
                    logger.addLogMessage("⬆️ [SNIFFER] Upgrade enviado para: " .. unitName .. " (tipo: Instance)")
                    if settings.isRecording then
                        table.insert(_G.macroData, {
                            action = "upgrade",
                            unit = unitName,
                            timestamp = os.clock()
                        })
                    end
                else
                    logger.addLogMessage("[ERRO] Upgrade ignorado: argumento não é uma unidade válida (tipo: " .. tostring(argType) .. ")")
                end
            end
        end
        return oldNamecall(self, ...)
    end)
    logger.addLogMessage("[SNIFFER] Sniffer de upgrade ativado!")
end

return sniffer
