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
local HttpService = game:GetService("HttpService")
local musicPlayer = {
    isPlaying = false,
    currentSound = nil,
    currentPlaylist = nil,
    playlists = {},
    currentIndex = 0,
    volume = 0.5,
    folderName = ".msdoors",
}

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

local JeepsTab = ExploitTab:AddSection({
	Name = "Jeeps"
})

JeepsTab:AddToggle({
    Name = "Spam Spawn Jeeps",
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

local MsPlayer = Window:MakeTab({
    Name = "Musica",
    Icon = "rbxassetid://7734020554",
    PremiumOnly = false
})

MsPlayer:AddLabel("Gerenciar Playlist")

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

MsPlayer:AddLabel("Playe(Playlist)")
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

MsPlayer:AddLabel("Player")
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

MsPlayer:AddButton({
    Name = "Próxima Música",
    Callback = function()
        local nextIndex = musicPlayer.currentIndex + 1
        if nextIndex > #musicPlayer.currentPlaylist then nextIndex = 1 end
        playMusic(nextIndex)
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
