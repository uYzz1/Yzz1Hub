--[[===========================================
    Yzz1Hub Premium - Ultimate Script para Anime Last Stand
    Versão: 0.0.21 - Design Premium & Temas Personalizáveis
    Atualização: 15/04/2025
    Executor Suportado: Wave
================================================]]--

-- Verificar e criar pasta para macros
if not isfolder("MacroAnimeLastStand_Yzz1Hub") then
    makefolder("MacroAnimeLastStand_Yzz1Hub")
end

-- Carregar módulos
local function loadModule(name)
    local success, module = pcall(function()
        return loadstring(readfile(name .. ".lua"))()
    end)
    
    if not success then
        warn("Erro ao carregar módulo: " .. name)
        return {}
    end
    
    return module
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

-- Carregar módulos
local utils = loadModule("utils")
local ui = loadModule("ui")
local macros = loadModule("macros")

-- Iniciar o script
ui.createMainUI()
macros.initialize()

-- Conectar eventos
utils.connectGameEvents()

-- Mensagem de início
utils.addLogMessage("✅ Yzz1Hub iniciado com sucesso!") 