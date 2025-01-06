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
local OrionLib = loadstring(game:HttpGetAsync('https://raw.githubusercontent.com/Sc-Rhyan57/Msdoors/refs/heads/main/Library/OrionLibrary_msdoors.lua'))()
local ESPLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/MS-ESP/refs/heads/main/source.lua"))()
local Window = OrionLib:MakeWindow({IntroText = "Msdoors | V1 ",Icon = "rbxassetid://100573561401335", IntroIcon = "rbxassetid://95869322194132", Name = "MsDoors | Carrinho + Cart Para GigaNoob!", HidePremium = false, SaveConfig = true, ConfigFolder = ".msdoors/places/carrinhoCartGiganoob"})

--// Player ESP \\--
local ESPEnabled = false
local ESPObjects = {}
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Helper functions
local function getDistance(from, to)
    return math.floor((from.Position - to.Position).Magnitude)
end

local function getRGB()
    local hue = tick() % 5 / 5
    return Color3.fromHSV(hue, 1, 1)
end

local function createBillboard(player, rootPart)
    local billboard = Instance.new("BillboardGui")
    billboard.Adornee = rootPart
    billboard.Size = UDim2.new(4, 0, 2, 0)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = game.CoreGui

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.3, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextScaled = true
    nameLabel.Text = player.Name
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.Parent = billboard

    local infoLabel = Instance.new("TextLabel")
    infoLabel.Size = UDim2.new(1, 0, 0.3, 0)
    infoLabel.Position = UDim2.new(0, 0, 0.3, 0)
    infoLabel.BackgroundTransparency = 1
    infoLabel.TextScaled = true
    infoLabel.Font = Enum.Font.SourceSansBold
    infoLabel.Parent = billboard

    return billboard, nameLabel, infoLabel
end

local function createESP(player, character)
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not rootPart or not humanoid then return end

    local billboard, nameLabel, infoLabel = createBillboard(player, rootPart)

    local box = Instance.new("BoxHandleAdornment")
    box.Adornee = character
    box.Size = Vector3.new(4, 7, 4)
    box.Color3 = getRGB()
    box.Transparency = 0.6
    box.AlwaysOnTop = true
    box.ZIndex = 2
    box.Parent = game.CoreGui

    local line = Drawing.new("Line")
    line.Color = getRGB()
    line.Thickness = 2
    line.Visible = true

    local function update()
        if not ESPEnabled or not character.Parent or not rootPart:IsDescendantOf(workspace) then
            removeESP(player)
            return
        end

        local screenPos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
        if onScreen then
            line.Visible = true
            line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
            line.To = Vector2.new(screenPos.X, screenPos.Y)

            nameLabel.TextColor3 = getRGB()
            box.Color3 = getRGB()

            local distance = getDistance(Camera.CFrame, rootPart.CFrame)
            infoLabel.Text = string.format("Health: %d | Distance: %d", math.floor(humanoid.Health), distance)
        else
            line.Visible = false
        end
    end

    local connection = RunService.RenderStepped:Connect(update)
    ESPObjects[player] = {Billboard = billboard, Box = box, Line = line, Connection = connection}
end

local function removeESP(player)
    local espObject = ESPObjects[player]
    if espObject then
        espObject.Billboard:Destroy()
        espObject.Box:Destroy()
        espObject.Line:Remove()
        espObject.Connection:Disconnect()
        ESPObjects[player] = nil
    end
end

local function handlePlayer(player)
    if player.Character then
        createESP(player, player.Character)
    end

    player.CharacterAdded:Connect(function(character)
        removeESP(player)
        createESP(player, character)
    end)

    player.CharacterRemoving:Connect(function()
        removeESP(player)
    end)
end

local function toggleESP(state)
    ESPEnabled = state
    if ESPEnabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                handlePlayer(player)
            end
        end
    else
        for player, _ in pairs(ESPObjects) do
            removeESP(player)
        end
    end
end

-- Player connections
Players.PlayerAdded:Connect(function(player)
    if ESPEnabled then
        handlePlayer(player)
    end
end)

Players.PlayerRemoving:Connect(removeESP)

--\\ FIM //--

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

local MainTab = Window:MakeTab({
    Name = "Extras",
    Icon = "rbxassetid://7734068495",
    PremiumOnly = false
})

local Section = MainTab:AddSection({
    Name = "Teleporte"
})

MainTab:AddDropdown({
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


MainTab:AddToggle({
    Name = "Players esp",
    Default = false,
    Callback = function(value)
        toggleESP(value)
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
