print("[Matcha] Loader started")

local url = "https://raw.githubusercontent.com/matchascriptz/Matcha-Hubs-Anime-Adventure/main/file.lua"

local success, result = pcall(function()
    local source = game:HttpGet(url)
    assert(type(source) == "string" and #source > 0, "Empty download")

    local script, err = loadstring(source)
    assert(script, err)

    script()
end)

if success then
    print("[Matcha] GUI script executed")
else
    warn("[Matcha] ERROR: " .. tostring(result))
end
