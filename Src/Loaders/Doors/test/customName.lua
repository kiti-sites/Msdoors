local plr = game.Players.LocalPlayer
local gui = plr.PlayerGui
local name = gui:FindFirstChild("NameUI"..plr.Name)
local ts = game:GetService("TweenService")
local rs = game:GetService("RunService")
local rng = function()
  return Random.new():NextNumber(0, 1)
end
if name then
  local stuff = name.Stuff.Frame
  while task.wait(1) do
    stuff.TextBadge.Text = "MS Doors"
    stuff.TextBadge.TextColor3 = Color3.fromRGB(0, 150, 255)
    ts:Create(name.Username, TweenInfo.new(1), {TextColor3 = Color3.new(rng(), rng(), rng())}):Play()
  end
else
  warn("Name UI of player "..plr.." not found!")
end
