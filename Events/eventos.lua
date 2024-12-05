local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local eventos = {
    {
        DataInicio = "12-25",
        DataFim = "12-25",
        Titulo = "🎄 FELIZ NATAL! 🎄",
        Descricao = "Que seu Natal seja cheio de magia!",
        Som = "rbxassetid://12345678",
        Emoji = "🎄",
        Cor = Color3.new(1, 0, 0) -- Vermelho
    },
    {
        DataInicio = "10-31",
        DataFim = "10-31",
        Titulo = "🎃 FELIZ HALLOWEEN 🎃",
        Descricao = "Prepare-se para os sustos!",
        Som = "rbxassetid://87654321",
        Emoji = "🎃",
        Cor = Color3.new(1, 0.5, 0) -- Laranja
    },
    {
        DataInicio = "01-01",
        DataFim = "01-01",
        Titulo = "🎆 FELIZ ANO NOVO! 🎆",
        Descricao = "Um ano incrível te espera!",
        Som = "rbxassetid://11223344",
        Emoji = "🎆",
        Cor = Color3.new(0, 1, 1) -- Azul Claro
    },
    {
        DataInicio = "02-14",
        DataFim = "02-14",
        Titulo = "💖 FELIZ DIA DOS NAMORADOS! 💖",
        Descricao = "Espalhe amor hoje e sempre!",
        Som = "rbxassetid://33445566",
        Emoji = "💖",
        Cor = Color3.new(1, 0, 1) -- Rosa
    }
}

local function createUI(evento)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local blur = Instance.new("BlurEffect")
    blur.Size = 24
    blur.Parent = game.Lighting

    local background = Instance.new("Frame")
    background.Size = UDim2.new(1, 0, 1, 0)
    background.BackgroundColor3 = evento.Cor
    background.BackgroundTransparency = 0.8
    background.Parent = ScreenGui

    local tweenBackground = TweenService:Create(background, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        BackgroundTransparency = 0.5
    })
    tweenBackground:Play()

    local textLabel = Instance.new("TextLabel")
    textLabel.Text = evento.Titulo
    textLabel.Size = UDim2.new(0.8, 0, 0.2, 0)
    textLabel.Position = UDim2.new(0.1, 0, 0.4, 0)
    textLabel.Font = Enum.Font.GothamBlack
    textLabel.TextScaled = true
    textLabel.BackgroundTransparency = 1
    textLabel.Parent = background

    local uiGradient = Instance.new("UIGradient")
    uiGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.new(1, 0, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.new(0, 1, 0)),
        ColorSequenceKeypoint.new(1, Color3.new(0, 0, 1))
    }
    uiGradient.Parent = textLabel

    coroutine.wrap(function()
        while true do
            for i = 0, 1, 0.01 do
                uiGradient.Rotation = uiGradient.Rotation + 1
                wait(0.05)
            end
        end
    end)()

    local notification = Instance.new("TextButton")
    notification.Text = evento.Descricao .. " " .. evento.Emoji
    notification.Size = UDim2.new(0.3, 0, 0.1, 0)
    notification.Position = UDim2.new(0.35, 0, 0.7, 0)
    notification.Font = Enum.Font.GothamBold
    notification.TextSize = 18
    notification.BackgroundColor3 = Color3.new(0, 0, 0)
    notification.BackgroundTransparency = 0.3
    notification.TextColor3 = Color3.new(1, 1, 1)
    notification.Parent = background

    notification.MouseButton1Click:Connect(function()

        local sound = Instance.new("Sound", workspace)
        sound.SoundId = evento.Som
        sound:Play()

        local teleportService = game:GetService("TeleportService")
        teleportService:Teleport(123456789, LocalPlayer) -- Substitua pelo ID do mapa de evento
    end)

    local sound = Instance.new("Sound", workspace)
    sound.SoundId = evento.Som
    sound:Play()

    wait(10)
    local fadeTween = TweenService:Create(background, TweenInfo.new(1), { BackgroundTransparency = 1 })
    fadeTween:Play()
    fadeTween.Completed:Wait()
    ScreenGui:Destroy()
    blur:Destroy()
end

local function checkEvent()
    local dataAtual = os.date("%m-%d") -- Formato MM-DD
    for _, evento in ipairs(eventos) do
        if dataAtual >= evento.DataInicio and dataAtual <= evento.DataFim then
            createUI(evento)
            break
        end
    end
end

checkEvent()
