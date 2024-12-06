local function getTimeBasedMessage()
    local hour = os.date("*t").hour
    local date = os.date("*t")
    local day = date.day
    local month = date.month
    local greetings = ""

    if month == 12 and day >= 24 and day <= 26 then
        greetings = "FELIZ NATAL! 🎄"
    elseif month == 10 and day >= 30 and day <= 31 then
        greetings = "FELIZ HALLOWEEN! 🎃"
    elseif hour >= 6 and hour < 12 then
        greetings = "BOM DIA"
    elseif hour >= 12 and hour < 18 then
        greetings = "BOA TARDE"
    elseif hour >= 18 or hour < 6 then
        greetings = "BOA NOITE"
    else
        greetings = "OLÁ!"
    end

    return greetings, string.format("%02d:%02d:%02d", hour, os.date("*t").min, os.date("*t").sec)
end

local function getRobloxVersion()
    local version = game:GetService("VersionControlService"):GetRobloxVersionAsync()
    return version or "Versão desconhecida"
end

local function printBanner()
    local greeting, currentTime = getTimeBasedMessage()
    local robloxVersion = getRobloxVersion()
    local banner = [[
                                                                                                                     
     ______  _______            ______       _____           _____            _____         _____            ______  
    |      \/       \       ___|\     \  ___|\    \     ____|\    \      ____|\    \    ___|\    \       ___|\     \ 
   /          /\     \     |    |\     \|    |\    \   /     /\    \    /     /\    \  |    |\    \     |    |\     \
  /     /\   / /\     |    |    |/____/||    | |    | /     /  \    \  /     /  \    \ |    | |    |    |    |/____/|
 /     /\ \_/ / /    /| ___|    \|   | ||    | |    ||     |    |    ||     |    |    ||    |/____/  ___|    \|   | |
|     |  \|_|/ /    / ||    \    \___|/ |    | |    ||     |    |    ||     |    |    ||    |\    \ |    \    \___|/ 
|     |       |    |  ||    |\     \    |    | |    ||\     \  /    /||\     \  /    /||    | |    ||    |\     \    
|\____\       |____|  /|\ ___\|_____|   |____|/____/|| \_____\/____/ || \_____\/____/ ||____| |____||\ ___\|_____|   
| |    |      |    | / | |    |     |   |    /    | | \ |    ||    | / \ |    ||    | /|    | |    || |    |     |   
 \|____|      |____|/   \|____|_____|   |____|____|/   \|____||____|/   \|____||____|/ |____| |____| \|____|_____|   
    \(          )/         \(    )/       \(    )/        \(    )/         \(    )/      \(     )/      \(    )/     
     '          '           '    '         '    '          '    '           '    '        '     '        '    '      
                                                                                                                     
                                        Por Rhyan57 💜
    ]]

    print(banner)
    print("\nOi! " .. greeting)
    print("Horário Atual: " .. currentTime)
    print("Versão do Roblox: " .. robloxVersion)
end

printBanner()

