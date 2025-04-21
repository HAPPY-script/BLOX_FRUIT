return function(sections)
    local HomeFrame = sections["Player"]

    --SPEED================================================================================================
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

    --NO CLIP================================================================================================

    local player = game.Players.LocalPlayer
    local userInputService = game:GetService("UserInputService")
    local runService = game:GetService("RunService")

    local noclipEnabled = false
    local character = player.Character or player.CharacterAdded:Wait()
    local noclipConnection

    -- Hàm bật/tắt No Clip
    local function setNoclip(state)
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = not state
                end
            end
        end
    end

    -- Nút No Clip trong tab Home
    local noclipButton = Instance.new("TextButton", HomeFrame)
    noclipButton.Size = UDim2.new(0, 90, 0, 30)
    noclipButton.Position = UDim2.new(0, 240, 0, 60)
    noclipButton.Text = "OFF"
    noclipButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    noclipButton.TextColor3 = Color3.new(1, 1, 1)
    noclipButton.Font = Enum.Font.SourceSansBold
    noclipButton.TextScaled = true

    -- Bật/Tắt No Clip
    noclipButton.MouseButton1Click:Connect(function()
        noclipEnabled = not noclipEnabled
        noclipButton.Text = noclipEnabled and "ON" or "OFF"
        noclipButton.BackgroundColor3 = noclipEnabled and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)

        if noclipEnabled then
            if noclipConnection then noclipConnection:Disconnect() end
            noclipConnection = runService.Stepped:Connect(function()
                if noclipEnabled and character then
                    setNoclip(true)
                end
            end)
        else
            if noclipConnection then noclipConnection:Disconnect() end
            setNoclip(false)
        end
    end)

    -- Reset khi nhân vật hồi sinh
    player.CharacterAdded:Connect(function(newChar)
        character = newChar
        noclipEnabled = false
        if noclipConnection then noclipConnection:Disconnect() end
        noclipButton.Text = "OFF"
        noclipButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    end)

    --TP KEY PC================================================================================================

    local player = game.Players.LocalPlayer
    local userInputService = game:GetService("UserInputService")

    -- Biến trạng thái
    local teleportEnabled = false
    local selectedKey = nil
    local listeningForKey = false

    -- Nút ON/OFF
    local TeleportButton = Instance.new("TextButton", HomeFrame)
    TeleportButton.Size = UDim2.new(0, 90, 0, 30)
    TeleportButton.Position = UDim2.new(0, 240, 0, 110)
    TeleportButton.Text = "OFF"
    TeleportButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    TeleportButton.TextColor3 = Color3.new(1, 1, 1)
    TeleportButton.Font = Enum.Font.SourceSansBold
    TeleportButton.TextScaled = true

    -- Ô chọn phím
    local KeySelectBox = Instance.new("TextButton", HomeFrame)
    KeySelectBox.Size = UDim2.new(0, 50, 0, 30)
    KeySelectBox.Position = UDim2.new(0, 190, 0, 110)
    KeySelectBox.Text = "Select Key"
    KeySelectBox.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    KeySelectBox.TextColor3 = Color3.new(1, 1, 1)
    KeySelectBox.Font = Enum.Font.SourceSans
    KeySelectBox.TextScaled = true

    -- Xử lý chọn phím
    KeySelectBox.MouseButton1Click:Connect(function()
    	if listeningForKey then return end
    	listeningForKey = true
    	KeySelectBox.Text = "Press a key..."
	
    	local conn
    	conn = userInputService.InputBegan:Connect(function(input, gameProcessed)
    		if gameProcessed then return end
		
    		local inputName
    		if input.UserInputType == Enum.UserInputType.Keyboard then
    			inputName = input.KeyCode.Name
    		elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
    			inputName = "MouseButton1"
    		elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
    			inputName = "MouseButton2"
    		end

    		if inputName then
    			selectedKey = inputName
    			KeySelectBox.Text = inputName
    			conn:Disconnect()
    			listeningForKey = false
    		end
    	end)
    end)

    -- Chức năng dịch chuyển
    local function teleportToMouse()
    	if teleportEnabled and selectedKey then
    		local character = player.Character
    		local mouse = player:GetMouse()
    		if character and character:FindFirstChild("HumanoidRootPart") then
    			local pos = mouse.Hit.Position
    			local root = character.HumanoidRootPart
    			local distance = (root.Position - pos).Magnitude
    			if distance <= 250 then
    				root.CFrame = CFrame.new(pos)
    			end
    		end
    	end
    end

    -- Bật/Tắt chức năng
    TeleportButton.MouseButton1Click:Connect(function()
    	teleportEnabled = not teleportEnabled
    	TeleportButton.Text = teleportEnabled and "ON" or "OFF"
    	TeleportButton.BackgroundColor3 = teleportEnabled and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
    end)

    -- Bắt phím để teleport
    userInputService.InputBegan:Connect(function(input, gameProcessed)
    	if gameProcessed or not teleportEnabled or not selectedKey then return end

    	local inputName
    	if input.UserInputType == Enum.UserInputType.Keyboard then
    		inputName = input.KeyCode.Name
    	elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
    		inputName = "MouseButton1"
    	elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
    		inputName = "MouseButton2"
    	end

    	if inputName == selectedKey then
    		teleportToMouse()
    	end
    end)

    -- Reset khi chết
    player.CharacterAdded:Connect(function()
    	teleportEnabled = false
    	selectedKey = nil
    	TeleportButton.Text = "OFF"
    	TeleportButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    	KeySelectBox.Text = "SELECT KEY"
    end)

    --TP BUTTON PE================================================================================================

    local player = game.Players.LocalPlayer
    local userInputService = game:GetService("UserInputService")
    local mouse = player:GetMouse()
    local teleportEnabled = false
    local tpButtonActive = false

    -- Nút bật/tắt chính trong Home
    local TeleportPEButton = Instance.new("TextButton", HomeFrame)
    TeleportPEButton.Size = UDim2.new(0, 90, 0, 30)
    TeleportPEButton.Position = UDim2.new(0, 240, 0, 160)
    TeleportPEButton.Text = "OFF"
    TeleportPEButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    TeleportPEButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TeleportPEButton.Font = Enum.Font.SourceSansBold
    TeleportPEButton.TextSize = 30

    -- Tạo nút TP trên màn hình (Không bị mất khi chết)
    local screenGui = Instance.new("ScreenGui", game.CoreGui) -- Chuyển qua CoreGui để tránh bị reset khi chết
    local MobileTPButton = Instance.new("TextButton", screenGui)
    MobileTPButton.Size = UDim2.new(0, 40, 0, 40) -- Nhỏ lại 1/3
    MobileTPButton.Position = UDim2.new(0.92, 0, 0.5, -13) -- Trung điểm cạnh phải
    MobileTPButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    MobileTPButton.BackgroundTransparency = 0.5 -- Xám trong suốt
    MobileTPButton.Text = "⚡"
    MobileTPButton.TextScaled = true
    MobileTPButton.TextColor3 = Color3.new(1, 1, 1)
    MobileTPButton.Visible = false

    -- Bo tròn nút TP
    local UICorner = Instance.new("UICorner", MobileTPButton)
    UICorner.CornerRadius = UDim.new(1, 0)

    -- Khi bật chức năng TP
    local function ToggleTeleport()
        teleportEnabled = not teleportEnabled
        TeleportPEButton.Text = teleportEnabled and "ON" or "OFF"
        TeleportPEButton.BackgroundColor3 = teleportEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)

        -- Hiện/ẩn nút tròn trên màn hình
        MobileTPButton.Visible = teleportEnabled
        tpButtonActive = false
        MobileTPButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    end

    TeleportPEButton.MouseButton1Click:Connect(ToggleTeleport)

    -- Khi bấm nút tròn TP
    MobileTPButton.MouseButton1Click:Connect(function()
        if tpButtonActive then
            -- Nếu đang chờ TP -> Hủy TP
            tpButtonActive = false
            MobileTPButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100) -- Reset lại xám
        else
            -- Bật trạng thái chờ TP
            tpButtonActive = true
            MobileTPButton.BackgroundColor3 = Color3.fromRGB(0, 0, 139) -- Xanh dương
        end
    end)

    -- Khi click vào màn hình để TP
    local function TeleportToMouse()
        if teleportEnabled and tpButtonActive then
            local targetPosition = mouse.Hit.Position
            local character = player.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local rootPart = character.HumanoidRootPart
                local distance = (rootPart.Position - targetPosition).Magnitude
                if distance <= 250 then
                    rootPart.CFrame = CFrame.new(targetPosition)
                    tpButtonActive = false
                    MobileTPButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100) -- Reset lại xám
                end
            end
        end
    end

    -- Cho PC: Bấm chuột trái để TP
    mouse.Button1Down:Connect(TeleportToMouse)

    -- Cho PE: Chạm vào màn hình để TP
    userInputService.TouchTap:Connect(function(_, processed)
        if not processed then
            TeleportToMouse()
        end
    end)

    --reset
    player.CharacterAdded:Connect(function()
        teleportEnabled = false
        tpButtonActive = false
        TeleportPEButton.Text = "OFF"
        TeleportPEButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        MobileTPButton.Visible = false
        MobileTPButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    end)
end
