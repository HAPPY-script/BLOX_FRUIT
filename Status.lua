return function(sections)
    local HomeFrame = sections["Status"]

        --MOON---------------------------------------------------------------------------------------------------------
    do
        -- Frame chứa ảnh mặt trăng
        local moonImage = Instance.new("ImageLabel")
        moonImage.Name = "MoonImage"
        moonImage.Parent = MoonFrame
        moonImage.Size = UDim2.new(0, 90, 0, 90)
        moonImage.Position = UDim2.new(0, 240, 0, 10)
        moonImage.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        moonImage.BorderSizePixel = 0
        moonImage.ScaleType = Enum.ScaleType.Stretch -- Đổi từ Fit sang Stretch để xoay ảnh
        moonImage.Rotation = 180 -- Xoay ảnh đúng chiều

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
    end

        --COUNT PLAYER---------------------------------------------------------------------------------------------------------
    do
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
    end
end
