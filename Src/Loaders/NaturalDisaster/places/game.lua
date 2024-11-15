--// LIBRARY \\--
local OrionLib = loadstring(game:HttpGetAsync('https://raw.githubusercontent.com/Giangplay/Script/main/Orion_Library_PE_V2.lua'))()
local Window = OrionLib:MakeWindow({IntroText = "Msdoors | V1",Icon = "rbxassetid://133997875469993", IntroIcon = "rbxassetid://133997875469993", Name = "MsDoors | Natural Disaster", HidePremium = false, SaveConfig = true, ConfigFolder = ".msdoors/places/natural/game"})

--// TROLL \\--

-- [[ INÍCIO DA CONFIGURAÇÃO ]]
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local AllBool = false

local Targets = {"All"}
local WhitelistedUserId = 1414978355

local function GetPlayer(Name)
    Name = Name:lower()
    if Name == "all" then
        AllBool = true
        return
    elseif Name == "random" then
        local PlayersList = Players:GetPlayers()
        table.remove(PlayersList, table.find(PlayersList, LocalPlayer))
        return PlayersList[math.random(#PlayersList)]
    else
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and (player.Name:lower():match("^" .. Name) or player.DisplayName:lower():match("^" .. Name)) then
                return player
            end
        end
    end
end

local function Notify(Title, Content, Duration)
    OrionLib:MakeNotification({
        Name = Title,
        Content = Content,
        Image = "rbxassetid://4483345998",
        Time = Duration
    })
end

local function SkidFling(TargetPlayer)
    local Character = LocalPlayer.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local RootPart = Humanoid and Humanoid.RootPart

    local TargetCharacter = TargetPlayer.Character
    local TargetRootPart = TargetCharacter and TargetCharacter:FindFirstChild("HumanoidRootPart")

    if not (Character and RootPart and TargetCharacter and TargetRootPart) then
        Notify("Erro", "Dados insuficientes para executar o Fling.", 5)
        return
    end

    local OriginalPosition = RootPart.CFrame
    local BV = Instance.new("BodyVelocity", RootPart)
    BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
    BV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)

    RootPart.CFrame = TargetRootPart.CFrame
    task.wait(0.1)

    BV:Destroy()
    RootPart.CFrame = OriginalPosition
    Notify("Fling Executado", "O alvo foi atingido com sucesso!", 5)
end

local TrollTab = Window:MakeTab({
    Name = "Troll",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

TrollTab:AddButton({
    Name = "Ativar Sistema",
    Callback = function()
        Notify("Sistema Ativado", "O sistema Orion Lib está ativo!", 5)
    end
})

TrollTab:AddTextbox({
    Name = "Definir Alvo",
    Default = "all",
    TextDisappear = true,
    Callback = function(Value)
        Targets = {Value}
        Notify("Alvo Definido", "O alvo foi atualizado para: " .. Value, 5)
    end
})

TrollTab:AddButton({
    Name = "Executar Fling",
    Callback = function()
        if AllBool then
            for _, player in ipairs(Players:GetPlayers()) do
                if player.UserId ~= WhitelistedUserId then
                    SkidFling(player)
                else
                    Notify("Aviso", "Usuário na whitelist! Fling ignorado.", 5)
                end
            end
        else
            for _, target in ipairs(Targets) do
                local Player = GetPlayer(target)
                if Player and Player.UserId ~= WhitelistedUserId then
                    SkidFling(Player)
                elseif Player and Player.UserId == WhitelistedUserId then
                    Notify("Aviso", "Usuário whitelistado identificado! Fling ignorado.", 5)
                else
                    Notify("Erro", "Jogador inválido: " .. target, 5)
                end
            end
        end
    end
})

TrollTab:AddButton({
    Name = "Desativar Sistema",
    Callback = function()
        Notify("Sistema Desativado", "O sistema foi desativado.", 5)
    end
})

local Troll2 = TrollTab:AddSection({
	Name = "Enforce TP"
})

Tab:AddParagraph("Player Sniper","Teleporta o seu personagem atual parq todos players do mapa a cada 5s \ Você pode usar os seguintes comandos no infinite yield para usar isso: ;fly 1, ;swim, ;invisfling")
Troll2:AddToggle({
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

Troll2:AddToggle({
    Name = "Forçar Sniper",
    Default = false,
    Callback = function(value)
        ForceTPActive = value
    end
})

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


local ExploitTab = Window:MakeTab({
    Name = "Exploits",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local TrollTab = Window:MakeTab({
    Name = "Troll",
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

-- Troll

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
