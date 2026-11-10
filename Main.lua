local CORE = "https://cdn.sourceb.in/bins/QojF6dPcSp/0"
local UI = "https://raw.githubusercontent.com/matchascriptz/Matcha-Hubs-Anime-Adventure/main/file.lua"

if getgenv().MatchaRunning then
    pcall(function()
        if getgenv().MatchaCleanup then
            getgenv().MatchaCleanup()
        end
    end)
end

getgenv().MatchaRunning = true

local function run(url, label)
    local ok, body = pcall(function()
        return game:HttpGet(url)
    end)

    if not ok or type(body) ~= "string" or #body < 32 then
        warn("[Matcha] Download failed: " .. label)
        return
    end

    local fn, err = loadstring(body)

    if not fn then
        warn("[Matcha] Syntax error: " .. tostring(err))
        return
    end

    local success, result = pcall(fn)

    if not success then
        warn("[Matcha] Runtime error: " .. tostring(result))
    end
end

task.spawn(run, CORE, "Core")
task.spawn(run, UI, "UI")
