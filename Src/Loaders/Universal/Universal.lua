--// <UNIVERSAL> | UPDATE EM BREVEL \\--
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
local Window = OrionLib:MakeWindow({IntroText = "Msdoors | V1",Icon = "rbxassetid://133997875469993", IntroIcon = "rbxassetid://133997875469993", Name = "MsDoors", HidePremium = false, SaveConfig = true, ConfigFolder = ".msdoors/places/hotel"})
--// APIS \\--
--[[ MS ESP(@mstudio45) - thanks for the API! ]]--
local ESPLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/MS-ESP/refs/heads/main/source.lua"))()
---[[ ELEMENTOS ]]--

-- Serviços necessários
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Configurações do Aimbot
local aimbotEnabled = false
local aimbotPart = "Head"
local maxDistance = 500
local whitelist = {}
local blacklist = {}
local ignoreTeams = true
local prioritizeBlacklist = false

-- Ponto giratório
local aimDot = Drawing.new("Circle")
aimDot.Visible = false
aimDot.Radius = 6
aimDot.Color = Color3.new(1, 0, 0) -- Vermelho
aimDot.Filled = true

-- Atualização do ponto giratório
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

-- Função para encontrar jogador mais próximo ou prioritário
local function getClosestPlayer()
    local closestPlayer, shortestDistance = nil, maxDistance
    local prioritizedPlayers = prioritizeBlacklist and blacklist or Players:GetPlayers()

    for _, player in pairs(prioritizedPlayers) do
        -- Verificar se o jogador é válido e possui a parte necessária
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild(aimbotPart) then
            local targetPart = player.Character[aimbotPart]
            local distance = (Camera.CFrame.Position - targetPart.Position).Magnitude

            -- Ignorar jogadores whitelistados
            if not table.find(whitelist, player.Name) then
                -- Verificar a lógica de times
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

-- Função de mira automática
local function aimAt(player)
    if player and player.Character and player.Character:FindFirstChild(aimbotPart) then
        local target = player.Character[aimbotPart]
        local smoothness = 0.2 -- Configuração de suavidade da câmera
        local currentCFrame = Camera.CFrame
        local targetCFrame = CFrame.new(currentCFrame.Position, target.Position)
        Camera.CFrame = currentCFrame:Lerp(targetCFrame, smoothness)
    end
end

-- Loop do Aimbot
RunService.RenderStepped:Connect(function()
    if aimbotEnabled then
        aimDot.Visible = true
        local target = getClosestPlayer()
        if target then
            aimAt(target)
        end
    end
end)



-- Aba do Aimbot
local AimbotTab = Window:MakeTab({
    Name = "Aimbot 🔫",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

AimbotTab:AddSection({ Name = "Configurações Gerais" })

-- Toggle do Aimbot
AimbotTab:AddToggle({
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

-- Dropdown para selecionar parte do corpo
AimbotTab:AddDropdown({
    Name = "Parte do Corpo para Mira",
    Default = "Head",
    Options = { "Head", "Torso" },
    Callback = function(option)
        aimbotPart = option
    end
})

-- Slider para configurar distância máxima
AimbotTab:AddSlider({
    Name = "Distância Máxima",
    Min = 100,
    Max = 1000,
    Default = 500,
    Increment = 50,
    Callback = function(value)
        maxDistance = value
    end
})


AimbotTab:AddToggle({
    Name = "Ignorar Jogadores do Mesmo Time",
    Default = true,
    Callback = function(value)
        ignoreTeams = value
    end
})

OrionLib:Init()
