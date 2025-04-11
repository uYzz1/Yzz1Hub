local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local MiscModule = {}

-- Anti AFK
function MiscModule.enableAntiAFK()
    local antiAFK = Players.LocalPlayer.Idled:Connect(function()
        game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        wait(1)
        game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
    _G.antiAFKConnection = antiAFK
    print("🛡️ Anti-AFK ativado")
end

function MiscModule.disableAntiAFK()
    if _G.antiAFKConnection then
        _G.antiAFKConnection:Disconnect()
        _G.antiAFKConnection = nil
        print("🛡️ Anti-AFK desativado")
    end
end

-- Auto Server Hop (exemplo básico)
function MiscModule.serverHop()
    print("🔄 Server hopping...")
    local TeleportService = game:GetService("TeleportService")
    local HttpService = game:GetService("HttpService")
    local placeId = game.PlaceId
    local servers = {}
    local req = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..placeId.."/servers/Public?sortOrder=Asc&limit=100"))
    for _, server in pairs(req.data) do
        if server.playing < server.maxPlayers and server.id ~= game.JobId then
            table.insert(servers, server)
        end
    end
    if #servers > 0 then
        local selectedServer = servers[math.random(1, #servers)]
        TeleportService:TeleportToPlaceInstance(placeId, selectedServer.id, Players.LocalPlayer)
    else
        print("❌ Nenhum servidor disponível encontrado")
    end
end

-- Outras funcionalidades misc podem ser adicionadas aqui

return MiscModule