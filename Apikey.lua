local HttpService = game:GetService("HttpService")
local userId = game.Players.LocalPlayer.UserId
local key = "SUA_KEY_AQUI"

local response = HttpService:GetAsync("https://script.google.com/macros/s/AKfycbx98I7GwDX8aCk2EKDbvjEqEAozhZMWmTfW7LBNCwXK9qIp_e6QzfbgFyDS8ojfzolcHQ/exec?action=validate&userId=" .. userId .. "&key=" .. key)
if response == "Validado" then
    print("Acesso liberado!")
else
    print("Key inválida ou usuário na blacklist.")
end
