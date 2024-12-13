local repo = 'https://raw.githubusercontent.com/usuario/repositorio/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

Library.ShowCustomCursor = true
Library.NotifySide = "Left"

local Window = Library:CreateWindow({
    Title = 'Msdoors v1 | (BETA)',
    Center = true,
    AutoShow = true,
})

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:SetFolder('msdoors')

SaveManager:BuildConfigSection(Window:AddTab('Configurações'))
ThemeManager:ApplyToTab(Window:AddTab('Temas'))

return {
    Library = Library,
    ThemeManager = ThemeManager,
    SaveManager = SaveManager
}

