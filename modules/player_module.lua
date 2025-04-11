local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

local PlayerModule = {}

-- WalkSpeed adjustment
function PlayerModule.setWalkSpeed(speed)
    if player and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = speed
        print("WalkSpeed definida para: " .. speed)
    end
end

-- Infinite Jump
function PlayerModule.enableInfiniteJump()
    _G.infiniteJump = true
    _G.jumpConnection = UserInputService.JumpRequest:Connect(function()
        if _G.infiniteJump and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
            player.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
    print("🦘 Infinite Jump ativado")
end

function PlayerModule.disableInfiniteJump()
    _G.infiniteJump = false
    if _G.jumpConnection then
        _G.jumpConnection:Disconnect()
        _G.jumpConnection = nil
    end
    print("🦘 Infinite Jump desativado")
end

-- No Clip
function PlayerModule.enableNoClip()
    _G.noClip = true
    _G.noClipConnection = RunService.Stepped:Connect(function()
        if _G.noClip and player.Character then
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
    print("👻 No Clip ativado")
end

function PlayerModule.disableNoClip()
    _G.noClip = false
    if _G.noClipConnection then
        _G.noClipConnection:Disconnect()
        _G.noClipConnection = nil
    end
    print("👻 No Clip desativado")
end

-- ESP (exemplo simples, para jogadores adversários)
function PlayerModule.enableESP()
    _G.espEnabled = true
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local highlight = Instance.new("Highlight")
            highlight.Name = "ESPHighlight"
            highlight.FillColor = Color3.fromRGB(255, 0, 0)
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.FillTransparency = 0.5
            highlight.Parent = plr.Character
        end
    end
    print("👁️ ESP ativado")
end

function PlayerModule.disableESP()
    _G.espEnabled = false
    for _, plr in pairs(Players:GetPlayers()) do
        if plr.Character then
            local highlight = plr.Character:FindFirstChild("ESPHighlight")
            if highlight then
                highlight:Destroy()
            end
        end
    end
    print("👁️ ESP desativado")
end

return PlayerModule