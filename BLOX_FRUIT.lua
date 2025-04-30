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
    {name = "PVP", icon = "rbxthumb://type=Asset&id=4391741908&w=150&h=150"},
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

----------------------------------------------------------------------------------------------------
--Tracker
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

--====================================================================
--=======TITLE========================================================
--====================================================================
--TITLE
local titleScript = loadstring(game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/BLOX_FRUIT/refs/heads/main/TITLE.lua"))()
titleScript(sections)

--Player tad
local PlayerPage = loadstring(game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/BLOX_FRUIT/refs/heads/main/Player.lua"))()
PlayerPage(sections)

--Home tad
local HomePage = loadstring(game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/BLOX_FRUIT/refs/heads/main/Home.lua"))()
HomePage(sections)

--Status tad
local StatusPage = loadstring(game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/BLOX_FRUIT/refs/heads/main/Status.lua"))()
StatusPage(sections)

--Visual tad
local VisualPage = loadstring(game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/BLOX_FRUIT/refs/heads/main/Visual.lua"))()
VisualPage(sections)

--Fruit tad
local FruitPage = loadstring(game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/BLOX_FRUIT/refs/heads/main/CHECK_Fruit.lua"))()
FruitPage(sections)

--Raid tad
local RaidPage = loadstring(game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/BLOX_FRUIT/refs/heads/main/Raid.lua"))()
RaidPage(sections)

wait(0.2)

print("Blox Fruit hub SUCCESS✅")
