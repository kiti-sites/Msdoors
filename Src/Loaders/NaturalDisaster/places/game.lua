--// LIBRARY \\--
local OrionLib = loadstring(game:HttpGetAsync('https://raw.githubusercontent.com/Giangplay/Script/main/Orion_Library_PE_V2.lua'))()
local Window = OrionLib:MakeWindow({IntroText = "Msdoors | V1",Icon = "rbxassetid://133997875469993", IntroIcon = "rbxassetid://133997875469993", Name = "MsDoors | Natural Disaster", HidePremium = false, SaveConfig = true, ConfigFolder = ".msdoors/places/natural/game"})
--// SCRIPT \\--
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



local MainTab = Window:MakeTab({
    Name = "player sniper",
    Icon = "rbxassetid://7734021047",
    PremiumOnly = false
})

MainTab:AddToggle({
    Name = "Player Sniper",
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

MainTab:AddToggle({
    Name = "Forçar Sniper",
    Default = false,
    Callback = function(value)
        ForceTPActive = value
    end
})

createHUD()
OrionLib:Init()
