if _G.NotificationUI then
    warn("Script đã chạy! Không thể chạy lại.")
    return
end
_G.NotificationUI = true

local SelectVersion = Instance.new("ScreenGui")
SelectVersion.Name = "SelectVersion"
SelectVersion.ResetOnSpawn = false
SelectVersion.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
SelectVersion.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.Size = UDim2.new(0.4, 0, 0.4, 0)
Main.BackgroundColor3 = Color3.new(0.113725, 0, 0.203922)
Main.BorderSizePixel = 0
Main.BorderColor3 = Color3.new(0, 0, 0)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Parent = SelectVersion

local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint.Name = "UIAspectRatioConstraint"
UIAspectRatioConstraint.AspectRatio = 1.75
UIAspectRatioConstraint.Parent = Main

local UIStroke = Instance.new("UIStroke")
UIStroke.Name = "UIStroke"
UIStroke.Color = Color3.new(0.784314, 0, 1)
UIStroke.Parent = Main

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Position = UDim2.new(0.5, 0, 0.075, 0)
Title.Size = UDim2.new(1, 0, 0.15, 0)
Title.BackgroundColor3 = Color3.new(0, 0, 0)
Title.BackgroundTransparency = 0.5
Title.BorderSizePixel = 0
Title.BorderColor3 = Color3.new(0, 0, 0)
Title.AnchorPoint = Vector2.new(0.5, 0.5)
Title.TextTransparency = 0
Title.Text = "NEW UI"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 14
Title.FontFace = Font.new("rbxasset://fonts/families/HighwayGothic.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Title.TextScaled = true
Title.TextWrapped = true
Title.Parent = Main

local UIStroke2 = Instance.new("UIStroke")
UIStroke2.Name = "UIStroke"
UIStroke2.Color = Color3.new(0.784314, 0, 1)
UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke2.Parent = Title

local Text = Instance.new("TextLabel")
Text.Name = "Text"
Text.Position = UDim2.new(0.5, 0, 0.4, 0)
Text.Size = UDim2.new(0.75, 0, 0.35, 0)
Text.BackgroundColor3 = Color3.new(1, 1, 1)
Text.BackgroundTransparency = 1
Text.BorderSizePixel = 0
Text.BorderColor3 = Color3.new(0, 0, 0)
Text.AnchorPoint = Vector2.new(0.5, 0.5)
Text.TextTransparency = 0
Text.Text = "Do you want to use the current version or the trial version?"
Text.TextColor3 = Color3.new(1, 1, 1)
Text.TextSize = 14
Text.FontFace = Font.new("rbxasset://fonts/families/RobotoMono.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Text.TextScaled = true
Text.TextWrapped = true
Text.Parent = Main

local UIStroke3 = Instance.new("UIStroke")
UIStroke3.Name = "UIStroke"
UIStroke3.Color = Color3.new(0.784314, 0, 1)
UIStroke3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke3.Parent = Text

local Current = Instance.new("TextButton")
Current.Name = "Current"
Current.Position = UDim2.new(0.125, 0, 0.65, 0)
Current.Size = UDim2.new(0.35, 0, 0.25, 0)
Current.BackgroundColor3 = Color3.new(0.188235, 0, 0.403922)
Current.BorderSizePixel = 0
Current.BorderColor3 = Color3.new(0, 0, 0)
Current.Text = "Current version"
Current.TextColor3 = Color3.new(1, 1, 1)
Current.TextSize = 14
Current.FontFace = Font.new("rbxasset://fonts/families/HighwayGothic.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Current.TextScaled = true
Current.TextWrapped = true
Current.Parent = Main

local UICorner = Instance.new("UICorner")
UICorner.Name = "UICorner"
UICorner.CornerRadius = UDim.new(0.25, 0)
UICorner.Parent = Current

local UIStroke4 = Instance.new("UIStroke")
UIStroke4.Name = "UIStroke"
UIStroke4.Color = Color3.new(0.54902, 0, 1)
UIStroke4.Thickness = 1.5
UIStroke4.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke4.Parent = Current

local Trial = Instance.new("TextButton")
Trial.Name = "Trial"
Trial.Position = UDim2.new(0.525, 0, 0.65, 0)
Trial.Size = UDim2.new(0.35, 0, 0.25, 0)
Trial.BackgroundColor3 = Color3.new(0.317647, 0, 0.380392)
Trial.BorderSizePixel = 0
Trial.BorderColor3 = Color3.new(0, 0, 0)
Trial.Text = "Trial version"
Trial.TextColor3 = Color3.new(1, 1, 1)
Trial.TextSize = 14
Trial.FontFace = Font.new("rbxasset://fonts/families/HighwayGothic.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Trial.TextScaled = true
Trial.TextWrapped = true
Trial.Parent = Main

local UICorner2 = Instance.new("UICorner")
UICorner2.Name = "UICorner"
UICorner2.CornerRadius = UDim.new(0.25, 0)
UICorner2.Parent = Trial

local UIStroke5 = Instance.new("UIStroke")
UIStroke5.Name = "UIStroke"
UIStroke5.Color = Color3.new(0.968628, 0, 1)
UIStroke5.Thickness = 1.5
UIStroke5.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke5.Parent = Trial

-- SYSTEM ======================================================================================

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = playerGui:WaitForChild("SelectVersion")
local main = screenGui:WaitForChild("Main")

local currentBtn = main:WaitForChild("Current")
local trialBtn = main:WaitForChild("trial")

-- URL của bạn (đổi lại theo ý bạn)
local CURRENT_URL = "https://raw.githubusercontent.com/HAPPY-script/BLOX_FRUIT/main/BLOX_FRUIT.lua"
local TRIAL_URL   = "https://raw.githubusercontent.com/HAPPY-script/BloxFruitHub_NewUI/refs/heads/main/MainLoad.lua"

local clicked = false

local function run(url)
	if clicked then return end
	clicked = true

	-- khóa cả hai nút
	currentBtn.Active = false
	trialBtn.Active = false

	-- xóa GUI ngay
	screenGui:Destroy()

	-- chạy script
	loadstring(game:HttpGet(url))()
end

currentBtn.MouseButton1Click:Connect(function()
	run(CURRENT_URL)
end)

trialBtn.MouseButton1Click:Connect(function()
	run(TRIAL_URL)
end)
