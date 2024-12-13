-- Boas-vindas ao Lobby de Doors
print("Bem-vindo ao Lobby de Doors!")

--// Serviços \\--
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local Lighting = game:GetService("Lighting")

-- Configurações de luz para o lobby
Lighting.Ambient = Color3.fromRGB(85, 85, 255)
Lighting.Brightness = 2
Lighting.OutdoorAmbient = Color3.fromRGB(60, 60, 220)

-- Notificação simples
local function enviarNotificacao(titulo, mensagem, duracao)
    StarterGui:SetCore("SendNotification", {
        Title = titulo,
        Text = mensagem,
        Duration = duracao
    })
end

-- Exibe uma mensagem para o jogador
local player = Players.LocalPlayer
enviarNotificacao("Lobby de Doors", "Bem-vindo, " .. player.Name .. "!", 5)

-- Funcionalidade adicional: Adiciona um botão para teleportar o jogador
local function criarBotaoTeleport()
    local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    screenGui.Name = "TeleportGui"

    local teleportButton = Instance.new("TextButton", screenGui)
    teleportButton.Size = UDim2.new(0, 200, 0, 50)
    teleportButton.Position = UDim2.new(0.5, -100, 0.8, 0)
    teleportButton.BackgroundColor3 = Color3.fromRGB(85, 85, 255)
    teleportButton.Text = "Ir para o Jogo"
    teleportButton.Font = Enum.Font.GothamBold
    teleportButton.TextSize = 20
    teleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)

    teleportButton.MouseButton1Click:Connect(function()
        -- Altere o localId para o ID do lugar onde o jogador será teleportado
        local lugarId = 123456789 -- Substitua pelo PlaceId do próximo local
        game:GetService("TeleportService"):Teleport(lugarId, player)
    end)
end

criarBotaoTeleport()
