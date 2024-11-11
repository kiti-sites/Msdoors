local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = OrionLib:MakeWindow({Name = "Teleport Menu", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTeleport"})

local MSoldLobby = Window:MakeTab({
	Name = "",
	Icon = "rbxassetid://4483345998",
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
