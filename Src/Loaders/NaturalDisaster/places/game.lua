--// LIBRARY \\--
local OrionLib = loadstring(game:HttpGetAsync('https://raw.githubusercontent.com/Giangplay/Script/main/Orion_Library_PE_V2.lua'))()
local Window = OrionLib:MakeWindow({IntroText = "Msdoors | V1",Icon = "rbxassetid://100573561401335", IntroIcon = "rbxassetid://95869322194132", Name = "MsDoors | Natural Disaster", HidePremium = false, SaveConfig = true, ConfigFolder = ".msdoors/places/natural/game"})

--[[ EVENTOS ]]--
loadstring(game:HttpGet("https://raw.githubusercontent.com/Sc-Rhyan57/Msdoors/refs/heads/main/Events/eventos.lua"))()
--// SCRIPT \\--
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer

--// GLOBAL VARIABLES \\--
local CooldownTime = 3
local TpCustomCooldown = 1
local ForceTpActive = false
local TpCustomActive = false
local CurrentTarget = nil

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local TeleportList = {}
local ToggleActive = false
local CurrentTarget = nil
local Cooldown = 5
local ForceTPActive = false 
local HUD 
local FixConnection 
local FixActive = false 

local function sendNotification(title, content, duration)
    OrionLib:MakeNotification({
        Name = title,
        Content = content,
        Image = "rbxassetid://133997875469993",
        Time = duration or 2
    })
end

local function teleportToAll()
    for _, targetPlayer in ipairs(Players:GetPlayers()) do
        if targetPlayer ~= Player then
            local Character = Player.Character
            local TargetCharacter = targetPlayer.Character
            if Character and TargetCharacter and TargetCharacter:FindFirstChild("HumanoidRootPart") then
                Character:SetPrimaryPartCFrame(TargetCharacter.HumanoidRootPart.CFrame)
                sendNotification("Force Tp", "Teleportado para: " .. targetPlayer.Name, 2)
                task.wait(0.2)
            end
        end
    end
end

local function ForceTpByMs()
    ForceTpActive = true
    while ForceTpActive do
        teleportToAll()
        task.wait(CooldownTime)
    end
end

local function TpCustomByMs()
    TpCustomActive = true
    while TpCustomActive do
        if CurrentTarget then
            local targetPlayer = Players:FindFirstChild(CurrentTarget)
            if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                Player.Character:SetPrimaryPartCFrame(targetPlayer.Character.HumanoidRootPart.CFrame)
                sendNotification("Tp Custom", "Teleportado para: " .. targetPlayer.Name, 2)
            else
                sendNotification("Erro", "Jogador selecionado não encontrado.", 2)
                TpCustomActive = false
            end
        end
        task.wait(TpCustomCooldown)
    end
end

local function stopAllSystems()
    ForceTpActive = false
    TpCustomActive = false
end

local function getPlayerList()
    local playerList = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Player then
            table.insert(playerList, player.Name)
        end
    end
    return playerList
end

local function updateHUD()
    if HUD then
        HUD.Text = "Alvo Atual: " .. (CurrentTarget or "Nenhum")
    end
end

local function createHUD()
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    HUD = Instance.new("TextLabel", ScreenGui)
    HUD.Size = UDim2.new(0, 300, 0, 50)
    HUD.Position = UDim2.new(0.5, -150, 0, 10)
    HUD.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    HUD.BackgroundTransparency = 0.5
    HUD.TextColor3 = Color3.fromRGB(255, 255, 255)
    HUD.Font = Enum.Font.SourceSansBold
    HUD.TextScaled = true
    HUD.Text = "Alvo Atual: Nenhum"
end

local function teleportToPlayer(targetPlayer)
    if not targetPlayer or not targetPlayer.Character or not LocalPlayer.Character then return end

    local localRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
    if localRoot and targetRoot then

        localRoot.CFrame = targetRoot.CFrame
        CurrentTarget = targetPlayer.Name
        updateHUD()
    end
end

local function applyHighlight(player, color, label)
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end

    local highlight = Instance.new("Highlight")
    highlight.FillColor = color
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0.7
    highlight.Parent = player.Character

    local billboard = Instance.new("BillboardGui")
    billboard.Adornee = player.Character:FindFirstChild("HumanoidRootPart")
    billboard.Size = UDim2.new(5, 0, 1, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = player.Character

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = label
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextColor3 = color
    textLabel.Parent = billboard
end

local function maintainFix()
    if FixConnection then FixConnection:Disconnect() end 

    FixConnection = RunService.Stepped:Connect(function()
        if not CurrentTarget then return end
        local targetPlayer = Players:FindFirstChild(CurrentTarget)
        if targetPlayer and targetPlayer.Character and LocalPlayer.Character then
            local localRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
            if localRoot and targetRoot then
                localRoot.CFrame = targetRoot.CFrame
            end
        else
  
            FixActive = false
            if FixConnection then FixConnection:Disconnect() end
        end
    end)
end

local function forceTeleport()
    if not LocalPlayer.Character then return end

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Name ~= CurrentTarget then
            teleportToPlayer(player)
            applyHighlight(player, Color3.fromRGB(0, 255, 0), "Forçado!")
            break
        end
    end
end

local function teleportLoop()
    while ToggleActive do
        for _, player in pairs(Players:GetPlayers()) do
            if not ToggleActive then break end
            if player ~= LocalPlayer and not table.find(TeleportList, player) then
                teleportToPlayer(player)
                applyHighlight(player, Color3.fromRGB(255, 0, 0), "Afetado")
                FixActive = true
                maintainFix() 
                task.wait(Cooldown)
                FixActive = false 
                if FixConnection then FixConnection:Disconnect() end
                table.insert(TeleportList, player)
            end
        end

        TeleportList = {}
        if ForceTPActive then
            forceTeleport()
        end
    end
end

local function stopAllSystems()
    ToggleActive = false
    FixActive = false
    TeleportList = {}
    CurrentTarget = nil
    if FixConnection then FixConnection:Disconnect() end
    updateHUD()
end

local TrollTab = Window:MakeTab({
    Name = "Troll",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local ExploitTab = Window:MakeTab({
    Name = "Exploits",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})


local TeleportTab = Window:MakeTab({
    Name = "Teleports",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local SettingsTab = Window:MakeTab({
    Name = "Settings",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local CreditsTab = Window:MakeTab({
    Name = "Credits",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Exploits
ExploitTab:AddToggle({
    Name = "Walk On Water",
    Default = false,
    Callback = function(state)
        local water = game.Workspace.WaterLevel
        if state then
            water.CanCollide = true
            water.Size = Vector3.new(1000, 1, 1000)
        else
            water.CanCollide = false
            water.Size = Vector3.new(10, 1, 10)
        end
    end
})


TrollTab:AddToggle({
    Name = "Force Tp (Todos os jogadores)",
    Default = false,
    Callback = function(state)
        if state then
            task.spawn(ForceTpByMs)
        else
            stopAllSystems()
        end
    end
})

TrollTab:AddDropdown({
    Name = "Selecionar Jogador",
    Default = "",
    Options = getPlayerList(),
    Callback = function(value)
        CurrentTarget = value
    end
})

TrollTab:AddSlider({
    Name = "Tempo de Teleporte (s)",
    Min = 0.5,
    Max = 5,
    Default = 1,
    Increment = 0.1,
    Callback = function(value)
        TpCustomCooldown = value
    end
})

TrollTab:AddToggle({
    Name = "Tp Custom",
    Default = false,
    Callback = function(state)
        if state then
            task.spawn(TpCustomByMs)
        else
            stopAllSystems()
        end
    end
})


ExploitTab:AddToggle({
    Name = "Solid Island",
    Default = false,
    Callback = function(state)
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if v.Name == "LowerRocks" then
                v.CanCollide = state
            end
        end
    end
})

ExploitTab:AddToggle({
    Name = "Choose Map",
    Default = false,
    Callback = function(state)
        game.Players.LocalPlayer.PlayerGui.MainGui.MapVotePage.Visible = state
    end
})

ExploitTab:AddToggle({
    Name = "Autofarm",
    Default = false,
    Callback = function(state)
        if state then
            autofarmEvent = game:GetService("RunService").RenderStepped:Connect(function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-264, 195, 288)
            end)
        else
            if autofarmEvent then
                autofarmEvent:Disconnect()
            end
        end
    end
})

ExploitTab:AddButton({
    Name = "Launch Rocket",
    Callback = function()
        pcall(function()
            fireclickdetector(game:GetService("Workspace").Structure["Launch Land"]["SPACESHIP!!"].Shuttle.IgnitionButton.ClickDetector)
            fireclickdetector(game:GetService("Workspace").Structure["Launch Land"].RocketStand.ConsoleLower.ReleaseButtonLower.ClickDetector)
            fireclickdetector(game:GetService("Workspace").Structure["Launch Land"].RocketStand.ConsoleUpper.ReleaseButtonUpper.ClickDetector)
            fireclickdetector(game:GetService("Workspace").Structure["Launch Land"].LoadingTower.Console.ReleaseEntryBridge.ClickDetector)
        end)
    end
})

ExploitTab:AddButton({
    Name = "Say Current Disaster",
    Callback = function()
        local chatEvents = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
        local sayMessageRequest = chatEvents and chatEvents:FindFirstChild("SayMessageRequest")
        local disasterTag = game.Players.LocalPlayer.Character:FindFirstChild("SurvivalTag")

        if sayMessageRequest and disasterTag then
            sayMessageRequest:FireServer(disasterTag.Value, "All")
        else
            OrionLib:MakeNotification({
                Name = "Erro",
                Content = "Não foi possível identificar o desastre ou enviar mensagem no chat.",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end
    end
})

ExploitTab:AddSlider({
    Name = "WalkSpeed",
    Min = 16,
    Max = 50,
    Default = 16,
    Color = Color3.fromRGB(255, 255, 255),
    Increment = 1,
    ValueName = "Speed",
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
})

ExploitTab:AddSlider({
    Name = "Gravity",
    Min = 0,
    Max = 196,
    Default = 196,
    Color = Color3.fromRGB(255, 255, 255),
    Increment = 1,
    ValueName = "Gravity",
    Callback = function(value)
        game.Workspace.Gravity = value
    end
})

ExploitTab:AddButton({
    Name = "Remove Sandstorm UI",
    Callback = function()
        game.Players.LocalPlayer.PlayerGui.SandStormGui:Destroy()
    end
})

ExploitTab:AddButton({
    Name = "Remove Blizzard UI",
    Callback = function()
        game.Players.LocalPlayer.PlayerGui.BlizzardGui:Destroy()
    end
})

ExploitTab:AddButton({
    Name = "Remove Ads",
    Callback = function()
        game:GetService("Workspace").BillboardAd:Destroy()
        game:GetService("Workspace")["Main Portal Template "]:Destroy()
        game:GetService("Workspace").ReturnPortal:Destroy()
    end
})



ExploitTab:AddToggle({
    Name = "Ativar Teleporte",
    Default = false,
    Callback = function(value)
        ToggleActive = value
        if ToggleActive then
            task.spawn(teleportLoop)
        else
            stopAllSystems()
        end
    end
})

ExploitTab:AddToggle({
    Name = "Forçar Teleporte",
    Default = false,
    Callback = function(value)
        ForceTPActive = value
    end
})


-- Teleports
TeleportTab:AddButton({
    Name = "Island",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-108, 49, 0)
    end
})

TeleportTab:AddButton({
    Name = "Tower",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-264, 196, 288)
    end
})

-- Settings
SettingsTab:AddButton({
    Name = "Destroy GUI",
    Callback = function()
        OrionLib:Destroy()
    end
})



-- Credits
CreditsTab:AddParagraph("Credits", [[
Msdoors made by:
Rhyan57 / https://github.com/Sc-rhyan57



Agradecimentos especiais a:
]] .. tostring(game.Players.LocalPlayer.Name) .. " / Você 🫵😃")

createHUD()
OrionLib:Init()
