-- Módulo de Auto Farm para Yzz1Hub
local autofarm = {}

-- Serviços do Roblox
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Dependências
local utils -- Será definido na inicialização

-- Estados
autofarm.autoPlaceEnabled = false
autofarm.autoUpgradeEnabled = false
autofarm.autoSellEnabled = false
autofarm.selectedUnit = nil
autofarm.lastDetectedUnit = nil
autofarm.unitQueue = {}

-- Inicializa o módulo
function autofarm.initialize(utilsModule)
    utils = utilsModule
    
    -- Conectar eventos
    autofarm.connectEvents()
end

-- Conectar eventos do jogo
function autofarm.connectEvents()
    -- Monitorar mudanças de estado
    RunService.Heartbeat:Connect(function()
        autofarm.updateFarm()
    end)
end

-- Atualização do farm
function autofarm.updateFarm()
    if not autofarm.autoPlaceEnabled and not autofarm.autoUpgradeEnabled and not autofarm.autoSellEnabled then
        return
    end
    
    -- Implementar lógica específica aqui
    if autofarm.autoPlaceEnabled and autofarm.selectedUnit then
        autofarm.tryPlaceUnit()
    end
    
    if autofarm.autoUpgradeEnabled then
        autofarm.tryUpgradeUnits()
    end
    
    if autofarm.autoSellEnabled then
        autofarm.trySellUnits()
    end
end

-- Tenta colocar uma unidade
function autofarm.tryPlaceUnit()
    -- Verificar se estamos em jogo
    if not game:GetService("Workspace"):FindFirstChild("_map") then
        return
    end
    
    -- Verificar cooldown
    if autofarm.placeCooldown and tick() - autofarm.placeCooldown < 2 then
        return
    end
    
    -- Encontrar posição para colocar
    local position = autofarm.findPlacementPosition()
    if not position then
        return
    end
    
    -- Tentar colocar a unidade
    local args = {
        autofarm.selectedUnit, -- unitName
        position -- position CFrame
    }
    
    -- Chamada de remoto
    local remoteFunction = ReplicatedStorage:FindFirstChild("endpoints")
    if remoteFunction and remoteFunction:FindFirstChild("place_unit") then
        local success, result = pcall(function()
            return remoteFunction.place_unit:InvokeServer(unpack(args))
        end)
        
        if success then
            autofarm.placeCooldown = tick()
            utils.addLogMessage("✓ Auto-colocando unidade: " .. autofarm.selectedUnit)
        end
    end
end

-- Encontra posição para colocar unidade
function autofarm.findPlacementPosition()
    -- Implementar lógica para encontrar uma posição válida
    local map = game:GetService("Workspace"):FindFirstChild("_map")
    if not map then return nil end
    
    local mapCFrame = map:GetPivot()
    local unitsCFrame = {}
    
    -- Obter CFrame de unidades já colocadas
    local units = game:GetService("Workspace"):FindFirstChild("_units")
    if units then
        for _, unit in ipairs(units:GetChildren()) do
            if unit:IsA("Model") and unit:FindFirstChild("_stats") and unit._stats:FindFirstChild("player") and unit._stats.player.Value == LocalPlayer then
                table.insert(unitsCFrame, unit:GetPivot())
            end
        end
    end
    
    -- Procurar uma posição livre
    for x = -20, 20, 4 do
        for z = -20, 20, 4 do
            local tryPosition = mapCFrame * CFrame.new(x, 0, z)
            local isTooClose = false
            
            -- Verificar se está muito próximo de outra unidade
            for _, unitCFrame in ipairs(unitsCFrame) do
                local distance = (tryPosition.Position - unitCFrame.Position).Magnitude
                if distance < 3 then
                    isTooClose = true
                    break
                end
            end
            
            if not isTooClose then
                return tryPosition
            end
        end
    end
    
    return nil
end

-- Tenta fazer upgrade em unidades
function autofarm.tryUpgradeUnits()
    -- Verificar se estamos em jogo
    if not game:GetService("Workspace"):FindFirstChild("_map") then
        return
    end
    
    -- Verificar cooldown
    if autofarm.upgradeCooldown and tick() - autofarm.upgradeCooldown < 3 then
        return
    end
    
    -- Obter unidades do jogador
    local units = game:GetService("Workspace"):FindFirstChild("_units")
    if not units then return end
    
    for _, unit in ipairs(units:GetChildren()) do
        if unit:IsA("Model") and 
           unit:FindFirstChild("_stats") and 
           unit._stats:FindFirstChild("player") and 
           unit._stats.player.Value == LocalPlayer and
           unit._stats:FindFirstChild("upgrade") and
           unit._stats:FindFirstChild("upgrade_cost") then
            
            -- Verificar se tem dinheiro suficiente
            local upgradeCost = unit._stats.upgrade_cost.Value
            local money = LocalPlayer.PlayerGui:FindFirstChild("spawn_units") and 
                         LocalPlayer.PlayerGui.spawn_units:FindFirstChild("Frame") and
                         LocalPlayer.PlayerGui.spawn_units.Frame:FindFirstChild("Money") and
                         tonumber(LocalPlayer.PlayerGui.spawn_units.Frame.Money.Text:gsub("[%$,]", ""))
            
            if money and money >= upgradeCost then
                -- Tentar fazer upgrade da unidade
                local args = {
                    unit
                }
                
                -- Chamada remota
                local remoteFunction = ReplicatedStorage:FindFirstChild("endpoints")
                if remoteFunction and remoteFunction:FindFirstChild("upgrade_unit_ingame") then
                    local success, result = pcall(function()
                        return remoteFunction.upgrade_unit_ingame:InvokeServer(unpack(args))
                    end)
                    
                    if success then
                        autofarm.upgradeCooldown = tick()
                        utils.addLogMessage("↑ Auto-upgrade de unidade: " .. (unit.Name or "Unidade"))
                        break -- Upgrade apenas uma unidade por vez
                    end
                end
            end
        end
    end
end

-- Tenta vender unidades
function autofarm.trySellUnits()
    -- Implementar lógica para venda automática
    -- Exemplo: Vender quando chegar em determinada onda ou quando tiver money suficiente
end

-- Define a unidade selecionada
function autofarm.setSelectedUnit(unitName)
    autofarm.selectedUnit = unitName
    utils.addLogMessage("🎯 Unidade selecionada: " .. unitName)
end

-- Define estado de auto place
function autofarm.setAutoPlace(enabled)
    autofarm.autoPlaceEnabled = enabled
    utils.addLogMessage(enabled and "✅ Auto-colocar ativado" or "❌ Auto-colocar desativado")
end

-- Define estado de auto upgrade
function autofarm.setAutoUpgrade(enabled)
    autofarm.autoUpgradeEnabled = enabled
    utils.addLogMessage(enabled and "✅ Auto-upgrade ativado" or "❌ Auto-upgrade desativado")
end

-- Define estado de auto sell
function autofarm.setAutoSell(enabled)
    autofarm.autoSellEnabled = enabled
    utils.addLogMessage(enabled and "✅ Auto-vender ativado" or "❌ Auto-vender desativado")
end

return autofarm 