local player = game.Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = gui
screenGui.Name = "ProjectVaporUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local isMobile = (game:GetService("UserInputService").TouchEnabled and not game:GetService("UserInputService").MouseEnabled)

local uiSize
local uiPosition
local titleHeight
local contentOffset
local tabBarHeight
local closeButtonSize
local closeButtonOffset
local logoSize
local logoOffset
local contentContainerSize
local scrollPadding

if isMobile then
    uiSize = UDim2.new(0, 320, 0, 400)
    uiPosition = UDim2.new(0.05, 0, 0.5, -200)
    titleHeight = 45
    contentOffset = 95
    tabBarHeight = 35
    closeButtonSize = UDim2.new(0, 28, 0, 28)
    closeButtonOffset = UDim2.new(1, -35, 0, 8)
    logoSize = UDim2.new(0, 32, 0, 32)
    logoOffset = UDim2.new(0, 8, 0, 6)
    contentContainerSize = UDim2.new(1, -20, 0, 260)
    scrollPadding = 10
else
    uiSize = UDim2.new(0, 600, 0, 560)
    uiPosition = UDim2.new(0.05, 0, 0.5, -280)
    titleHeight = 60
    contentOffset = 115
    tabBarHeight = 45
    closeButtonSize = UDim2.new(0, 40, 0, 40)
    closeButtonOffset = UDim2.new(1, -45, 0, 10)
    logoSize = UDim2.new(0, 50, 0, 50)
    logoOffset = UDim2.new(0, 10, 0, 5)
    contentContainerSize = UDim2.new(1, -20, 1, -340)
    scrollPadding = 0
end

local main = Instance.new("Frame")
main.Parent = screenGui
main.Size = uiSize
main.Position = uiPosition
main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
main.BorderSizePixel = 0
main.BackgroundTransparency = 0
main.ClipsDescendants = false

local outline = Instance.new("UIStroke")
outline.Parent = main
outline.Color = Color3.fromRGB(255, 255, 255)
outline.Thickness = 2

local corner = Instance.new("UICorner", main)
corner.CornerRadius = UDim.new(0, 12)

local logo = Instance.new("ImageLabel")
logo.Parent = main
logo.Size = logoSize
logo.Position = logoOffset
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://102077742709888"

local title = Instance.new("TextLabel")
title.Parent = main
title.Size = UDim2.new(1, 0, 0, titleHeight)
title.Text = "ProjectVapor"
title.TextScaled = true
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextStrokeTransparency = 0.5

local close = Instance.new("TextButton")
close.Parent = main
close.Size = closeButtonSize
close.Position = closeButtonOffset
close.Text = "X"
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.BackgroundTransparency = 1
close.TextScaled = true
close.Font = Enum.Font.GothamBold
close.AutoButtonColor = false

close.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

local tabBar = Instance.new("Frame")
tabBar.Parent = main
tabBar.Size = UDim2.new(1, -20, 0, tabBarHeight)
tabBar.Position = UDim2.new(0, 10, 0, contentOffset - tabBarHeight + 5)
tabBar.BackgroundTransparency = 1

local contentContainer = Instance.new("ScrollingFrame")
contentContainer.Parent = main
contentContainer.Size = contentContainerSize
contentContainer.Position = UDim2.new(0, 10, 0, contentOffset + 15)
contentContainer.BackgroundTransparency = 1
contentContainer.BorderSizePixel = 0
contentContainer.ScrollBarThickness = 4
contentContainer.ScrollBarImageColor3 = Color3.fromRGB(150, 150, 150)
contentContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
contentContainer.AutomaticCanvasSize = Enum.AutomaticSize.None

local content = Instance.new("TextLabel")
content.Parent = contentContainer
content.Size = UDim2.new(1, -scrollPadding, 0, 0)
content.Position = UDim2.new(0, scrollPadding / 2, 0, 0)
content.BackgroundTransparency = 1
content.TextColor3 = Color3.new(1, 1, 1)
content.TextWrapped = true
content.TextYAlignment = Enum.TextYAlignment.Top
content.TextXAlignment = Enum.TextXAlignment.Left
content.Font = Enum.Font.GothamBold
if isMobile then
    content.TextSize = 13
else
    content.TextSize = 16
end
content.TextStrokeTransparency = 0.3
content.RichText = true
content.Text = ""

local TextService = game:GetService("TextService")

-- Strip rich text tags for accurate measurement
local function stripRichText(text)
    return (text:gsub("<[^>]->", ""))
end

local function updateScrollSize()
    local containerWidth = contentContainer.AbsoluteSize.X - scrollPadding
    if containerWidth <= 0 then
        containerWidth = 500
    end
    local plainText = stripRichText(content.Text)
    local measured = TextService:GetTextSize(
        plainText,
        content.TextSize,
        content.Font,
        Vector2.new(containerWidth, math.huge)
    )
    local textHeight = measured.Y + 20
    content.Size = UDim2.new(1, -scrollPadding, 0, textHeight)
    contentContainer.CanvasSize = UDim2.new(0, 0, 0, textHeight)
end

content:GetPropertyChangedSignal("Text"):Connect(updateScrollSize)
contentContainer:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateScrollSize)

local function setTab(tabName)
    if tabName == "Changelog" then
        content.Text = [[VaporMvsd V1.4

Aimbot tab:

- Added FOV Mode dropdown with Mouse and Center options
- Added optional Shiftlock toggle, now off by default so aimbot looks more legit
- Aimbot can no longer be enabled in the lobby, it will also auto disables when a match ends
- Trigger Bot was improved, added Hold Mode, Use FOV mode, separate Trigger FOV circle, and Alive Check
- Fixed Triggerbot sliders, FOV Size, Trigger Delay, Trigger Radius, and Max Distance sliders and etc with proper ranges
- Fixed Trigger Bot not respecting match state, it no longer fires in the lobby
- Fixed Trigger Bot delay not actually throttling shots
- Fixed Reset Aimbot Settings button to reset all new options


Combat Tab:

+ Updated Wallbang + Silent Aim features in Combat tab

- Added "Prediction Aim" right under Gun Features. Allows you to lead moving targets so shots actually land.


Rage Tab:

+ improved the Gun Kill all

+ Improved the Knife Kill all

+ Improved the KnifeCrashAll, it's now stronger

- Added "Mass Blind" feature, allows you to target a selected player blinding them with shroud & crashing them same time.


Rage Tab 2:

- Comes with features such as Sticking to nearby enemy's. [Stick position, Team check , Offset Distance & Height Offset]

- Added "Stick Kill Aura" with a Kill Aura hit rate, which will stick to the enemy , and knife them instantly.

- Added "Anti Aim" to where enemies only see you backwards.


Misc 2 Tab:

+ Added "Auto Soul Reap", your gun will be equipped as well.

+ Added "AntiCrash"

- Added "SafeSpot" feature, allows you to teleport to different areas to avoid getting killed or if u wanted to troll.


Setting tab:

Now has "View Latest Changelog"


- Removed Rapid mode in Gun cooldown mode in combat tab. (That was for Pc users)
- Removed the Kill all that used to be in the [Knife Crash All feature]
- Removed BangSomeone in the Misc tab.]]
    end
    task.wait()
    updateScrollSize()
end

local activeTab = nil

local function createTab(tabName, position)
    local tabButton = Instance.new("TextButton")
    tabButton.Parent = tabBar
    tabButton.Size = UDim2.new(0.45, -5, 1, 0)
    tabButton.Position = UDim2.new(position, 0, 0, 0)
    tabButton.Text = tabName
    tabButton.TextColor3 = Color3.new(1, 1, 1)
    tabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    tabButton.Font = Enum.Font.GothamBold
    tabButton.TextScaled = true
    tabButton.AutoButtonColor = false
    
    local tabCorner = Instance.new("UICorner", tabButton)
    tabCorner.CornerRadius = UDim.new(0, 8)
    
    local tabStroke = Instance.new("UIStroke", tabButton)
    tabStroke.Color = Color3.new(1, 1, 1)
    tabStroke.Thickness = 1
    
    tabButton.MouseButton1Click:Connect(function()
        if activeTab then
            activeTab.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        end
        tabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        activeTab = tabButton
        setTab(tabName)
    end)
    
    return tabButton
end

local changelogTab = createTab("Changelog", 0)

changelogTab.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
activeTab = changelogTab
setTab("Changelog")

local dragToggle = false
local dragStart = nil
local dragStartPos = nil
local dragging = false

local dragFrame = Instance.new("Frame")
dragFrame.Parent = main
dragFrame.Size = UDim2.new(1, 0, 0, titleHeight)
dragFrame.BackgroundTransparency = 1

dragFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragToggle = true
        dragStart = input.Position
        dragStartPos = main.Position
        dragging = true
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragToggle = false
                dragging = false
            end
        end)
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragToggle and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        local newX = dragStartPos.X.Offset + delta.X
        local newY = dragStartPos.Y.Offset + delta.Y
        main.Position = UDim2.new(dragStartPos.X.Scale, newX, dragStartPos.Y.Scale, newY)
    end
end)

screenGui.Parent = gui

task.delay(60, function()
    if screenGui and screenGui.Parent then
        screenGui:Destroy()
    end
end)
