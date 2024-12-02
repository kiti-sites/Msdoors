local OrionLib = loadstring(game:HttpGetAsync('https://raw.githubusercontent.com/Giangplay/Script/main/Orion_Library_PE_V2.lua'))()
local Window = OrionLib:MakeWindow({IntroText = "Msdoors | V1 ",Icon = "rbxassetid://100573561401335", IntroIcon = "rbxassetid://95869322194132", Name = "MsDoors | PRE HOTEL Lobby", HidePremium = false, SaveConfig = true, ConfigFolder = ".msdoors/places/Oldlobby"})

--[[ APIS ]]--
local MsdoorsNotify = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sc-Rhyan57/Notification-doorsAPI/refs/heads/main/Msdoors/MsdoorsApi.lua"))()

local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://4590656842"
sound.Volume = 2
sound.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
sound:Play()
sound.Ended:Connect(function()
    sound:Destroy()
end)

MsdoorsNotify("Msdoors", "Script Inicializado.", "Execução", "rbxassetid://6023426923", Color3.new(128, 0, 128), 5)



local MSoldLobby = Window:MakeTab({
	Name = "Funções",
	Icon = "rbxassetid://7733924046",
	PremiumOnly = false
})

MSoldLobby:AddButton({
	Name = "Teleport to PRE HOTEL LOBBY",
	Callback = function()
		game:GetService("TeleportService"):Teleport(110258689672367)
	end    
})

MSoldLobby:AddButton({
	Name = "Teleport to HOTEL LOBBY",
	Callback = function()
		game:GetService("TeleportService"):Teleport(6516141723)
	end    
})

OrionLib:Init()
