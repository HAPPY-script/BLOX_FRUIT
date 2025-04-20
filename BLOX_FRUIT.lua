game.StarterGui:SetCore("SendNotification", {
    Title = "Blox Fruit";
    Text = "Create by HAPPY script";
    Duration = 7;
    Icon = "rbxthumb://type=Asset&id=83522950280582&w=150&h=150";
})

local player = game.Players.LocalPlayer
local userInputService = game:GetService("UserInputService")

-- Tạo GUI chứa nút icon
local iconGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
iconGui.ResetOnSpawn = false

-- Tạo nút icon
local iconButton = Instance.new("ImageButton")
iconButton.Size = UDim2.new(0, 50, 0, 50)
iconButton.Position = UDim2.new(0.05, 0, 0.05, 0) -- Vị trí ban đầu
iconButton.BackgroundTransparency = 1
iconButton.Image = "rbxthumb://type=Asset&id=86710626358228&w=150&h=150" -- Icon bạn yêu cầu
iconButton.Parent = iconGui

-- Kéo thả nút icon
local dragging, dragInput, dragStart, startPos

iconButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = iconButton.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

iconButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

userInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart
        iconButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Biến kiểm soát menu
local menuVisible = false
local mainFrame = nil -- Biến chứa Frame chính của menu

-- Sự kiện khi bấm vào icon
iconButton.MouseButton1Click:Connect(function()
    if mainFrame then
        menuVisible = not menuVisible
        mainFrame.Visible = menuVisible -- Hiện hoặc ẩn menu
    else
        print("Menu chưa được gán! Hãy dán script menu vào và gán biến mainFrame.")
    end
end)

local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- Tạo GUI
local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 400, 0, 300)
Frame.Position = UDim2.new(0.3, 0, 0, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 2
Frame.Parent = ScreenGui
mainFrame = Frame -- Gán biến cho Frame chính của menu
mainFrame.Visible = false -- Ẩn menu lúc đầu

-- Cải thiện kéo thả menu
local dragging, dragInput, dragStart, startPos

Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Danh sách tab (Dễ dàng thêm tab mới)
local tabs = {
    {name = "Page change", icon = "rbxthumb://type=Asset&id=1587302690&w=150&h=150"},
    {name = "Status", icon = "rbxthumb://type=Asset&id=93942197037043&w=150&h=150"},
    {name = "Home", icon = "rbxthumb://type=Asset&id=13060262582&w=150&h=150"},
    {name = "Raid", icon = "rbxthumb://type=Asset&id=17600288795&w=150&h=150"},
    {name = "Fruit", icon = "rbxthumb://type=Asset&id=130882648&w=150&h=150"},
    {name = "Visual", icon = "rbxthumb://type=Asset&id=17688532644&w=150&h=150"},
    {name = "Player", icon = "rbxthumb://type=Asset&id=11656483343&w=150&h=150"},
    {name = "Tracker", icon = "rbxthumb://type=Asset&id=136258799911155&w=150&h=150"},
    {name = "Info", icon = "rbxthumb://type=Asset&id=11780939142&w=150&h=150"}
}

-- Tạo phần tab (bên trái)
local TabFrame = Instance.new("ScrollingFrame")
TabFrame.Size = UDim2.new(0, 50, 0.98, 0)
TabFrame.Position = UDim2.new(0, 0, 0, 5) -- Hạ thấp tab xuống để Home không bị che
TabFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TabFrame.ScrollBarThickness = 5
TabFrame.CanvasSize = UDim2.new(0, 0, 0, #tabs * 50) -- Đảm bảo đủ khoảng trống để lăn chuột
TabFrame.Parent = Frame

-- Tạo phần chính (chứa các nút)
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(1, -60, 1, -30)
ContentFrame.Position = UDim2.new(0, 55, 0, 30)
ContentFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ContentFrame.ScrollBarThickness = 5
ContentFrame.CanvasSize = UDim2.new(0, 0, 1.5, 0)
ContentFrame.Parent = Frame

-- Tiêu đề menu
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 30)
TitleLabel.Position = UDim2.new(0, 0, 0, 0)
TitleLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TitleLabel.Text = "Menu"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 20
TitleLabel.TextXAlignment = Enum.TextXAlignment.Center
TitleLabel.Parent = Frame

-- Chứa các khung chức năng theo từng tab
local sections = {}

for i, tab in ipairs(tabs) do
    -- Tạo nút tab
    local TabButton = Instance.new("ImageButton")
    TabButton.Size = UDim2.new(0, 40, 0, 40)
    TabButton.Position = UDim2.new(0, 5, 0, (i - 1) * 45 + 10) -- Hạ xuống để không che Home
    TabButton.Image = tab.icon
    TabButton.BackgroundTransparency = 1
    TabButton.Parent = TabFrame

    -- Tạo khung chứa nội dung của từng tab
    local SectionFrame = Instance.new("Frame")
    SectionFrame.Size = UDim2.new(1, 0, 1, 0)
    SectionFrame.BackgroundTransparency = 1
    SectionFrame.Visible = (i == 1)
    SectionFrame.Parent = ContentFrame
    sections[tab.name] = SectionFrame

    -- Sự kiện khi bấm vào tab
    TabButton.MouseButton1Click:Connect(function()
        for _, section in pairs(sections) do
            section.Visible = false
        end
        SectionFrame.Visible = true
        TitleLabel.Text = tab.name
    end)
end

-- Sửa lỗi lăn chuột tab
TabFrame.MouseWheelForward:Connect(function()
    TabFrame.CanvasPosition = TabFrame.CanvasPosition - Vector2.new(0, 30)
end)

TabFrame.MouseWheelBackward:Connect(function()
    TabFrame.CanvasPosition = TabFrame.CanvasPosition + Vector2.new(0, 30)
end)

-- 🚀 **Thêm chức năng vào tab "Home"**
local function CreateButton(parent, text, position, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0.9, 0, 0, 40)
    Button.Position = UDim2.new(0.05, 0, 0, position)
    Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Button.Text = text
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.Font = Enum.Font.SourceSansBold
    Button.TextSize = 16
    Button.Parent = parent
    Button.MouseButton1Click:Connect(callback)
end

--------------------------------------------------------------------------------------------------------------------------------------
--RAID
local RaidFrame = sections["Raid"]
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")

-- Nút bật/tắt Auto RAID
local toggleRaid = Instance.new("TextButton", RaidFrame)
toggleRaid.Size = UDim2.new(0, 90, 0, 30)
toggleRaid.Position = UDim2.new(0, 240, 0, 10)
toggleRaid.Text = "[⚔️] START"
toggleRaid.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
toggleRaid.TextColor3 = Color3.new(1, 1, 1)

-- Trạng thái RAID
local running = false
local autoClicking = false

-- Auto click loop
task.spawn(function()
	while true do
		if autoClicking then
			VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
			VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
		end
		task.wait(0.5)
	end
end)

-- Bật/tắt RAID khi bấm nút
toggleRaid.MouseButton1Click:Connect(function()
	running = not running
	autoClicking = running
	toggleRaid.Text = running and "[🛑] STOP" or "[⚔️] START"
	toggleRaid.BackgroundColor3 = running and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(0, 170, 255)
end)

-- Tween đến vị trí
local function tweenTo(pos)
	local dist = (hrp.Position - pos).Magnitude
	if dist > 5000 then return end
	local tween = TweenService:Create(hrp, TweenInfo.new(dist/300, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)})
	tween:Play()
	tween.Completed:Wait()
end

-- Tìm đảo có độ ưu tiên cao nhất
local function getHighestPriorityIsland()
	local island = workspace:FindFirstChild("Map")
	if island and island:FindFirstChild("RaidMap") then
		for i = 5, 1, -1 do
			local model = island.RaidMap:FindFirstChild("RaidIsland"..i)
			if model and model:IsA("Model") then
				return model
			end
		end
	end
	return nil
end

-- Lấy quái gần
local function getEnemiesNear(origin)
	local enemies = {}
	local folder = workspace:FindFirstChild("Enemies")
	if not folder then return enemies end
	for _, mob in ipairs(folder:GetChildren()) do
		if mob:IsA("Model") and mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChildOfClass("Humanoid") then
			local dist = (origin.Position - mob.HumanoidRootPart.Position).Magnitude
			if dist <= 5000 and mob.Humanoid.Health > 0 then
				table.insert(enemies, mob)
			end
		end
	end
	return enemies
end

-- Theo dõi và đánh quái
local function followEnemy(enemy)
	local hrpEnemy = enemy:FindFirstChild("HumanoidRootPart")
	if not hrpEnemy then return end
	while enemy:FindFirstChildOfClass("Humanoid") and enemy:FindFirstChildOfClass("Humanoid").Health > 0 and running do
		hrp.CFrame = CFrame.new(hrpEnemy.Position + Vector3.new(0, 30, 0))
		RunService.RenderStepped:Wait()
	end
end

-- Vòng lặp chính Auto RAID
task.spawn(function()
	while true do
		RunService.Heartbeat:Wait()
		if not running then continue end

		local island = getHighestPriorityIsland()
		if island then
			local root = island:IsA("Model") and island:FindFirstChild("PrimaryPart") or island.PrimaryPart or island:FindFirstChild("HumanoidRootPart")
			if not root then
				root = island:FindFirstChildWhichIsA("BasePart")
			end
			if root then
				tweenTo(root.Position + Vector3.new(0, 10, 0))
			end
		end

		local enemies = getEnemiesNear(hrp)
		if #enemies > 0 then
			for _, enemy in ipairs(enemies) do
				if not running then break end
				followEnemy(enemy)
			end
		end
	end
end)

--title
local HomeFrame = sections["Raid"]

local Title = Instance.new("TextLabel", HomeFrame)
Title.Size = UDim2.new(0, 220, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 10)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Text = "AUTO RAID💀"
Title.TextScaled = true
Title.Font = Enum.Font.SourceSansBold
Title.BorderSizePixel = 2
Title.BorderColor3 = Color3.new(255, 255, 255)

-------------------------------------------------------------------------------
--FRAM LV
local HomeFrame = sections["Home"]
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local mouse = player:GetMouse()
local currentQuestBeli = 0
local currentQuestKills = 0
local maxQuestKills = 10 -- số quái cần giết để hoàn thành
local expectedRewardBeli = 500000 -- mặc định, bạn sẽ thay theo từng vùng nếu cần
local VirtualInputManager = game:GetService("VirtualInputManager")

-- Nút bật/tắt Auto Farm
local autoFarmBtn = Instance.new("TextButton")
autoFarmBtn.Size = UDim2.new(0, 90, 0, 30)
autoFarmBtn.Position = UDim2.new(0, 240, 0, 10)
autoFarmBtn.Text = "OFF"
autoFarmBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
autoFarmBtn.TextColor3 = Color3.new(1, 1, 1)
autoFarmBtn.Font = Enum.Font.SourceSansBold
autoFarmBtn.TextScaled = true
autoFarmBtn.Parent = HomeFrame

-- Config vùng farm
local FarmZones = {
    {
        MinLevel = 0,
        MaxLevel = 9,
        MobName = "Trainee",
        FarmPos = Vector3.new(-2839.79, 41.05, 2153.06),
        QuestNPCPos = Vector3.new(-2721.94, 24.56, 2101.26),
        QuestName = "MarineQuest",
        QuestIndex = 1,
        RewardBeli = 350
    },
    {
        MinLevel = 10,
        MaxLevel = 14,
        MobName = "Monkey",
        FarmPos = Vector3.new(-1609.02, 20.89, 146.93),
        QuestNPCPos = Vector3.new(-1610.07, 20.89, 130.48),
        QuestName = "JungleQuest",
        QuestIndex = 1,
        RewardBeli = 800
    },
    {
        MinLevel = 15,
        MaxLevel = 29,
        MobName = "Gorilla",
        FarmPos = Vector3.new(-1307.42, 18.66, -401.41),
        QuestNPCPos = Vector3.new(-1610.07, 20.89, 130.48),
        QuestName = "Area2Quest",
        QuestIndex = 2,
        RewardBeli = 1200
    },
    {
        MinLevel = 30,
        MaxLevel = 39,
        MobName = "Pirate",
        FarmPos = Vector3.new(-1147.27, 55.41, 3983.74),
        QuestNPCPos = Vector3.new(-1121.64, 4.79, 3842.47),
        QuestName = "BuggyQuest1",
        QuestIndex = 1,
        RewardBeli = 3000
    },
    {
        MinLevel = 40,
        MaxLevel = 59,
        MobName = "Brute",
        FarmPos = Vector3.new(-1147.27, 55.41, 3983.74),
        QuestNPCPos = Vector3.new(-1121.64, 4.79, 3842.47),
        QuestName = "BuggyQuest1",
        QuestIndex = 2,
        RewardBeli = 3500
    },
    {
        MinLevel = 60,
        MaxLevel = 74,
        MobName = "Desert Bandit",
        FarmPos = Vector3.new(929.86, 6.47, 4271.35),
        QuestNPCPos = Vector3.new(914.87, 6.47, 4399.57),
        QuestName = "DesertQuest",
        QuestIndex = 1,
        RewardBeli = 4000
    },
    {
        MinLevel = 75,
        MaxLevel = 89,
        MobName = "Desert Officer",
        FarmPos = Vector3.new(1565.94, 11.12, 4389.14),
        QuestNPCPos = Vector3.new(914.87, 6.47, 4399.57),
        QuestName = "DesertQuest",
        QuestIndex = 2,
        RewardBeli = 4500
    },
    {
        MinLevel = 90,
        MaxLevel = 99,
        MobName = "Snow Bandit",
        FarmPos = Vector3.new(1376.77, 104.43, -1411.01),
        QuestNPCPos = Vector3.new(1375.02, 87.31, -1313.90),
        QuestName = "SnowQuest",
        QuestIndex = 1,
        RewardBeli = 5000
    },
    {
        MinLevel = 100,
        MaxLevel = 119,
        MobName = "Snowman",
        FarmPos = Vector3.new(1205.99, 105.81, -1522.20),
        QuestNPCPos = Vector3.new(1375.02, 87.31, -1313.90),
        QuestName = "SnowQuest",
        QuestIndex = 2,
        RewardBeli = 5500
    },
    {
        MinLevel = 120,
        MaxLevel = 149,
        MobName = "Chief Petty Officer",
        FarmPos = Vector3.new(-4715.38, 31.96, 4191.34),
        QuestNPCPos = Vector3.new(-5014.49, 22.49, 4324.33),
        QuestName = "MarineQuest2",
        QuestIndex = 1,
        RewardBeli = 6000
    },
    {
        MinLevel = 150,
        MaxLevel = 174,
        MobName = "Sky Bandit",
        FarmPos = Vector3.new(-4992.65, 278.10, -2856.87),
        QuestNPCPos = Vector3.new(-4860.68, 717.71, -2626.04),
        QuestName = "SkyQuest",
        QuestIndex = 1,
        RewardBeli = 7000
    },
    {
        MinLevel = 175,
        MaxLevel = 189,
        MobName = "Dark Master",
        FarmPos = Vector3.new(-5251.88, 388.69, -2257.42),
        QuestNPCPos = Vector3.new(-4860.68, 717.71, -2626.04),
        QuestName = "SkyQuest",
        QuestIndex = 2,
        RewardBeli = 7500
    },
    {
        MinLevel = 190,
        MaxLevel = 209,
        MobName = "Prisoner",
        FarmPos = Vector3.new(5325.13, 88.70, 715.62),
        QuestNPCPos = Vector3.new(5292.71, 1.69, 474.49),
        QuestName = "PrisonerQuest",
        QuestIndex = 1,
        RewardBeli = 7000
    },
    {
        MinLevel = 210,
        MaxLevel = 299,
        MobName = "Dangerous Prisoner",
        FarmPos = Vector3.new(5325.13, 88.70, 715.62),
        QuestNPCPos = Vector3.new(5292.71, 1.69, 474.49),
        QuestName = "PrisonerQuest",
        QuestIndex = 2,
        RewardBeli = 7500
    },
    {
        MinLevel = 220,
        MaxLevel = 299,
        MobName = "Warden",
        FarmPos = Vector3.new(5325.13, 88.70, 715.62),
        QuestNPCPos = Vector3.new(5183.75, 3.57, 705.09),
        QuestName = "ImpelQuest",
        QuestIndex = 1,
        RewardBeli = 6000
    },
    {
        MinLevel = 230,
        MaxLevel = 299,
        MobName = "Chief Warden",
        FarmPos = Vector3.new(5325.13, 88.70, 715.62),
        QuestNPCPos = Vector3.new(5183.75, 3.57, 705.09),
        QuestName = "ImpelQuest",
        QuestIndex = 2,
        RewardBeli = 10000
    },
    {
        MinLevel = 300,
        MaxLevel = 324,
        MobName = "Military Soldier",
        FarmPos = Vector3.new(-5404.68, 25.73, 8522.42),
        QuestNPCPos = Vector3.new(-5321.87, 8.63, 8502.13),
        QuestName = "MagmaQuest",
        QuestIndex = 1,
        RewardBeli = 8250
    },
    {
        MinLevel = 325,
        MaxLevel = 374,
        MobName = "Military Spy",
        FarmPos = Vector3.new(-5799.55, 98.00, 8781.13),
        QuestNPCPos = Vector3.new(-5321.87, 8.63, 8502.13),
        QuestName = "MagmaQuest",
        QuestIndex = 2,
        RewardBeli = 8500
    },
    {
        MinLevel = 375,
        MaxLevel = 399,
        MobName = "Fishman Warrior",
        FarmPos = Vector3.new(60941.54, 48.71, 1513.80),
        QuestNPCPos = Vector3.new(61113.66, 18.51, 1544.92),
        QuestName = "FishmanQuest",
        QuestIndex = 1,
        RewardBeli = 8750
    },
    {
        MinLevel = 400,
        MaxLevel = 449,
        MobName = "Fishman Commando",
        FarmPos = Vector3.new(61892.86, 18.52, 1481.29),
        QuestNPCPos = Vector3.new(61113.66, 18.51, 1544.92),
        QuestName = "FishmanQuest",
        QuestIndex = 2,
        RewardBeli = 9000
    },
    {
        MinLevel = 450,
        MaxLevel = 474,
        MobName = "God's Guard",
        FarmPos = Vector3.new(-4629.25, 849.94, -1941.40),
        QuestNPCPos = Vector3.new(-4718.40, 854.12, -1939.54),
        QuestName = "SkyExp1Quest",
        QuestIndex = 1,
        RewardBeli = 8750
    },
    {
        MinLevel = 475,
        MaxLevel = 524,
        MobName = "Shanda",
        FarmPos = Vector3.new(-7683.37, 5565.10, -437.47),
        QuestNPCPos = Vector3.new(-7845.91, 5558.07, -392.70),
        QuestName = "SkyExp1Quest",
        QuestIndex = 2,
        RewardBeli = 9000
    },
    {
        MinLevel = 525,
        MaxLevel = 549,
        MobName = "Royal Squad",
        FarmPos = Vector3.new(-7647.08, 5606.91, -1454.96),
        QuestNPCPos = Vector3.new(-7888.37, 5636.00, -1409.92),
        QuestName = "SkyExp2Quest",
        QuestIndex = 1,
        RewardBeli = 9500
    },
    {
        MinLevel = 550,
        MaxLevel = 624,
        MobName = "Royal Soldier",
        FarmPos = Vector3.new(-7859.01, 5626.31, -1709.91),
        QuestNPCPos = Vector3.new(-7888.37, 5636.00, -1409.92),
        QuestName = "SkyExp2Quest",
        QuestIndex = 2,
        RewardBeli = 9750
    },
    {
        MinLevel = 625,
        MaxLevel = 649,
        MobName = "Galley Pirate",
        FarmPos = Vector3.new(5575.72, 38.54, 3927.25),
        QuestNPCPos = Vector3.new(5261.02, 38.54, 4034.20),
        QuestName = "FountainQuest",
        QuestIndex = 1,
        RewardBeli = 10000
    },
    {
        MinLevel = 650,
        MaxLevel = 699,
        MobName = "Galley Captain",
        FarmPos = Vector3.new(5680.94, 51.82, 4865.71),
        QuestNPCPos = Vector3.new(5261.02, 38.54, 4034.20),
        QuestName = "FountainQuest",
        QuestIndex = 2,
        RewardBeli = 10000
    }, --------------------SEA 1-----------------------------------------------
    {  --------------------SEA 2-----------------------------------------------
        MinLevel = 700,
        MaxLevel = 724,
        MobName = "Raider",
        FarmPos = Vector3.new(-128.45, 39.00, 2284.68),
        QuestNPCPos = Vector3.new(-440.17, 77.54, 1851.46),
        QuestName = "Area1Quest",
        QuestIndex = 1,
        RewardBeli = 10250
    },
    {
        MinLevel = 725,
        MaxLevel = 774,
        MobName = "Mercenary",
        FarmPos = Vector3.new(-990.28, 73.05, 1402.77),
        QuestNPCPos = Vector3.new(-440.17, 77.54, 1851.46),
        QuestName = "Area1Quest",
        QuestIndex = 2,
        RewardBeli = 10500
    },
    {
        MinLevel = 775,
        MaxLevel = 799,
        MobName = "Swan Pirate",
        FarmPos = Vector3.new(842.49, 121.62, 1243.63),
        QuestNPCPos = Vector3.new(637.54, 73.15, 934.80),
        QuestName = "Area2Quest",
        QuestIndex = 1,
        RewardBeli = 10750
    },
    {
        MinLevel = 800,
        MaxLevel = 874,
        MobName = "Factory Staff",
        FarmPos = Vector3.new(327.91, 73.00, -19.81),
        QuestNPCPos = Vector3.new(637.54, 73.15, 934.80),
        QuestName = "Area2Quest",
        QuestIndex = 2,
        RewardBeli = 11000
    },
    {
        MinLevel = 875,
        MaxLevel = 899,
        MobName = "Marine Lieutenant",
        FarmPos = Vector3.new(-2866.94, 73.00, -3003.71),
        QuestNPCPos = Vector3.new(-2435.19, 73.20, -3232.76),
        QuestName = "MarineQuest3",
        QuestIndex = 1,
        RewardBeli = 11250
    },
    {
        MinLevel = 900,
        MaxLevel = 949,
        MobName = "Marine Captain",
        FarmPos = Vector3.new(-1956.02, 73.20, -3236.77),
        QuestNPCPos = Vector3.new(-2435.19, 73.20, -3232.76),
        QuestName = "MarineQuest3",
        QuestIndex = 2,
        RewardBeli = 11500
    },
    {
        MinLevel = 950,
        MaxLevel = 974,
        MobName = "Zombie",
        FarmPos = Vector3.new(-5624.78, 48.52, -711.50),
        QuestNPCPos = Vector3.new(-5506.25, 48.52, -811.98),
        QuestName = "ZombieQuest",
        QuestIndex = 1,
        RewardBeli = 11750
    },
    {
        MinLevel = 975,
        MaxLevel = 999,
        MobName = "Vampire",
        FarmPos = Vector3.new(-6017.56, 6.44, -1305.21),
        QuestNPCPos = Vector3.new(-5506.25, 48.52, -811.98),
        QuestName = "ZombieQuest",
        QuestIndex = 2,
        RewardBeli = 12000
    },
    {
        MinLevel = 1000,
        MaxLevel = 1049,
        MobName = "Snow Trooper",
        FarmPos = Vector3.new(558.35, 401.46, -5424.40),
        QuestNPCPos = Vector3.new(602.76, 401.46, -5356.61),
        QuestName = "SnowMountainQuest",
        QuestIndex = 1,
        RewardBeli = 12250
    },
    {
        MinLevel = 1050,
        MaxLevel = 1099,
        MobName = "Winter Warrior",
        FarmPos = Vector3.new(1176.49, 429.46, -5231.42),
        QuestNPCPos = Vector3.new(602.76, 401.46, -5356.61),
        QuestName = "SnowMountainQuest",
        QuestIndex = 2,
        RewardBeli = 12500
    },
    {
        MinLevel = 1100,
        MaxLevel = 1124,
        MobName = "Lab Subordinate",
        FarmPos = Vector3.new(-5778.44, 15.99, -4479.97),
        QuestNPCPos = Vector3.new(-6043.20, 15.99, -4909.17),
        QuestName = "IceSideQuest",
        QuestIndex = 1,
        RewardBeli = 12250
    },
    {
        MinLevel = 1125,
        MaxLevel = 1174,
        MobName = "Horned Warrior",
        FarmPos = Vector3.new(-6265.67, 15.99, -5766.91),
        QuestNPCPos = Vector3.new(-6043.20, 15.99, -4909.17),
        QuestName = "IceSideQuest",
        QuestIndex = 2,
        RewardBeli = 12500
    },
    {
        MinLevel = 1175,
        MaxLevel = 1199,
        MobName = "Lava Pirate",
        FarmPos = Vector3.new(-5293.55, 35.44, -4705.81),
        QuestNPCPos = Vector3.new(-5445.89, 15.99, -5292.91),
        QuestName = "FireSideQuest",
        QuestIndex = 1,
        RewardBeli = 12250
    },
    {
        MinLevel = 1200,
        MaxLevel = 1249,
        MobName = "Magma Ninja",
        FarmPos = Vector3.new(-5524.52, 60.59, -5935.76),
        QuestNPCPos = Vector3.new(-5445.89, 15.99, -5292.91),
        QuestName = "FireSideQuest",
        QuestIndex = 2,
        RewardBeli = 12500
    },
    {
        MinLevel = 1250,
        MaxLevel = 1274,
        MobName = "Ship Deckhand",
        FarmPos = Vector3.new(914.82, 125.99, 33128.67),
        QuestNPCPos = Vector3.new(1028.28, 125.09, 32922.51),
        QuestName = "ShipQuest1",
        QuestIndex = 1,
        RewardBeli = 12250
    },
    {
        MinLevel = 1275,
        MaxLevel = 1299,
        MobName = "Ship Engineer",
        FarmPos = Vector3.new(950.61, 44.09, 32968.16),
        QuestNPCPos = Vector3.new(1028.28, 125.09, 32922.51),
        QuestName = "ShipQuest1",
        QuestIndex = 2,
        RewardBeli = 12500
    },
    {
        MinLevel = 1300,
        MaxLevel = 1324,
        MobName = "Ship Steward",
        FarmPos = Vector3.new(918.42, 127.03, 33425.64),
        QuestNPCPos = Vector3.new(962.09, 125.09, 33269.21),
        QuestName = "ShipQuest2",
        QuestIndex = 1,
        RewardBeli = 12250
    },
    {
        MinLevel = 1325,
        MaxLevel = 1349,
        MobName = "Ship Officer",
        FarmPos = Vector3.new(921.45, 181.09, 33348.12),
        QuestNPCPos = Vector3.new(962.09, 125.09, 33269.21),
        QuestName = "ShipQuest2",
        QuestIndex = 2,
        RewardBeli = 12500
    },
    {
        MinLevel = 1350,
        MaxLevel = 1374,
        MobName = "Arctic Warrior",
        FarmPos = Vector3.new(5988.11, 28.40, -6229.00),
        QuestNPCPos = Vector3.new(5694.20, 28.40, -6489.64),
        QuestName = "FrostQuest",
        QuestIndex = 1,
        RewardBeli = 12250
    },
    {
        MinLevel = 1375,
        MaxLevel = 1424,
        MobName = "Snow Lurker",
        FarmPos = Vector3.new(5565.94, 34.94, -6798.41),
        QuestNPCPos = Vector3.new(5694.20, 28.40, -6489.64),
        QuestName = "FrostQuest",
        QuestIndex = 2,
        RewardBeli = 12500
    },
    {
        MinLevel = 1425,
        MaxLevel = 1449,
        MobName = "Sea Soldier",
        FarmPos = Vector3.new(-3051.46, 131.67, -9816.88),
        QuestNPCPos = Vector3.new(-3078.13, 239.68, -10138.27),
        QuestName = "ForgottenQuest",
        QuestIndex = 1,
        RewardBeli = 12250
    },
    {
        MinLevel = 1450,
        MaxLevel = 1499,
        MobName = "Water Fighter",
        FarmPos = Vector3.new(-3417.38, 238.88, -10514.25),
        QuestNPCPos = Vector3.new(-3078.13, 239.68, -10138.27),
        QuestName = "ForgottenQuest",
        QuestIndex = 2,
        RewardBeli = 12500
    },  --------------------SEA 2------------------------------------------
    {   --------------------SEA 3------------------------------------------
        MinLevel = 1500,
        MaxLevel = 1524,
        MobName = "Pirate Millionaire",
        FarmPos = Vector3.new(-716.74, 86.13, 5821.20),
        QuestNPCPos = Vector3.new(-446.33, 108.61, 5934.46),
        QuestName = "PiratePortQuest",
        QuestIndex = 1,
        RewardBeli = 13000
    },
    {
        MinLevel = 1525,
        MaxLevel = 1624,
        MobName = "Pistol Billionaire",
        FarmPos = Vector3.new(-137.76, 86.13, 5906.20),
        QuestNPCPos = Vector3.new(-446.33, 108.61, 5934.46),
        QuestName = "PiratePortQuest",
        QuestIndex = 2,
        RewardBeli = 15000
    },
    {
        MinLevel = 1625,
        MaxLevel = 1649,
        MobName = "Hydra Enforcer",
        FarmPos = Vector3.new(4516.00, 1002.26, 430.23),
        QuestNPCPos = Vector3.new(5196.71, 1004.10, 756.85),
        QuestName = "VenomCrewQuest",
        QuestIndex = 1,
        RewardBeli = 13000
    },
    {
        MinLevel = 1650,
        MaxLevel = 1699,
        MobName = "Venomous Assailant",
        FarmPos = Vector3.new(4521.05, 1158.85, 837.77),
        QuestNPCPos = Vector3.new(5196.71, 1004.10, 756.85),
        QuestName = "VenomCrewQuest",
        QuestIndex = 2,
        RewardBeli = 15000
    },
    {
        MinLevel = 1700,
        MaxLevel = 1724,
        MobName = "Marine Commodore",
        FarmPos = Vector3.new(2835.74, 115.52, -7780.65),
        QuestNPCPos = Vector3.new(2495.12, 74.27, -6800.91),
        QuestName = "MarineTreeIsland",
        QuestIndex = 1,
        RewardBeli = 13000
    },
    {
        MinLevel = 1725,
        MaxLevel = 1974,
        MobName = "Marine Rear Admiral",
        FarmPos = Vector3.new(3648.25, 123.98, -7042.48),
        QuestNPCPos = Vector3.new(2495.12, 74.27, -6800.91),
        QuestName = "MarineTreeIsland",
        QuestIndex = 2,
        RewardBeli = 15000
    },
    {
        MinLevel = 1975,
        MaxLevel = 1999,
        MobName = "Reborn Skeleton",
        FarmPos = Vector3.new(-8783.82, 142.14, 6028.49),
        QuestNPCPos = Vector3.new(-9475.78, 142.14, 5586.67),
        QuestName = "HauntedQuest1",
        QuestIndex = 1,
        RewardBeli = 13000
    },
    {
        MinLevel = 2000,
        MaxLevel = 2024,
        MobName = "Living Zombie",
        FarmPos = Vector3.new(-10049.56, 141.36, 5837.81),
        QuestNPCPos = Vector3.new(-9475.78, 142.14, 5586.67),
        QuestName = "HauntedQuest1",
        QuestIndex = 2,
        RewardBeli = 13250
    },
    {
        MinLevel = 2025,
        MaxLevel = 2049,
        MobName = "Demonic Soul",
        FarmPos = Vector3.new(-9506.13, 172.14, 6157.09),
        QuestNPCPos = Vector3.new(-9517.62, 172.14, 6091.13),
        QuestName = "HauntedQuest2",
        QuestIndex = 1,
        RewardBeli = 13500
    },
    {
        MinLevel = 2050,
        MaxLevel = 2074,
        MobName = "Posessed Mummy",
        FarmPos = Vector3.new(-9591.54, 5.83, 6211.81),
        QuestNPCPos = Vector3.new(-9517.62, 172.14, 6091.13),
        QuestName = "HauntedQuest2",
        QuestIndex = 2,
        RewardBeli = 13750
    },
    {
        MinLevel = 2075,
        MaxLevel = 2099,
        MobName = "Peanut Scout",
        FarmPos = Vector3.new(-2105.39, 38.14, -10122.31),
        QuestNPCPos = Vector3.new(-2120.49, 39.92, -10189.19),
        QuestName = "NutsIslandQuest",
        QuestIndex = 1,
        RewardBeli = 14000
    },
    {
        MinLevel = 2100,
        MaxLevel = 2124,
        MobName = "Peanut President",
        FarmPos = Vector3.new(-2120.99, 79.08, -10462.72),
        QuestNPCPos = Vector3.new(-2120.49, 39.92, -10189.19),
        QuestName = "NutsIslandQuest",
        QuestIndex = 2,
        RewardBeli = 14100
    },
    {
        MinLevel = 2125,
        MaxLevel = 2149,
        MobName = "Ice Cream Chef",
        FarmPos = Vector3.new(-747.29, 65.85, -11002.71),
        QuestNPCPos = Vector3.new(-829.21, 65.85, -10960.83),
        QuestName = "IceCreamIslandQuest",
        QuestIndex = 1,
        RewardBeli = 14200
    },
    {
        MinLevel = 2150,
        MaxLevel = 2199,
        MobName = "Ice Cream Commander",
        FarmPos = Vector3.new(-625.10, 126.91, -11176.10),
        QuestNPCPos = Vector3.new(-829.21, 65.85, -10960.83),
        QuestName = "IceCreamIslandQuest",
        QuestIndex = 2,
        RewardBeli = 14300
    },
    {
        MinLevel = 2200,
        MaxLevel = 2224,
        MobName = "Cookie Crafter",
        FarmPos = Vector3.new(-2369.50, 37.83, -12124.49),
        QuestNPCPos = Vector3.new(-2039.86, 37.83, -12032.57),
        QuestName = "CakeQuest1",
        QuestIndex = 1,
        RewardBeli = 14200
    },
    {
        MinLevel = 2225,
        MaxLevel = 2249,
        MobName = "Cake Guard",
        FarmPos = Vector3.new(-1599.10, 43.83, -12247.68),
        QuestNPCPos = Vector3.new(-2039.86, 37.83, -12032.57),
        QuestName = "CakeQuest1",
        QuestIndex = 2,
        RewardBeli = 14300
    },
    {
        MinLevel = 2250,
        MaxLevel = 2274,
        MobName = "Baking Staff",
        FarmPos = Vector3.new(-1865.02, 37.83, -12985.24),
        QuestNPCPos = Vector3.new(-1929.10, 37.83, -12854.16),
        QuestName = "CakeQuest2",
        QuestIndex = 1,
        RewardBeli = 14400
    },
    {
        MinLevel = 2275,
        MaxLevel = 2299,
        MobName = "Head Baker",
        FarmPos = Vector3.new(-2211.77, 53.54, -12874.58),
        QuestNPCPos = Vector3.new(-1929.10, 37.83, -12854.16),
        QuestName = "CakeQuest2",
        QuestIndex = 2,
        RewardBeli = 14500
    },
    {
        MinLevel = 2300,
        MaxLevel = 2324,
        MobName = "Cocoa Warrior",
        FarmPos = Vector3.new(32.86, 24.77, -12223.83),
        QuestNPCPos = Vector3.new(232.58, 24.77, -12185.34),
        QuestName = "ChocQuest1e",
        QuestIndex = 1,
        RewardBeli = 14600
    },
    {
        MinLevel = 2325,
        MaxLevel = 2349,
        MobName = "Chocolate Bar Battler",
        FarmPos = Vector3.new(681.76, 24.77, -12583.60),
        QuestNPCPos = Vector3.new(232.58, 24.77, -12185.34),
        QuestName = "ChocQuest1",
        QuestIndex = 2,
        RewardBeli = 14700
    },
    {
        MinLevel = 2350,
        MaxLevel = 2374,
        MobName = "Sweet Thief",
        FarmPos = Vector3.new(48.88, 24.83, -12623.41),
        QuestNPCPos = Vector3.new(135.77, 24.83, -12776.10),
        QuestName = "ChocQuest2",
        QuestIndex = 1,
        RewardBeli = 14800
    },
    {
        MinLevel = 2375,
        MaxLevel = 2399,
        MobName = "Candy Rebel",
        FarmPos = Vector3.new(95.06, 24.83, -12935.54),
        QuestNPCPos = Vector3.new(135.77, 24.83, -12776.10),
        QuestName = "ChocQuest2",
        QuestIndex = 2,
        RewardBeli = 14900
    },
    {
        MinLevel = 2400,
        MaxLevel = 2424,
        MobName = "Candy Pirate",
        FarmPos = Vector3.new(-1359.20, 32.08, -14547.01),
        QuestNPCPos = Vector3.new(-1164.43, 60.97, -14506.08),
        QuestName = "CandyQuest1",
        QuestIndex = 1,
        RewardBeli = 14950
    },
    {
        MinLevel = 2425,
        MaxLevel = 2449,
        MobName = "Snow Demon",
        FarmPos = Vector3.new(-823.14, 13.18, -14539.29),
        QuestNPCPos = Vector3.new(-1164.43, 60.97, -14506.08),
        QuestName = "CandyQuest1",
        QuestIndex = 2,
        RewardBeli = 15000
    },
    {
        MinLevel = 2450,
        MaxLevel = 2474,
        MobName = "Isle Outlaw",
        FarmPos = Vector3.new(-16283.74, 21.71, -191.98),
        QuestNPCPos = Vector3.new(-16550.60, 55.73, -184.48),
        QuestName = "TikiQuest1",
        QuestIndex = 1,
        RewardBeli = 15100
    },
    {
        MinLevel = 2475,
        MaxLevel = 2499,
        MobName = "Island Boy",
        FarmPos = Vector3.new(-16825.98, 21.71, -195.33),
        QuestNPCPos = Vector3.new(-16550.60, 55.73, -184.48),
        QuestName = "TikiQuest1",
        QuestIndex = 2,
        RewardBeli = 15200
    },
    {
        MinLevel = 2500,
        MaxLevel = 2524,
        MobName = "Sun-kissed Warrior",
        FarmPos = Vector3.new(-16241.96, 21.71, 1067.87),
        QuestNPCPos = Vector3.new(-16536.19, 55.73, 1063.75),
        QuestName = "TikiQuest2",
        QuestIndex = 1,
        RewardBeli = 15250
    },
    {
        MinLevel = 2525,
        MaxLevel = 2549,
        MobName = "Isle Champion",
        FarmPos = Vector3.new(-16821.18, 21.71, 1036.77),
        QuestNPCPos = Vector3.new(-16536.19, 55.73, 1063.75),
        QuestName = "TikiQuest2",
        QuestIndex = 2,
        RewardBeli = 15500
    },
    {
        MinLevel = 2550,
        MaxLevel = 2574,
        MobName = "Serpent Hunter",
        FarmPos = Vector3.new(-16538.62, 106.28, 1487.51),
        QuestNPCPos = Vector3.new(-16654.62, 105.88, 1590.55),
        QuestName = "TikiQuest3",
        QuestIndex = 1,
        RewardBeli = 15750
    },
    {
        MinLevel = 2575,
        MaxLevel = 99999,
        MobName = "Skull Slayer",
        FarmPos = Vector3.new(-16843.12, 71.28, 1643.89),
        QuestNPCPos = Vector3.new(-16654.62, 105.88, 1590.55),
        QuestName = "TikiQuest3",
        QuestIndex = 2,
        RewardBeli = 16000
    }
}

-- Auto Farm Biến
local running = false
local lastLevel = 0
local function getLevel()
    local d = player:FindFirstChild("Data")
    return d and d:FindFirstChild("Level") and d.Level.Value or 0
end

local function getZoneForLevel(level)
    for _, zone in ipairs(FarmZones) do
        if level >= zone.MinLevel and level <= zone.MaxLevel then
            return zone
        end
    end
    return nil
end

-- Tween function
local function tweenTo(pos)
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local distance = (hrp.Position - pos).Magnitude
    local tween = TweenService:Create(hrp, TweenInfo.new(distance / 300, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)})
    tween:Play()
    tween.Completed:Wait()
end

-- Nhận nhiệm vụ
local function acceptQuest(zone)
    if not zone then return end

    tweenTo(zone.QuestNPCPos + Vector3.new(0, 3, 0))
    task.wait(1)

    local args = {
        [1] = "StartQuest",
        [2] = zone.QuestName,
        [3] = zone.QuestIndex
    }

    pcall(function()
        ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
    end)

    currentQuestKills = 0
    currentQuestBeli = player:WaitForChild("Data"):WaitForChild("Beli").Value

    -- Tùy chỉnh số Beli phần thưởng nếu biết cụ thể:
    if zone.RewardBeli then
        expectedRewardBeli = zone.RewardBeli
    end
end

-- Auto click bằng VirtualInputManager
spawn(function()
    while true do
        wait(0.5)
        if running then
            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
        end
    end
end)

-- Tìm quái
local function getNearestMob(name)
    local enemies = workspace:FindFirstChild("Enemies")
    if not enemies then return nil end

    local closest = nil
    local minDist = math.huge
    for _, mob in pairs(enemies:GetChildren()) do
        if mob.Name == name and mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChildOfClass("Humanoid") then
            local dist = (player.Character.HumanoidRootPart.Position - mob.HumanoidRootPart.Position).Magnitude
            if mob:FindFirstChildOfClass("Humanoid").Health > 0 and dist < minDist then
                closest = mob
                minDist = dist
            end
        end
    end
    return closest
end

-- Theo quái
local function followMob(mob)
    local hrp = player.Character:WaitForChild("HumanoidRootPart")
    while mob and mob.Parent and mob:FindFirstChildOfClass("Humanoid") and mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChildOfClass("Humanoid").Health > 0 and running do
        hrp.CFrame = CFrame.new(mob.HumanoidRootPart.Position + Vector3.new(0, 30, 0))
        RunService.RenderStepped:Wait()
    end
end

-- Toggle ON/OFF
autoFarmBtn.MouseButton1Click:Connect(function()
    running = not running
    autoFarmBtn.Text = running and "ON" or "OFF"
    autoFarmBtn.BackgroundColor3 = running and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
    lastLevel = getLevel()
end)

-- Farm Loop
spawn(function()
    while true do
        task.wait()
        if not running then continue end

        local level = getLevel()
        local zone = getZoneForLevel(level)
        if not zone then continue end

        -- Nếu lên level
        if level ~= lastLevel then
            lastLevel = level
            acceptQuest(zone)
        end

        -- Kiểm tra vị trí farm
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if hrp and (hrp.Position - zone.FarmPos).Magnitude > 1000 then
            tweenTo(zone.FarmPos + Vector3.new(0, 3, 0))
        end

        -- Tìm và đánh quái
        local mob = getNearestMob(zone.MobName)
        if mob then
            followMob(mob)
            currentQuestKills += 1
        end

        -- Kiểm tra hoàn thành
        local newBeli = player:FindFirstChild("Data"):FindFirstChild("Beli").Value
        if newBeli - currentQuestBeli >= expectedRewardBeli then
            acceptQuest(zone) -- đã hoàn thành -> nhận lại
        elseif currentQuestKills >= maxQuestKills then
            acceptQuest(zone) -- không thấy tăng Beli -> nhiệm vụ lỗi -> nhận lại
        end
    end
end)

--title
local HomeFrame = sections["Home"]

local Title = Instance.new("TextLabel", HomeFrame)
Title.Size = UDim2.new(0, 220, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 10)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Text = "AUTO FRAM LV🔼"
Title.TextScaled = true
Title.Font = Enum.Font.SourceSansBold
Title.BorderSizePixel = 2
Title.BorderColor3 = Color3.new(255, 255, 255)

---------------------------------------------------------------------------------
--ESP player
local HomeFrame = sections["Visual"]
local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local espEnabled = false
local espObjects = {}

-- Nút ESP
local espButton = Instance.new("TextButton", HomeFrame)
espButton.Size = UDim2.new(0, 90, 0, 30)
espButton.Position = UDim2.new(0, 240, 0, 10)
espButton.Text = "OFF"
espButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
espButton.TextColor3 = Color3.new(1, 1, 1)
espButton.Font = Enum.Font.SourceSansBold
espButton.TextScaled = true

-- Tạo ESP
local function createESP(playerObj)
    if playerObj.Character and playerObj.Character:FindFirstChild("HumanoidRootPart") then
        local char = playerObj.Character

        -- Highlight
        local highlight = Instance.new("Highlight")
        highlight.Adornee = char
        highlight.FillColor = Color3.fromRGB(255, 191, 0) -- Vàng cam
        highlight.OutlineColor = Color3.fromRGB(255, 191, 0)
        highlight.FillTransparency = 1
        highlight.OutlineTransparency = 0
        highlight.Parent = char

        -- Billboard
        local billboard = Instance.new("BillboardGui")
        billboard.Adornee = char:FindFirstChild("HumanoidRootPart")
        billboard.Size = UDim2.new(0, 150, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true
        billboard.Name = "ESP_Billboard"
        billboard.Parent = char

        local text = Instance.new("TextLabel")
        text.Size = UDim2.new(1, 0, 1, 0)
        text.BackgroundTransparency = 1
        text.TextColor3 = Color3.fromRGB(255, 191, 0)
        text.Font = Enum.Font.SourceSansBold
        text.TextScaled = true
        text.Text = ""
        text.Parent = billboard

        local updateConn
        updateConn = game:GetService("RunService").RenderStepped:Connect(function()
            if not char or not char:FindFirstChild("Humanoid") or not char:FindFirstChild("HumanoidRootPart") then
                updateConn:Disconnect()
                return
            end

            local hp = math.floor(char.Humanoid.Health)
            local distance = math.floor((camera.CFrame.Position - char.HumanoidRootPart.Position).Magnitude)
            text.Text = string.format("%s\nHP: %d | %dm", playerObj.Name, hp, distance)
        end)

        table.insert(espObjects, {highlight, billboard, updateConn})
    end
end

-- Bật/tắt toàn bộ ESP
local function toggleESP(state)
    if state then
        for _, plr in pairs(game.Players:GetPlayers()) do
            if plr ~= player then
                createESP(plr)
            end
        end

        game.Players.PlayerAdded:Connect(function(newPlr)
            newPlr.CharacterAdded:Connect(function()
                task.wait(1)
                if espEnabled then
                    createESP(newPlr)
                end
            end)
        end)

    else
        for _, data in pairs(espObjects) do
            for _, obj in pairs(data) do
                if typeof(obj) == "Instance" and obj:IsDescendantOf(game) then
                    obj:Destroy()
                elseif typeof(obj) == "RBXScriptConnection" then
                    obj:Disconnect()
                end
            end
        end
        espObjects = {}
    end
end

-- Nút ON/OFF
espButton.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    espButton.Text = espEnabled and "ON" or "OFF"
    espButton.BackgroundColor3 = espEnabled and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
    toggleESP(espEnabled)
end)

--title
local HomeFrame = sections["Visual"]

local Title = Instance.new("TextLabel", HomeFrame)
Title.Size = UDim2.new(0, 220, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 10)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Text = "ESP PLAYER👤"
Title.TextScaled = true
Title.Font = Enum.Font.SourceSansBold
Title.BorderSizePixel = 2
Title.BorderColor3 = Color3.new(255, 255, 255)

--------------------------------------------------------------------------------------
--ESP NPC
local HomeFrame = sections["Visual"]
local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local espEnabled = false
local espObjects = {}

-- Nút ESP
local espButton = Instance.new("TextButton", HomeFrame)
espButton.Size = UDim2.new(0, 90, 0, 30)
espButton.Position = UDim2.new(0, 240, 0, 60)
espButton.Text = "OFF"
espButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
espButton.TextColor3 = Color3.new(1, 1, 1)
espButton.Font = Enum.Font.SourceSansBold
espButton.TextScaled = true

-- Tạo ESP
local function createESP(model)
    if not model:IsA("Model") or not model:FindFirstChild("HumanoidRootPart") then return end

    -- Highlight
    local highlight = Instance.new("Highlight")
    highlight.Adornee = model
    highlight.FillColor = Color3.fromRGB(255, 0, 0) -- Vàng cam
    highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
    highlight.FillTransparency = 1
    highlight.OutlineTransparency = 0
    highlight.Parent = model

    -- Billboard
    local billboard = Instance.new("BillboardGui")
    billboard.Adornee = model:FindFirstChild("HumanoidRootPart")
    billboard.Size = UDim2.new(0, 150, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Name = "ESP_Billboard"
    billboard.Parent = model

    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.TextColor3 = Color3.fromRGB(255, 0, 0)
    text.Font = Enum.Font.SourceSansBold
    text.TextScaled = true
    text.Text = ""
    text.Parent = billboard

    local updateConn
    updateConn = game:GetService("RunService").RenderStepped:Connect(function()
        if not model or not model.Parent or not model:FindFirstChild("HumanoidRootPart") then
            updateConn:Disconnect()
            return
        end

        local distance = math.floor((camera.CFrame.Position - model.HumanoidRootPart.Position).Magnitude)
        local hpText = ""

        if model:FindFirstChild("Humanoid") then
            local hp = math.floor(model.Humanoid.Health)
            hpText = " | HP: " .. hp
        end

        text.Text = model.Name .. "\n" .. "Dist: " .. distance .. "m" .. hpText
    end)

    table.insert(espObjects, {highlight, billboard, updateConn})
end

-- Bật/tắt toàn bộ ESP
local function toggleESP(state)
    if state then
        local enemies = workspace:FindFirstChild("Enemies")
        if enemies then
            for _, model in pairs(enemies:GetChildren()) do
                createESP(model)
            end

            enemies.ChildAdded:Connect(function(child)
                task.wait(0.5)
                if espEnabled then
                    createESP(child)
                end
            end)
        end
    else
        for _, data in pairs(espObjects) do
            for _, obj in pairs(data) do
                if typeof(obj) == "Instance" and obj:IsDescendantOf(game) then
                    obj:Destroy()
                elseif typeof(obj) == "RBXScriptConnection" then
                    obj:Disconnect()
                end
            end
        end
        espObjects = {}
    end
end

-- Nút ON/OFF
espButton.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    espButton.Text = espEnabled and "ON" or "OFF"
    espButton.BackgroundColor3 = espEnabled and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
    toggleESP(espEnabled)
end)

--title
local HomeFrame = sections["Visual"]

local Title = Instance.new("TextLabel", HomeFrame)
Title.Size = UDim2.new(0, 220, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 60)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Text = "ESP ENEMIES🧟"
Title.TextScaled = true
Title.Font = Enum.Font.SourceSansBold
Title.BorderSizePixel = 2
Title.BorderColor3 = Color3.new(255, 255, 255)

----------------------------------------------------------------------------------
--LIGHT
local VisualFrame = sections["Visual"]
local lighting = game:GetService("Lighting")

local lightEnabled = false

-- Tạo nút Light
local lightButton = Instance.new("TextButton", VisualFrame)
lightButton.Size = UDim2.new(0, 90, 0, 30)
lightButton.Position = UDim2.new(0, 240, 0, 110)
lightButton.Text = "OFF"
lightButton.Font = Enum.Font.SourceSansBold
lightButton.TextScaled = true
lightButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
lightButton.TextColor3 = Color3.new(1, 1, 1)

-- Bật/tắt ánh sáng
local function toggleLight(state)
    if state then
        lighting.Brightness = 3
        lighting.Ambient = Color3.new(1, 1, 1)
        lighting.OutdoorAmbient = Color3.new(1, 1, 1)
        lighting.GlobalShadows = false
    else
        lighting.Brightness = 1
        lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
        lighting.OutdoorAmbient = Color3.new(0.5, 0.5, 0.5)
        lighting.GlobalShadows = true
    end
end

-- Nút ON/OFF
lightButton.MouseButton1Click:Connect(function()
    lightEnabled = not lightEnabled
    lightButton.Text = lightEnabled and "ON" or "OFF"
    lightButton.BackgroundColor3 = lightEnabled and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
    toggleLight(lightEnabled)
end)

--title
local HomeFrame = sections["Visual"]

local Title = Instance.new("TextLabel", HomeFrame)
Title.Size = UDim2.new(0, 220, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 110)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Text = "LIGHT💡"
Title.TextScaled = true
Title.Font = Enum.Font.SourceSansBold
Title.BorderSizePixel = 2
Title.BorderColor3 = Color3.new(255, 255, 255)

-----------------------------------------------------------------------------------
--ESP FRUIT
local HomeFrame = sections["Fruit"]
local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera

local fruitESPEnabled = false
local fruitESPObjects = {}

-- Nút bật/tắt ESP Fruit
local espFruitButton = Instance.new("TextButton", HomeFrame)
espFruitButton.Size = UDim2.new(0, 90, 0, 30)
espFruitButton.Position = UDim2.new(0, 240, 0, 10)
espFruitButton.Text = "OFF"
espFruitButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
espFruitButton.TextColor3 = Color3.new(1, 1, 1)
espFruitButton.Font = Enum.Font.SourceSansBold
espFruitButton.TextScaled = true

-- Kiểm tra xem object có phải là Fruit
local function isFruit(obj)
    return obj:IsA("Model") and obj.Name:lower():find("fruit") and not obj:IsA("Folder")
end

-- Tạo ESP Fruit
local function createFruitESP(obj)
    if not obj:FindFirstChild("Handle") and not obj:FindFirstChild("Main") and not obj:FindFirstChild("Part") then return end

    local part = obj:FindFirstChild("Handle") or obj:FindFirstChild("Main") or obj:FindFirstChild("Part") or obj:FindFirstChildWhichIsA("BasePart")
    if not part then return end

    local billboard = Instance.new("BillboardGui")
    billboard.Adornee = part
    billboard.Size = UDim2.new(0, 100, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = obj

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(0, 255, 0)
    label.Font = Enum.Font.SourceSansBold
    label.TextScaled = true
    label.Text = ""
    label.Parent = billboard

    local conn
    conn = game:GetService("RunService").RenderStepped:Connect(function()
        if not obj or not obj.Parent or not part then
            conn:Disconnect()
            return
        end

        local dist = math.floor((camera.CFrame.Position - part.Position).Magnitude)
        label.Text = obj.Name .. "\n" .. "Dist: " .. dist .. "m"
    end)

    table.insert(fruitESPObjects, {billboard, conn})
end

-- Cập nhật tất cả Fruit hiện có
local function scanFruits()
    for _, obj in pairs(workspace:GetChildren()) do
        if isFruit(obj) then
            createFruitESP(obj)
        end
    end

    workspace.ChildAdded:Connect(function(child)
        task.wait(0.2)
        if fruitESPEnabled and isFruit(child) then
            createFruitESP(child)
        end
    end)
end

-- Bật/tắt ESP Fruit
local function toggleFruitESP(state)
    if state then
        scanFruits()
    else
        for _, item in pairs(fruitESPObjects) do
            for _, obj in pairs(item) do
                if typeof(obj) == "Instance" and obj:IsDescendantOf(game) then
                    obj:Destroy()
                elseif typeof(obj) == "RBXScriptConnection" then
                    obj:Disconnect()
                end
            end
        end
        fruitESPObjects = {}
    end
end

-- Gán sự kiện cho nút bật/tắt
espFruitButton.MouseButton1Click:Connect(function()
    fruitESPEnabled = not fruitESPEnabled
    espFruitButton.Text = fruitESPEnabled and "ON" or "OFF"
    espFruitButton.BackgroundColor3 = fruitESPEnabled and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
    toggleFruitESP(fruitESPEnabled)
end)

--title
local HomeFrame = sections["Fruit"]

local Title = Instance.new("TextLabel", HomeFrame)
Title.Size = UDim2.new(0, 220, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 10)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Text = "ESP FRUIT🍇"
Title.TextScaled = true
Title.Font = Enum.Font.SourceSansBold
Title.BorderSizePixel = 2
Title.BorderColor3 = Color3.new(255, 255, 255)

--------------------------------------------------------------------------------------
--FRAM BONE
local HomeFrame = sections["Home"]
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local mouse = player:GetMouse()
local currentQuestBeli = 0
local currentQuestKills = 0
local maxQuestKills = 10 -- số quái cần giết để hoàn thành
local expectedRewardBeli = 500000 -- mặc định, bạn sẽ thay theo từng vùng nếu cần
local VirtualInputManager = game:GetService("VirtualInputManager")

-- Nút bật/tắt Auto Farm
local autoFarmBtn = Instance.new("TextButton")
autoFarmBtn.Size = UDim2.new(0, 90, 0, 30)
autoFarmBtn.Position = UDim2.new(0, 240, 0, 60)
autoFarmBtn.Text = "OFF"
autoFarmBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
autoFarmBtn.TextColor3 = Color3.new(1, 1, 1)
autoFarmBtn.Font = Enum.Font.SourceSansBold
autoFarmBtn.TextScaled = true
autoFarmBtn.Parent = HomeFrame

-- Config vùng farm
local FarmZones = {
    {
        MinLevel = 2000,
        MaxLevel = 99999,
        MobName = "Posessed Mummy",
        FarmPos = Vector3.new(-9506.13, 172.14, 6157.09),
        QuestNPCPos = Vector3.new(-9517.62, 172.14, 6091.13),
        QuestName = "HauntedQuest2",
        QuestIndex = 2,
        RewardBeli = 13750
    },
    {
        MinLevel = 1900,
        MaxLevel = 99999,
        MobName = "Demonic Soul",
        FarmPos = Vector3.new(-9506.13, 172.14, 6157.09),
        QuestNPCPos = Vector3.new(-9517.62, 172.14, 6091.13),
        QuestName = "HauntedQuest2",
        QuestIndex = 1,
        RewardBeli = 13500
    },
    {
        MinLevel = 1800,
        MaxLevel = 99999,
        MobName = "Living Zombie",
        FarmPos = Vector3.new(-9506.13, 172.14, 6157.09),
        QuestNPCPos = Vector3.new(-9475.78, 142.14, 5586.67),
        QuestName = "HauntedQuest1",
        QuestIndex = 2,
        RewardBeli = 13250
    },
    {
        MinLevel = 1700,
        MaxLevel = 99999,
        MobName = "Reborn Skeleton",
        FarmPos = Vector3.new(-9506.13, 172.14, 6157.09),
        QuestNPCPos = Vector3.new(-9475.78, 142.14, 5586.67),
        QuestName = "HauntedQuest1",
        QuestIndex = 1,
        RewardBeli = 13000
    }
}

-- Auto Farm Biến
local running = false
local lastLevel = 0
local function getLevel()
    local d = player:FindFirstChild("Data")
    return d and d:FindFirstChild("Level") and d.Level.Value or 0
end

local function getZoneForLevel(level)
    for _, zone in ipairs(FarmZones) do
        if level >= zone.MinLevel and level <= zone.MaxLevel then
            return zone
        end
    end
    return nil
end

-- Tween function
local function tweenTo(pos)
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local distance = (hrp.Position - pos).Magnitude
    local tween = TweenService:Create(hrp, TweenInfo.new(distance / 300, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)})
    tween:Play()
    tween.Completed:Wait()
end

-- Nhận nhiệm vụ
local function acceptQuest(zone)
    if not zone then return end

    tweenTo(zone.QuestNPCPos + Vector3.new(0, 3, 0))
    task.wait(1)

    local args = {
        [1] = "StartQuest",
        [2] = zone.QuestName,
        [3] = zone.QuestIndex
    }

    pcall(function()
        ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
    end)

    currentQuestKills = 0
    currentQuestBeli = player:WaitForChild("Data"):WaitForChild("Beli").Value

    -- Tùy chỉnh số Beli phần thưởng nếu biết cụ thể:
    if zone.RewardBeli then
        expectedRewardBeli = zone.RewardBeli
    end
end

-- Auto click bằng VirtualInputManager
spawn(function()
    while true do
        wait(0.5)
        if running then
            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
        end
    end
end)

-- Tìm quái
local function getNearestMob(name)
    local enemies = workspace:FindFirstChild("Enemies")
    if not enemies then return nil end

    local closest = nil
    local minDist = math.huge
    for _, mob in pairs(enemies:GetChildren()) do
        if mob.Name == name and mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChildOfClass("Humanoid") then
            local dist = (player.Character.HumanoidRootPart.Position - mob.HumanoidRootPart.Position).Magnitude
            if mob:FindFirstChildOfClass("Humanoid").Health > 0 and dist < minDist then
                closest = mob
                minDist = dist
            end
        end
    end
    return closest
end

-- Theo quái
local function followMob(mob)
    local hrp = player.Character:WaitForChild("HumanoidRootPart")
    while mob and mob.Parent and mob:FindFirstChildOfClass("Humanoid") and mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChildOfClass("Humanoid").Health > 0 and running do
        hrp.CFrame = CFrame.new(mob.HumanoidRootPart.Position + Vector3.new(0, 30, 0))
        RunService.RenderStepped:Wait()
    end
end

-- Toggle ON/OFF
autoFarmBtn.MouseButton1Click:Connect(function()
    running = not running
    autoFarmBtn.Text = running and "ON" or "OFF"
    autoFarmBtn.BackgroundColor3 = running and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
    lastLevel = getLevel()
end)

-- Farm Loop
spawn(function()
    while true do
        task.wait()
        if not running then continue end

        local level = getLevel()
        local zone = getZoneForLevel(level)
        if not zone then continue end

        -- Nếu lên level
        if level ~= lastLevel then
            lastLevel = level
            acceptQuest(zone)
        end

        -- Kiểm tra vị trí farm
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if hrp and (hrp.Position - zone.FarmPos).Magnitude > 1000 then
            tweenTo(zone.FarmPos + Vector3.new(0, 3, 0))
        end

        -- Tìm và đánh quái
        local mob = getNearestMob(zone.MobName)
        if mob then
            followMob(mob)
            currentQuestKills += 1
        end

        -- Kiểm tra hoàn thành
        local newBeli = player:FindFirstChild("Data"):FindFirstChild("Beli").Value
        if newBeli - currentQuestBeli >= expectedRewardBeli then
            acceptQuest(zone) -- đã hoàn thành -> nhận lại
        elseif currentQuestKills >= maxQuestKills then
            acceptQuest(zone) -- không thấy tăng Beli -> nhiệm vụ lỗi -> nhận lại
        end
    end
end)

--title
local HomeFrame = sections["Home"]

local Title = Instance.new("TextLabel", HomeFrame)
Title.Size = UDim2.new(0, 220, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 60)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Text = "AUTO FRAM BONE🦴"
Title.TextScaled = true
Title.Font = Enum.Font.SourceSansBold
Title.BorderSizePixel = 2
Title.BorderColor3 = Color3.new(255, 255, 255)

-----------------------------------------------------------------------------------------------
--Player view
local PlayerFrame = sections["Tracker"]
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local camera = game.Workspace.CurrentCamera

local buttons = {} -- Lưu các nút của người chơi
local originalCameraSubject = camera.CameraSubject -- Lưu trạng thái camera ban đầu
local viewingPlayer = nil -- Người chơi đang được xem

-- Hàm cập nhật danh sách người chơi
local function updatePlayerList()
    -- Xóa các nút cũ trước khi tạo mới
    for _, button in pairs(buttons) do
        button:Destroy()
    end
    buttons = {}

    -- Tạo danh sách nút người chơi
    local yOffset = 10 -- Vị trí y ban đầu
    for _, player in pairs(players:GetPlayers()) do
        if player ~= localPlayer then -- Không hiển thị bản thân
            local PlayerButton = Instance.new("TextButton", PlayerFrame)
            PlayerButton.Size = UDim2.new(0, 300, 0, 40)
            PlayerButton.Position = UDim2.new(0, 10, 0, yOffset)
            PlayerButton.Text = player.Name
            PlayerButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
            PlayerButton.TextColor3 = Color3.new(1, 1, 1)

            -- Khi bấm vào nút
            PlayerButton.MouseButton1Click:Connect(function()
                if viewingPlayer == player then
                    -- Nếu đang xem người này, quay về bản thân
                    camera.CameraSubject = localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") or camera.CameraSubject
                    viewingPlayer = nil
                else
                    -- Chuyển camera qua người chơi được chọn
                    if player.Character and player.Character:FindFirstChild("Humanoid") then
                        camera.CameraSubject = player.Character.Humanoid
                        viewingPlayer = player
                    end
                end
            end)

            table.insert(buttons, PlayerButton) -- Lưu nút vào danh sách
            yOffset = yOffset + 50 -- Dịch vị trí xuống dòng tiếp theo
        end
    end
end

-- Khi có người vào hoặc rời khỏi server, cập nhật danh sách
players.PlayerAdded:Connect(updatePlayerList)
players.PlayerRemoving:Connect(updatePlayerList)

-- Cập nhật danh sách ban đầu khi script chạy
updatePlayerList()

--------------------------------------------------------------------------------------------
--Info
local InfoFrame = sections["Info"]

local function copyToClipboard(text)
    if setclipboard then
        setclipboard(text)
    elseif toclipboard then
        toclipboard(text)
    else
        print("Không thể sao chép, script không hỗ trợ clipboard!")
    end
end

-- Tạo nút "Discord"
CreateButton(InfoFrame, "👾 Discord", 10, function()
    copyToClipboard("https://discord.gg/HSEfQPzdpH") -- Thay link này bằng link Discord của bạn
end)

-----------------------------------------------------------------------------
--SPEED
local SpeedFrame = sections["Player"]
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local runService = game:GetService("RunService")

local isActive = false
local speedValue = 3 -- Tốc độ mặc định
local distancePerTeleport = 1.5

-- Nút bật/tắt
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleSpeed"
toggleButton.Parent = SpeedFrame
toggleButton.Size = UDim2.new(0, 90, 0, 30)
toggleButton.Position = UDim2.new(0, 240, 0, 10)
toggleButton.Text = "OFF"
toggleButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
toggleButton.TextColor3 = Color3.new(1, 1, 1)
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextScaled = true

-- Ô nhập tốc độ
local speedBox = Instance.new("TextBox")
speedBox.Name = "SpeedInput"
speedBox.Parent = SpeedFrame
speedBox.Size = UDim2.new(0, 50, 0, 30)
speedBox.Position = UDim2.new(0, 190, 0, 10)
speedBox.Text = tostring(speedValue)
speedBox.PlaceholderText = "Speed"
speedBox.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
speedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBox.Font = Enum.Font.SourceSansBold
speedBox.TextScaled = true

-- Cập nhật tốc độ từ ô nhập
speedBox.FocusLost:Connect(function()
	local newSpeed = tonumber(speedBox.Text)
	if newSpeed and newSpeed > 0 and newSpeed <= 10 then
		speedValue = newSpeed
	else
		speedBox.Text = tostring(speedValue)
	end
end)

-- Toggle nút ON/OFF
toggleButton.MouseButton1Click:Connect(function()
	isActive = not isActive
	toggleButton.Text = isActive and "ON" or "OFF"
	toggleButton.BackgroundColor3 = isActive and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
end)

-- Hàm dịch chuyển
local function TeleportStep()
	if not isActive or not character or not humanoidRootPart then return end
	local moveDirection = character:FindFirstChild("Humanoid") and character.Humanoid.MoveDirection or Vector3.zero
	if moveDirection.Magnitude > 0 then
		local newPos = humanoidRootPart.Position + (moveDirection * distancePerTeleport)
		humanoidRootPart.CFrame = CFrame.new(newPos, newPos + moveDirection)
	end
end

-- Gọi dịch chuyển mỗi frame
runService.RenderStepped:Connect(function()
	if isActive then
		for _ = 1, speedValue do
			TeleportStep()
		end
	end
end)

-- Cập nhật khi respawn
player.CharacterAdded:Connect(function(char)
	character = char
	humanoidRootPart = char:WaitForChild("HumanoidRootPart")
end)

--title
local HomeFrame = sections["Player"]

local Title = Instance.new("TextLabel", HomeFrame)
Title.Size = UDim2.new(0, 170, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 10)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Text = "SPEED"
Title.TextScaled = true
Title.Font = Enum.Font.SourceSansBold
Title.BorderSizePixel = 2
Title.BorderColor3 = Color3.new(255, 255, 255)

---------------------------------------------------------------------------------
--MOON
local MoonFrame = sections["Status"]
local Lighting = game:GetService("Lighting")

-- Frame chứa ảnh mặt trăng
local moonImage = Instance.new("ImageLabel")
moonImage.Name = "MoonImage"
moonImage.Parent = MoonFrame
moonImage.Size = UDim2.new(0, 90, 0, 90)
moonImage.Position = UDim2.new(0, 240, 0, 10)
moonImage.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
moonImage.BorderSizePixel = 0
moonImage.ScaleType = Enum.ScaleType.Fit

-- Hàm lấy ID từ đường dẫn MoonTextureId
local function extractIdFromUrl(url)
	local id = string.match(url, "%d+")
	return id
end

-- Cập nhật hình ảnh theo MoonTextureId
local function updateMoonImage()
	local moonTexture = Lighting:FindFirstChildOfClass("Sky") and Lighting:FindFirstChildOfClass("Sky").MoonTextureId
	if moonTexture then
		local id = extractIdFromUrl(moonTexture)
		if id then
			moonImage.Image = "rbxthumb://type=Asset&id=" .. id .. "&w=150&h=150"
		end
	end
end

-- Theo dõi thay đổi MoonTextureId
local currentSky = Lighting:FindFirstChildOfClass("Sky")
if currentSky then
	currentSky:GetPropertyChangedSignal("MoonTextureId"):Connect(updateMoonImage)
end

-- Nếu Sky bị thay đổi
Lighting.ChildAdded:Connect(function(child)
	if child:IsA("Sky") then
		currentSky = child
		child:GetPropertyChangedSignal("MoonTextureId"):Connect(updateMoonImage)
		updateMoonImage()
	end
end)

Lighting.ChildRemoved:Connect(function(child)
	if child == currentSky then
		currentSky = nil
		moonImage.Image = "" -- Xóa ảnh nếu Sky bị xoá
	end
end)

-- Cập nhật lần đầu
updateMoonImage()

--title
local HomeFrame = sections["Status"]

local Title = Instance.new("TextLabel", HomeFrame)
Title.Size = UDim2.new(0, 220, 0, 80)
Title.Position = UDim2.new(0, 10, 0, 10)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Text = "Moon"
Title.TextScaled = true
Title.Font = Enum.Font.SourceSansBold
Title.BorderSizePixel = 2
Title.BorderColor3 = Color3.new(255, 255, 255)

-------------------------------------------------------------------------------
--COUNT PLAYER
local HomeFrame = sections["Status"]
local Players = game:GetService("Players")

-- Frame chứa icon và văn bản
local playerCountFrame = Instance.new("Frame")
playerCountFrame.Name = "PlayerCountFrame"
playerCountFrame.Parent = HomeFrame
playerCountFrame.Size = UDim2.new(0, 130, 0, 30)
playerCountFrame.Position = UDim2.new(0, 240, 0, 50)
playerCountFrame.BackgroundTransparency = 1

-- Icon hình cộng đồng
local icon = Instance.new("ImageLabel")
icon.Name = "CommunityIcon"
icon.Parent = playerCountFrame
icon.Size = UDim2.new(0, 30, 0, 30)
icon.Position = UDim2.new(0, 10, 0, 60)
icon.BackgroundTransparency = 1
icon.Image = "rbxthumb://type=Asset&id=136258799911155&w=150&h=150"

-- Label hiển thị số lượng người
local playerLabel = Instance.new("TextLabel")
playerLabel.Name = "PlayerLabel"
playerLabel.Parent = playerCountFrame
playerLabel.Size = UDim2.new(0, 90, 0, 30)
playerLabel.Position = UDim2.new(0, 35, 0, 60)
playerLabel.BackgroundTransparency = 1
playerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
playerLabel.TextXAlignment = Enum.TextXAlignment.Left
playerLabel.Font = Enum.Font.SourceSans
playerLabel.TextSize = 20

-- Hàm cập nhật số lượng người chơi
local function updatePlayerCount()
	local currentPlayers = #Players:GetPlayers()
	local maxPlayers = game:GetService("Players").MaxPlayers or 12 -- thường mặc định 12
	playerLabel.Text = tostring(currentPlayers) .. "/" .. tostring(maxPlayers)
end

-- Kết nối cập nhật khi người vào/ra
Players.PlayerAdded:Connect(updatePlayerCount)
Players.PlayerRemoving:Connect(updatePlayerCount)

-- Cập nhật ban đầu
updatePlayerCount()

--title
local HomeFrame = sections["Status"]

local Title = Instance.new("TextLabel", HomeFrame)
Title.Size = UDim2.new(0, 220, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 110)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Text = "Player"
Title.TextScaled = true
Title.Font = Enum.Font.SourceSansBold
Title.BorderSizePixel = 2
Title.BorderColor3 = Color3.new(255, 255, 255)
