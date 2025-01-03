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
local OrionLib = loadstring(game:HttpGetAsync('https://raw.githubusercontent.com/Sc-Rhyan57/Msdoors/refs/heads/main/Library/OrionLibrary_msdoors.lua'))()
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

    humanoid.WalkSpeed = ativo and 900000 or velocidadeOriginal

    if ativo then
        local distancia = (humanoidRootPart.Position - destino).Magnitude
        local passos = math.ceil(distancia / 20)
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

--// ADDONS \\--
task.spawn(function()

    local AddonTab = Window:MakeTab({Name = "Addons [BETA]", Icon = "rbxassetid://4483345998", PremiumOnly = false})

    if not isfolder(".msdoors/addons") then
        makefolder(".msdoors/addons")
    end

    local function AddAddonElement(Element)
        if not Element or typeof(Element) ~= "table" then return end

        if Element.Type == "Label" then
            AddonTab:AddLabel(Element.Arguments[1])
        elseif Element.Type == "Toggle" then
            AddonTab:AddToggle({
                Name = Element.Name,
                Default = Element.Arguments.Default or false,
                Callback = Element.Arguments.Callback
            })
        elseif Element.Type == "Button" then
            AddonTab:AddButton({
                Name = Element.Arguments.Name,
                Callback = Element.Arguments.Callback
            })
        elseif Element.Type == "Slider" then
            AddonTab:AddSlider({
                Name = Element.Name,
                Min = Element.Arguments.Min,
                Max = Element.Arguments.Max,
                Default = Element.Arguments.Default,
                Callback = Element.Arguments.Callback
            })
        elseif Element.Type == "Input" then
            AddonTab:AddTextbox({
                Name = Element.Name,
                Default = Element.Arguments.Default,
                TextDisappear = true,
                Callback = Element.Arguments.Callback
            })
        elseif Element.Type == "Dropdown" then
            AddonTab:AddDropdown({
                Name = Element.Name,
                Options = Element.Arguments.Options,
                Default = Element.Arguments.Default,
                Callback = Element.Arguments.Callback
            })
        elseif Element.Type == "ColorPicker" then
            AddonTab:AddColorPicker({
                Name = Element.Name,
                Default = Element.Arguments.Default,
                Callback = Element.Arguments.Callback
            })
        elseif Element.Type == "KeyPicker" then
            AddonTab:AddKeybind({
                Name = Element.Name,
                Default = Element.Arguments.Default,
                Callback = Element.Arguments.Callback
            })
        else
            warn("[MsDoors Addons] Elemento '" .. tostring(Element.Name) .. "' não foi carregado: Tipo de elemento inválido.")
        end
    end


    local containAddonsLoaded = false

    for _, file in pairs(listfiles(".msdoors/addons")) do
        print("[MsDoors Addons] Carregando addon '" .. string.gsub(file, ".msdoors/addons/", "") .. "'...")
        if file:sub(-4) ~= ".lua" then continue end

        local success, errorMessage = pcall(function()
            local fileContent = readfile(file)
            local addon = loadstring(fileContent)()

            if typeof(addon.Name) ~= "string" or typeof(addon.Elements) ~= "table" then
                warn("[MsDoors Addons] Addon '" .. string.gsub(file, ".msdoors/addons/", "") .. "' não carregado: Nome/Elementos inválidos.")
                return 
            end

            containAddonsLoaded = true

            AddonTab:AddLabel("Addon: " .. addon.Name)
            AddonTab:AddParagraph("Descrição", addon.Description or "Sem descrição.")

            for _, element in pairs(addon.Elements) do
                AddAddonElement(element)
            end
        end)

        if not success then
            warn("[MsDoors Addons] Falha ao carregar addon '" .. string.gsub(file, ".msdoors/addons/", "") .. "':", errorMessage)
        end
    end
    

    if not containAddonsLoaded then
        AddonTab:AddLabel("A pasta de addons está vazia. Adicione addons na pasta '.msdoors/addons' e reinicie o script.")
    end
end)

OrionLib:Init()
