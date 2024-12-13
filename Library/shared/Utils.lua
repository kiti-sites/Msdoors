local Utils = {}

function Utils:HttpGet(url)
    local success, result = pcall(function()
        return game:HttpGet(url)
    end)

    if not success then
        warn("[Utils] Falha ao baixar conteúdo de " .. url .. ": " .. result)
        return nil
    end
    return result
end

function Utils:SafeLoadString(content)
    local success, err = pcall(function()
        loadstring(content)()
    end)

    if not success then
        warn("[Utils] Erro ao executar script: " .. err)
    end
end

return Utils
