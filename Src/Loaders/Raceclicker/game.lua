--// <[❄️UPD] Race Clicker | UPDATE EM BREVEL \\--

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
local ESPLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/MS-ESP/refs/heads/main/source.lua"))()
local Window = OrionLib:MakeWindow({IntroText = "Msdoors | V1 ",Icon = "rbxassetid://100573561401335", IntroIcon = "rbxassetid://95869322194132", Name = "MsDoors | RaceClicker", HidePremium = false, SaveConfig = true, ConfigFolder = ".msdoors/places/RaceClicker"})

--// CRÉDITOS \\--
local CreditsTab = Window:MakeTab({
    Name = "Créditos - Msdoors",
    Icon = "rbxassetid://7743875759",
    PremiumOnly = false
})
local CdSc = CreditsTab:AddSection({Name = "Créditos"})
CdSc:AddParagraph("Rhyan57", "• Criador e fundador do Msdoors.")
CdSc:AddParagraph("SeekAlegriaFla", "• Ajudante e coletor de files.")

--[[ Auto Farm Wins script ]]--
local destino = Vector3.new(-583062, 37, 77)
local ativo = false
local clicando = false

local function clicarTela()
    while clicando do
        for _ = 1, 10 do
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, nil, 0)
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, nil, 0)
        end
        task.wait(0.001)
    end
end

local function autoWin()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local velocidadeOriginal = humanoid.WalkSpeed

    humanoid.WalkSpeed = ativo and 100000 or velocidadeOriginal

    if ativo then
        local distancia = (humanoidRootPart.Position - destino).Magnitude
        local passos = math.ceil(distancia / 10)
        for i = 1, passos do
            if not ativo then break end
            humanoidRootPart.CFrame = humanoidRootPart.CFrame:Lerp(CFrame.new(destino), i / passos)
            task.wait(0.01)
        end
        if ativo then humanoidRootPart.CFrame = CFrame.new(destino) end
    else
        humanoid.WalkSpeed = velocidadeOriginal
    end
end

local function verificarUI()
    local player = game.Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui", 10)
    local clickUI = playerGui:FindFirstChild("ClicksUI")
    local clickHelper = clickUI and clickUI:FindFirstChild("ClickHelper")

    if clickHelper and clickHelper:IsA("GuiObject") then
        clickHelper:GetPropertyChangedSignal("Visible"):Connect(function()
            if clickHelper.Visible then
                ativo = false
                clicando = true
                clicarTela()
        else
                clicando = false
                ativo = true
                task.spawn(autoWin)
            end
        end)

        if clickHelper.Visible then
            ativo = false
            clicando = true
            clicarTela()
        else
            ativo = true
            task.spawn(autoWin)
        end
    else
        warn("[MsDoors] • ClickHelper não encontrado! Não será possível ativar o Autoclick.")
    end
end

local Farm = Window:MakeTab({
    Name = "Automação",
    Icon = "rbxassetid://7743873633",
    PremiumOnly = false
})
Farm:AddToggle({
    Name = "Auto Farm Win",
    Default = false,
    Callback = function(estado)
        ativo = estado

        if ativo then
            verificarUI()
            autoWin()
        else
            clicando = false
        end
    end
})

OrionLib:Init()
