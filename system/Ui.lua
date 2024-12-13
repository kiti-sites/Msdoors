local repo = 'https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/'

if getgenv().ActiveUI then
    getgenv().ActiveUI.Library:Unload()
end

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

Library.ShowCustomCursor = true
Library.NotifySide = "Left"

if getgenv().LoadUI ~= false then
    local Window = Library:CreateWindow({
        Title = 'Msdoors v1 | (BETA)',
        Center = true,
        AutoShow = true,
    })

    SaveManager:SetLibrary(Library)
    SaveManager:SetFolder('msdoors')

    ThemeManager:SetLibrary(Library)
    SaveManager:BuildConfigSection(Window:AddTab('Configurações'))
    ThemeManager:ApplyToTab(Window:AddTab('Temas'))
end

getgenv().ActiveUI = {
    Library = Library,
    ThemeManager = ThemeManager,
    SaveManager = SaveManager
}

return getgenv().ActiveUI
