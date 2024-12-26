--// <SUPER HARD MODE> | UPDATE EM BREVEL \\--
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
local Window = OrionLib:MakeWindow({IntroText = "Msdoors | V1",Icon = "rbxassetid://100573561401335", IntroIcon = "rbxassetid://95869322194132", Name = "MsDoors | Super Hard Mode", HidePremium = false, SaveConfig = true, ConfigFolder = ".msdoors/places/fools23"})

--// APIS \\--
local MsdoorsNotify = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sc-Rhyan57/Notification-doorsAPI/refs/heads/main/Msdoors/MsdoorsApi.lua"))()
local ESPLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/MS-ESP/refs/heads/main/source.lua"))()

MsdoorsNotify("Msdoors","Msdoors foi carregado com sucesso!","Execução","rbxassetid://133997875469993", Color3.new(0.5, 0, 0.5), 5)
if game.PlaceId == 6516141723 then
MsdoorsNotify("Msdoors","Por favor, execute em SUPER HARD MODE.","Execução","rbxassetid://133997875469993", Color3.new(0.5, 0, 0.5), 6)
end

--// Serviços \\--
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

--[[ SCRIPTS ]]--
--//ANTI BANANA\\--
local autoDestroy = false
local function destroyAllBananaPeel()
    for _, child in ipairs(workspace:GetChildren()) do
        if child.Name == "BananaPeel" then
            if autoDestroy == true then
                child.CanTouch = false
                --[[
                print("[Msdoors] Apagando banana:", child.Name)
                child:Destroy()
                ]]
            else
                child.CanTouch = true
            end
        end
    end
end

workspace.ChildAdded:Connect(function(child)
    if autoDestroy and child.Name == "BananaPeel" then
        task.wait(0.1)
        destroyAllBananaPeel()
        --[[
        print("[Msdoors]Banana encontrada e destruída:", child.Name)
        child:Destroy()
        ]]
    end
end)

--------------------[[ 💻 AUTOMAÇÃO 💻 ]]--------------------------------
local autoIn = Window:MakeTab({
    Name = "Automoção",
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

autoIn:AddToggle({
    Name = "Interação instantânea",
    Default = false,
    Callback = function(value)
        InstaInteractEnabled = value
        UpdateProximityPrompts()
    end
})
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

--[[ ELEMENTOS/UI ]]--
local ExploitsTab = Window:MakeTab({
    Name = "Exploits",
    Icon = "rbxassetid://7743873633",
    PremiumOnly = false
})

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

ExploitsTab:AddToggle({
    Name = "Anti Banana",
    Default = false,
    Callback = function(value)
        autoDestroy = value
        if autoDestroy then
            print("[Msdoors] Anti Banana: ATIVADA")
            MsdoorsNotify( "Msdoors", "AntiBanana ativo", "Exploits", "rbxassetid://6023426923", Color3.new(0, 1, 0), 2)
        else
            print("[Msdoors] Anti Banana: DESATIVADA")
            MsdoorsNotify( "Msdoors", "AntiBanana desativado", "Exploits", "rbxassetid://6023426923", Color3.new(0, 1, 0), 2)
        end
        destroyAllBananaPeel()
    end
})


OrionLib:Init()
