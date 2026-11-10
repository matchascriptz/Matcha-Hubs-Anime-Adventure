
-- MATCHA HUB MAIN LOADER

local CORE = "https://cdn.sourceb.in/bins/QojF6dPcSp/0"

local UI = "https://raw.githubusercontent.com/matchascriptz/Matcha-Hubs-Anime-Adventure/main/file.lua"

local function run(url, name)
    task.spawn(function()
        local success, body = pcall(function()
            return game:HttpGet(url)
        end)

        if not success or type(body) ~= "string" then
            warn("[Matcha] Download failed: " .. name)
            return
        end

        local fn, err = loadstring(body)

        if not fn then
            warn("[Matcha] Compile error: " .. tostring(err))
            return
        end

        local executed, result = pcall(fn)

        if not executed then
            warn("[Matcha] Execution error: " .. tostring(result))
        end
    end)
end

run(CORE, "Background")
run(UI, "Visual GUI")
