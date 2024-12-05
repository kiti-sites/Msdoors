local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local url = "https://raw.githubusercontent.com/Sc-Rhyan57/Msdoors/refs/heads/main/Events/eventos.json"

local function getEventData()
    local success, result = pcall(function()
        return HttpService:JSONDecode(HttpService:GetAsync(url))
    end)
    if success then
        return result
    else
        warn("[Msdoors] Não Foi possível extrair os dados dos eventos! ", result)
        return nil
    end
end

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
    textLabel.Position = UDim2.new(0.1, 0, 0.4, 0)
    textLabel.Font = Enum.Font.GothamBlack
    textLabel.TextScaled = true
    textLabel.BackgroundTransparency = 1
    textLabel.Parent = frame

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
    notification.Parent = frame

    notification.MouseButton1Click:Connect(function()
        local sound = Instance.new("Sound", workspace)
        sound.SoundId = evento.Som
        sound:Play()

        local teleportService = game:GetService("TeleportService")
        teleportService:Teleport(123456789, LocalPlayer) 
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
    local eventos = getEventData()

    if eventos and eventos.Eventos then
        for _, evento in ipairs(eventos.Eventos) do
            if dataAtual >= evento.DataInicio and dataAtual <= evento.DataFim then
                createUI(evento)
                break
            end
        end
    end
end

checkEvent()
