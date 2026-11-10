
-- MATCHA HUB | Visual GUI
-- Visual-only interface. No game actions are performed.

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

-- Remove previous copy
local parent
if gethui then
    parent = gethui()
else
    parent = player:WaitForChild("PlayerGui")
end

local old = parent:FindFirstChild("MatchaHubVisual")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "MatchaHubVisual"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = parent

local purple = Color3.fromRGB(164, 112, 235)
local dark = Color3.fromRGB(24, 21, 32)
local panel = Color3.fromRGB(35, 30, 46)
local textColor = Color3.fromRGB(245, 238, 255)
local muted = Color3.fromRGB(174, 158, 195)

local function create(class, props, parentObject)
    local obj = Instance.new(class)
    for k, v in pairs(props) do
        obj[k] = v
    end
    obj.Parent = parentObject
    return obj
end

local main = create("Frame", {
    Size = UDim2.fromOffset(570, 370),
    Position = UDim2.new(0.5, -285, 0.5, -185),
    BackgroundColor3 = dark,
    BorderSizePixel = 0
}, gui)

create("UICorner", {CornerRadius = UDim.new(0, 12)}, main)
create("UIStroke", {Color = purple, Thickness = 1.5}, main)

-- Header
local header = create("Frame", {
    Size = UDim2.new(1, 0, 0, 55),
    BackgroundColor3 = panel,
    BorderSizePixel = 0
}, main)
create("UICorner", {CornerRadius = UDim.new(0, 12)}, header)

create("TextLabel", {
    Size = UDim2.new(1, -70, 1, 0),
    Position = UDim2.fromOffset(18, 0),
    BackgroundTransparency = 1,
    Text = "✦ MATCHA HUB",
    TextColor3 = textColor,
    TextSize = 20,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left
}, header)

local close = create("TextButton", {
    Size = UDim2.fromOffset(34, 34),
    Position = UDim2.new(1, -45, 0, 10),
    BackgroundColor3 = Color3.fromRGB(90, 55, 115),
    Text = "×",
    TextColor3 = textColor,
    TextSize = 23,
    Font = Enum.Font.GothamBold
}, header)
create("UICorner", {CornerRadius = UDim.new(0, 8)}, close)

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Dragging
local dragging, dragStart, startPosition

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPosition = main.Position
    end
end)

header.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

-- Sidebar
local sidebar = create("Frame", {
    Size = UDim2.new(0, 155, 1, -65),
    Position = UDim2.fromOffset(0, 60),
    BackgroundTransparency = 1
}, main)

local sideLayout = create("UIListLayout", {
    Padding = UDim.new(0, 7),
    HorizontalAlignment = Enum.HorizontalAlignment.Center,
    SortOrder = Enum.SortOrder.LayoutOrder
}, sidebar)

sideLayout.Padding = UDim.new(0, 7)

local content = create("Frame", {
    Size = UDim2.new(1, -170, 1, -75),
    Position = UDim2.fromOffset(160, 65),
    BackgroundColor3 = panel,
    BorderSizePixel = 0
}, main)
create("UICorner", {CornerRadius = UDim.new(0, 10)}, content)

local status = create("TextLabel", {
    Size = UDim2.new(1, -20, 0, 25),
    Position = UDim2.new(0, 10, 1, -30),
    BackgroundTransparency = 1,
    Text = "MATCHA HUB • VISUAL MODE",
    TextColor3 = muted,
    TextSize = 10,
    Font = Enum.Font.Gotham
}, content)

local pages = {}
local currentPage

local function showPage(name)
    for _, page in pairs(pages) do
        page.Visible = false
    end
    pages[name].Visible = true
    currentPage = name
end

local function createPage(name)
    local page = create("Frame", {
        Name = name,
        Size = UDim2.new(1, -20, 1, -45),
        Position = UDim2.fromOffset(10, 10),
        BackgroundTransparency = 1,
        Visible = false
    }, content)

    pages[name] = page

    create("TextLabel", {
        Size = UDim2.new(1, 0, 0, 35),
        BackgroundTransparency = 1,
        Text = name,
        TextColor3 = textColor,
        TextSize = 19,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left
    }, page)

    return page
end

local function addButton(page, label, description)
    local button = create("TextButton", {
        Size = UDim2.new(1, 0, 0, 58),
        BackgroundColor3 = Color3.fromRGB(53, 43, 69),
        Text = "",
        AutoButtonColor = true
    }, page)

    create("UICorner", {CornerRadius = UDim.new(0, 8)}, button)

    create("TextLabel", {
        Size = UDim2.new(1, -20, 0, 25),
        Position = UDim2.fromOffset(12, 5),
        BackgroundTransparency = 1,
        Text = label,
        TextColor3 = textColor,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left
    }, button)

    create("TextLabel", {
        Size = UDim2.new(1, -20, 0, 18),
        Position = UDim2.fromOffset(12, 31),
        BackgroundTransparency = 1,
        Text = description,
        TextColor3 = muted,
        TextSize = 10,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left
    }, button)

    button.MouseButton1Click:Connect(function()
        status.Text = label .. " • VISUAL ONLY"
    end)

    return button
end

-- Home
local home = createPage("Home")
addButton(home, "Welcome to Matcha Hub", "Your custom Anime Adventures interface")
local info = create("TextLabel", {
    Size = UDim2.new(1, 0, 0, 55),
    Position = UDim2.fromOffset(0, 115),
    BackgroundTransparency = 1,
    Text = "Purple edition | Lightweight visual interface\nNo gameplay actions are connected.",
    TextColor3 = muted,
    TextSize = 12,
    Font = Enum.Font.Gotham,
    TextWrapped = true
}, home)

-- Trait Management
local traits = createPage("Trait Management")
addButton(traits, "TRAIT REROLL", "Visual button • No game action")
local rollback = addButton(traits, "TRAIT ROLLBACK", "Visual button • No game action")
local traitNote = create("TextLabel", {
    Size = UDim2.new(1, 0, 0, 35),
    Position = UDim2.fromOffset(0, 155),
    BackgroundTransparency = 1,
    Text = "Trait controls are visual placeholders.",
    TextColor3 = muted,
    TextSize = 11,
    Font = Enum.Font.Gotham
}, traits)

-- Other tabs
local settings = createPage("Settings")
addButton(settings, "Interface", "Matcha Hub visual settings")

local farm = createPage("Auto Farm")
addButton(farm, "Auto Farm", "Visual placeholder only")

local teleport = createPage("Teleport")
addButton(teleport, "Teleport", "Visual placeholder only")

local misc = createPage("Miscellaneous")
addButton(misc, "Miscellaneous", "Visual placeholder only")

-- Sidebar buttons
local tabNames = {
    "Home",
    "Trait Management",
    "Auto Farm",
    "Teleport",
    "Settings",
    "Miscellaneous"
}

for index, name in ipairs(tabNames) do
    local tab = create("TextButton", {
        Size = UDim2.new(1, -12, 0, 42),
        BackgroundColor3 = Color3.fromRGB(45, 37, 58),
        Text = name,
        TextColor3 = textColor,
        TextSize = 11,
        Font = Enum.Font.GothamSemibold,
        LayoutOrder = index
    }, sidebar)

    create("UICorner", {CornerRadius = UDim.new(0, 7)}, tab)

    tab.MouseButton1Click:Connect(function()
        showPage(name)
    end)
end

showPage("Home")

print("[Matcha Hub] Visual interface loaded.")
