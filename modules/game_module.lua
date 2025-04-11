local GameModule = {}

-- Variáveis de estado para auto recursos
GameModule.autoPlaceEnabled = false
GameModule.autoUpgradeEnabled = false
GameModule.autoSellEnabled = false

-- Funções para ativar/desativar cada funcionalidade
function GameModule.setAutoPlace(state)
    GameModule.autoPlaceEnabled = state
    print("Auto Place " .. (state and "habilitado" or "desabilitado"))
end

function GameModule.setAutoUpgrade(state)
    GameModule.autoUpgradeEnabled = state
    print("Auto Upgrade " .. (state and "habilitado" or "desabilitado"))
end

function GameModule.setAutoSell(state)
    GameModule.autoSellEnabled = state
    print("Auto Sell " .. (state and "habilitado" or "desabilitado"))
end

-- Loop de atualização das informações do jogo (ex: wave, cash, timer)
function GameModule.startInfoLoop(gameInfoDisplay)
    spawn(function()
        while wait(1) do
            local wave = workspace:FindFirstChild("Wave") and workspace.Wave.Value or "?"
            local cash = "$0"
            if LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") and LocalPlayer.PlayerGui:FindFirstChild("MainUI") then
                local hud = LocalPlayer.PlayerGui.MainUI:FindFirstChild("HUD")
                if hud and hud:FindFirstChild("Cash") then
                    cash = hud.Cash.Text
                end
            end
            local minutes = math.floor(workspace.DistributedGameTime / 60)
            local seconds = math.floor(workspace.DistributedGameTime % 60)
            local timeStr = string.format("%02d:%02d", minutes, seconds)
            gameInfoDisplay.Text = "Wave: " .. wave .. " | Cash: " .. cash .. " | Timer: " .. timeStr
        end
    end)
end

return GameModule