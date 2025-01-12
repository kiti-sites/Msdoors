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
local OrionLib = loadstring(game:HttpGetAsync('https://raw.githubusercontent.com/Sc-Rhyan57/Msdoors/refs/heads/main/Library/OrionLibrary_msdoors.lua'))()
local Window = OrionLib:MakeWindow({IntroText = "Msdoors | V1 ",Icon = "rbxassetid://100573561401335", IntroIcon = "rbxassetid://95869322194132", Name = "MsDoors | Campos De Armas FFA", HidePremium = false, SaveConfig = true, ConfigFolder = ".msdoors/places/CamposArmasFFA"})
  --// APIS \\--
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

--// PLAYER ESP \\--
local ESPEnabled = false
local ESPObjects = {}

local function getDistance(from, to)
    return math.floor((from.Position - to.Position).Magnitude)
end

local function getRGB()
    local hue = tick() % 5 / 5
    return Color3.fromHSV(hue, 1, 1)
end

local function createESPForCharacter(player, character)
    local rootPart = character:WaitForChild("HumanoidRootPart", 5)
    local humanoid = character:WaitForChild("Humanoid", 5)
    if not rootPart or not humanoid then return end

    local billboard = Instance.new("BillboardGui")
    billboard.Adornee = rootPart
    billboard.Size = UDim2.new(4, 0, 2, 0)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = game.CoreGui

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.3, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextScaled = true
    nameLabel.Text = player.Name
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.Parent = billboard

    local infoLabel = Instance.new("TextLabel")
    infoLabel.Size = UDim2.new(1, 0, 0.3, 0)
    infoLabel.Position = UDim2.new(0, 0, 0.3, 0)
    infoLabel.BackgroundTransparency = 1
    infoLabel.TextScaled = true
    infoLabel.Text = ""
    infoLabel.Font = Enum.Font.SourceSansBold
    infoLabel.Parent = billboard

    local box = Instance.new("BoxHandleAdornment")
    box.Adornee = character
    box.Size = Vector3.new(4, 7, 4)
    box.Color3 = getRGB()
    box.Transparency = 0.6
    box.AlwaysOnTop = true
    box.ZIndex = 2
    box.Parent = game.CoreGui

    local line = Drawing.new("Line")
    line.Color = getRGB()
    line.Thickness = 2
    line.Visible = true

    local function update()
        if not ESPEnabled or not character.Parent or not rootPart:IsDescendantOf(workspace) then
            removeESP(player)
            return
        end

        local camera = workspace.CurrentCamera
        local screenPos, onScreen = camera:WorldToViewportPoint(rootPart.Position)
        if onScreen then
            line.Visible = true
            line.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
            line.To = Vector2.new(screenPos.X, screenPos.Y)

            nameLabel.TextColor3 = getRGB()
            box.Color3 = getRGB()

            local distance = getDistance(camera.CFrame, rootPart.CFrame)
            infoLabel.Text = string.format("Health: %d | Distance: %d", math.floor(humanoid.Health), distance)
        else
            line.Visible = false
        end
    end

    local connection = game:GetService("RunService").RenderStepped:Connect(update)

    ESPObjects[player] = {Billboard = billboard, Box = box, Line = line, Connection = connection}
end

local function removeESP(player)
    if ESPObjects[player] then
        ESPObjects[player].Billboard:Destroy()
        ESPObjects[player].Box:Destroy()
        ESPObjects[player].Line:Remove()
        ESPObjects[player].Connection:Disconnect()
        ESPObjects[player] = nil
    end
end

local function handlePlayer(player)
    if player.Character then
        createESPForCharacter(player, player.Character)
    end

    player.CharacterAdded:Connect(function(character)
        removeESP(player)
        createESPForCharacter(player, character)
    end)

    player.CharacterRemoving:Connect(function()
        removeESP(player)
    end)
end

local function toggleESP(state)
    ESPEnabled = state
    if ESPEnabled then
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                handlePlayer(player)
            end
        end
    else
        for player, _ in pairs(ESPObjects) do
            removeESP(player)
        end
    end
end

game.Players.PlayerAdded:Connect(function(player)
    if ESPEnabled then
        handlePlayer(player)
    end
end)

game.Players.PlayerRemoving:Connect(function(player)
    removeESP(player)
end)

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

ExploitsTab:AddButton({
	Name = "Expandir Hitbox doa inimigos",
	Callback = function()
      		print("[Msdoors] • Hitbox dos jogadores expandidas.")
          loadstring(game:HttpGet("https://mscripts.vercel.app/scfiles/hitbox-expander.lua"))()
  	end    
})


local VisualsTab = Window:MakeTab({
    Name = "Visuais",
    Icon = "rbxassetid://7743873633",
    PremiumOnly = false
})

VisualsTab:AddToggle({
    Name = "Players esp",
    Default = false,
    Callback = function(value)
        toggleESP(value)
    end
})

OrionLib:Init()
_G.MsdoorsLoaded = true

