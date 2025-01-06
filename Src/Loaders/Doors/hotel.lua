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
--[[ LIBRARY & API]]--
if _G.OrionLibLoaded then
    warn("[Msdoors] • Script já está carregado!")
    return
end
local OrionLib = loadstring(game:HttpGetAsync('https://raw.githubusercontent.com/Sc-Rhyan57/Msdoors/refs/heads/main/Library/OrionLibrary_msdoors.lua'))()
local Window = OrionLib:MakeWindow({IntroText = "Msdoors | V1",Icon = "rbxassetid://100573561401335", IntroIcon = "rbxassetid://95869322194132", Name = "MsDoors | The Hotel", HidePremium = false, SaveConfig = true, ConfigFolder = ".msdoors/places/hotel"})
local MsdoorsNotify = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sc-Rhyan57/Notification-doorsAPI/refs/heads/main/Msdoors/MsdoorsApi.lua"))()
local ESPLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/MS-ESP/refs/heads/main/source.lua"))()
print("[Msdoors] • [✅] Inialização da livraria e apis")
_G.OrionLibLoaded = true

--[[ SERVIÇOS ]]--
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local TextChatService = game:GetService("TextChatService")
local UserInputService = game:GetService("UserInputService")
local PathfindingService = game:GetService("PathfindingService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local LatestRoom = ReplicatedStorage:WaitForChild("GameData"):WaitForChild("LatestRoom")
print("[Msdoors] • [✅] Inicialização de Serviços")
if game.PlaceId == 6516141723 then
print("[Msdoors] • [✅] Inialização interrompida!")
print("[Msdoors] • [❎] Jogo Incorreto!")
end
--[[ SCRIPT ]]--
local GroupPrincipal = Window:MakeTab({
    Name = "Principal",
    Icon = "rbxassetid://7733765045",
    PremiumOnly = false
})
local AutomationGroup = GroupPrincipal:AddSection({Name = "Automation"})
local PlayerGroup = GroupPrincipal:AddSection({Name = "Player"})


local GroupExploits = Window:MakeTab({
    Name = "Exploits",
    Icon = "rbxassetid://7733765045",
    PremiumOnly = false
})

local GroupVisual = Window:MakeTab({
    Name = "Visual",
    Icon = "rbxassetid://7733765045",
    PremiumOnly = false
})
local NotificationGroup = GroupVisual:AddSection({Name = "Notification"})
local EspGroup = GroupVisual:AddSection({Name = "Esp"})

local GroupCredits = Window:MakeTab({
    Name = "Msdoors",
    Icon = "rbxassetid://7733765045",
    PremiumOnly = false
})

GroupCredits:AddLabel('<font color="#00FFFF">Créditos</font>')
GroupCredits:AddLabel('• Rhyan57 - <font color="#FFA500">DONO</font>')
GroupCredits:AddLabel('• SeekAlegriaFla - <font color="#FFA500">SUB-DONO</font>')
GroupCredits:AddLabel('<font color="#00FFFF">Redes</font>')
GroupCredits:AddLabel('• Discord: <font color="#9DABFF">https://dsc.gg/msdoors-gg</font>')
GroupCredits:AddButton({
    Name = "Copiar Link",
    Callback = function()
        local url = "https://dsc.gg/msdoors-gg"
        if syn then
            syn.request({
                Url = url,
                Method = "GET"
            })
        elseif setclipboard then
            setclipboard(url)
            OrionLib:MakeNotification({
                Name = "Link Copiado!",
                Content = "Seu executor não suporta redirecionar. Link copiado.",
                Time = 5
            })
        else
            OrionLib:MakeNotification({
                Name = "LOL",
                Content = "Seu executor não suporta redirecionar ou copiar links.",
                Time = 5
            })
        end
    end
})
GroupCredits:AddLabel('<font color="#FF0000">Script</font>')
GroupCredits:AddButton({
    Name = "Descarregar",
    Callback = function()
        for _, thread in pairs(getfenv()) do
            if typeof(thread) == "thread" then
                task.cancel(thread)
            end
        end
      
        notificationsEnabled = false
        InstaInteractEnabled = false
        AutoInteractEnabled = false
        initialized = false
        verificarEspObjetos = false
        desativarESPObjetos()
      
        if OrionLib then
            OrionLib:Destroy()
        end
        warn("[Msdoors] • Todos os sistemas foram desativados e a interface fechada.")
    end
})

local ObjectiveESPConfig = {
    Types = {
        KeyObtain = {
            Name = "Chave",
            Color = Color3.fromRGB(0, 255, 0)
        },
        LeverForGate = {
            Name = "Alavanca",
            Color = Color3.fromRGB(0, 255, 0)
        },
        ElectricalKeyObtain = {
            Name = "Chave elétrica",
            Color = Color3.fromRGB(0, 255, 0)
        },
        LiveHintBook = {
            Name = "Livro",
            Color = Color3.fromRGB(0, 255, 0)
        },
        LiveBreakerPolePickup = {
            Name = "Disjuntor",
            Color = Color3.fromRGB(0, 255, 0)
        },
        MinesGenerator = {
            Name = "Gerador",
            Color = Color3.fromRGB(0, 255, 0)
        },
        MinesGateButton = {
            Name = "Botão do portão",
            Color = Color3.fromRGB(0, 255, 0)
        },
        FuseObtain = {
            Name = "Fusível",
            Color = Color3.fromRGB(0, 255, 0)
        },
        MinesAnchor = {
            Name = "Torre",
            Color = Color3.fromRGB(0, 255, 0)
        },
        WaterPump = {
            Name = "Bomba de água",
            Color = Color3.fromRGB(0, 255, 0)
        }
    },
    Settings = {
        MaxDistance = 5000,
        UpdateInterval = 5,
        TextSize = 16,
        FillTransparency = 0.75,
        OutlineTransparency = 0,
        TracerStartPosition = "Bottom",
        ArrowCenterOffset = 300
    }
}

local ObjectiveESPManager = {
    ActiveESPs = {},
    IsEnabled = false,
    IsChecking = false,
    CurrentRoom = nil
}

function ObjectiveESPManager:CreateESP(object, config)
    if not object or not object.PrimaryPart then return nil end
    
    local espInstance = ESPLibrary.ESP.Highlight({
        Name = config.Name,
        Model = object,
        MaxDistance = ObjectiveESPConfig.Settings.MaxDistance,
        
        FillColor = config.Color,
        OutlineColor = config.Color,
        TextColor = config.Color,
        TextSize = ObjectiveESPConfig.Settings.TextSize,
        
        FillTransparency = ObjectiveESPConfig.Settings.FillTransparency,
        OutlineTransparency = ObjectiveESPConfig.Settings.OutlineTransparency,
        
        Tracer = {
            Enabled = true,
            From = ObjectiveESPConfig.Settings.TracerStartPosition,
            Color = config.Color
        },
        
        Arrow = {
            Enabled = true,
            CenterOffset = ObjectiveESPConfig.Settings.ArrowCenterOffset,
            Color = config.Color
        }
    })
    
    return espInstance
end

function ObjectiveESPManager:HandleSpecialCases(object, config)
    if object.Name == "MinesAnchor" then
        local sign = object:WaitForChild("Sign", 5)
        if sign and sign:FindFirstChild("TextLabel") then
            config.Name = string.format("Torre %s", sign.TextLabel.Text)
        end
    elseif object.Name == "WaterPump" then
        local wheel = object:WaitForChild("Wheel", 5)
        local onFrame = object:FindFirstChild("OnFrame", true)
        
        if not (wheel and onFrame and onFrame.Visible) then
            return nil
        end
        
        onFrame:GetPropertyChangedSignal("Visible"):Connect(function()
            self:RemoveESP(object)
        end)
    end
    
    return config
end

function ObjectiveESPManager:AddESP(object)
    if not object or self.ActiveESPs[object] then return end
    
    local config = ObjectiveESPConfig.Types[object.Name]
    if not config then return end
    
    config = self:HandleSpecialCases(object, table.clone(config))
    if not config then return end
    
    local espInstance = self:CreateESP(object, config)
    if espInstance then
        self.ActiveESPs[object] = espInstance
    end
end

function ObjectiveESPManager:RemoveESP(object)
    if self.ActiveESPs[object] then
        self.ActiveESPs[object].Destroy()
        self.ActiveESPs[object] = nil
    end
end

function ObjectiveESPManager:ScanRoom()
    if not self.IsEnabled then return end
    
    local currentRoom = workspace.CurrentRooms:FindFirstChild(game.Players.LocalPlayer:GetAttribute("CurrentRoom"))
    if not currentRoom then return end
    
    if self.CurrentRoom ~= currentRoom then
        self:ClearESPs()
        self.CurrentRoom = currentRoom
    end
    
    for _, asset in pairs(currentRoom:GetDescendants()) do
        if ObjectiveESPConfig.Types[asset.Name] then
            self:AddESP(asset)
        end
    end
end

function ObjectiveESPManager:ClearESPs()
    for object, esp in pairs(self.ActiveESPs) do
        esp.Destroy()
    end
    self.ActiveESPs = {}
end

function ObjectiveESPManager:StartScanning()
    if self.IsChecking then return end
    self.IsChecking = true
    
    spawn(function()
        while self.IsChecking do
            self:ScanRoom()
            wait(ObjectiveESPConfig.Settings.UpdateInterval)
        end
    end)
end

function ObjectiveESPManager:StopScanning()
    self.IsChecking = false
    self:ClearESPs()
end

EspGroup:AddToggle({
    Name = "esp de objetivo",
    Default = false,
    Callback = function(state)
        ObjectiveESPManager.IsEnabled = state
        
        if state then
            ObjectiveESPManager:StartScanning()
        else
            ObjectiveESPManager:StopScanning()
        end
    end
})

game.Players.LocalPlayer:GetAttributeChangedSignal("CurrentRoom"):Connect(function()
    if ObjectiveESPManager.IsEnabled then
        ObjectiveESPManager:ScanRoom()
    end
end)

-- Tabela de Entidades para notificação.
local EntityTable = {
    ["Names"] = {"BackdoorRush", "BackdoorLookman", "RushMoving", "AmbushMoving", "Eyes", "JeffTheKiller", "A60", "A120"},
    ["NotifyReason"] = {
        ["A60"] = { ["Image"] = "12350986086", ["Title"] = "A-60", ["Description"] = "A-60 SPAWNOU!" },
        ["A120"] = { ["Image"] = "12351008553", ["Title"] = "A-120", ["Description"] = "A-120 SPAWNOU!" },
        ["HaltRoom"] = { ["Image"] = "11331795398", ["Title"] = "Halt", ["Description"] = "Prepare-se para Halt.",  ["Spawned"] = true },
        ["Window_BrokenSally"] = { ["Image"] = "100573561401335", ["Title"] = "Sally", ["Description"] = "Sally SPAWNOU!",  ["Spawned"] = true },
        ["BackdoorRush"] = { ["Image"] = "11102256553", ["Title"] = "Backdoor Blitz", ["Description"] = "Blitz SPAWNOU!" },
        ["RushMoving"] = { ["Image"] = "11102256553", ["Title"] = "Rush", ["Description"] = "Rush SPAWNOU!" },
        ["AmbushMoving"] = { ["Image"] = "10938726652", ["Title"] = "Ambush", ["Description"] = "Ambush SPAWNOU!" },
        ["Eyes"] = { ["Image"] = "10865377903", ["Title"] = "Eyes", ["Description"] = "Não olhe para os olhos!", ["Spawned"] = true },
        ["BackdoorLookman"] = { ["Image"] = "16764872677", ["Title"] = "Backdoor Lookman", ["Description"] = "Olhe para baixo!", ["Spawned"] = true },
        ["JeffTheKiller"] = { ["Image"] = "98993343", ["Title"] = "Jeff The Killer", ["Description"] = "Fuja do Jeff the Killer!" }
    }
}

local notificationsEnabled = false
local initialized = false

function MonitorEntities()
    game:GetService("RunService").Stepped:Connect(function()
        if notificationsEnabled then
            for _, entityName in ipairs(EntityTable.Names) do
                local entity = workspace:FindFirstChild(entityName)
                if entity and not entity:GetAttribute("Notified") then
                    entity:SetAttribute("Notified", true)
                    NotifyEntity(entityName)
                end
            end
        end
    end)
end

function NotifyEntity(entityName)
    local notificationData = EntityTable.NotifyReason[entityName]
    if notificationData then
        MsdoorsNotify(
            notificationData.Title,
            notificationData.Description,
            "",
            "rbxassetid://" .. notificationData.Image,
            Color3.fromRGB(255, 0, 0),
            5
        )
    end
end

MonitorEntities()
NotificationGroup:AddToggle({
    Name = "Notificar Entidades",
    Save = true,
    Flag = "NotifyEntitys-toggle",
    Default = false,
    Callback = function(value)
        if not initialized then
            initialized = true
            return
        end
        
        notificationsEnabled = value
        local sound = Instance.new("Sound")
        sound.SoundId = value and "rbxassetid://4590657391" or "rbxassetid://4590662766"
        sound.Volume = 1
        sound.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
        sound:Play()
        sound.Ended:Connect(function()
            sound:Destroy()
        end)
        
        MsdoorsNotify(
            "MsDoors",
            value and "Notificações de Entidades ativas!" or "Notificações de Entidades desativadas!",
            "",
            "rbxassetid://100573561401335",
            value and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0),
            3
        )
    end
})

local Toggles = {}
local InstaInteractEnabled = false

local function UpdateProximityPrompts()
    for _, prompt in pairs(workspace.CurrentRooms:GetDescendants()) do
        if prompt:IsA("ProximityPrompt") then
            if InstaInteractEnabled then
                if not prompt:GetAttribute("Hold") then 
                    prompt:SetAttribute("Hold", prompt.HoldDuration)
                end
                prompt.HoldDuration = 0
            else
                prompt.HoldDuration = prompt:GetAttribute("Hold") or 0
            end
        end
    end
end
workspace.CurrentRooms.DescendantAdded:Connect(function(descendant)
    if descendant:IsA("ProximityPrompt") then
        if InstaInteractEnabled then
            if not descendant:GetAttribute("Hold") then 
                descendant:SetAttribute("Hold", descendant.HoldDuration)
            end
            descendant.HoldDuration = 0
        end
    end
end)

AutomationGroup:AddToggle({
    Name = "Instant Interaction",
    Default = false,
    Save = true,
    Flag = "instantInteract-toggle",
    Callback = function(value)
        InstaInteractEnabled = value
        UpdateProximityPrompts()
    end
})
AutomationGroup:AddLabel("")

shared = {
    Character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait(),
    LocalPlayer = game.Players.LocalPlayer,
    Humanoid = nil,
}

local function InitializeScript()
    shared.Humanoid = shared.Character:WaitForChild("Humanoid")
    game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
        shared.Character = char
        shared.Humanoid = char:WaitForChild("Humanoid")
    end)
end

shared.fireproximityprompt = function(prompt)
    if prompt.ClassName == "ProximityPrompt" then
        fireproximityprompt(prompt)
    end
end

local Script = {
    PromptTable = {
        GamePrompts = {},
        Aura = {
            ["ActivateEventPrompt"] = false,
            ["AwesomePrompt"] = true,
            ["FusesPrompt"] = true,
            ["HerbPrompt"] = false,
            ["LeverPrompt"] = true,
            ["LootPrompt"] = false,
            ["ModulePrompt"] = true,
            ["SkullPrompt"] = false,
            ["UnlockPrompt"] = true,
            ["ValvePrompt"] = false,
            ["PropPrompt"] = true
        },
        AuraObjects = {
            "Lock",
            "Button"
        },
        Clip = {
            "AwesomePrompt",
            "FusesPrompt",
            "HerbPrompt",
            "HidePrompt",
            "LeverPrompt",
            "LootPrompt",
            "ModulePrompt",
            "Prompt",
            "PushPrompt",
            "SkullPrompt",
            "UnlockPrompt",
            "ValvePrompt"
        },
        ClipObjects = {
            "LeverForGate",
            "LiveBreakerPolePickup",
            "LiveHintBook",
            "Button",
        },
        Excluded = {
            Prompt = {
                "HintPrompt",
                "InteractPrompt"
            },
            Parent = {
                "KeyObtainFake",
                "Padlock"
            },
            ModelAncestor = {
                "DoorFake"
            }
        }
    },
    Temp = {
        PaintingDebounce = {}
    }
}

Script.Functions = {
    GetAllPromptsWithCondition = function(condition)
        local prompts = {}
        for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
            if v:IsA("ProximityPrompt") then
                if condition(v) then
                    table.insert(prompts, v)
                end
            end
        end
        return prompts
    end,

    DistanceFromCharacter = function(object)
        if not shared.Character or not shared.Character:FindFirstChild("HumanoidRootPart") or not object then
            return math.huge
        end
        local objectPosition = object:IsA("BasePart") and object.Position or 
                             object:FindFirstChild("HumanoidRootPart") and object.HumanoidRootPart.Position or
                             object:FindFirstChildWhichIsA("BasePart") and object:FindFirstChildWhichIsA("BasePart").Position
        if not objectPosition then
            return math.huge
        end
        return (shared.Character.HumanoidRootPart.Position - objectPosition).Magnitude
    end,
    
    IsExcluded = function(prompt)
        for _, excludedName in ipairs(Script.PromptTable.Excluded.Prompt) do
            if prompt.Name == excludedName then return true end
        end
        if prompt.Parent then
            for _, excludedParent in ipairs(Script.PromptTable.Excluded.Parent) do
                if prompt.Parent.Name == excludedParent then return true end
            end
        end
        local model = prompt:FindFirstAncestorWhichIsA("Model")
        if model then
            for _, excludedModel in ipairs(Script.PromptTable.Excluded.ModelAncestor) do
                if model.Name == excludedModel then return true end
            end
        end
        return false
    end
}

local AutoInteractEnabled = false
local IgnoreSettings = {
    ["Jeff Items"] = true,
    ["Unlock w/ Lockpick"] = false,
    ["Paintings"] = true,
    ["Gold"] = false,
    ["Light Source Items"] = false,
    ["Skull Prompt"] = false
}

AutomationGroup:AddToggle({
    Name = "Auto Interact",
    Default = false,
    Save = true,
    Flag = "AutoInteract-toggle",
    Callback = function(Value)
        AutoInteractEnabled = Value
    end    
})

AutomationGroup:AddDropdown({
    Name = "Ignore List",
    Default = {"Jeff Items"},
    Options = {"Jeff Items", "Unlock w/ Lockpick", "Paintings", "Gold", "Light Source Items", "Skull Prompt"},
    Callback = function(Value)
        for k, _ in pairs(IgnoreSettings) do
            IgnoreSettings[k] = false
        end
        for _, v in pairs(Value) do
            IgnoreSettings[v] = true
        end
    end,
    Multi = true
})

AutomationGroup:AddBind({
    Name = "KeyBind",
    Default = Enum.KeyCode.R,
    Hold = false,
    Callback = function()
        AutoInteractEnabled = not AutoInteractEnabled
    end    
})
AutomationGroup:AddLabel("")

local function AutoInteractLoop()
    while true do
        task.wait()
        if AutoInteractEnabled then
            local prompts = Script.Functions.GetAllPromptsWithCondition(function(prompt)
                if not prompt.Parent then return false end
                if IgnoreSettings["Jeff Items"] and prompt.Parent:GetAttribute("JeffShop") then return false end
                if IgnoreSettings["Unlock w/ Lockpick"] and (prompt.Name == "UnlockPrompt" or prompt.Parent:GetAttribute("Locked")) and shared.Character:FindFirstChild("Lockpick") then return false end
                if IgnoreSettings["Paintings"] and prompt.Name == "PropPrompt" then return false end
                if IgnoreSettings["Gold"] and prompt.Name == "LootPrompt" then return false end
                if IgnoreSettings["Light Source Items"] and prompt.Parent:GetAttribute("Tool_LightSource") and not prompt.Parent:GetAttribute("Tool_CanCutVines") then return false end
                if IgnoreSettings["Skull Prompt"] and prompt.Name == "SkullPrompt" then return false end
                if prompt.Parent:GetAttribute("PropType") == "Battery" and not (shared.Character:FindFirstChildOfClass("Tool") and (shared.Character:FindFirstChildOfClass("Tool"):GetAttribute("RechargeProp") == "Battery" or shared.Character:FindFirstChildOfClass("Tool"):GetAttribute("StorageProp") == "Battery")) then return false end 
                if prompt.Parent:GetAttribute("PropType") == "Heal" and shared.Humanoid and shared.Humanoid.Health == shared.Humanoid.MaxHealth then return false end
                if prompt.Parent.Name == "MinesAnchor" then return false end
                if Script.IsRetro and prompt.Parent.Parent.Name == "RetroWardrobe" then return false end
                return Script.PromptTable.Aura[prompt.Name] ~= nil
            end)

            for _, prompt in pairs(prompts) do
                task.spawn(function()
                    if Script.Functions.DistanceFromCharacter(prompt.Parent) < prompt.MaxActivationDistance and (not prompt:GetAttribute("Interactions" .. shared.LocalPlayer.Name) or Script.PromptTable.Aura[prompt.Name] or table.find(Script.PromptTable.AuraObjects, prompt.Parent.Name)) then
                        if prompt.Parent.Name == "Slot" and prompt.Parent:GetAttribute("Hint") then
                            if Script.Temp.PaintingDebounce[prompt] then return end
                            local currentPainting = shared.Character:FindFirstChild("Prop")
                            local slotPainting = prompt.Parent:FindFirstChild("Prop")
                            local currentHint = (currentPainting and currentPainting:GetAttribute("Hint"))
                            local slotHint = (slotPainting and slotPainting:GetAttribute("Hint"))
                            local promptHint = prompt.Parent:GetAttribute("Hint")
                            if slotHint ~= promptHint and (currentHint == promptHint or slotPainting) then
                                Script.Temp.PaintingDebounce[prompt] = true
                                shared.fireproximityprompt(prompt)
                                task.wait(0.3)
                                Script.Temp.PaintingDebounce[prompt] = false    
                            end
                            return
                        end
                        shared.fireproximityprompt(prompt)
                    end
                end)
            end
        end
    end
end
InitializeScript()
task.spawn(AutoInteractLoop)


local Script = { IsFools = false }
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local CanJumpEnabled = false
PlayerGroup:AddToggle({
    Name = "Enable Jump",
    Default = false,
    Save = true,
    Flag = "enableJump-toggle",
    Callback = function(value)
        CanJumpEnabled = value
        if Script.IsFools then return end
        Character:SetAttribute("CanJump", value)
        if value then
            
        else
           
            if Humanoid then
                Humanoid.WalkSpeed = 22
            end
        end
    end
})


