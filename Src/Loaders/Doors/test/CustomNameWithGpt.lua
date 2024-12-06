local plr = game.Players.LocalPlayer
local gui = plr:WaitForChild("PlayerGui")
local name = gui:FindFirstChild("NameUI"..plr.Name)
local ts = game:GetService("TweenService")
local rs = game:GetService("RunService")

local rng = function()
    return Random.new():NextNumber(0, 1)
end

local defaultText = "MSDOORS LOBBY" -- Texto padrão para o TextDeaths

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
        local baseName = "MS " .. plr.Name
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

    -- Função para reconfigurar todos os elementos
    local function reconfigureElements()
        local stuff = name:FindFirstChild("Stuff")
        if stuff and stuff:FindFirstChild("Frame") then
            -- Reconfigurar TextBadge
            local textBadge = stuff.Frame:FindFirstChild("TextBadge")
            if textBadge then
                textBadge.Text = "MsDoors"
                textBadge.TextColor3 = Color3.fromRGB(0, 255, 255)

                -- Atualizar gradiente do TextBadge
                local badgeGradient = textBadge:FindFirstChild("UIGradient") or Instance.new("UIGradient", textBadge)
                badgeGradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.new(1, 0, 0)),
                    ColorSequenceKeypoint.new(1, Color3.new(0, 0, 1))
                })

                -- Animar o gradiente
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
            end

            -- Reconfigurar IconBadge
            local iconBadge = stuff.Frame:FindFirstChild("IconBadge")
            if iconBadge then
                iconBadge.Image = "rbxassetid://100573561401335"
            else
                warn("IconBadge not found in Stuff.Frame")
            end

            -- Reconfigurar TextDeaths
            local textDeaths = stuff.Frame:FindFirstChild("TextDeaths")
            if textDeaths then
                textDeaths.TextColor3 = Color3.fromRGB(0, 255, 255) -- Cor ciano
                textDeaths.Text = defaultText
            else
                warn("TextDeaths not found in Stuff.Frame")
            end

            -- Reconfigurar visibilidade dos ícones
            local iconEscapesHolder = stuff.Frame:FindFirstChild("IconEscapesHolder")
            local iconDeathHolder = stuff.Frame:FindFirstChild("IconDeathHolder")

            if iconEscapesHolder and iconDeathHolder then
                iconEscapesHolder.Visible = true -- Mostrar
                iconDeathHolder.Visible = false -- Esconder
            else
                warn("IconEscapesHolder or IconDeathHolder not found in Stuff.Frame")
            end
        else
            warn("Stuff or Stuff.Frame not found in NameUI")
        end
    end

    -- Reconfigurar elementos inicialmente
    reconfigureElements()

    -- Monitorar alterações no texto e reconfigurar tudo
    local textDeaths = name:FindFirstChild("Stuff") and name.Stuff.Frame:FindFirstChild("TextDeaths")
    if textDeaths then
        task.spawn(function()
            while true do
                if textDeaths.Text ~= defaultText then
                    reconfigureElements() -- Reconfigura todos os elementos
                end
                task.wait(0.5) -- Intervalo de verificação
            end
        end)
    end
else
    warn("Name UI of player "..plr.Name.." not found!")
end
