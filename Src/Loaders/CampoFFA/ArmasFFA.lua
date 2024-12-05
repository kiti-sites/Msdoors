--// <Campos de armas FFA> | UPDATE EM BREVEL \\--
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
local OrionLib = loadstring(game:HttpGetAsync('https://raw.githubusercontent.com/Giangplay/Script/main/Orion_Library_PE_V2.lua'))()
local Window = OrionLib:MakeWindow({IntroText = "Msdoors | V1 ",Icon = "rbxassetid://100573561401335", IntroIcon = "rbxassetid://95869322194132", Name = "MsDoors | Campos De Armas FFA", HidePremium = false, SaveConfig = true, ConfigFolder = ".msdoors/places/CamposArmasFFA"})
  --// APIS \\--
--[[ EVENTOS ]]--
loadstring(game:HttpGet("https://raw.githubusercontent.com/Sc-Rhyan57/Msdoors/refs/heads/main/Events/eventos.lua"))()
--[[ MS ESP(@mstudio45) - thanks for the API! ]]--
local ESPLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/MS-ESP/refs/heads/main/source.lua"))()
---[[ ELEMENTOS ]]--
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local aimbotEnabled = false
local aimbotPart = "Head"
local maxDistance = 500
local whitelist = {}
local blacklist = {}
local ignoreTeams = true
local prioritizeBlacklist = false

local aimDot = Drawing.new("Circle")
aimDot.Visible = false
aimDot.Radius = 6
aimDot.Color = Color3.new(1, 0, 0)
aimDot.Filled = true
local rotationAngle = 0
RunService.RenderStepped:Connect(function()
    if aimbotEnabled then
        rotationAngle = rotationAngle + math.rad(3)
        local xOffset = math.cos(rotationAngle) * 15
        local yOffset = math.sin(rotationAngle) * 15
        aimDot.Position = Camera.ViewportSize / 2 + Vector2.new(xOffset, yOffset)
    else
        aimDot.Visible = false
    end
end)

local function getClosestPlayer()
    local closestPlayer, shortestDistance = nil, maxDistance
    local prioritizedPlayers = prioritizeBlacklist and blacklist or Players:GetPlayers()

    for _, player in pairs(prioritizedPlayers) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild(aimbotPart) then
            local targetPart = player.Character[aimbotPart]
            local distance = (Camera.CFrame.Position - targetPart.Position).Magnitude
            if not table.find(whitelist, player.Name) then
                local isSameTeam = player.Team and player.Team == LocalPlayer.Team
                if not (ignoreTeams and isSameTeam) then
                    if distance < shortestDistance then
                        closestPlayer = player
                        shortestDistance = distance
                    end
                end
            end
        end
    end
    return closestPlayer
end

local function aimAt(player)
    if player and player.Character and player.Character:FindFirstChild(aimbotPart) then
        local target = player.Character[aimbotPart]
        local smoothness = 0.2
        local currentCFrame = Camera.CFrame
        local targetCFrame = CFrame.new(currentCFrame.Position, target.Position)
        Camera.CFrame = currentCFrame:Lerp(targetCFrame, smoothness)
    end
end
RunService.RenderStepped:Connect(function()
    if aimbotEnabled then
        aimDot.Visible = true
        local target = getClosestPlayer()
        if target then
            aimAt(target)
        end
    end
end)

--// ESP PLAYER \\--
local Options = {
    ESPColor = Color3.fromRGB(255, 0, 0),
    MaxDistance = 5000
}

local espAtivo = false
local linhasAtivas = {}

local function aplicarESPPlayer(player)
    local function setupESP(character)
        if not character or not character:FindFirstChild("HumanoidRootPart") then return end

        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

        local highlight = ESPLibrary.ESP.Highlight({
            Name = player.Name,
            Model = character,
            MaxDistance = Options.MaxDistance,
            FillColor = Options.ESPColor,
            OutlineColor = Options.ESPColor,
            FillTransparency = 0.5,
            OutlineTransparency = 0.2
        })

        local billboard = ESPLibrary.ESP.Billboard({
            Name = player.Name,
            Model = humanoidRootPart,
            MaxDistance = Options.MaxDistance,
            Color = Options.ESPColor,
            Text = string.format("[ %s ]", player.Name),
            TextSize = 17
        })

        local linha = Drawing.new("Line")
        linha.Thickness = 1.5
        linha.Color = Options.ESPColor
        linha.Transparency = 1
        linhasAtivas[player] = linha

        local function atualizarTraco()
            if humanoidRootPart and humanoidRootPart:IsDescendantOf(workspace) then
                local humanoidPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(humanoidRootPart.Position)
                if onScreen then
                    linha.Visible = true
                    linha.From = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y)
                    linha.To = Vector2.new(humanoidPos.X, humanoidPos.Y)
                else
                    linha.Visible = false
                end
            else
                linha.Visible = false
            end
        end

        local renderConnection = game:GetService("RunService").RenderStepped:Connect(atualizarTraco)

        character.AncestryChanged:Connect(function()
            if not character:IsDescendantOf(workspace) then
                linha:Remove()
                linhasAtivas[player] = nil
                highlight.Destroy()
                billboard.Destroy()
                renderConnection:Disconnect()
            end
        end)
    end

    if player.Character then
        setupESP(player.Character)
    end

    player.CharacterAdded:Connect(function(character)
        setupESP(character)
    end)
end

local function ativarESP()
    for _, player in ipairs(game.Players:GetPlayers()) do
        aplicarESPPlayer(player)
    end
end

local function desativarESP()
    ESPLibrary.ESP.Clear()
    for _, linha in pairs(linhasAtivas) do
        linha:Remove()
    end
    linhasAtivas = {}
end

game.Players.PlayerAdded:Connect(function(player)
    if espAtivo then
        player.CharacterAdded:Connect(function(character)
            aplicarESPPlayer(player)
        end)
    end
end)

game.Players.PlayerRemoving:Connect(function(player)
    if linhasAtivas[player] then
        linhasAtivas[player]:Remove()
        linhasAtivas[player] = nil
    end
end)


OrionLib:Init()

--// CRÉDITOS \\--
local CreditsTab = Window:MakeTab({
    Name = "Créditos - Msdoors",
    Icon = "rbxassetid://7743875759",
    PremiumOnly = false
})
local CdSc = CreditsTab:AddSection({
    Name = "Créditos"
})

CdSc:AddParagraph("Rhyan57", "• Criador e fundador do Msdoors.")
CdSc:AddParagraph("SeekAlegriaFla", "• Ajudante e coletor de files.")

local ExploitsTab = Window:MakeTab({
    Name = "Exploits",
    Icon = "rbxassetid://7743873633",
    PremiumOnly = false
})

ExploitsTab:AddToggle({
    Name = "Ativar Aimbot",
    Default = false,
    Callback = function(value)
        aimbotEnabled = value
        OrionLib:MakeNotification({
            Name = value and "Aimbot Ativado" or "Aimbot Desativado",
            Content = value and "Agora o Aimbot está ativo!" or "O Aimbot foi desativado!",
            Time = 5
        })
    end
})

ExploitsTab:AddDropdown({
    Name = "Parte do Corpo para Mira",
    Default = "Head",
    Options = { "Head", "Torso" },
    Callback = function(option)
        aimbotPart = option
    end
})

ExploitsTab:AddSlider({
    Name = "Distância Máxima",
    Min = 100,
    Max = 1000,
    Default = 500,
    Increment = 50,
    Callback = function(value)
        maxDistance = value
    end
})


ExploitsTab:AddToggle({
    Name = "Ignorar Jogadores do Mesmo Time",
    Default = true,
    Callback = function(value)
        ignoreTeams = value
    end
})

local VisualsTab = Window:MakeTab({
    Name = "Visuais",
    Icon = "rbxassetid://7743873633",
    PremiumOnly = false
})




VisualsTab:AddToggle({
    Name = "Players Esp",
    Default = false,
    Callback = function(state)
        espAtivo = state
        if espAtivo then
            ativarESP()
        else
            desativarESP()
        end
    end
})
OrionLib:Init()

