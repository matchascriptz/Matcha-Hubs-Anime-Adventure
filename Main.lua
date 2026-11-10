
-- MATCHA HUB | MAIN LOADER

local CORE = "https://cdn.sourceb.in/bins/QojF6dPcSp/0"

local UI = "https://raw.githubusercontent.com/matchascriptz/Matcha-Hubs-Anime-Adventure/main/file.lua"

local function downloadAndCheck(url, name)
    local success, body = pcall(function()
        return game:HttpGet(url)
    end)

    if not success then
        warn("[Matcha] Download failed: " .. name .. ": " .. tostring(body))
        return nil
    end

    if type(body) ~= "string" or #body < 32 then
        warn("[Matcha] Invalid response: " .. name)
        return nil
    end

    return body
end

local function run(url, name)
    task.spawn(function()
        local body = downloadAndCheck(url, name)
        if not body then return end

        local fn, err = loadstring(body)

        if not fn then
            warn("[Matcha] Syntax error: " .. tostring(err))
            return
        end

        local success, result = pcall(fn)

        if not success then
            warn("[Matcha] Runtime error: " .. tostring(result))
        end
    end)
end

-- Start each script once
run(CORE, "Background")
run(UI, "Visual GUI")
