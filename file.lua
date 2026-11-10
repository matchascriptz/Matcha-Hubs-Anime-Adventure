
-- MATCHA HUB | PREMIUM PURPLE EDITION
-- Interface controls and presentation only

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("MatchaHubTest")
if old then old:Destroy() end

local C = {
    Background = Color3.fromRGB(19, 16, 27),
    Main = Color3.fromRGB(29, 24, 39),
    Sidebar = Color3.fromRGB(35, 28, 47),
    Card = Color3.fromRGB(45, 36, 59),
    CardHover = Color3.fromRGB(57, 44, 74),
    Purple = Color3.fromRGB(171, 119, 239),
    LightPurple = Color3.fromRGB(211, 179, 255),
    White = Color3.fromRGB(248, 243, 255),
    Muted = Color3.fromRGB(168, 154, 187),
    Green = Color3.fromRGB(128, 220, 171)
}

local function corner(object, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius)
    c.Parent = object
end

local function stroke(object, color, transparency)
    local s = Instance.new("UIStroke")
    s.Color = color
    s.Transparency = transparency or 0
    s.Thickness = 1
    s.Parent = object
end

local function label(parent, text, pos, size, fontSize, color, font)
    local l = Instance.new("TextLabel")
    l.BackgroundTransparency = 1
    l.Position = pos
    l.Size = size
    l.Text = text
    l.TextColor3 = color
    l.TextSize = fontSize
    l.Font = font or Enum.Font.Gotham
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.TextYAlignment = Enum.TextYAlignment.Center
    l.TextWrapped = true
    l.Parent = parent
    return l
end

local gui = Instance.new("ScreenGui")
gui.Name = "MatchaHubTest"
gui.ResetOnSpawn = false
gui.DisplayOrder = 50
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(690, 445)
main.Position = UDim2.new(0.5, -345, 0.5, -222)
main.BackgroundColor3 = C.Background
main.BorderSizePixel = 0
main.Parent = gui
corner(main, 14)
stroke(main, C.Purple, 0.45)

-- HEADER
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 65)
header.BackgroundColor3 = C.Main
header.BorderSizePixel = 0
header.Parent = main
corner(header, 14)

local accent = Instance.new("Frame")
accent.Size = UDim2.new(1, 0, 0, 3)
accent.Position = UDim2.new(0, 0, 1, -3)
accent.BackgroundColor3 = C.Purple
accent.BorderSizePixel = 0
accent.Parent = header

label(header, "✦  MATCHA HUB", UDim2.fromOffset(20, 7),
    UDim2.fromOffset(260, 30), 21, C.LightPurple, Enum.Font.GothamBold)

label(header, "ANIME ADVENTURES  •  PURPLE EDITION",
    UDim2.fromOffset(22, 36), UDim2.fromOffset(320, 18),
    9, C.Muted, Enum.Font.GothamMedium)

local status = label(header, "●  INTERFACE READY",
    UDim2.new(1, -180, 0, 20), UDim2.fromOffset(135, 24),
    10, C.Green, Enum.Font.GothamBold)
status.TextXAlignment = Enum.TextXAlignment.Right

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(32, 32)
close.Position = UDim2.new(1, -45, 0, 16)
close.BackgroundColor3 = C.Card
close.Text = "×"
close.TextColor3 = C.White
close.TextSize = 23
close.Font = Enum.Font.Gotham
close.Parent = header
corner(close, 8)

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- SIDEBAR
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 165, 1, -82)
sidebar.Position = UDim2.fromOffset(10, 72)
sidebar.BackgroundColor3 = C.Sidebar
sidebar.BorderSizePixel = 0
sidebar.Parent = main
corner(sidebar, 11)

label(sidebar, "NAVIGATION", UDim2.fromOffset(15, 12),
    UDim2.new(1, -25, 0, 22), 10, C.Muted, Enum.Font.GothamBold)

local content = Instance.new("Frame")
content.Size = UDim2.new(1, -190, 1, -82)
content.Position = UDim2.fromOffset(180, 72)
content.BackgroundColor3 = C.Main
content.BorderSizePixel = 0
content.ClipsDescendants = true
content.Parent = main
corner(content, 11)

-- PAGE DATA
local data = {
    ["Home"] = {
        "Welcome back",
        "Your Matcha Hub dashboard.",
        {
            {"Hub Version", "Purple Edition"},
            {"Interface", "Successfully loaded"},
            {"Theme", "Lavender Night"}
        }
    },
    ["Trait Management"] = {
        "Trait Management",
        "Manage your trait interface preferences.",
        {
            {"Trait Reroll", "Reroll menu preference"},
            {"Trait Rollback", "Rollback menu preference"},
            {"Trait Options", "Additional trait settings"}
        }
    },
    ["Auto Farm"] = {
        "Auto Farm",
        "Your farming interface preferences.",
        {
            {"Auto Farm", "Farm interface switch"},
            {"Farm Settings", "Configure displayed preferences"},
            {"Farm Options", "Additional options"}
        }
    },
    ["Teleport"] = {
        "Teleport",
        "Quick access to destination preferences.",
        {
            {"Lobby", "Lobby destination"},
            {"Summon Area", "Summon destination"},
            {"Upgrade Area", "Upgrade destination"}
        }
    },
    ["Settings"] = {
        "Settings",
        "Personalize your Matcha experience.",
        {
            {"Purple Theme", "Lavender color scheme"},
            {"Interface Effects", "Interface appearance"},
            {"Compact Mode", "Display preference"}
        }
    },
    ["Miscellaneous"] = {
        "Miscellaneous",
        "Additional Matcha preferences.",
        {
            {"Extra Options", "Additional interface options"},
            {"Notifications", "Notification preference"},
            {"About Matcha", "Hub information"}
        }
    }
}

local pages = {}
local tabs = {}
local names = {
    "Home",
    "Trait Management",
    "Auto Farm",
    "Teleport",
    "Settings",
    "Miscellaneous"
}

-- CREATE PAGES
local function createCard(page, title, description, y)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, -30, 0, 76)
    card.Position = UDim2.fromOffset(15, y)
    card.BackgroundColor3 = C.Card
    card.BorderSizePixel = 0
    card.Parent = page
    corner(card, 10)
    stroke(card, C.Purple, 0.8)

    local dot = Instance.new("Frame")
    dot.Size = UDim2.fromOffset(7, 7)
    dot.Position = UDim2.fromOffset(14, 17)
    dot.BackgroundColor3 = C.Purple
    dot.BorderSizePixel = 0
    dot.Parent = card
    corner(dot, 10)

    label(card, title, UDim2.fromOffset(30, 9),
        UDim2.new(1, -120, 0, 25), 13, C.White, Enum.Font.GothamBold)

    label(card, description, UDim2.fromOffset(30, 37),
        UDim2.new(1, -120, 0, 22), 10, C.Muted)

    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.fromOffset(55, 27)
    toggle.Position = UDim2.new(1, -70, 0.5, -13)
    toggle.BackgroundColor3 = Color3.fromRGB(66, 56, 77)
    toggle.Text = "OFF"
    toggle.TextColor3 = C.White
    toggle.TextSize = 10
    toggle.Font = Enum.Font.GothamBold
    toggle.BorderSizePixel = 0
    toggle.Parent = card
    corner(toggle, 8)

    local enabled = false

    toggle.MouseButton1Click:Connect(function()
        enabled = not enabled

        TweenService:Create(toggle,
            TweenInfo.new(0.18),
            {
                BackgroundColor3 = enabled and C.Purple
                    or Color3.fromRGB(66, 56, 77)
            }
        ):Play()

        toggle.Text = enabled and "ON" or "OFF"
    end)

    card.MouseEnter:Connect(function()
        TweenService:Create(card, TweenInfo.new(0.12), {
            BackgroundColor3 = C.CardHover
        }):Play()
    end)

    card.MouseLeave:Connect(function()
        TweenService:Create(card, TweenInfo.new(0.12), {
            BackgroundColor3 = C.Card
        }):Play()
    end)
end

for index, name in ipairs(names) do
    local info = data[name]

    local page = Instance.new("ScrollingFrame")
    page.Name = name .. "Page"
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = C.Purple
    page.CanvasSize = UDim2.new(0, 0, 0, 360)
    page.Visible = false
    page.Parent = content
    pages[name] = page

    label(page, info[1], UDim2.fromOffset(17, 13),
        UDim2.new(1, -30, 0, 32), 20, C.White, Enum.Font.GothamBold)

    label(page, info[2], UDim2.fromOffset(18, 46),
        UDim2.new(1, -35, 0, 25), 10, C.Muted)

    for i, item in ipairs(info[3]) do
        createCard(page, item[1], item[2], 85 + (i - 1) * 86)
    end

    local tab = Instance.new("TextButton")
    tab.Size = UDim2.new(1, -16, 0, 42)
    tab.Position = UDim2.fromOffset(8, 42 + (index - 1) * 48)
    tab.BackgroundColor3 = C.Card
    tab.Text = name
    tab.TextColor3 = C.Muted
    tab.TextSize = 11
    tab.Font = Enum.Font.GothamSemibold
    tab.TextWrapped = true
    tab.BorderSizePixel = 0
    tab.Parent = sidebar
    corner(tab, 8)
    tabs[name] = tab

    tab.MouseButton1Click:Connect(function()
        for pageName, otherPage in pairs(pages) do
            otherPage.Visible = pageName == name
        end

        for tabName, otherTab in pairs(tabs) do
            otherTab.BackgroundColor3 =
                tabName == name and C.Purple or C.Card
            otherTab.TextColor3 =
                tabName == name and C.White or C.Muted
        end
    end)
end

-- HOME PAGE EXTRA STATUS CARD
local home = pages["Home"]
local infoCard = Instance.new("Frame")
infoCard.Size = UDim2.new(1, -30, 0, 65)
infoCard.Position = UDim2.fromOffset(15, 350)
infoCard.BackgroundColor3 = C.Card
infoCard.BorderSizePixel = 0
infoCard.Parent = home
corner(infoCard, 10)

label(infoCard, "✦  MATCHA HUB",
    UDim2.fromOffset(13, 7), UDim2.new(1, -25, 0, 23),
    12, C.LightPurple, Enum.Font.GothamBold)

label(infoCard, "Made with a little purple magic.",
    UDim2.fromOffset(13, 32), UDim2.new(1, -25, 0, 20),
    10, C.Muted)

-- INITIAL PAGE
pages["Home"].Visible = true
tabs["Home"].BackgroundColor3 = C.Purple
tabs["Home"].TextColor3 = C.White

print("[Matcha Hub] Premium interface loaded!")
