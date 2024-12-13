local repo = 'https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/'

if getgenv().ActiveUI then
    getgenv().ActiveUI.Library:Unload()
end

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

Library.ShowCustomCursor = true
Library.NotifySide = "Left"

getgenv().ActiveUI = {
    Library = Library,
    ThemeManager = ThemeManager,
    SaveManager = SaveManager
}

local function SetupTabs(Window)
    if not Window then return end 

    local ConfigTab = Window:AddTab('Configurações')
    SaveManager:SetLibrary(Library)
    SaveManager:SetFolder('msdoors')
    SaveManager:BuildConfigSection(ConfigTab)

    local ThemeTab = Window:AddTab('Temas')
    ThemeManager:SetLibrary(Library)
    ThemeManager:ApplyToTab(ThemeTab)
end

if getgenv().ActiveUI.Window then
    SetupTabs(getgenv().ActiveUI.Window)
end

return getgenv().ActiveUI
