local plr = game.Players.LocalPlayer
local gui = plr.PlayerGui
local name = gui:FindFirstChild("NameUI"..plr.Name)
local ts = game:GetService("TweenService")
local rs = game:GetService("RunService")
if name then
  local stuff = name.Stuff.Frame
  rs.RenderStepped:Connect(function ()
      name.Username.Text = "MS "..plr.Name
      stuff.TextBadge.Text = "MS Doors"
      stuff.TextBadge.TextColor3 = Color3.fromRGB(0, 150, 255)
  end)
else
  warn("Name UI of player "..plr.." not found!")
end
