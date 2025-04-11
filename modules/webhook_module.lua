local HttpService = game:GetService("HttpService")

local WebhookModule = {}
WebhookModule.webhookUrl = ""

function WebhookModule.loadWebhook()
    if isfile("MacroAnimeLastStand_Yzz1Hub/webhook.txt") then
        WebhookModule.webhookUrl = readfile("MacroAnimeLastStand_Yzz1Hub/webhook.txt")
    end
end

function WebhookModule.saveWebhook(url)
    WebhookModule.webhookUrl = url
    writefile("MacroAnimeLastStand_Yzz1Hub/webhook.txt", url)
    print("💾 Webhook salvo!")
end

function WebhookModule.testWebhook()
    if WebhookModule.webhookUrl == "" then
        print("⚠️ Nenhum webhook configurado!")
        return
    end
    local data = {
        content = nil,
        embeds = {{
            title = "Yzz1Hub Teste",
            description = "Seu webhook está funcionando corretamente!",
            color = 7419530,
            footer = { text = "Yzz1Hub - Anime Last Stand | " .. os.date("%Y-%m-%d %H:%M:%S") }
        }}
    }
    local success, response = pcall(function()
        return HttpService:RequestAsync({
            Url = WebhookModule.webhookUrl,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = HttpService:JSONEncode(data)
        })
    end)
    if success and response.Success then
        print("✅ Webhook testado com sucesso!")
    else
        print("❌ Falha ao testar webhook: " .. tostring(response))
    end
end

return WebhookModule