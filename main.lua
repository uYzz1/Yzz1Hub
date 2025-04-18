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

-- Os módulos já foram carregados pelo loader.lua
-- Vamos usar as variáveis globais que foram definidas
local utils = getgenv().Yzz1Hub_utils
local ui = getgenv().Yzz1Hub_ui
local macros = getgenv().Yzz1Hub_macros

if not utils or not ui or not macros then
    warn("❌ Erro: Módulos não foram carregados corretamente pelo loader")
    return
end

-- Iniciar o script
ui.createMainUI()
macros.initialize()

-- Conectar eventos
utils.connectGameEvents()

-- Mensagem de início
utils.addLogMessage("✅ Yzz1Hub iniciado com sucesso!") 