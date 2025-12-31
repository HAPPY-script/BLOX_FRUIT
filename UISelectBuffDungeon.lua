local AutoBuffSelectionGui = Instance.new("ScreenGui")
AutoBuffSelectionGui.Name = "AutoBuffSelectionGui"
AutoBuffSelectionGui.ResetOnSpawn = false
AutoBuffSelectionGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
AutoBuffSelectionGui.DisplayOrder = 10
AutoBuffSelectionGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.Size = UDim2.new(0.5, 0, 0.5, 0)
Main.BackgroundColor3 = Color3.new(1, 1, 1)
Main.BorderSizePixel = 0
Main.BorderColor3 = Color3.new(0, 0, 0)
Main.ZIndex = 50
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Parent = AutoBuffSelectionGui

local TitleFrame = Instance.new("Frame")
TitleFrame.Name = "TitleFrame"
TitleFrame.Position = UDim2.new(0.5, 0, 0.025, 0)
TitleFrame.Size = UDim2.new(1.005, 0, 0.15, 0)
TitleFrame.BackgroundColor3 = Color3.new(1, 1, 1)
TitleFrame.BorderSizePixel = 0
TitleFrame.BorderColor3 = Color3.new(0, 0, 0)
TitleFrame.AnchorPoint = Vector2.new(0.5, 0.5)
TitleFrame.Parent = Main

local UIGradient = Instance.new("UIGradient")
UIGradient.Name = "UIGradient"
UIGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(1, 0.784314, 0)), ColorSequenceKeypoint.new(0.5, Color3.new(0.94902, 1, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 0.784314, 0))})
UIGradient.Parent = TitleFrame

local UICorner = Instance.new("UICorner")
UICorner.Name = "UICorner"
UICorner.CornerRadius = UDim.new(0.15, 0)
UICorner.Parent = TitleFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Name = "UIStroke"
UIStroke.Thickness = 2
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = TitleFrame

local Close = Instance.new("ImageButton")
Close.Name = "Close"
Close.Position = UDim2.new(0.95, 0, 0.5, 0)
Close.Size = UDim2.new(0.8, 0, 0.8, 0)
Close.BackgroundColor3 = Color3.new(1, 1, 1)
Close.BorderSizePixel = 0
Close.BorderColor3 = Color3.new(0, 0, 0)
Close.AnchorPoint = Vector2.new(0.5, 0.5)
Close.Parent = TitleFrame

local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint.Parent = Close

local UIStroke2 = Instance.new("UIStroke")
UIStroke2.Name = "UIStroke"
UIStroke2.Thickness = 1.5
UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke2.Parent = Close

local UIGradient2 = Instance.new("UIGradient")
UIGradient2.Name = "UIGradient"
UIGradient2.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(1, 0.196078, 0.054902)), ColorSequenceKeypoint.new(0.5, Color3.new(1, 0.47451, 0.341176)), ColorSequenceKeypoint.new(1, Color3.new(1, 0.196078, 0.054902))})
UIGradient2.Rotation = 90
UIGradient2.Parent = Close

local ImageLabel = Instance.new("ImageLabel")
ImageLabel.Name = "ImageLabel"
ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
ImageLabel.Size = UDim2.new(0.75, 0, 0.75, 0)
ImageLabel.BackgroundColor3 = Color3.new(1, 1, 1)
ImageLabel.BackgroundTransparency = 1
ImageLabel.BorderSizePixel = 0
ImageLabel.BorderColor3 = Color3.new(0, 0, 0)
ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
ImageLabel.Transparency = 1
ImageLabel.Image = "rbxassetid://90766052876890"
ImageLabel.Parent = Close

local TextLabel = Instance.new("TextLabel")
TextLabel.Name = "TextLabel"
TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
TextLabel.Size = UDim2.new(0.65, 0, 0.8, 0)
TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel.BackgroundTransparency = 1
TextLabel.BorderSizePixel = 0
TextLabel.BorderColor3 = Color3.new(0, 0, 0)
TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
TextLabel.Transparency = 1
TextLabel.Text = "Automatic Buff Selection"
TextLabel.TextColor3 = Color3.new(1, 1, 1)
TextLabel.TextSize = 14
TextLabel.FontFace = Font.new("rbxasset://fonts/families/HighwayGothic.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
TextLabel.TextScaled = true
TextLabel.TextWrapped = true
TextLabel.Parent = TitleFrame

local UIStroke3 = Instance.new("UIStroke")
UIStroke3.Name = "UIStroke"
UIStroke3.Thickness = 1.5
UIStroke3.Parent = TextLabel

local UIStroke4 = Instance.new("UIStroke")
UIStroke4.Name = "UIStroke"
UIStroke4.Thickness = 2
UIStroke4.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke4.Parent = Main

local UIGradient3 = Instance.new("UIGradient")
UIGradient3.Name = "UIGradient"
UIGradient3.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0, 0.027451, 0.0980392)), ColorSequenceKeypoint.new(0.728374, Color3.new(0.0980392, 0.0980392, 0.0980392)), ColorSequenceKeypoint.new(1, Color3.new(0.14902, 0.14902, 0.14902))})
UIGradient3.Rotation = 90
UIGradient3.Parent = Main

local UICorner2 = Instance.new("UICorner")
UICorner2.Name = "UICorner"
UICorner2.CornerRadius = UDim.new(0.015, 0)
UICorner2.Parent = Main

local UIDragDetector = Instance.new("UIDragDetector")
UIDragDetector.Name = "UIDragDetector"

UIDragDetector.Parent = Main

local Execution = Instance.new("ScrollingFrame")
Execution.Name = "Execution"
Execution.Position = UDim2.new(0.255, 0, 0.6, 0)
Execution.Size = UDim2.new(0.45, 0, 0.75, 0)
Execution.BackgroundColor3 = Color3.new(1, 1, 1)
Execution.BackgroundTransparency = 1
Execution.BorderSizePixel = 0
Execution.BorderColor3 = Color3.new(0, 0, 0)
Execution.AnchorPoint = Vector2.new(0.5, 0.5)
Execution.Transparency = 1
Execution.Active = true
Execution.ScrollBarThickness = 3
Execution.Parent = Main

local UIStroke5 = Instance.new("UIStroke")
UIStroke5.Name = "UIStroke"
UIStroke5.Color = Color3.new(1, 0.784314, 0)
UIStroke5.Thickness = 2
UIStroke5.Parent = Execution

local List = Instance.new("ScrollingFrame")
List.Name = "List"
List.Position = UDim2.new(0.75, 0, 0.6, 0)
List.Size = UDim2.new(0.45, 0, 0.75, 0)
List.BackgroundColor3 = Color3.new(1, 1, 1)
List.BackgroundTransparency = 1
List.BorderSizePixel = 0
List.BorderColor3 = Color3.new(0, 0, 0)
List.AnchorPoint = Vector2.new(0.5, 0.5)
List.Transparency = 1
List.Active = true
List.ScrollBarThickness = 3
List.Parent = Main

local UIStroke6 = Instance.new("UIStroke")
UIStroke6.Name = "UIStroke"
UIStroke6.Color = Color3.new(1, 0.784314, 0)
UIStroke6.Thickness = 2
UIStroke6.Parent = List

local Melee = Instance.new("TextButton")
Melee.Name = "Melee"
Melee.Position = UDim2.new(0.5, 0, 0.105, 0)
Melee.Size = UDim2.new(0.95, 0, 0.075, 0)
Melee.BackgroundColor3 = Color3.new(1, 1, 1)
Melee.BorderSizePixel = 0
Melee.BorderColor3 = Color3.new(0, 0, 0)
Melee.AnchorPoint = Vector2.new(0.5, 0)
Melee.Text = ""
Melee.TextColor3 = Color3.new(0, 0, 0)
Melee.TextSize = 14
Melee.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Melee.Parent = List

local UIStroke7 = Instance.new("UIStroke")
UIStroke7.Name = "UIStroke"
UIStroke7.Color = Color3.new(1, 0.882353, 0)
UIStroke7.Thickness = 2
UIStroke7.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke7.Parent = Melee

local UIGradient4 = Instance.new("UIGradient")
UIGradient4.Name = "UIGradient"
UIGradient4.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.12549, 0.188235, 0.113725)), ColorSequenceKeypoint.new(0.5, Color3.new(0.156863, 0.156863, 0.156863)), ColorSequenceKeypoint.new(1, Color3.new(0.156863, 0.156863, 0.156863))})
UIGradient4.Parent = Melee

local Logo = Instance.new("ImageLabel")
Logo.Name = "Logo"
Logo.Position = UDim2.new(0.11, 0, 0.5, 0)
Logo.Size = UDim2.new(1, 0, 1, 0)
Logo.BackgroundColor3 = Color3.new(1, 1, 1)
Logo.BackgroundTransparency = 1
Logo.BorderSizePixel = 0
Logo.BorderColor3 = Color3.new(0, 0, 0)
Logo.AnchorPoint = Vector2.new(0.5, 0.5)
Logo.Transparency = 1
Logo.Image = "rbxassetid://105862822867112"
Logo.Parent = Melee

local UIAspectRatioConstraint2 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint2.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint2.Parent = Logo

local Name = Instance.new("TextLabel")
Name.Name = "Name"
Name.Position = UDim2.new(0.5, 0, 0.25, 0)
Name.Size = UDim2.new(0.75, 0, 0.5, 0)
Name.BackgroundColor3 = Color3.new(1, 1, 1)
Name.BackgroundTransparency = 1
Name.BorderSizePixel = 0
Name.BorderColor3 = Color3.new(0, 0, 0)
Name.AnchorPoint = Vector2.new(0.5, 0.5)
Name.Transparency = 1
Name.Text = "Melee"
Name.TextColor3 = Color3.new(1, 1, 1)
Name.TextSize = 14
Name.FontFace = Font.new("rbxasset://fonts/families/HighwayGothic.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Name.TextScaled = true
Name.TextWrapped = true
Name.Parent = Melee

local UIStroke8 = Instance.new("UIStroke")
UIStroke8.Name = "UIStroke"
UIStroke8.Thickness = 1.5
UIStroke8.Parent = Name

local Features = Instance.new("TextLabel")
Features.Name = "Features"
Features.Position = UDim2.new(0.6, 0, 0.75, 0)
Features.Size = UDim2.new(0.75, 0, 0.35, 0)
Features.BackgroundColor3 = Color3.new(1, 1, 1)
Features.BackgroundTransparency = 1
Features.BorderSizePixel = 0
Features.BorderColor3 = Color3.new(0, 0, 0)
Features.AnchorPoint = Vector2.new(0.5, 0.5)
Features.Transparency = 1
Features.Text = "+500 Melee stats"
Features.TextColor3 = Color3.new(0.772549, 0.772549, 0.772549)
Features.TextSize = 14
Features.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic)
Features.TextScaled = true
Features.TextWrapped = true
Features.Parent = Melee

local Lifesteal = Instance.new("TextButton")
Lifesteal.Name = "Lifesteal"
Lifesteal.Position = UDim2.new(0.5, 0, 0.195, 0)
Lifesteal.Size = UDim2.new(0.95, 0, 0.075, 0)
Lifesteal.BackgroundColor3 = Color3.new(1, 1, 1)
Lifesteal.BorderSizePixel = 0
Lifesteal.BorderColor3 = Color3.new(0, 0, 0)
Lifesteal.AnchorPoint = Vector2.new(0.5, 0)
Lifesteal.Text = ""
Lifesteal.TextColor3 = Color3.new(0, 0, 0)
Lifesteal.TextSize = 14
Lifesteal.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Lifesteal.Parent = List

local UIStroke9 = Instance.new("UIStroke")
UIStroke9.Name = "UIStroke"
UIStroke9.Color = Color3.new(1, 0.882353, 0)
UIStroke9.Thickness = 2
UIStroke9.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke9.Parent = Lifesteal

local UIGradient5 = Instance.new("UIGradient")
UIGradient5.Name = "UIGradient"
UIGradient5.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.12549, 0.188235, 0.113725)), ColorSequenceKeypoint.new(0.5, Color3.new(0.156863, 0.156863, 0.156863)), ColorSequenceKeypoint.new(1, Color3.new(0.156863, 0.156863, 0.156863))})
UIGradient5.Parent = Lifesteal

local Logo2 = Instance.new("ImageLabel")
Logo2.Name = "Logo"
Logo2.Position = UDim2.new(0.11, 0, 0.5, 0)
Logo2.Size = UDim2.new(1, 0, 1, 0)
Logo2.BackgroundColor3 = Color3.new(1, 1, 1)
Logo2.BackgroundTransparency = 1
Logo2.BorderSizePixel = 0
Logo2.BorderColor3 = Color3.new(0, 0, 0)
Logo2.AnchorPoint = Vector2.new(0.5, 0.5)
Logo2.Transparency = 1
Logo2.Image = "rbxassetid://88149768819442"
Logo2.Parent = Lifesteal

local UIAspectRatioConstraint3 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint3.Name = "UIAspectRatioConstraint"
UIAspectRatioConstraint3.AspectRatio = 0.8999999761581421
UIAspectRatioConstraint3.Parent = Logo2

local Name2 = Instance.new("TextLabel")
Name2.Name = "Name"
Name2.Position = UDim2.new(0.5, 0, 0.25, 0)
Name2.Size = UDim2.new(0.75, 0, 0.5, 0)
Name2.BackgroundColor3 = Color3.new(1, 1, 1)
Name2.BackgroundTransparency = 1
Name2.BorderSizePixel = 0
Name2.BorderColor3 = Color3.new(0, 0, 0)
Name2.AnchorPoint = Vector2.new(0.5, 0.5)
Name2.Transparency = 1
Name2.Text = "Lifesteal"
Name2.TextColor3 = Color3.new(1, 1, 1)
Name2.TextSize = 14
Name2.FontFace = Font.new("rbxasset://fonts/families/HighwayGothic.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Name2.TextScaled = true
Name2.TextWrapped = true
Name2.Parent = Lifesteal

local UIStroke10 = Instance.new("UIStroke")
UIStroke10.Name = "UIStroke"
UIStroke10.Thickness = 1.5
UIStroke10.Parent = Name2

local Features2 = Instance.new("TextLabel")
Features2.Name = "Features"
Features2.Position = UDim2.new(0.6, 0, 0.75, 0)
Features2.Size = UDim2.new(0.75, 0, 0.5, 0)
Features2.BackgroundColor3 = Color3.new(1, 1, 1)
Features2.BackgroundTransparency = 1
Features2.BorderSizePixel = 0
Features2.BorderColor3 = Color3.new(0, 0, 0)
Features2.AnchorPoint = Vector2.new(0.5, 0.5)
Features2.Transparency = 1
Features2.Text = "Heal for 10% of damage dealt to enemies."
Features2.TextColor3 = Color3.new(0.772549, 0.772549, 0.772549)
Features2.TextSize = 14
Features2.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic)
Features2.TextScaled = true
Features2.TextWrapped = true
Features2.Parent = Lifesteal

local Defense = Instance.new("TextButton")
Defense.Name = "Defense"
Defense.Position = UDim2.new(0.5, 0, 0.285, 0)
Defense.Size = UDim2.new(0.95, 0, 0.075, 0)
Defense.BackgroundColor3 = Color3.new(1, 1, 1)
Defense.BorderSizePixel = 0
Defense.BorderColor3 = Color3.new(0, 0, 0)
Defense.AnchorPoint = Vector2.new(0.5, 0)
Defense.Text = ""
Defense.TextColor3 = Color3.new(0, 0, 0)
Defense.TextSize = 14
Defense.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Defense.Parent = List

local UIStroke11 = Instance.new("UIStroke")
UIStroke11.Name = "UIStroke"
UIStroke11.Color = Color3.new(1, 0.882353, 0)
UIStroke11.Thickness = 2
UIStroke11.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke11.Parent = Defense

local UIGradient6 = Instance.new("UIGradient")
UIGradient6.Name = "UIGradient"
UIGradient6.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.12549, 0.188235, 0.113725)), ColorSequenceKeypoint.new(0.5, Color3.new(0.156863, 0.156863, 0.156863)), ColorSequenceKeypoint.new(1, Color3.new(0.156863, 0.156863, 0.156863))})
UIGradient6.Parent = Defense

local Logo3 = Instance.new("ImageLabel")
Logo3.Name = "Logo"
Logo3.Position = UDim2.new(0.15, 0, 0.45, 0)
Logo3.Size = UDim2.new(1.1, 0, 1.1, 0)
Logo3.BackgroundColor3 = Color3.new(1, 1, 1)
Logo3.BackgroundTransparency = 1
Logo3.BorderSizePixel = 0
Logo3.BorderColor3 = Color3.new(0, 0, 0)
Logo3.AnchorPoint = Vector2.new(0.5, 0.5)
Logo3.Transparency = 1
Logo3.Image = "rbxassetid://92248946047126"
Logo3.Parent = Defense

local UIAspectRatioConstraint4 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint4.Name = "UIAspectRatioConstraint"
UIAspectRatioConstraint4.AspectRatio = 1.149999976158142
UIAspectRatioConstraint4.Parent = Logo3

local Name3 = Instance.new("TextLabel")
Name3.Name = "Name"
Name3.Position = UDim2.new(0.5, 0, 0.25, 0)
Name3.Size = UDim2.new(0.75, 0, 0.5, 0)
Name3.BackgroundColor3 = Color3.new(1, 1, 1)
Name3.BackgroundTransparency = 1
Name3.BorderSizePixel = 0
Name3.BorderColor3 = Color3.new(0, 0, 0)
Name3.AnchorPoint = Vector2.new(0.5, 0.5)
Name3.Transparency = 1
Name3.Text = "Defense"
Name3.TextColor3 = Color3.new(1, 1, 1)
Name3.TextSize = 14
Name3.FontFace = Font.new("rbxasset://fonts/families/HighwayGothic.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Name3.TextScaled = true
Name3.TextWrapped = true
Name3.Parent = Defense

local UIStroke12 = Instance.new("UIStroke")
UIStroke12.Name = "UIStroke"
UIStroke12.Thickness = 1.5
UIStroke12.Parent = Name3

local Features3 = Instance.new("TextLabel")
Features3.Name = "Features"
Features3.Position = UDim2.new(0.6, 0, 0.75, 0)
Features3.Size = UDim2.new(0.75, 0, 0.35, 0)
Features3.BackgroundColor3 = Color3.new(1, 1, 1)
Features3.BackgroundTransparency = 1
Features3.BorderSizePixel = 0
Features3.BorderColor3 = Color3.new(0, 0, 0)
Features3.AnchorPoint = Vector2.new(0.5, 0.5)
Features3.Transparency = 1
Features3.Text = "+500 Defense stats"
Features3.TextColor3 = Color3.new(0.772549, 0.772549, 0.772549)
Features3.TextSize = 14
Features3.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic)
Features3.TextScaled = true
Features3.TextWrapped = true
Features3.Parent = Defense

local Sword = Instance.new("TextButton")
Sword.Name = "Sword"
Sword.Position = UDim2.new(0.5, 0, 0.015, 0)
Sword.Size = UDim2.new(0.95, 0, 0.075, 0)
Sword.BackgroundColor3 = Color3.new(1, 1, 1)
Sword.BorderSizePixel = 0
Sword.BorderColor3 = Color3.new(0, 0, 0)
Sword.AnchorPoint = Vector2.new(0.5, 0)
Sword.Text = ""
Sword.TextColor3 = Color3.new(0, 0, 0)
Sword.TextSize = 14
Sword.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Sword.Parent = List

local UIStroke13 = Instance.new("UIStroke")
UIStroke13.Name = "UIStroke"
UIStroke13.Color = Color3.new(1, 0.882353, 0)
UIStroke13.Thickness = 2
UIStroke13.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke13.Parent = Sword

local UIGradient7 = Instance.new("UIGradient")
UIGradient7.Name = "UIGradient"
UIGradient7.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.12549, 0.188235, 0.113725)), ColorSequenceKeypoint.new(0.5, Color3.new(0.156863, 0.156863, 0.156863)), ColorSequenceKeypoint.new(1, Color3.new(0.156863, 0.156863, 0.156863))})
UIGradient7.Parent = Sword

local Logo4 = Instance.new("ImageLabel")
Logo4.Name = "Logo"
Logo4.Position = UDim2.new(0.1, 0, 0.5, 0)
Logo4.Size = UDim2.new(1.3, 0, 1.3, 0)
Logo4.BackgroundColor3 = Color3.new(1, 1, 1)
Logo4.BackgroundTransparency = 1
Logo4.BorderSizePixel = 0
Logo4.BorderColor3 = Color3.new(0, 0, 0)
Logo4.AnchorPoint = Vector2.new(0.5, 0.5)
Logo4.Transparency = 1
Logo4.Image = "rbxassetid://105688057956034"
Logo4.Parent = Sword

local UIAspectRatioConstraint5 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint5.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint5.Parent = Logo4

local Name4 = Instance.new("TextLabel")
Name4.Name = "Name"
Name4.Position = UDim2.new(0.5, 0, 0.25, 0)
Name4.Size = UDim2.new(0.75, 0, 0.5, 0)
Name4.BackgroundColor3 = Color3.new(1, 1, 1)
Name4.BackgroundTransparency = 1
Name4.BorderSizePixel = 0
Name4.BorderColor3 = Color3.new(0, 0, 0)
Name4.AnchorPoint = Vector2.new(0.5, 0.5)
Name4.Transparency = 1
Name4.Text = "Sword"
Name4.TextColor3 = Color3.new(1, 1, 1)
Name4.TextSize = 14
Name4.FontFace = Font.new("rbxasset://fonts/families/HighwayGothic.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Name4.TextScaled = true
Name4.TextWrapped = true
Name4.Parent = Sword

local UIStroke14 = Instance.new("UIStroke")
UIStroke14.Name = "UIStroke"
UIStroke14.Thickness = 1.5
UIStroke14.Parent = Name4

local Features4 = Instance.new("TextLabel")
Features4.Name = "Features"
Features4.Position = UDim2.new(0.6, 0, 0.75, 0)
Features4.Size = UDim2.new(0.75, 0, 0.35, 0)
Features4.BackgroundColor3 = Color3.new(1, 1, 1)
Features4.BackgroundTransparency = 1
Features4.BorderSizePixel = 0
Features4.BorderColor3 = Color3.new(0, 0, 0)
Features4.AnchorPoint = Vector2.new(0.5, 0.5)
Features4.Transparency = 1
Features4.Text = "+500 Sword stats"
Features4.TextColor3 = Color3.new(0.772549, 0.772549, 0.772549)
Features4.TextSize = 14
Features4.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic)
Features4.TextScaled = true
Features4.TextWrapped = true
Features4.Parent = Sword

local HYPER_ = Instance.new("TextButton")
HYPER_.Name = "HYPER!"
HYPER_.Position = UDim2.new(0.5, 0, 0.375, 0)
HYPER_.Size = UDim2.new(0.95, 0, 0.075, 0)
HYPER_.BackgroundColor3 = Color3.new(1, 1, 1)
HYPER_.BorderSizePixel = 0
HYPER_.BorderColor3 = Color3.new(0, 0, 0)
HYPER_.AnchorPoint = Vector2.new(0.5, 0)
HYPER_.Text = ""
HYPER_.TextColor3 = Color3.new(0, 0, 0)
HYPER_.TextSize = 14
HYPER_.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
HYPER_.Parent = List

local UIStroke15 = Instance.new("UIStroke")
UIStroke15.Name = "UIStroke"
UIStroke15.Color = Color3.new(1, 0.882353, 0)
UIStroke15.Thickness = 2
UIStroke15.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke15.Parent = HYPER_

local UIGradient8 = Instance.new("UIGradient")
UIGradient8.Name = "UIGradient"
UIGradient8.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.12549, 0.188235, 0.113725)), ColorSequenceKeypoint.new(0.5, Color3.new(0.156863, 0.156863, 0.156863)), ColorSequenceKeypoint.new(1, Color3.new(0.156863, 0.156863, 0.156863))})
UIGradient8.Parent = HYPER_

local Logo5 = Instance.new("ImageLabel")
Logo5.Name = "Logo"
Logo5.Position = UDim2.new(0.11, 0, 0.5, 0)
Logo5.Size = UDim2.new(1.3, 0, 1.3, 0)
Logo5.BackgroundColor3 = Color3.new(1, 1, 1)
Logo5.BackgroundTransparency = 1
Logo5.BorderSizePixel = 0
Logo5.BorderColor3 = Color3.new(0, 0, 0)
Logo5.AnchorPoint = Vector2.new(0.5, 0.5)
Logo5.Transparency = 1
Logo5.Image = "rbxassetid://119569121742874"
Logo5.Parent = HYPER_

local UIAspectRatioConstraint6 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint6.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint6.Parent = Logo5

local Name5 = Instance.new("TextLabel")
Name5.Name = "Name"
Name5.Position = UDim2.new(0.5, 0, 0.25, 0)
Name5.Size = UDim2.new(0.75, 0, 0.5, 0)
Name5.BackgroundColor3 = Color3.new(1, 1, 1)
Name5.BackgroundTransparency = 1
Name5.BorderSizePixel = 0
Name5.BorderColor3 = Color3.new(0, 0, 0)
Name5.AnchorPoint = Vector2.new(0.5, 0.5)
Name5.Transparency = 1
Name5.Text = "HYPER!"
Name5.TextColor3 = Color3.new(1, 0.784314, 0)
Name5.TextSize = 14
Name5.FontFace = Font.new("rbxasset://fonts/families/HighwayGothic.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Name5.TextScaled = true
Name5.TextWrapped = true
Name5.Parent = HYPER_

local UIStroke16 = Instance.new("UIStroke")
UIStroke16.Name = "UIStroke"
UIStroke16.Thickness = 1.5
UIStroke16.Parent = Name5

local Features5 = Instance.new("TextLabel")
Features5.Name = "Features"
Features5.Position = UDim2.new(0.6, 0, 0.75, 0)
Features5.Size = UDim2.new(0.75, 0, 0.35, 0)
Features5.BackgroundColor3 = Color3.new(1, 1, 1)
Features5.BackgroundTransparency = 1
Features5.BorderSizePixel = 0
Features5.BorderColor3 = Color3.new(0, 0, 0)
Features5.AnchorPoint = Vector2.new(0.5, 0.5)
Features5.Transparency = 1
Features5.Text = "Increases attack speed by 35%"
Features5.TextColor3 = Color3.new(0.772549, 0.772549, 0.772549)
Features5.TextSize = 14
Features5.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic)
Features5.TextScaled = true
Features5.TextWrapped = true
Features5.Parent = HYPER_

local Armor = Instance.new("TextButton")
Armor.Name = "Armor"
Armor.Position = UDim2.new(0.5, 0, 0.465, 0)
Armor.Size = UDim2.new(0.95, 0, 0.075, 0)
Armor.BackgroundColor3 = Color3.new(1, 1, 1)
Armor.BorderSizePixel = 0
Armor.BorderColor3 = Color3.new(0, 0, 0)
Armor.AnchorPoint = Vector2.new(0.5, 0)
Armor.Text = ""
Armor.TextColor3 = Color3.new(0, 0, 0)
Armor.TextSize = 14
Armor.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Armor.Parent = List

local UIStroke17 = Instance.new("UIStroke")
UIStroke17.Name = "UIStroke"
UIStroke17.Color = Color3.new(1, 0.882353, 0)
UIStroke17.Thickness = 2
UIStroke17.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke17.Parent = Armor

local UIGradient9 = Instance.new("UIGradient")
UIGradient9.Name = "UIGradient"
UIGradient9.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.12549, 0.188235, 0.113725)), ColorSequenceKeypoint.new(0.5, Color3.new(0.156863, 0.156863, 0.156863)), ColorSequenceKeypoint.new(1, Color3.new(0.156863, 0.156863, 0.156863))})
UIGradient9.Parent = Armor

local Logo6 = Instance.new("ImageLabel")
Logo6.Name = "Logo"
Logo6.Position = UDim2.new(0.11, 0, 0.5, 0)
Logo6.Size = UDim2.new(1, 0, 1, 0)
Logo6.BackgroundColor3 = Color3.new(1, 1, 1)
Logo6.BackgroundTransparency = 1
Logo6.BorderSizePixel = 0
Logo6.BorderColor3 = Color3.new(0, 0, 0)
Logo6.AnchorPoint = Vector2.new(0.5, 0.5)
Logo6.Transparency = 1
Logo6.Image = "rbxassetid://72071066664937"
Logo6.Parent = Armor

local UIAspectRatioConstraint7 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint7.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint7.Parent = Logo6

local Name6 = Instance.new("TextLabel")
Name6.Name = "Name"
Name6.Position = UDim2.new(0.5, 0, 0.25, 0)
Name6.Size = UDim2.new(0.75, 0, 0.5, 0)
Name6.BackgroundColor3 = Color3.new(1, 1, 1)
Name6.BackgroundTransparency = 1
Name6.BorderSizePixel = 0
Name6.BorderColor3 = Color3.new(0, 0, 0)
Name6.AnchorPoint = Vector2.new(0.5, 0.5)
Name6.Transparency = 1
Name6.Text = "Armor"
Name6.TextColor3 = Color3.new(1, 1, 1)
Name6.TextSize = 14
Name6.FontFace = Font.new("rbxasset://fonts/families/HighwayGothic.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Name6.TextScaled = true
Name6.TextWrapped = true
Name6.Parent = Armor

local UIStroke18 = Instance.new("UIStroke")
UIStroke18.Name = "UIStroke"
UIStroke18.Thickness = 1.5
UIStroke18.Parent = Name6

local Features6 = Instance.new("TextLabel")
Features6.Name = "Features"
Features6.Position = UDim2.new(0.6, 0, 0.75, 0)
Features6.Size = UDim2.new(0.75, 0, 0.35, 0)
Features6.BackgroundColor3 = Color3.new(1, 1, 1)
Features6.BackgroundTransparency = 1
Features6.BorderSizePixel = 0
Features6.BorderColor3 = Color3.new(0, 0, 0)
Features6.AnchorPoint = Vector2.new(0.5, 0.5)
Features6.Transparency = 1
Features6.Text = "+10% Armor (-1% for each bonus)"
Features6.TextColor3 = Color3.new(0.772549, 0.772549, 0.772549)
Features6.TextSize = 14
Features6.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic)
Features6.TextScaled = true
Features6.TextWrapped = true
Features6.Parent = Armor

local Shadow = Instance.new("TextButton")
Shadow.Name = "Shadow"
Shadow.Position = UDim2.new(0.5, 0, 0.555, 0)
Shadow.Size = UDim2.new(0.95, 0, 0.075, 0)
Shadow.BackgroundColor3 = Color3.new(1, 1, 1)
Shadow.BorderSizePixel = 0
Shadow.BorderColor3 = Color3.new(0, 0, 0)
Shadow.AnchorPoint = Vector2.new(0.5, 0)
Shadow.Text = ""
Shadow.TextColor3 = Color3.new(0, 0, 0)
Shadow.TextSize = 14
Shadow.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Shadow.Parent = List

local UIStroke19 = Instance.new("UIStroke")
UIStroke19.Name = "UIStroke"
UIStroke19.Color = Color3.new(1, 0.882353, 0)
UIStroke19.Thickness = 2
UIStroke19.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke19.Parent = Shadow

local UIGradient10 = Instance.new("UIGradient")
UIGradient10.Name = "UIGradient"
UIGradient10.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.12549, 0.188235, 0.113725)), ColorSequenceKeypoint.new(0.5, Color3.new(0.156863, 0.156863, 0.156863)), ColorSequenceKeypoint.new(1, Color3.new(0.156863, 0.156863, 0.156863))})
UIGradient10.Parent = Shadow

local Logo7 = Instance.new("ImageLabel")
Logo7.Name = "Logo"
Logo7.Position = UDim2.new(0.11, 0, 0.5, 0)
Logo7.Size = UDim2.new(1.3, 0, 1.3, 0)
Logo7.BackgroundColor3 = Color3.new(1, 1, 1)
Logo7.BackgroundTransparency = 1
Logo7.BorderSizePixel = 0
Logo7.BorderColor3 = Color3.new(0, 0, 0)
Logo7.AnchorPoint = Vector2.new(0.5, 0.5)
Logo7.Transparency = 1
Logo7.Image = "rbxassetid://90433393676384"
Logo7.Parent = Shadow

local UIAspectRatioConstraint8 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint8.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint8.Parent = Logo7

local Name7 = Instance.new("TextLabel")
Name7.Name = "Name"
Name7.Position = UDim2.new(0.5, 0, 0.25, 0)
Name7.Size = UDim2.new(0.75, 0, 0.5, 0)
Name7.BackgroundColor3 = Color3.new(1, 1, 1)
Name7.BackgroundTransparency = 1
Name7.BorderSizePixel = 0
Name7.BorderColor3 = Color3.new(0, 0, 0)
Name7.AnchorPoint = Vector2.new(0.5, 0.5)
Name7.Transparency = 1
Name7.Text = "Shadow"
Name7.TextColor3 = Color3.new(0.705882, 0, 1)
Name7.TextSize = 14
Name7.FontFace = Font.new("rbxasset://fonts/families/HighwayGothic.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Name7.TextScaled = true
Name7.TextWrapped = true
Name7.Parent = Shadow

local UIStroke20 = Instance.new("UIStroke")
UIStroke20.Name = "UIStroke"
UIStroke20.Thickness = 1.5
UIStroke20.Parent = Name7

local Features7 = Instance.new("TextLabel")
Features7.Name = "Features"
Features7.Position = UDim2.new(0.6, 0, 0.75, 0)
Features7.Size = UDim2.new(0.75, 0, 0.35, 0)
Features7.BackgroundColor3 = Color3.new(1, 1, 1)
Features7.BackgroundTransparency = 1
Features7.BorderSizePixel = 0
Features7.BorderColor3 = Color3.new(0, 0, 0)
Features7.AnchorPoint = Vector2.new(0.5, 0.5)
Features7.Transparency = 1
Features7.Text = "Every 60 seconds, a shadow is born."
Features7.TextColor3 = Color3.new(0.772549, 0.772549, 0.772549)
Features7.TextSize = 14
Features7.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic)
Features7.TextScaled = true
Features7.TextWrapped = true
Features7.Parent = Shadow

local All_Cooldowns = Instance.new("TextButton")
All_Cooldowns.Name = "All Cooldowns"
All_Cooldowns.Position = UDim2.new(0.5, 0, 0.645, 0)
All_Cooldowns.Size = UDim2.new(0.95, 0, 0.075, 0)
All_Cooldowns.BackgroundColor3 = Color3.new(1, 1, 1)
All_Cooldowns.BorderSizePixel = 0
All_Cooldowns.BorderColor3 = Color3.new(0, 0, 0)
All_Cooldowns.AnchorPoint = Vector2.new(0.5, 0)
All_Cooldowns.Text = ""
All_Cooldowns.TextColor3 = Color3.new(0, 0, 0)
All_Cooldowns.TextSize = 14
All_Cooldowns.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
All_Cooldowns.Parent = List

local UIStroke21 = Instance.new("UIStroke")
UIStroke21.Name = "UIStroke"
UIStroke21.Color = Color3.new(1, 0.882353, 0)
UIStroke21.Thickness = 2
UIStroke21.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke21.Parent = All_Cooldowns

local UIGradient11 = Instance.new("UIGradient")
UIGradient11.Name = "UIGradient"
UIGradient11.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.12549, 0.188235, 0.113725)), ColorSequenceKeypoint.new(0.5, Color3.new(0.156863, 0.156863, 0.156863)), ColorSequenceKeypoint.new(1, Color3.new(0.156863, 0.156863, 0.156863))})
UIGradient11.Parent = All_Cooldowns

local Logo8 = Instance.new("ImageLabel")
Logo8.Name = "Logo"
Logo8.Position = UDim2.new(0.11, 0, 0.5, 0)
Logo8.Size = UDim2.new(1, 0, 1, 0)
Logo8.BackgroundColor3 = Color3.new(1, 1, 1)
Logo8.BackgroundTransparency = 1
Logo8.BorderSizePixel = 0
Logo8.BorderColor3 = Color3.new(0, 0, 0)
Logo8.AnchorPoint = Vector2.new(0.5, 0.5)
Logo8.Transparency = 1
Logo8.Image = "rbxassetid://135833090144444"
Logo8.Parent = All_Cooldowns

local UIAspectRatioConstraint9 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint9.Name = "UIAspectRatioConstraint"
UIAspectRatioConstraint9.AspectRatio = 0.8999999761581421
UIAspectRatioConstraint9.Parent = Logo8

local Name8 = Instance.new("TextLabel")
Name8.Name = "Name"
Name8.Position = UDim2.new(0.5, 0, 0.25, 0)
Name8.Size = UDim2.new(0.75, 0, 0.5, 0)
Name8.BackgroundColor3 = Color3.new(1, 1, 1)
Name8.BackgroundTransparency = 1
Name8.BorderSizePixel = 0
Name8.BorderColor3 = Color3.new(0, 0, 0)
Name8.AnchorPoint = Vector2.new(0.5, 0.5)
Name8.Transparency = 1
Name8.Text = "All Cooldowns"
Name8.TextColor3 = Color3.new(1, 1, 1)
Name8.TextSize = 14
Name8.FontFace = Font.new("rbxasset://fonts/families/HighwayGothic.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Name8.TextScaled = true
Name8.TextWrapped = true
Name8.Parent = All_Cooldowns

local UIStroke22 = Instance.new("UIStroke")
UIStroke22.Name = "UIStroke"
UIStroke22.Thickness = 1.5
UIStroke22.Parent = Name8

local Features8 = Instance.new("TextLabel")
Features8.Name = "Features"
Features8.Position = UDim2.new(0.6, 0, 0.75, 0)
Features8.Size = UDim2.new(0.75, 0, 0.35, 0)
Features8.BackgroundColor3 = Color3.new(1, 1, 1)
Features8.BackgroundTransparency = 1
Features8.BorderSizePixel = 0
Features8.BorderColor3 = Color3.new(0, 0, 0)
Features8.AnchorPoint = Vector2.new(0.5, 0.5)
Features8.Transparency = 1
Features8.Text = "All Cooldowns increased by 10%."
Features8.TextColor3 = Color3.new(0.772549, 0.772549, 0.772549)
Features8.TextSize = 14
Features8.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic)
Features8.TextScaled = true
Features8.TextWrapped = true
Features8.Parent = All_Cooldowns

local Overflow = Instance.new("TextButton")
Overflow.Name = "Overflow"
Overflow.Position = UDim2.new(0.5, 0, 0.735, 0)
Overflow.Size = UDim2.new(0.95, 0, 0.075, 0)
Overflow.BackgroundColor3 = Color3.new(1, 1, 1)
Overflow.BorderSizePixel = 0
Overflow.BorderColor3 = Color3.new(0, 0, 0)
Overflow.AnchorPoint = Vector2.new(0.5, 0)
Overflow.Text = ""
Overflow.TextColor3 = Color3.new(0, 0, 0)
Overflow.TextSize = 14
Overflow.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Overflow.Parent = List

local UIStroke23 = Instance.new("UIStroke")
UIStroke23.Name = "UIStroke"
UIStroke23.Color = Color3.new(1, 0.882353, 0)
UIStroke23.Thickness = 2
UIStroke23.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke23.Parent = Overflow

local UIGradient12 = Instance.new("UIGradient")
UIGradient12.Name = "UIGradient"
UIGradient12.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.12549, 0.188235, 0.113725)), ColorSequenceKeypoint.new(0.5, Color3.new(0.156863, 0.156863, 0.156863)), ColorSequenceKeypoint.new(1, Color3.new(0.156863, 0.156863, 0.156863))})
UIGradient12.Parent = Overflow

local Logo9 = Instance.new("ImageLabel")
Logo9.Name = "Logo"
Logo9.Position = UDim2.new(0.11, 0, 0.5, 0)
Logo9.Size = UDim2.new(1, 0, 1, 0)
Logo9.BackgroundColor3 = Color3.new(1, 1, 1)
Logo9.BackgroundTransparency = 1
Logo9.BorderSizePixel = 0
Logo9.BorderColor3 = Color3.new(0, 0, 0)
Logo9.AnchorPoint = Vector2.new(0.5, 0.5)
Logo9.Transparency = 1
Logo9.Image = "rbxassetid://112128389041636"
Logo9.Parent = Overflow

local UIAspectRatioConstraint10 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint10.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint10.Parent = Logo9

local Name9 = Instance.new("TextLabel")
Name9.Name = "Name"
Name9.Position = UDim2.new(0.5, 0, 0.25, 0)
Name9.Size = UDim2.new(0.75, 0, 0.5, 0)
Name9.BackgroundColor3 = Color3.new(1, 1, 1)
Name9.BackgroundTransparency = 1
Name9.BorderSizePixel = 0
Name9.BorderColor3 = Color3.new(0, 0, 0)
Name9.AnchorPoint = Vector2.new(0.5, 0.5)
Name9.Transparency = 1
Name9.Text = "Overflow"
Name9.TextColor3 = Color3.new(0.290196, 0.858824, 1)
Name9.TextSize = 14
Name9.FontFace = Font.new("rbxasset://fonts/families/HighwayGothic.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Name9.TextScaled = true
Name9.TextWrapped = true
Name9.Parent = Overflow

local UIStroke24 = Instance.new("UIStroke")
UIStroke24.Name = "UIStroke"
UIStroke24.Thickness = 1.5
UIStroke24.Parent = Name9

local Features9 = Instance.new("TextLabel")
Features9.Name = "Features"
Features9.Position = UDim2.new(0.6, 0, 0.75, 0)
Features9.Size = UDim2.new(0.75, 0, 0.5, 0)
Features9.BackgroundColor3 = Color3.new(1, 1, 1)
Features9.BackgroundTransparency = 1
Features9.BorderSizePixel = 0
Features9.BorderColor3 = Color3.new(0, 0, 0)
Features9.AnchorPoint = Vector2.new(0.5, 0.5)
Features9.Transparency = 1
Features9.Text = "Every 15 seconds, gain 6000 Overflow health."
Features9.TextColor3 = Color3.new(0.772549, 0.772549, 0.772549)
Features9.TextSize = 14
Features9.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic)
Features9.TextScaled = true
Features9.TextWrapped = true
Features9.Parent = Overflow

local Fortress = Instance.new("TextButton")
Fortress.Name = "Fortress"
Fortress.Position = UDim2.new(0.5, 0, 0.825, 0)
Fortress.Size = UDim2.new(0.95, 0, 0.075, 0)
Fortress.BackgroundColor3 = Color3.new(1, 1, 1)
Fortress.BorderSizePixel = 0
Fortress.BorderColor3 = Color3.new(0, 0, 0)
Fortress.AnchorPoint = Vector2.new(0.5, 0)
Fortress.Text = ""
Fortress.TextColor3 = Color3.new(0, 0, 0)
Fortress.TextSize = 14
Fortress.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Fortress.Parent = List

local UIStroke25 = Instance.new("UIStroke")
UIStroke25.Name = "UIStroke"
UIStroke25.Color = Color3.new(1, 0.882353, 0)
UIStroke25.Thickness = 2
UIStroke25.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke25.Parent = Fortress

local UIGradient13 = Instance.new("UIGradient")
UIGradient13.Name = "UIGradient"
UIGradient13.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.12549, 0.188235, 0.113725)), ColorSequenceKeypoint.new(0.5, Color3.new(0.156863, 0.156863, 0.156863)), ColorSequenceKeypoint.new(1, Color3.new(0.156863, 0.156863, 0.156863))})
UIGradient13.Parent = Fortress

local Logo10 = Instance.new("ImageLabel")
Logo10.Name = "Logo"
Logo10.Position = UDim2.new(0.145, 0, 0.5, 0)
Logo10.Size = UDim2.new(1.125, 0, 1.125, 0)
Logo10.BackgroundColor3 = Color3.new(1, 1, 1)
Logo10.BackgroundTransparency = 1
Logo10.BorderSizePixel = 0
Logo10.BorderColor3 = Color3.new(0, 0, 0)
Logo10.AnchorPoint = Vector2.new(0.5, 0.5)
Logo10.Transparency = 1
Logo10.Image = "rbxassetid://122470677660883"
Logo10.Parent = Fortress

local UIAspectRatioConstraint11 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint11.Name = "UIAspectRatioConstraint"
UIAspectRatioConstraint11.AspectRatio = 1.2999999523162842
UIAspectRatioConstraint11.Parent = Logo10

local Name10 = Instance.new("TextLabel")
Name10.Name = "Name"
Name10.Position = UDim2.new(0.5, 0, 0.25, 0)
Name10.Size = UDim2.new(0.75, 0, 0.5, 0)
Name10.BackgroundColor3 = Color3.new(1, 1, 1)
Name10.BackgroundTransparency = 1
Name10.BorderSizePixel = 0
Name10.BorderColor3 = Color3.new(0, 0, 0)
Name10.AnchorPoint = Vector2.new(0.5, 0.5)
Name10.Transparency = 1
Name10.Text = "Fortress"
Name10.TextColor3 = Color3.new(1, 1, 1)
Name10.TextSize = 14
Name10.FontFace = Font.new("rbxasset://fonts/families/HighwayGothic.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Name10.TextScaled = true
Name10.TextWrapped = true
Name10.Parent = Fortress

local UIStroke26 = Instance.new("UIStroke")
UIStroke26.Name = "UIStroke"
UIStroke26.Thickness = 1.5
UIStroke26.Parent = Name10

local Features10 = Instance.new("TextLabel")
Features10.Name = "Features"
Features10.Position = UDim2.new(0.6, 0, 0.75, 0)
Features10.Size = UDim2.new(0.75, 0, 0.35, 0)
Features10.BackgroundColor3 = Color3.new(1, 1, 1)
Features10.BackgroundTransparency = 1
Features10.BorderSizePixel = 0
Features10.BorderColor3 = Color3.new(0, 0, 0)
Features10.AnchorPoint = Vector2.new(0.5, 0.5)
Features10.Transparency = 1
Features10.Text = "Stuns no longer apply to you."
Features10.TextColor3 = Color3.new(0.772549, 0.772549, 0.772549)
Features10.TextSize = 14
Features10.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic)
Features10.TextScaled = true
Features10.TextWrapped = true
Features10.Parent = Fortress

local Race_Meter = Instance.new("TextButton")
Race_Meter.Name = "Race Meter"
Race_Meter.Position = UDim2.new(0.5, 0, 0.915, 0)
Race_Meter.Size = UDim2.new(0.95, 0, 0.075, 0)
Race_Meter.BackgroundColor3 = Color3.new(1, 1, 1)
Race_Meter.BorderSizePixel = 0
Race_Meter.BorderColor3 = Color3.new(0, 0, 0)
Race_Meter.AnchorPoint = Vector2.new(0.5, 0)
Race_Meter.Text = ""
Race_Meter.TextColor3 = Color3.new(0, 0, 0)
Race_Meter.TextSize = 14
Race_Meter.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Race_Meter.Parent = List

local UIStroke27 = Instance.new("UIStroke")
UIStroke27.Name = "UIStroke"
UIStroke27.Color = Color3.new(1, 0.882353, 0)
UIStroke27.Thickness = 2
UIStroke27.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke27.Parent = Race_Meter

local UIGradient14 = Instance.new("UIGradient")
UIGradient14.Name = "UIGradient"
UIGradient14.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.12549, 0.188235, 0.113725)), ColorSequenceKeypoint.new(0.5, Color3.new(0.156863, 0.156863, 0.156863)), ColorSequenceKeypoint.new(1, Color3.new(0.156863, 0.156863, 0.156863))})
UIGradient14.Parent = Race_Meter

local Logo11 = Instance.new("ImageLabel")
Logo11.Name = "Logo"
Logo11.Position = UDim2.new(0.135, 0, 0.5, 0)
Logo11.Size = UDim2.new(1.2, 0, 1.2, 0)
Logo11.BackgroundColor3 = Color3.new(1, 1, 1)
Logo11.BackgroundTransparency = 1
Logo11.BorderSizePixel = 0
Logo11.BorderColor3 = Color3.new(0, 0, 0)
Logo11.AnchorPoint = Vector2.new(0.5, 0.5)
Logo11.Transparency = 1
Logo11.Image = "rbxassetid://78950127265032"
Logo11.Parent = Race_Meter

local UIAspectRatioConstraint12 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint12.Name = "UIAspectRatioConstraint"
UIAspectRatioConstraint12.AspectRatio = 1.2000000476837158
UIAspectRatioConstraint12.Parent = Logo11

local Name11 = Instance.new("TextLabel")
Name11.Name = "Name"
Name11.Position = UDim2.new(0.5, 0, 0.25, 0)
Name11.Size = UDim2.new(0.75, 0, 0.5, 0)
Name11.BackgroundColor3 = Color3.new(1, 1, 1)
Name11.BackgroundTransparency = 1
Name11.BorderSizePixel = 0
Name11.BorderColor3 = Color3.new(0, 0, 0)
Name11.AnchorPoint = Vector2.new(0.5, 0.5)
Name11.Transparency = 1
Name11.Text = "Race Meter"
Name11.TextColor3 = Color3.new(1, 1, 1)
Name11.TextSize = 14
Name11.FontFace = Font.new("rbxasset://fonts/families/HighwayGothic.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Name11.TextScaled = true
Name11.TextWrapped = true
Name11.Parent = Race_Meter

local UIStroke28 = Instance.new("UIStroke")
UIStroke28.Name = "UIStroke"
UIStroke28.Thickness = 1.5
UIStroke28.Parent = Name11

local Features11 = Instance.new("TextLabel")
Features11.Name = "Features"
Features11.Position = UDim2.new(0.6, 0, 0.75, 0)
Features11.Size = UDim2.new(0.75, 0, 0.5, 0)
Features11.BackgroundColor3 = Color3.new(1, 1, 1)
Features11.BackgroundTransparency = 1
Features11.BorderSizePixel = 0
Features11.BorderColor3 = Color3.new(0, 0, 0)
Features11.AnchorPoint = Vector2.new(0.5, 0.5)
Features11.Transparency = 1
Features11.Text = "Gain 20% additional race meter from all sources."
Features11.TextColor3 = Color3.new(0.772549, 0.772549, 0.772549)
Features11.TextSize = 14
Features11.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic)
Features11.TextScaled = true
Features11.TextWrapped = true
Features11.Parent = Race_Meter

local ExecutionTitle = Instance.new("TextLabel")
ExecutionTitle.Name = "ExecutionTitle"
ExecutionTitle.Position = UDim2.new(0.255, 0, 0.175, 0)
ExecutionTitle.Size = UDim2.new(0.45, 0, 0.1, 0)
ExecutionTitle.BackgroundColor3 = Color3.new(1, 1, 1)
ExecutionTitle.BackgroundTransparency = 1
ExecutionTitle.BorderSizePixel = 0
ExecutionTitle.BorderColor3 = Color3.new(0, 0, 0)
ExecutionTitle.AnchorPoint = Vector2.new(0.5, 0.5)
ExecutionTitle.Transparency = 1
ExecutionTitle.Text = "Execution"
ExecutionTitle.TextColor3 = Color3.new(1, 1, 1)
ExecutionTitle.TextSize = 14
ExecutionTitle.FontFace = Font.new("rbxasset://fonts/families/HighwayGothic.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
ExecutionTitle.TextScaled = true
ExecutionTitle.TextWrapped = true
ExecutionTitle.Parent = Main

local ListTitle = Instance.new("TextLabel")
ListTitle.Name = "ListTitle"
ListTitle.Position = UDim2.new(0.75, 0, 0.175, 0)
ListTitle.Size = UDim2.new(0.45, 0, 0.1, 0)
ListTitle.BackgroundColor3 = Color3.new(1, 1, 1)
ListTitle.BackgroundTransparency = 1
ListTitle.BorderSizePixel = 0
ListTitle.BorderColor3 = Color3.new(0, 0, 0)
ListTitle.AnchorPoint = Vector2.new(0.5, 0.5)
ListTitle.Transparency = 1
ListTitle.Text = "List"
ListTitle.TextColor3 = Color3.new(1, 1, 1)
ListTitle.TextSize = 14
ListTitle.FontFace = Font.new("rbxasset://fonts/families/HighwayGothic.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
ListTitle.TextScaled = true
ListTitle.TextWrapped = true
ListTitle.Parent = Main

local player = game.Players.LocalPlayer
local gui = player.PlayerGui:FindFirstChild("AutoBuffSelectionGui")

if gui then
	for _, obj in ipairs(gui:GetDescendants()) do
		if obj:IsA("TextLabel") then
			obj.TextTransparency = 0
		end
	end
end
