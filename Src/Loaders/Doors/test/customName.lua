local plr = game.Players.LocalPlayer
local gui = plr.PlayerGui
local name = gui:FindFirstChild("NameUI"..plr.Name)
local rs = game:GetService("RunService")
local ng = require(107216037571494)()
if name then
  local stuff = name.Stuff.Frame
  ng.Parent = name.Username
  rs.RenderStepped:Connect(function ()
      name.Username.Text = "MS "..plr.Name
      stuff.TextBadge.Text = "MS Doors"
      stuff.TextBadge.TextColor3 = Color3.fromRGB(0, 150 ,255)
      ng.Rotation += 0.2
  end)
else
  warn("Name UI of player "..plr.." not found!")
end
