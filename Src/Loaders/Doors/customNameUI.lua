local plr = game.Players.LocalPlayer
local gui = plr.PlayerGui
local name = gui:FindFirstChild("NameUI"..plr.Name)
local ts = game:GetService("TweenService")
local rs = game:GetService("RunService")
local rng = function()
  return Color3.new(Random.new():NextNumber(0, 1), Random.new():NextNumber(0, 1), Random.new():NextNumber(0, 1))
end
local textcolor = rng()
local times = 0
if name then
  rs.RenderStepped:Connect(function ()
      name.Username.Text = "MS "..plr.Name
      local stuff = name.Stuff.Frame
      stuff.TextBadge.Text = "MS Doors"
      stuff.TextBadge.TextColor3 = Color3.fromRGB(0, 150 ,255)
      ts:Create(name.Username, TweenInfo.new(0.2), {TextColor3 = Color3.new(rng(), rng(), rng())}):Play()
      times += 1
      if times >= 1000 then
        textcolor = rng()
      end
  end)
else
  warn("Name UI of player "..plr.." not found!")
end
