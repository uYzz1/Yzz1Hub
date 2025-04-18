--[[===========================================
    Yzz1Hub Premium - Ultimate Script para Anime Last Stand
    Versão: 0.0.21 - Design Premium & Temas Personalizáveis
    Atualização: 15/04/2025
    Executor Suportado: Wave
================================================]]--

-- Verificar se os módulos foram carregados
local function waitForModules()
    local startTime = tick()
    local timeout = 10 -- 10 segundos de timeout
    
    while not (getgenv().Yzz1Hub_utils and 
               getgenv().Yzz1Hub_ui and 
               getgenv().Yzz1Hub_macros) do
        if tick() - startTime > timeout then
            warn("❌ Timeout ao esperar pelos módulos")
            return false
        end
        wait(0.1)
    end
    return true
end

-- Esperar pelos módulos
if not waitForModules() then
    warn("❌ Falha ao carregar os módulos necessários")
    return
end

-- Obter referências aos módulos
local utils = getgenv().Yzz1Hub_utils
local ui = getgenv().Yzz1Hub_ui
local macros = getgenv().Yzz1Hub_macros

-- Verificar se os módulos foram carregados corretamente
if not utils or not ui or not macros then
    warn("❌ Erro: Módulos não foram carregados corretamente")
    return
end

-- Verificar se SCRIPT_VERSION está disponível
if not utils.SCRIPT_VERSION then
    warn("❌ Erro: SCRIPT_VERSION não está definido no módulo utils")
    return
end

-- Verificar e criar pasta para macros
if not isfolder("MacroAnimeLastStand_Yzz1Hub") then
    makefolder("MacroAnimeLastStand_Yzz1Hub")
end

-- Serviços do Roblox
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local CoreGui = game:GetService("CoreGui")

-- Iniciar o script
ui.createMainUI()
macros.initialize()

-- Conectar eventos
utils.connectGameEvents()

-- Mensagem de início
utils.addLogMessage("✅ Yzz1Hub iniciado com sucesso!") 