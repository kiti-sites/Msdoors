MsdoorsNotify("Msdoors","Iniciando...","","rbxassetid://133997875469993", Color3.new(0.5, 0, 0.5), 5)
if game.PlaceId == 6516141723 then
MsdoorsNotify("Msdoors","Inicialização interrompida!","Jogo Incorreto!","rbxassetid://133997875469993", Color3.new(0.5, 0, 0.5), 6)
print("[Msdoors] • Inialização interrompida!")
print("[Msdoors] • Jogo Incorreto!")
end
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
local OrionLib = loadstring(game:HttpGetAsync('https://raw.githubusercontent.com/Sc-Rhyan57/Msdoors/refs/heads/main/Library/OrionLibrary_msdoors.lua'))()
local Window = OrionLib:MakeWindow({IntroText = "Msdoors | V1",Icon = "rbxassetid://100573561401335", IntroIcon = "rbxassetid://95869322194132", Name = "MsDoors | The Hotel", HidePremium = false, SaveConfig = true, ConfigFolder = ".msdoors/places/hotel"})
local MsdoorsNotify = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sc-Rhyan57/Notification-doorsAPI/refs/heads/main/Msdoors/MsdoorsApi.lua"))()
local ESPLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/MS-ESP/refs/heads/main/source.lua"))()
print("[Msdoors] • [✅] Inialização da livraria e apis")
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
--[[ SCRIPT ]]--
local GroupPrincipal = Window:MakeTab({
    Name = "Principal",
    Icon = "rbxassetid://7733765045",
    PremiumOnly = false
})
local AutomationGroup = GroupPrincipal:AddSection({Name = "Automation"})


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
    Callback = function(value)
        InstaInteractEnabled = value
        UpdateProximityPrompts()
    end
})


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
    ["Paintings"] = false,
    ["Gold"] = false,
    ["Light Source Items"] = false,
    ["Skull Prompt"] = false
}

AutomationGroup:AddToggle({
    Name = "Auto Interact",
    Default = false,
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
    Name = "Toggle Key",
    Default = Enum.KeyCode.R,
    Hold = false,
    Callback = function()
        AutoInteractEnabled = not AutoInteractEnabled
    end    
})

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
