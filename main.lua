-- Script Principal: main.lua

-- Requer os módulos necessários
local UIHelper = require(script.Parent.modules.ui_helper)
local HUDSetup = require(script.Parent.modules.hud_setup)
local MacroModule = require(script.Parent.modules.macro_module)
local WebhookModule = require(script.Parent.modules.webhook_module)
local GameModule = require(script.Parent.modules.game_module)
local SummonModule = require(script.Parent.modules.summon_module)
local MiscModule = require(script.Parent.modules.misc_module)
local PlayerModule = require(script.Parent.modules.player_module)

-- Cria o HUD principal
local uiElements = HUDSetup.createMainHUD()

-- Exemplo: Criar botões laterais para troca de seções
local sideMenu = uiElements.SideMenu
local sections = uiElements.Sections

local sideButtons = {}
local function createSideButton(text, sectionName)
    local btn = UIHelper.createButton(sideMenu, text, nil, UDim2.new(1, 0, 0, 40), function()
        for name, sect in pairs(sections) do
            sect.Visible = (name == sectionName)
        end
        print("Seção selecionada: " .. sectionName)
    end)
    btn.Parent = sideMenu
    table.insert(sideButtons, btn)
end

createSideButton("Log", "Log")
createSideButton("Game", "Game")
createSideButton("Macro", "Macro")
createSideButton("Webhook", "Webhook")
createSideButton("Summon", "Summon")
createSideButton("Misc", "Misc")
createSideButton("Player", "Player")
createSideButton("About", "About")

-- Inicializa o módulo de webhook (carrega webhook se existir)
WebhookModule.loadWebhook()

-- Aqui você pode registrar eventos, por exemplo:
-- Hook para gravação de macro via clique do mouse
local Players = game:GetService("Players")
local Mouse = Players.LocalPlayer:GetMouse()
Mouse.Button1Down:Connect(function()
    if MacroModule.isRecording then
        local pos = Mouse.Hit.Position
        local unitName = "Unknown"
        if #MacroModule.unitQueue > 0 then
            unitName = table.remove(MacroModule.unitQueue, 1)
        end
        table.insert(MacroModule.macroData, {
            unit = unitName,
            pos = {X = pos.X, Y = pos.Y, Z = pos.Z},
            wave = workspace:FindFirstChild("Wave") and workspace.Wave.Value or "?",
            cash = "?"  -- Você pode complementar com lógica para capturar cash
        })
        print("✅ Posição registrada: " .. string.format("%.2f, %.2f, %.2f", pos.X, pos.Y, pos.Z) .. " | Unit: " .. unitName)
    end
end)

-- Inicia loops e demais lógicas, por exemplo, update do gameInfoDisplay no módulo GameModule:
if sections["Game"] then
    local gameSection = sections["Game"]
    local gameInfoDisplay = UIHelper.createLabel(gameSection, "Wave: ? | Cash: $0 | Timer: 00:00", UDim2.new(0,10,0,250), UDim2.new(0,450,0,60))
    GameModule.startInfoLoop(gameInfoDisplay)
end

print("✅ Yzz1Hub carregado com sucesso!")