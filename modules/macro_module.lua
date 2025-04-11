local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local MacroModule = {}

MacroModule.macroData = {}
MacroModule.isRecording = false
MacroModule.unitQueue = {}

function MacroModule.startRecording()
    MacroModule.macroData = {}
    MacroModule.isRecording = true
    print("🎥 Gravação iniciada!")
end

function MacroModule.stopRecording()
    MacroModule.isRecording = false
    print("🛑 Gravação parada!")
end

function MacroModule.saveMacro(macroName)
    if macroName == "" then
        print("⚠️ Informe um nome para a macro!")
        return
    end
    local json = HttpService:JSONEncode(MacroModule.macroData)
    writefile("MacroAnimeLastStand_Yzz1Hub/" .. macroName .. ".json", json)
    print("💾 Macro salva como: " .. macroName)
end

function MacroModule.executeMacro(macroName)
    if macroName == "" then
        print("⚠️ Informe o nome da macro para executar!")
        return
    end
    local path = "MacroAnimeLastStand_Yzz1Hub/" .. macroName .. ".json"
    if not isfile(path) then
        print("❌ Macro não encontrada!")
        return
    end
    local data = HttpService:JSONDecode(readfile(path))
    print("▶️ Executando macro: " .. macroName)
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
    if not remotes then
        print("❌ Remotes não encontrados!")
        return
    end
    local placeRemote = nil
    for _, r in pairs(remotes:GetChildren()) do
        if r:IsA("RemoteEvent") and r.Name:lower():find("place") then
            placeRemote = r
            break
        end
    end
    if not placeRemote then
        print("❌ RemoteEvent para colocar unidades não encontrado!")
        return
    end
    for _, entry in ipairs(data) do
        local pos = Vector3.new(entry.pos.X, entry.pos.Y, entry.pos.Z)
        local args = {entry.unit, CFrame.new(pos), 1, {}}
        placeRemote:FireServer(unpack(args))
        wait(0.5)
    end
end

function MacroModule.updateMacroList(scrollFrame)
    for _, child in pairs(scrollFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    local macros = {}
    local files = listfiles("MacroAnimeLastStand_Yzz1Hub")
    for _, file in ipairs(files) do
        if file:sub(-5) == ".json" then
            table.insert(macros, file:match("([^/\\]+)%.json$"))
        end
    end
    for i, name in ipairs(macros) do
        local btn = Instance.new("TextButton", scrollFrame)
        btn.Size = UDim2.new(0, 190, 0, 30)
        btn.Position = UDim2.new(0, 5, 0, (i-1) * 35)
        btn.Text = name
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 14
        btn.TextColor3 = Color3.new(1,1,1)
        btn.BackgroundColor3 = Color3.fromRGB(50,0,0)
        btn.BorderSizePixel = 0
        btn.MouseButton1Click:Connect(function()
            -- Define o nome da macro para uso posterior (ex: preenchimento em um TextBox)
            print("Macro selecionada: " .. name)
        end)
        local delBtn = Instance.new("TextButton", scrollFrame)
        delBtn.Size = UDim2.new(0, 25, 0, 30)
        delBtn.Position = UDim2.new(0, 200, 0, (i-1) * 35)
        delBtn.Text = "🗑️"
        delBtn.Font = Enum.Font.Gotham
        delBtn.TextSize = 14
        delBtn.TextColor3 = Color3.new(1,1,1)
        delBtn.BackgroundColor3 = Color3.fromRGB(150,0,0)
        delBtn.BorderSizePixel = 0
        delBtn.MouseButton1Click:Connect(function()
            delfile("MacroAnimeLastStand_Yzz1Hub/" .. name .. ".json")
            MacroModule.updateMacroList(scrollFrame)
            print("🗑️ Macro deletada: " .. name)
        end)
    end
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, #macros * 35)
end

return MacroModule