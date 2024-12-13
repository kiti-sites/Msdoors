local repo = 'https://raw.githubusercontent.com/usuario/repositorio/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

-- Configurações básicas
Library.ShowCustomCursor = true
Library.NotifySide = "Left"

local Window = Library:CreateWindow({
    Title = 'Msdoors v1 | (BETA)',
    Center = true,
    AutoShow = true,
})

-- Configurações de tema e salvamento
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:SetFolder('msdoors')

-- Aplica tema e configurações
SaveManager:BuildConfigSection(Window:AddTab('Configurações'))
ThemeManager:ApplyToTab(Window:AddTab('Temas'))

return {
    Library = Library,
    ThemeManager = ThemeManager,
    SaveManager = SaveManager
}

