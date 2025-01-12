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
--[[ LIBRARY & API]]--
if _G.OrionLibLoaded then
    warn("[Msdoors] • Script já está carregado!")
    return
end
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local OrionLib = loadstring(game:HttpGetAsync('https://raw.githubusercontent.com/Sc-Rhyan57/Msdoors/refs/heads/main/Library/OrionLibrary_msdoors.lua'))()
local Window = OrionLib:MakeWindow({IntroText = "Msdoors | V1",Icon = "rbxassetid://100573561401335", IntroIcon = "rbxassetid://95869322194132", Name = "MsDoors | Cart into gigaNoob!", HidePremium = false, SaveConfig = true, ConfigFolder = ".msdoors/places/hotel"})
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
local musicPlayer = { isPlaying = false, currentSound = nil, currentPlaylist = nil, playlists = {}, currentIndex = 0, volume = 0.5, folderName = ".msdoors", }
print("[Msdoors] • [✅] Inicialização de Serviços")
--[[ VERIFICAÇÃO DE JOGO ]]--
local GAME_ID_ESPERADO = 5275822877
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
    Icon = "rbxassetid://7733765045",
    PremiumOnly = false
})
local CartsTab = GroupPrincipal:AddSection({ Name = "Carts"})
CartsTab:AddLabel('<font color="#FF0000">Use responsibly and with consent.</font>')
local JeepsTab = GroupPrincipal:AddSection({ Name = "Jeeps" })
JeepsTab:AddLabel('<font color="#FF0000">This function may cause some lag for the player.</font>')
local TeleportGroup = GroupPrincipal:AddSection({ Name = "Teleportes" })
TeleportGroup:AddLabel('<font color="#9DABFF">Aba de teleportes</font>')

local GroupMusic = Window:MakeTab({
    Name = "Musica",
    Icon = "rbxassetid://7734020554",
    PremiumOnly = false
})
local MsPlayer = GroupMusic:AddSection({ Name = "Sistema de Músicas" })
MsPlayer:AddLabel('<font color="#9DABFF">Escute músicas enquanto joga</font>')

--[[ MUSIC SYSTEM ]]--
local function createFolderIfNotExists()
    if not isfolder(musicPlayer.folderName) then
        makefolder(musicPlayer.folderName)
    end
end

local function savePlaylist(name, data)
    createFolderIfNotExists()
    local filePath = musicPlayer.folderName .. "/" .. name .. ".json"
    local jsonData = HttpService:JSONEncode(data)
    writefile(filePath, jsonData)
end

local function loadPlaylist(name)
    local filePath = musicPlayer.folderName .. "/" .. name .. ".json"
    if isfile(filePath) then
        local jsonData = readfile(filePath)
        return HttpService:JSONDecode(jsonData)
    else
        return nil
    end
end

local function deletePlaylist(name)
    local filePath = musicPlayer.folderName .. "/" .. name .. ".json"
    if isfile(filePath) then
        delfile(filePath)
    end
end

local function createNotification(title, content, duration)
    OrionLib:MakeNotification({
        Name = title,
        Content = content,
        Image = "rbxassetid://4483345998",
        Time = duration or 5
    })
end

local function playMusic(index)
    if not musicPlayer.currentPlaylist or #musicPlayer.currentPlaylist == 0 then
        createNotification("Erro", "Playlist vazia ou não carregada.(tente re-entrar)", 3)
        return
    end

    if musicPlayer.currentSound then
        musicPlayer.currentSound:Destroy()
    end

    local sound = Instance.new("Sound", game:GetService("Workspace"))
    local musicData = musicPlayer.currentPlaylist[index]
    if not musicData then
        createNotification("Erro", "Nenhuma música encontrada.", 3)
        return
    end

    sound.SoundId = "rbxassetid://" .. musicData.Id
    sound.Volume = musicPlayer.volume
    sound.Looped = false
    sound:Play()

    musicPlayer.isPlaying = true
    musicPlayer.currentSound = sound
    musicPlayer.currentIndex = index

    createNotification("Reprodutor", "Tocando: " .. musicData.NAME, 3)

    sound.Ended:Connect(function()
        local nextIndex = musicPlayer.currentIndex + 1
        if nextIndex > #musicPlayer.currentPlaylist then nextIndex = 1 end
        playMusic(nextIndex)
    end)
end

-- Variáveis globais para controle
getgenv().AutoClickDetectors = false
getgenv().ClickSpeed = 0.3
local autoDestroy = true
local player = Players.LocalPlayer

local initialPosition = player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character.HumanoidRootPart.Position

local function destroyAllBuyHatGamePassSign()
    for _, child in ipairs(workspace:GetChildren()) do
        if child.Name == "Buy Hat Game Pass Sign" then
            print("[Msdoors] • A seguinte pasta será apagada para evitar bugs:", child.Name)
            child:Destroy()
        end
    end
end

workspace.ChildAdded:Connect(function(child)
    if autoDestroy and child.Name == "Buy Hat Game Pass Sign" then
        task.wait(0.1)
        print("[Msdoors] • 'Buy Hat Game Pass Sign' encontrada e destruída:", child.Name)
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
            print("[Msdoors] • Jogador retornado à posição inicial.")
        end
    else
        print("[Msdoors] • Pasta 'Buy Hat Game Pass Sign' não encontrada para teleporte.")
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
        Name = "Msdoors",
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

--// JEEP \\--
getgenv().AutoSpamCarrinhos = false
local function getAllCarrinhos()
    local carrinhos = {}
    for _, descendant in ipairs(workspace:GetDescendants()) do
        if descendant:IsA("Model") and descendant.Name:lower():find("jeep") then
            table.insert(carrinhos, descendant)
        end
    end
    return carrinhos
end
local function interactWithCarrinho(carrinho)
    for _, part in ipairs(carrinho:GetDescendants()) do
        if part:IsA("ClickDetector") then
            pcall(function()
                fireclickdetector(part)
            end)
        end
        if part:IsA("ProximityPrompt") then
            pcall(function()
                fireproximityprompt(part)
            end)
        end
        if part:IsA("TouchTransmitter") or part.Name == "TouchInterest" then
            pcall(function()
                firetouchinterest(part.Parent, game.Players.LocalPlayer.Character.HumanoidRootPart, 0)
                task.wait(0.1)
                firetouchinterest(part.Parent, game.Players.LocalPlayer.Character.HumanoidRootPart, 1)
            end)
        end
    end
end

local function interactWithAllCarrinhos()
    while getgenv().AutoSpamCarrinhos do
        local carrinhos = getAllCarrinhos()
        for _, carrinho in ipairs(carrinhos) do
            pcall(function()
                interactWithCarrinho(carrinho)
            end)
        end
        task.wait(0.1) 
    end
end
destroyAllBuyHatGamePassSign()

CartsTab:AddToggle({
    Name = "Break Carts",
    Default = false,
    Callback = function(state)
        getgenv().AutoClickDetectors = state
        if state then
            OrionLib:MakeNotification({
                Name = "Msdoors",
                Content = "Auto Click está ativo!",
                Time = 5
            })
            spawn(interactWithClickDetectors)
        else
            OrionLib:MakeNotification({
                Name = "Msdoors",
                Content = "Auto Click foi desativado!",
                Time = 5
            })
        end
    end
})

CartsTab:AddSlider({
    Name = "Spam speed",
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
    Name = "speed for all carts",
    Default = false,
    Callback = function(state)
        getgenv().AutoClickDetectors1 = state
        if state then
            spawn(spamClickDetectors)
			else
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
    Name = "Stop/Play carts",
    Callback = function()
        interactOnce()
    end
})



JeepsTab:AddToggle({
    Name = "Spawn Infinite Jeeps(half slow)",
    Default = false,
    Callback = function(state)
        getgenv().AutoSpamCarrinhos = state
        if state then
            OrionLib:MakeNotification({
                Name = "Sistema Ativado",
                Content = "Spam Jeeps iniciado!",
                Time = 5
            })
            spawn(interactWithAllCarrinhos)
        else
            OrionLib:MakeNotification({
                Name = "Sistema Desativado",
                Content = "Spam Jeeps pausado.",
                Time = 5
            })
        end
    end
})


TeleportGroup:AddDropdown({
    Name = "Selecione um Local",
    Default = "Início",
    Options = {"Início", "Meio", "Fim"},
    Callback = function(value)
        if value == "Início" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(233, 3, 7)
        elseif value == "Meio" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(271, 350, 466)
        elseif value == "Fim" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(163, 761, -1020)
        end
    end
})


MsPlayer:AddTextbox({
    Name = "Nome da Playlist",
    Default = "",
    TextDisappear = true,
    Callback = function(value)
        musicPlayer.currentPlaylistName = value
    end
})

MsPlayer:AddButton({
    Name = "Criar Playlist",
    Callback = function()
        if musicPlayer.currentPlaylistName and musicPlayer.currentPlaylistName ~= "" then
            musicPlayer.playlists[musicPlayer.currentPlaylistName] = {}
            savePlaylist(musicPlayer.currentPlaylistName, musicPlayer.playlists[musicPlayer.currentPlaylistName])
            createNotification("Playlist", "Playlist criada com sucesso!", 3)
        else
            createNotification("Erro", "Insira um nome para a playlist.", 3)
        end
    end
})

MsPlayer:AddButton({
    Name = "Carregar Playlist",
    Callback = function()
        if musicPlayer.currentPlaylistName and musicPlayer.currentPlaylistName ~= "" then
            local loadedPlaylist = loadPlaylist(musicPlayer.currentPlaylistName)
            if loadedPlaylist then
                musicPlayer.currentPlaylist = loadedPlaylist
                createNotification("Playlist", "Playlist carregada com sucesso!", 3)
            else
                createNotification("Erro", "Playlist não encontrada.", 3)
            end
        else
            createNotification("Erro", "Insira o nome da playlist para carregar.", 3)
        end
    end
})

MsPlayer:AddButton({
    Name = "Salvar Playlist",
    Callback = function()
        if musicPlayer.currentPlaylistName and musicPlayer.currentPlaylist then
            savePlaylist(musicPlayer.currentPlaylistName, musicPlayer.currentPlaylist)
            createNotification("Playlist", "Playlist salva com sucesso!", 3)
        else
            createNotification("Erro", "Nenhuma playlist carregada para salvar.", 3)
        end
    end
})

MsPlayer:AddButton({
    Name = "Excluir Playlist",
    Callback = function()
        if musicPlayer.currentPlaylistName then
            deletePlaylist(musicPlayer.currentPlaylistName)
            musicPlayer.currentPlaylist = nil
            createNotification("Playlist", "Playlist excluída com sucesso!", 3)
        else
            createNotification("Erro", "Insira o nome da playlist para excluir.", 3)
        end
    end
})

MsPlayer:AddTextbox({
    Name = "Adicionar Música (Nome e Id) separados por vírgula)",
    Default = "",
    TextDisappear = true,
    Callback = function(value)
        if musicPlayer.currentPlaylist then
            local splitValue = string.split(value, ",")
            local musicData = { NAME = splitValue[1], Id = splitValue[2] }
            table.insert(musicPlayer.currentPlaylist, musicData)
            createNotification("Playlist", "Música adicionada à playlist.", 3)
        else
            createNotification("Erro", "Carregue uma playlist antes de adicionar músicas.", 3)
        end
    end
})

MsPlayer:AddLabel('<font color="#9DABFF">Playlist</font>')
MsPlayer:AddButton({
    Name = "Tocar Playlist",
    Callback = function()
        playMusic(musicPlayer.currentIndex > 0 and musicPlayer.currentIndex or 1)
    end
})

MsPlayer:AddButton({
    Name = "Próxima Música",
    Callback = function()
        local nextIndex = musicPlayer.currentIndex + 1
        if nextIndex > #musicPlayer.currentPlaylist then nextIndex = 1 end
        playMusic(nextIndex)
    end
})

MsPlayer:AddButton({
    Name = "Pausar",
    Callback = function()
        if musicPlayer.currentSound and musicPlayer.isPlaying then
            musicPlayer.currentSound:Pause()
            musicPlayer.isPlaying = false
            createNotification("Reprodutor", "Música pausada.", 3)
        else
            createNotification("Erro", "Nenhuma música está tocando ou já está pausada.", 3)
        end
    end
})

MsPlayer:AddLabel('<font color="#9DABFF">Player</font>')
local musicIdFromTextbox = ""
MsPlayer:AddTextbox({
    Name = "Música (ID do Roblox)",
    Default = "",
    TextDisappear = true,
    Callback = function(value)
        musicIdFromTextbox = value 
    end
})

MsPlayer:AddButton({
    Name = "Tocar",
    Callback = function()
        if musicIdFromTextbox == "" then
            createNotification("Erro", "Insira um ID válido no textbox.", 3)
            return
        end

        if musicPlayer.currentSound then
            musicPlayer.currentSound:Destroy()
        end

        local sound = Instance.new("Sound", game:GetService("Workspace"))
        sound.SoundId = "rbxassetid://" .. musicIdFromTextbox
        sound.Volume = musicPlayer.volume
        sound.Looped = false
        sound:Play()

        musicPlayer.isPlaying = true
        musicPlayer.currentSound = sound

        createNotification("Reprodutor", "Tocando música com ID: " .. musicIdFromTextbox, 3)

        sound.Ended:Connect(function()
            musicPlayer.isPlaying = false
            createNotification("Reprodutor", "Música finalizada.", 3)
        end)
    end
})

MsPlayer:AddButton({
    Name = "Pausar",
    Callback = function()
        if musicPlayer.currentSound and musicPlayer.isPlaying then
            musicPlayer.currentSound:Pause()
            musicPlayer.isPlaying = false
            createNotification("Reprodutor", "Música pausada.", 3)
        else
            createNotification("Erro", "Nenhuma música está tocando ou já está pausada.", 3)
        end
    end
})

MsPlayer:AddSlider({
    Name = "Volume",
    Min = 0,
    Max = 1,
    Default = 0.5,
    Color = Color3.fromRGB(255, 255, 255),
    Increment = 0.1,
    Callback = function(value)
        musicPlayer.volume = value
        if musicPlayer.currentSound then
            musicPlayer.currentSound.Volume = value
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

_G.MsdoorsLoaded = true
