--// EXECUTANDO ARQUIVO DE EXECUÇÃO PRINCIPAL ".Exe.lua" \\--
--[[
                                                                                                                     
     ______  _______            ______       _____           _____            _____         _____            ______  
    |      \/       \       ___|\     \  ___|\    \     ____|\    \      ____|\    \    ___|\    \       ___|\     \ 
   /          /\     \     |    |\     \|    |\    \   /     /\    \    /     /\    \  |    |\    \     |    |\     \
  /     /\   / /\     |    |    |/____/||    | |    | /     /  \    \  /     /  \    \ |    | |    |    |    |/____/|
 /     /\ \_/ / /    /| ___|    \|   | ||    | |    ||     |    |    ||     |    |    ||    |/____/  ___|    \|   | |
|     |  \|_|/ /    / ||    \    \___|/ |    | |    ||     |    |    ||     |    |    ||    |\    \ |    \    \___|/ 
|     |       |    |  ||    |\     \    |    | |    ||\     \  /    /||\     \  /    /||    | |    ||    |\     \    
|\____\       |____|  /|\ ___\|_____|   |____|/____/|| \_____\/____/ || \_____\/____/ ||____| |____||\ ___\|_____|   
| |    |      |    | / | |    |     |   |    /    | | \ |    ||    | / \ |    ||    | /|    | |    || |    |     |   
 \|____|      |____|/   \|____|_____|   |____|____|/   \|____||____|/   \|____||____|/ |____| |____| \|____|_____|   
    \(          )/         \(    )/       \(    )/        \(    )/         \(    )/      \(     )/      \(    )/     
     '          '           '    '         '    '          '    '           '    '        '     '        '    '      
                                                                                                                     
                                        Por Rhyan57 💜
  ]]--

--// Serviços \\--
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

--// Configurações \\--
local scriptUrl = "https://raw.githubusercontent.com/Sc-Rhyan57/Msdoors/main/Src/Loaders/"
local vipScriptUrl = "https://raw.githubusercontent.com/Sc-Rhyan57/Msdoors/main/Src/Loaders/VipDoors/"
local supportedPlaceIds = {
    [6516141723] = "Doors/lobby.lua", -- Lobby
    [6839171747] = "Doors/hotel.lua", -- Doors
    [10549820578] = "Doors/Fools23.lua", -- Fools2023
    [110258689672367] = "Doors/OldLobby.lua", -- Pre Hotel+
    [189707] = "NaturalDisaster/places/game.lua" -- Natural Disaster
}

local blacklist = { 
    [""] = true, 
    [""] = true 
}

local vipList = {
    [""] = true,
    [""] = true
}

local function criarPainelDeCarregamento()
    local blurEffect = Instance.new("BlurEffect", Lighting)
    blurEffect.Size = 15

    local screenGui = Instance.new("ScreenGui", Players.LocalPlayer:WaitForChild("PlayerGui"))
    screenGui.Name = "LoadingScreen"
    screenGui.ResetOnSpawn = false

    local mainFrame = Instance.new("Frame", screenGui)
    mainFrame.Size = UDim2.new(0, 350, 0, 300)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true

    local gradient = Instance.new("UIGradient", mainFrame)
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 43, 226)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 191, 255))
    }
    gradient.Rotation = 45
    RunService.RenderStepped:Connect(function(deltaTime)
        gradient.Rotation = gradient.Rotation + deltaTime * 15
    end)

    local borderGlow = Instance.new("UIStroke", mainFrame)
    borderGlow.Thickness = 3
    borderGlow.Color = Color3.fromRGB(255, 255, 255)
    borderGlow.Transparency = 0.3

    local corner = Instance.new("UICorner", mainFrame)
    corner.CornerRadius = UDim.new(0, 20)

    local titleLabel = Instance.new("TextLabel", mainFrame)
    titleLabel.Text = "[ MsDoors ]"
    titleLabel.Size = UDim2.new(1, 0, 0.3, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 24
    titleLabel.TextStrokeTransparency = 0.8

    local pulseTweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true)
    local titlePulseTween = TweenService:Create(titleLabel, pulseTweenInfo, {TextTransparency = 0.2})
    titlePulseTween:Play()
  
    local rotatingImage = Instance.new("ImageLabel", screenGui)
    rotatingImage.Size = UDim2.new(0, 120, 0, 120)
    rotatingImage.Position = UDim2.new(0.5, 0, 0.6, -40)
    rotatingImage.AnchorPoint = Vector2.new(0.5, 0.5)
    rotatingImage.BackgroundTransparency = 1
    rotatingImage.Image = "rbxassetid://7733992358"

    local rotationTweenInfo = TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1)
    local rotationTween = TweenService:Create(rotatingImage, rotationTweenInfo, {Rotation = 360})
    rotationTween:Play()

    local statusLabel = Instance.new("TextLabel", mainFrame)
    statusLabel.Text = "Status: Verificando..."
    statusLabel.Size = UDim2.new(1, 0, 0.2, 0)
    statusLabel.Position = UDim2.new(0, 0, 0.6, 0)
    statusLabel.BackgroundTransparency = 1
    statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextSize = 18
    statusLabel.TextStrokeTransparency = 0.8

    local particles = Instance.new("ParticleEmitter", mainFrame)
    particles.Texture = "rbxassetid://7733992358"
    particles.LightEmission = 1
    particles.Size = NumberSequence.new(0.2, 0.5)
    particles.Lifetime = NumberRange.new(1, 2)
    particles.Rate = 10
    particles.Speed = NumberRange.new(0, 1)
    particles.Rotation = NumberRange.new(0, 360)
    particles.RotSpeed = NumberRange.new(50, 100)
    particles.Enabled = true

    return screenGui, mainFrame, statusLabel, blurEffect
end

local function atualizarStatus(statusLabel, texto, cor)
    statusLabel.Text = "Status: " .. texto
    statusLabel.TextColor3 = cor
end

local function ocultarPainel(screenGui, mainFrame, blurEffect)
    wait(2)
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(mainFrame, tweenInfo, {Size = UDim2.new(0, 0, 0, 0), Transparency = 1})
    tween:Play()
    tween.Completed:Connect(function()
        screenGui:Destroy()
        blurEffect:Destroy()
    end)
end

local function enviarNotificacao(titulo, texto, duracao)
    StarterGui:SetCore("SendNotification", {
        Title = titulo,
        Text = texto,
        Duration = duracao
    })
end

local function verificarBlacklistEVip(statusLabel)
    local player = Players.LocalPlayer
    local playerId = tostring(player.UserId)
    local playerName = player.Name

    enviarNotificacao("MsDoors", "⏳ Verificando Blacklist e vip...", 5)
    atualizarStatus(statusLabel, "Verificando...", Color3.fromRGB(255, 255, 0))
    wait(4)

    if blacklist[playerId] or blacklist[playerName] then
        enviarNotificacao("🚫 MsDoors - Acesso Negado", "Você está na blacklist e não pode usar este script.", 8)
        atualizarStatus(statusLabel, "Acesso Negado", Color3.fromRGB(255, 0, 0))
        return false, false
    end
  
    if vipList[playerId] or vipList[playerName] then
        enviarNotificacao("⭐ MsDoors - Painel VIP Ativo", "Bem-vindo ao painel VIP!", 5)
        atualizarStatus(statusLabel, "Usuário VIP Acessado", Color3.fromRGB(0, 255, 215))
        return true, true
    end

    enviarNotificacao("✅ MsDoors", "Usuário verificado com sucesso!", 5)
    atualizarStatus(statusLabel, "Acesso Garantido", Color3.fromRGB(0, 255, 0))
    return true, false
end

local function verificarSuporteAoJogo(placeId, statusLabel)
    local scriptName = supportedPlaceIds[placeId]
    local gameName = game:GetService("MarketplaceService"):GetProductInfo(placeId).Name

    if not scriptName then
        enviarNotificacao("MsDoors", "❌ Msdoors não oferce suporte para " .. gameName .. ".", 8)
        atualizarStatus(statusLabel, "Sem suporte!", Color3.fromRGB(0, 140, 0))
        return nil, false
    end
    return scriptName
end

local function carregarScript(url)
    local sucesso, resposta = pcall(function()
        return game:HttpGet(url)
    end)
    
    if sucesso then
        local carregarSucesso, erro = pcall(function()
            loadstring(resposta)()
        end)
        
        if not carregarSucesso then
            warn("Erro ao carregar o script: " .. erro)
            enviarNotificacao("Erro", "Falha ao executar o script.", 5)
        end
    else
        warn("Erro ao obter o script da URL: " .. url)
        enviarNotificacao("Erro", "Falha ao baixar o script.", 5)
    end
end

local function iniciarCarregamento()
    local screenGui, mainFrame, statusLabel, blurEffect = criarPainelDeCarregamento()
    
    local acessoLiberado, isVip = verificarBlacklistEVip(statusLabel)
    
    if not acessoLiberado then
        ocultarPainel(screenGui, mainFrame, blurEffect)
        return
    end

    local placeId = game.PlaceId
    local scriptName = verificarSuporteAoJogo(placeId, statusLabel)
    
    if not scriptName then
        ocultarPainel(screenGui, mainFrame, blurEffect)
        return
    end

    local url = isVip and (vipScriptUrl .. scriptName) or (scriptUrl .. scriptName)
    atualizarStatus(statusLabel, "Carregando Script...", Color3.fromRGB(0, 191, 255))
    enviarNotificacao("MsDoors", isVip and "Painel VIP Ativo!" or "Carregando script padrão...", 5)
    wait(1)

    carregarScript(url)

    atualizarStatus(statusLabel, "Carregamento Concluído!", Color3.fromRGB(0, 255, 0))
    enviarNotificacao("MsDoors", "Script carregado com sucesso!", 5)
    ocultarPainel(screenGui, mainFrame, blurEffect)
end

iniciarCarregamento()
