local plr = game.Players.LocalPlayer
local gui = plr.PlayerGui
local name = gui:FindFirstChild("NameUI"..plr.Name)
local ts = game:GetService("TweenService")
local rs = game:GetService("RunService")
local rng = function()
  return Random.new():NextNumber(0, 1)
end
if name then
  rs.RenderStepped:Connect(function ()
      --[[
      local namegradient = Instance.new("UIGradient",name.Username)
      namegradient.Color = ColorSequence({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255 ,255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 150 ,255))})
      ]]
      name.Username.Text = "MS "..plr.Name
      local stuff = name.Stuff.Frame
      stuff.TextBadge.Text = "MS User"
      stuff.TextBadge.Color = Color3.fromRGB(0, 150 ,255)
      --stuff.TextBadge.ThemeGradient.Color = ColorSequence({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255 ,255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 150 ,255))})
      stuff.TextDeaths.Text = "inf"
      ts:Create(name.Username, TweenInfo.new(0.1), {TextColor3 = Color3.new(rng(), rng(), rng())}):Play()
  end)
else
  warn("Name UI of player "..plr.." not found!")
end
