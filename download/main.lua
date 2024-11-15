local url = "https://github.com/Sc-Rhyan57/Msdoors/releases/download/Msdoors/msdoors-download.lua"
local response = game:HttpGet(url, true)
local script = loadstring(response)
script()
