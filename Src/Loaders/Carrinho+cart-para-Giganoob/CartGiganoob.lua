--// <Carts Game> | UPDATE EM BREVEL \\--

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

--// SERVIÇOS \\--
local OrionLib = loadstring(game:HttpGetAsync('https://raw.githubusercontent.com/Giangplay/Script/main/Orion_Library_PE_V2.lua'))()
--[[ MS ESP(@mstudio45) - thanks for the API! ]]--
local ESPLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/MS-ESP/refs/heads/main/source.lua"))()

local Window = OrionLib:MakeWindow({IntroText = "Msdoors | V1 ",Icon = "rbxassetid://100573561401335", IntroIcon = "rbxassetid://95869322194132", Name = "MsDoors | Carrinho + Cart Para GigaNoob!", HidePremium = false, SaveConfig = true, ConfigFolder = ".msdoors/places/carrinhoCartGiganoob"})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Variáveis globais para controle
getgenv().AutoClickDetectors = false
getgenv().ClickSpeed = 0.3
local autoDestroy = true
local player = Players.LocalPlayer

local initialPosition = player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character.HumanoidRootPart.Position

local function destroyAllBuyHatGamePassSign()
    for _, child in ipairs(workspace:GetChildren()) do
        if child.Name == "Buy Hat Game Pass Sign" then
            print("[MsDoors] Apagando pasta:", child.Name)
            child:Destroy()
        end
    end
end

workspace.ChildAdded:Connect(function(child)
    if autoDestroy and child.Name == "Buy Hat Game Pass Sign" then
        task.wait(0.1)
        print("[Msdoors] 'Buy Hat Game Pass Sign' encontrada e destruída:", child.Name)
        child:Destroy()
    end
end)

local function teleportToBuyHatGamePassSign()
    local target = workspace:FindFirstChild("Buy Hat Game Pass Sign")
    if target and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = target.CFrame + Vector3.new(0, 5, 0)
        print("[Msdoors] Jogador teleportado para 'Buy Hat Game Pass Sign'.")
        task.wait(3)
        if initialPosition then
            player.Character.HumanoidRootPart.CFrame = CFrame.new(initialPosition)
            print("[Msdoors] Jogador retornado à posição inicial.")
        end
    else
        print("[Msdoors] Pasta 'Buy Hat Game Pass Sign' não encontrada para teleporte.")
    end
end

local function interactWithClickDetectors()
    while getgenv().AutoClickDetectors do
        task.wait(getgenv().ClickSpeed)
        pcall(function()
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("ClickDetector") then
                    fireclickdetector(v)
                end
            end
        end)
    end
end

--[[
--// DOWN CART \\--
getgenv().Down = false 
local Building = game:GetService("Workspace"):FindFirstChild("Building")

local function getAllClickDetectors()
    local clickDetectors = {}
    if Building then
        for _, descendant in ipairs(Building:GetDescendants()) do
            if descendant:IsA("ClickDetector") and descendant.Parent and descendant.Parent.Name == "Down" then
                table.insert(clickDetectors, descendant)
            end
        end
    end
    return clickDetectors
end

local function spamClickDetectors()
    while getgenv().Down do 
        local clickDetectors = getAllClickDetectors() 
        for _, clickDetector in ipairs(clickDetectors) do
            pcall(function()
                fireclickdetector(clickDetector)
            end)
        end
        task.wait(0.1) 
    end
end
]]--
--// ON/PLAY CART \\--
local Building = game:GetService("Workspace"):FindFirstChild("Building")
local function getAllClickDetectors()
    local clickDetectors = {}
    if Building then
        for _, descendant in ipairs(Building:GetDescendants()) do
            if descendant:IsA("ClickDetector") and descendant.Parent and descendant.Parent.Name == "On" then
                table.insert(clickDetectors, descendant)
            end
        end
    end
    return clickDetectors
end
local function interactOnce()
    local clickDetectors = getAllClickDetectors()
    for _, clickDetector in ipairs(clickDetectors) do
        pcall(function()
            fireclickdetector(clickDetector)
        end)
    end
    OrionLib:MakeNotification({
        Name = "Interação Completa",
        Content = "Interagiu com todos os carts encontrados!",
        Time = 5
    })
end

--// UP CARTS \\--
getgenv().AutoClickDetectors1 = false
local Building = game:GetService("Workspace"):FindFirstChild("Building")

local function getAllClickDetectors()
    local clickDetectors = {}
    if Building then
        for _, descendant in ipairs(Building:GetDescendants()) do
            if descendant:IsA("ClickDetector") and descendant.Parent and descendant.Parent.Name == "Up" then
                table.insert(clickDetectors, descendant)
            end
        end
    end
    return clickDetectors
end

local function spamClickDetectors()
    while getgenv().AutoClickDetectors1 do
        local clickDetectors = getAllClickDetectors()
        for _, clickDetector in ipairs(clickDetectors) do
            pcall(function()
                fireclickdetector(clickDetector)
            end)
        end
        task.wait(0.1)
    end
end


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

local ExploitTab = Window:MakeTab({
    Name = "Exploits",
    Icon = "rbxassetid://7743873633",
    PremiumOnly = false
})
local CartsTab = ExploitTab:AddSection({
	Name = "Carts"
})

destroyAllBuyHatGamePassSign()
CartsTab:AddToggle({
    Name = "Quebrar Carts",
    Default = false,
    Callback = function(state)
        getgenv().AutoClickDetectors = state
        if state then
            OrionLib:MakeNotification({
                Name = "Sistema Ativado",
                Content = "Auto Click está ativo!",
                Time = 5
            })
            spawn(interactWithClickDetectors)
        else
            OrionLib:MakeNotification({
                Name = "Sistema Desativado",
                Content = "Auto Click foi desativado!",
                Time = 5
            })
        end
    end
})

CartsTab:AddSlider({
    Name = "Velocidade do Clique (segundos)",
    Min = 0.1,
    Max = 2,
    Default = 0.3,
    Color = Color3.fromRGB(255, 255, 255),
    Increment = 0.1,
    Callback = function(value)
        getgenv().ClickSpeed = value
        OrionLib:MakeNotification({
            Name = "Velocidade Atualizada",
            Content = "Velocidade ajustada para " .. value .. " segundos.",
            Time = 3
        })
    end
})

CartsTab:AddToggle({
    Name = "Spam Mais Velocidade ",
    Default = false,
    Callback = function(state)
        getgenv().AutoClickDetectors1 = state -- Usa a nova variável de controle
        if state then
            OrionLib:MakeNotification({
                Name = "Sistema Ativado",
                Content = "Spam de ➕ iniciado!",
                Time = 5
            })
            spawn(spamClickDetectors)
        else
            OrionLib:MakeNotification({
                Name = "Sistema Desativado",
                Content = "Spam de ➕ pausado.",
                Time = 5
            })
        end
    end
})
--// REMOVIDO \\
--[[
CartsTab:AddToggle({
    Name = "Spam menos velocidade",
    Default = false,
    Callback = function(state)
        getgenv().Down = state
        if state then
            OrionLib:MakeNotification({
                Name = "Sistema Ativado",
                Content = "Spam de ➖ iniciado!",
                Time = 5
            })
            spawn(spamClickDetectors)
        else
            OrionLib:MakeNotification({
                Name = "Sistema Desativado",
                Content = "Spam de ➖ pausado.",
                Time = 5
            })
        end
    end
})
]]--

CartsTab:AddButton({
    Name = "Ligar/Desligar Carts",
    Callback = function()
        interactOnce()
    end
})
