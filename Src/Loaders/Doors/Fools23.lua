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

--[[ PAINEL ]]--
-- Certifique-se de ter o OrionLib no jogo
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local autoDestroy = false -- Variável de controle para ativar/desativar o script

-- Função para destruir todos os objetos com o nome "BananaPeel"
local function destroyAllBananaPeel()
    for _, child in ipairs(workspace:GetChildren()) do
        if child.Name == "BananaPeel" then
            print("Apagando a pasta/arquivo:", child.Name)
            child:Destroy()
        end
    end
end

workspace.ChildAdded:Connect(function(child)
    if autoDestroy and child.Name == "BananaPeel" then
        task.wait(0.1) -- Pequeno delay antes de destruir
        print("Novo objeto encontrado:", child.Name)
        child:Destroy()
    end
end)

-- Criar GUI com OrionLib
local Window = OrionLib:MakeWindow({Name = "Controle de BananaPeel", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionConfig"})

-- Adicionar aba de controle
local Exploits = Window:MakeTab({
    Name = "BananaPeel",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

Tab:AddToggle({
    Name = "Ativar Destruição Automática",
    Default = false,
    Callback = function(value)
        autoDestroy = value -- Atualizar estado de ativação
        if autoDestroy then
            print("Destruição Automática: ATIVADA")
            destroyAllBananaPeel() -- Destruir imediatamente, se necessário
        else
            print("Destruição Automática: DESATIVADA")
        end
    end
})


OrionLib:Init()
