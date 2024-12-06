warn("RHYAN MANDOU VOCÊ PRA CASA DO CARALHO - ")
local plr = game.Players.LocalPlayer
local gui = plr:WaitForChild("PlayerGui")
local name = gui:FindFirstChild("NameUI"..plr.Name)
local ts = game:GetService("TweenService")
local rs = game:GetService("RunService")

local rng = function()
    return Random.new():NextNumber(0, 1)
end

if name then
    -- Criar gradiente dinâmico no Username
    local usernameLabel = name:FindFirstChild("Username")
    if usernameLabel then
        local gradient = Instance.new("UIGradient", usernameLabel)
        gradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
            ColorSequenceKeypoint.new(1, Color3.new(0, 0.5, 1))
        })
        gradient.Rotation = 0 -- Iniciar em 0 graus

        -- Loop para animação do gradiente
        task.spawn(function()
            while true do
                ts:Create(gradient, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                    Rotation = gradient.Rotation + 180
                }):Play()
                wait(1)
            end
        end)
    end

    -- Configurar animação do nome
    local function animateUsername()
        local baseName = "[ MS ]" .. plr.Name
        local animationStates = {}

        -- Criar estados de animação para o nome
        for i = 1, #baseName do
            table.insert(animationStates, baseName:sub(1, i) .. "_")
        end
        for i = #baseName, 1, -1 do
            table.insert(animationStates, baseName:sub(1, i) .. "_")
        end

        -- Loop para animar o nome do jogador
        while true do
            for _, state in ipairs(animationStates) do
                usernameLabel.Text = state

                -- Alterar cor dinamicamente
                ts:Create(usernameLabel, TweenInfo.new(0.2), {
                    TextColor3 = Color3.new(rng(), rng(), rng())
                }):Play()

                wait(0.2)
            end
        end
    end

    task.spawn(animateUsername)

    -- Configurar gradiente dinâmico no TextBadge
    local stuff = name:FindFirstChild("Stuff")
    if stuff and stuff:FindFirstChild("Frame") then
        local textBadge = stuff.Frame:FindFirstChild("TextBadge")
        if textBadge then
            textBadge.Text = "MsDoors"
            
            -- Adicionar gradiente dinâmico ao TextBadge
            local badgeGradient = Instance.new("UIGradient", textBadge)
            badgeGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.new(1, 0, 0)),
                ColorSequenceKeypoint.new(1, Color3.new(0, 0, 1))
            })
            
            -- Atualizar gradiente dinamicamente
            task.spawn(function()
                while true do
                    ts:Create(badgeGradient, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                        Color = ColorSequence.new({
                            ColorSequenceKeypoint.new(0, Color3.new(rng(), rng(), rng())),
                            ColorSequenceKeypoint.new(1, Color3.new(rng(), rng(), rng()))
                        })
                    }):Play()
                    wait(1)
                end
            end)
        else
            warn("TextBadge not found in Stuff.Frame")
        end
    else
        warn("Stuff or Stuff.Frame no
t found in NameUI")
    end
else
    warn("Name UI of player "..plr.Name.." not found!")
  end
