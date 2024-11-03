local url = "https://github.com/Sc-Rhyan57/Msdoors/releases/download/MsdoorsLoad/Msdoors.lua"
local response = game:HttpGet(url, true)
local script = loadstring(response)
script()
