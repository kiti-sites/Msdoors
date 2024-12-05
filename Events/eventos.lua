local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Eventos = {
    {
        DataInicio = "12-25",
        DataFim = "12-25",
        Titulo = "🎄 FELIZ NATAL! 🎄",
        Descricao = "Que seu Natal seja incrível!",
        Som = "rbxassetid://12345678",
        Emoji = "🎄",
        Cor = Color3.fromRGB(255, 0, 0),
        Particulas = "rbxassetid://98765432"
    },
    {
        DataInicio = "12-05",
        DataFim = "12-05",
        Titulo = "😱 MENSAGEM SECRETA! 😱",
        Descricao = "SECRET! ",
        Som = "rbxassetid://138654538550134",
        Emoji = "🤨",
        Cor = Color3.new(1, 0.5, 0)
    },
    {
        DataInicio = "10-31",
        DataFim = "10-31",
        Titulo = "🎃 FELIZ HALLOWEEN 🎃",
        Descricao = "Prepare-se para os sustos!",
        Som = "rbxassetid://87654321",
        Emoji = "🎃",
        Cor = Color3.fromRGB(255, 128, 0),
        Particulas = "rbxassetid://12398745"
    },
    {
        DataInicio = "01-01",
        DataFim = "01-01",
        Titulo = "🎆 FELIZ ANO NOVO! 🎆",
        Descricao = "Um ano incrível te espera!",
        Som = "rbxassetid://11223344",
        Emoji = "🎆",
        Cor = Color3.fromRGB(0, 255, 255),
        Particulas = "rbxassetid://67890123"
    }
}

local function createUI(evento)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local blur = Instance.new("BlurEffect")
    blur.Size = 24
    blur.Parent = game.Lighting

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    frame.Parent = ScreenGui

    local textLabel = Instance.new("TextLabel")
    textLabel.Text = evento.Titulo
    textLabel.Size = UDim2.new(0.8, 0, 0.2, 0)
    textLabel.Position = UDim2.new(0.1, 0, 1.2, 0) 
    textLabel.Font = Enum.Font.GothamBlack
    textLabel.TextScaled = true
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = evento.Cor
    textLabel.Parent = frame

    local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out)
    local finalPosition = UDim2.new(0.1, 0, 0.4, 0) -- Posição final do texto
    local jumpPosition = UDim2.new(0.1, 0, 0.2, 0) -- Posição do "pulo"

    local jumpTween = TweenService:Create(textLabel, tweenInfo, {Position = jumpPosition})
    jumpTween:Play()

    jumpTween.Completed:Connect(function()
        local settleTween = TweenService:Create(textLabel, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = finalPosition})
        settleTween:Play()
    end)

    local descricaoLabel = Instance.new("TextLabel")
    descricaoLabel.Text = evento.Descricao .. " " .. evento.Emoji
    descricaoLabel.Size = UDim2.new(0.6, 0, 0.1, 0)
    descricaoLabel.Position = UDim2.new(0.2, 0, 0.6, 0)
    descricaoLabel.Font = Enum.Font.Gotham
    descricaoLabel.TextScaled = true
    descricaoLabel.BackgroundTransparency = 1
    descricaoLabel.TextColor3 = Color3.new(1, 1, 1)
    descricaoLabel.Parent = frame

    if evento.Particulas then
        local particles = Instance.new("ParticleEmitter")
        particles.Texture = evento.Particulas
        particles.Parent = workspace
        particles.Rate = 50
        particles.Lifetime = NumberRange.new(2)
        particles.Speed = NumberRange.new(5, 10)
        particles.Size = NumberSequence.new(1, 2)
        game:GetService("Debris"):AddItem(particles, 10)
    end

    local button = Instance.new("TextButton")
    button.Text = "By: Msdoors Team."
    button.Size = UDim2.new(0.3, 0, 0.1, 0)
    button.Position = UDim2.new(0.35, 0, 0.8, 0)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 18
    button.BackgroundColor3 = evento.Cor
    button.BackgroundTransparency = 0.3
    button.Parent = frame

    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundTransparency = 0.3}):Play()
    end)

    local sound = Instance.new("Sound", workspace)
    sound.SoundId = evento.Som
    sound:Play()

    wait(10)
    ScreenGui:Destroy()
    blur:Destroy()
end

local function checkEvent()
    local dataAtual = os.date("%m-%d")
    for _, evento in ipairs(Eventos) do
        if dataAtual >= evento.DataInicio and dataAtual <= evento.DataFim then
            createUI(evento)
            break
        end
    end
end

checkEvent()

