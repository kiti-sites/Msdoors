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
local Window = OrionLib:MakeWindow({IntroText = "Msdoors | V1",Icon = "rbxassetid://133997875469993", IntroIcon = "rbxassetid://133997875469993", Name = "MsDoors | Super Hard Mode", HidePremium = false, SaveConfig = true, ConfigFolder = ".msdoors/places/fools23"})

--// APIS \\--
--[[ MSDOORS API ]]--
local MsdoorsNotify = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sc-Rhyan57/Notification-doorsAPI/refs/heads/main/Msdoors/MsdoorsApi.lua"))()
--[[ MS ESP(@mstudio45) - thanks for the API! ]]--
local ESPLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/MS-ESP/refs/heads/main/source.lua"))()

MsdoorsNotify("Msdoors","Msdoors foi carregado com sucesso!","Execução","rbxassetid://133997875469993", Color3.new(0.5, 0, 0.5), 5)
if game.PlaceId == 6516141723 then
MsdoorsNotify("Msdoors","Por favor, execute em SUPER HARD MODE.","Execução","rbxassetid://133997875469993", Color3.new(0.5, 0, 0.5), 6)
end

--[[ SCRIPTS ]]--
--//ANTI BANANA\\--
local autoDestroy = false
local function destroyAllBananaPeel()
    for _, child in ipairs(workspace:GetChildren()) do
        if child.Name == "BananaPeel" then
            print("[Msdoors] Apagando banana:", child.Name)
            child:Destroy()
        end
    end
end

workspace.ChildAdded:Connect(function(child)
    if autoDestroy and child.Name == "BananaPeel" then
        task.wait(0.1)
        print("[Msdoors]Banana encontrada e destruída:", child.Name)
        child:Destroy()
    end
end)

--[[ ELEMENTOS/UI ]]--
local ExploitsTab = Window:MakeTab({
    Name = "Exploits",
    Icon = "rbxassetid://7743873633",
    PremiumOnly = false
})

ExploitsTab:AddToggle({
    Name = "Anti Banana",
    Default = false,
    Callback = function(value)
        autoDestroy = value
        if autoDestroy then
            print("[Msdoors] Anti Banana: ATIVADA")
            MsdoorsNotify( "Msdoors", "AntiBanana ativo", "Exploits", "rbxassetid://6023426923", Color3.new(0, 1, 0), 2)
            destroyAllBananaPeel()
        else
            print("[Msdoors] Anti Banana: DESATIVADA")
            MsdoorsNotify( "Msdoors", "AntiBanana desativado", "Exploits", "rbxassetid://6023426923", Color3.new(0, 1, 0), 2)
        end
    end
})


OrionLib:Init()
