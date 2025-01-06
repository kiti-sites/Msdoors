--[[ LIBRARY & API]]--
if _G.OrionLibLoaded then
    warn("[Msdoors] • Script já está carregado!")
    return
end
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local OrionLib = loadstring(game:HttpGetAsync('https://raw.githubusercontent.com/Sc-Rhyan57/Msdoors/refs/heads/main/Library/OrionLibrary_msdoors.lua'))()
local Window = OrionLib:MakeWindow({IntroText = "Msdoors | V1",Icon = "rbxassetid://100573561401335", IntroIcon = "rbxassetid://95869322194132", Name = "MsDoors | Natural Disaster", HidePremium = false, SaveConfig = true, ConfigFolder = ".msdoors/places/natural-disaster"})
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
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
print("[Msdoors] • [✅] Inicialização de Serviços")
--[[ VERIFICAÇÃO DE JOGO ]]--
local GAME_ID_ESPERADO = 189707
local function getGameInfo()
    local success, gameInfo = pcall(function()
        return game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
    end)
    
    if not success then
        warn("[Msdoors] • Erro ao obter informações do jogo:", gameInfo)
        return nil
    end
    
    return gameInfo
end
local function verificarJogo()
    local gameInfo = getGameInfo()
    
    if not gameInfo then
        error(string.format([[
[ERRO CRÍTICO]
==========================================
Falha ao verificar o jogo atual
Detalhes do erro:
- Não foi possível obter informações do jogo
- Place ID atual: %d
- Hora do erro: %s
==========================================
]], game.PlaceId, os.date("%Y-%m-%d %H:%M:%S")))
        return false
    end
    
    if game.PlaceId ~= GAME_ID_ESPERADO then
        error(string.format([[
[ERRO DE VERIFICAÇÃO]
==========================================
Jogo incompatível detectado!
Detalhes:
- ID Esperado: %d
- ID Atual: %d
- Nome do Jogo: %s
- Criador: %s
- Hora da verificação: %s
==========================================
]], GAME_ID_ESPERADO, game.PlaceId, gameInfo.Name, gameInfo.Creator.Name, os.date("%Y-%m-%d %H:%M:%S")))
        return false
    end
    print(string.format([[
[VERIFICAÇÃO BEM-SUCEDIDA]
==========================================
Jogo verificado com sucesso!
- ID do Jogo: %d
- Nome: %s
- Hora: %s
==========================================
]], game.PlaceId, gameInfo.Name, os.date("%Y-%m-%d %H:%M:%S")))
    return true
end
verificarJogo()

--[[ TABS]]--
local GroupPrincipal = Window:MakeTab({
    Name = "Principal",
    Icon = "rbxassetid://7733954760",
    PremiumOnly = false
})
local TeleportsGroup = GroupPrincipal:AddSection({ Name = "Teleports"})
TeleportsGroup:AddLabel('<font color="#00FF34">Teleport between island and tower</font>')

--[[ TELEPORTES ]]--
TeleportsGroup:AddButton({
    Name = "Island",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-108, 49, 0)
    end
})

TeleportsGroup:AddButton({
    Name = "Tower",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-264, 196, 288)
    end
})
TeleportsGroup:AddLabel("")

local VisualsGroup = GroupPrincipal:AddSection({ Name = "Visuals"})
VisualsGroup:AddLabel('<font color="#00FF34">Things like Delete Screen Effects</font>')

--[[ VISUAIS ]]--
VisualsGroup:AddButton({
    Name = "Remove Sandstorm UI",
    Callback = function()
        game.Players.LocalPlayer.PlayerGui.SandStormGui:Destroy()
    end
})

VisualsGroup:AddButton({
    Name = "Remove Blizzard UI",
    Callback = function()
        game.Players.LocalPlayer.PlayerGui.BlizzardGui:Destroy()
    end
})

VisualsGroup:AddButton({
    Name = "Remove Ads",
    Callback = function()
        game:GetService("Workspace").BillboardAd:Destroy()
        game:GetService("Workspace")["Main Portal Template "]:Destroy()
        game:GetService("Workspace").ReturnPortal:Destroy()
    end
})
VisualsGroup:AddLabel("")

local GroupPlayers = Window:MakeTab({
    Name = "Player",
    Icon = "rbxassetid://7743871002",
    PremiumOnly = false
})
local GroupPlayer = GroupPlayers:AddSection({ Name = "movement"})
GroupPlayer:AddLabel('<font color="#00FF34">Speed hack, walk speed and player stuff.</font>')
--[[ PLAYER ]]--
GroupPlayer:AddToggle({
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
GroupPlayer:AddSlider({
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

GroupPlayer:AddSlider({
    Name = "Gravity / Jump boost",
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



local GroupExploits = Window:MakeTab({
    Name = "Exploits",
    Icon = "rbxassetid://7733655834",
    PremiumOnly = false
})
local GroupExploit = GroupExploits:AddSection({ Name = "map"})
GroupExploit:AddLabel('<font color="#00FF34">things like solid sland and solid water</font>')

GroupExploit:AddToggle({
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


GroupExploit:AddToggle({
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

GroupExploit:AddToggle({
    Name = "Choose Map",
    Default = false,
    Callback = function(state)
        game.Players.LocalPlayer.PlayerGui.MainGui.MapVotePage.Visible = state
    end
})


GroupExploit:AddButton({
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

GroupExploit:AddButton({
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



--// ADDONS \\--
task.spawn(function()
     local AddonTab = Window:MakeTab({Name = "Addons [BETA]", Icon = "rbxassetid://7733799901", PremiumOnly = false})
    AddonTab:AddLabel('<font color="#FF0000">This tab is for unofficial Msdoors addons! We are not responsible for anything!</font>')
   
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

OrionLib:Init()
