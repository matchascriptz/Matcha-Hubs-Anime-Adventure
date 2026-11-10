-- Main.lua  (replace the 71-byte pointer with this)
local CORE = "https://cdn.sourceb.in/bins/QojF6dPcSp/0"
local UI = "https://raw.githubusercontent.com/matchascriptz/Matcha-Hubs-Anime-Adventure/main/file.lua"

if getgenv().MatchaRunning then
    pcall(function() if getgenv().MatchaCleanup then getgenv().MatchaCleanup() end end)
end
getgenv().MatchaRunning = true

local function run(url, label)
    local ok, body = pcall(game.HttpGet, game, url, true) -- true = bypass executor cache
    if not ok or type(body) ~= "string" or #body < 32 then
        warn(("[Matcha] %s failed to download: %s"):format(label, tostring(body)))
        return
    end
    local fn, err = loadstring(body, "Matcha_" .. label)
    if not fn then warn(("[Matcha] %s syntax error: %s"):format(label, err)) return end
    local ok2, e = pcall(fn)
    if not ok2 then warn(("[Matcha] %s runtime error: %s"):format(label, e)) end
end

run(CORE, "Core")  -- its GUI is built first, so yours paints above it
run(UI,   "UI")
