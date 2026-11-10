
-- MATCHA HUB MAIN LOADER

local CORE = "https://cdn.sourceb.in/bins/QojF6dPcSp/0"
local UI = "https://raw.githubusercontent.com/matchascriptz/Matcha-Hubs-Anime-Adventure/main/file.lua"

local function loadScript(url, name)
    task.spawn(function()
        local success, source = pcall(function()
            return game:HttpGet(url)
        end)

        if not success or type(source) ~= "string" or #source == 0 then
            warn("[Matcha] Failed to download " .. name)
            return
        end

        local compiled, fn = pcall(loadstring, source)

        if not compiled or type(fn) ~= "function" then
            warn("[Matcha] Failed to compile " .. name)
            return
        end

        local executed, err = pcall(fn)

        if not executed then
            warn("[Matcha] " .. name .. " error: " .. tostring(err))
        end
    end)
end

-- Start CORE in background
loadScript(CORE, "CORE")

-- Start GUI in background
loadScript(UI, "GUI")
