return function(sections)
    local HomeFrame = sections["Player"]

        --SPEED================================================================================================f
    do
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
    end
        --NO CLIP================================================================================================
    do
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
    end
        --TP KEY PC================================================================================================
    do
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
    end
        --TP BUTTON PE================================================================================================
    do
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

        --IFN JUMP======================================================================================================
    do
        local player = game.Players.LocalPlayer
        local userInputService = game:GetService("UserInputService")

        local infiniteJumpEnabled = false
        local jumpConnection

        -- Nút bật/tắt Infinite Jump
        local jumpButton = Instance.new("TextButton", HomeFrame)
        jumpButton.Size = UDim2.new(0, 90, 0, 30)
        jumpButton.Position = UDim2.new(0, 240, 0, 210)
        jumpButton.Text = "OFF"
        jumpButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        jumpButton.TextColor3 = Color3.new(1, 1, 1)
        jumpButton.Font = Enum.Font.SourceSansBold
        jumpButton.TextSize = 30

        -- Kết nối sự kiện nhảy
        jumpConnection = userInputService.JumpRequest:Connect(function()
            if infiniteJumpEnabled then
                local char = player.Character
                if char and char:FindFirstChildOfClass("Humanoid") then
                    char:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)

        -- Xử lý bật/tắt
        jumpButton.MouseButton1Click:Connect(function()
            infiniteJumpEnabled = not infiniteJumpEnabled
            jumpButton.Text = infiniteJumpEnabled and "ON" or "OFF"
            jumpButton.BackgroundColor3 = infiniteJumpEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(250, 50, 50)
        end)
    end

        --AIMBOT KEY PC======================================================================================================
    do
        local player = game.Players.LocalPlayer
        local camera = workspace.CurrentCamera
        local userInputService = game:GetService("UserInputService")
        local runService = game:GetService("RunService")

        local aimModEnabled = false
        local selectedInput = Enum.KeyCode.F
        local isKeyHeld = false
        local waitingForKey = false

        -- 🟢 Nút bật/tắt Aim Player
        local AimModButton = Instance.new("TextButton", HomeFrame)
        AimModButton.Size  = UDim2.new(0,90,0,30)
        AimModButton.Position = UDim2.new(0,240,0,260)
        AimModButton.Text  = "OFF"
        AimModButton.BackgroundColor3 = Color3.fromRGB(255,50,50)
        AimModButton.TextColor3 = Color3.fromRGB(255,255,255)
        AimModButton.Font = Enum.Font.SourceSansBold
        AimModButton.TextSize = 30

        -- 🔵 Nút chọn phím Aim Player
        local KeybindButton = Instance.new("TextButton", HomeFrame)
        KeybindButton.Size = UDim2.new(0, 50, 0, 30)
        KeybindButton.Position = UDim2.new(0, 190, 0, 260)
        KeybindButton.Text = "Select\nkey"
        KeybindButton.BackgroundColor3 = Color3.fromRGB(50, 50, 200)
        KeybindButton.TextColor3 = Color3.fromRGB(255, 255, 255)

        -- 🔹 Khi bấm nút bật Aim
        AimModButton.MouseButton1Click:Connect(function()
            aimModEnabled = not aimModEnabled
            AimModButton.Text = aimModEnabled and "ON" or "OFF"
            AimModButton.BackgroundColor3 = aimModEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 50, 50)
        end)

        -- 🔹 Khi bấm nút chọn phím
        KeybindButton.MouseButton1Click:Connect(function()
            KeybindButton.Text = "Select key..."
            waitingForKey = true
        end)

        -- 🔹 Bắt input
        userInputService.InputBegan:Connect(function(input, gameProcessed)
            if waitingForKey then
                if input.UserInputType == Enum.UserInputType.Keyboard or input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 then
                    selectedInput = input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode or input.UserInputType
                    KeybindButton.Text = "Select key:\n" .. (input.KeyCode.Name or tostring(input.UserInputType.Name))
                    waitingForKey = false
                end
            else
                if input.KeyCode == selectedInput or input.UserInputType == selectedInput then
                    isKeyHeld = true
                end
            end
        end)

        userInputService.InputEnded:Connect(function(input)
            if input.KeyCode == selectedInput or input.UserInputType == selectedInput then
                isKeyHeld = false
            end
        end)

        -- 🔹 **Tìm người chơi gần nhất**
        local function GetClosestPlayerHead()
            local closestHead = nil
            local closestDistance = math.huge
            local crosshair = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
            local maxRadius = 200

            for _, otherPlayer in pairs(game.Players:GetPlayers()) do
                if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("Head") then
                    local head = otherPlayer.Character.Head
                    local screenPoint, onScreen = camera:WorldToViewportPoint(head.Position)
                    if onScreen then
                        local screenPos = Vector2.new(screenPoint.X, screenPoint.Y)
                        local screenDistance = (screenPos - crosshair).magnitude
                        if screenDistance < closestDistance and screenDistance <= maxRadius then
                            closestDistance = screenDistance
                            closestHead = head
                        end
                    end
                end
            end
            return closestHead
        end

        -- 🔹 **Cập nhật Aim**
        local function AimAtTarget()
            if not aimModEnabled or not isKeyHeld then return end

            local targetHead = GetClosestPlayerHead()
            if targetHead then
                camera.CFrame = CFrame.new(camera.CFrame.Position, targetHead.Position)
            end
        end

        runService.RenderStepped:Connect(AimAtTarget)

        -- 🔄 Reset khi hồi sinh
        player.CharacterAdded:Connect(function()
            aimModEnabled = false
            isKeyHeld = false
            AimModButton.Text = "OFF"
            AimModButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        end)
    end

        --AIMBOT KEY PC======================================================================================================
    do
        local player = game.Players.LocalPlayer
        local camera = workspace.CurrentCamera
        local userInputService = game:GetService("UserInputService")
        local runService = game:GetService("RunService")
        local mouse = player:GetMouse()

        local silentAimEnabled = false
        local isAimHeld = false

        -- 🟢 NÚT BẬT/TẮT AIM (TRONG HOME TAB)
        local AimButton = Instance.new("TextButton", HomeFrame)
        AimButton.Size = UDim2.new(0, 90, 0, 30)
        AimButton.Position = UDim2.new(0, 240, 0, 310)
        AimButton.Text = "OFF"
        AimButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        AimButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        AimButton.Font = Enum.Font.SourceSansBold
        AimButton.TextSize = 30

        -- 🟢 NÚT AIM TRÊN MÀN HÌNH (DÀNH CHO PE)
        local screenGui = Instance.new("ScreenGui", game.CoreGui)
        local MobileAimButton = Instance.new("TextButton", screenGui)
        MobileAimButton.Size = UDim2.new(0, 40, 0, 40)
        MobileAimButton.Position = UDim2.new(0.89, 0, 0.5, -70)
        MobileAimButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        MobileAimButton.BackgroundTransparency = 0.5
        MobileAimButton.Text = "🎯"
        MobileAimButton.TextScaled = true
        MobileAimButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        MobileAimButton.Visible = false

        -- Bo tròn nút Aim
        local UICorner = Instance.new("UICorner", MobileAimButton)
        UICorner.CornerRadius = UDim.new(1, 0)

        -- 🟢 BẬT/TẮT CHỨC NĂNG AIM
        local function ToggleAim()
            silentAimEnabled = not silentAimEnabled
            AimButton.Text = silentAimEnabled and "ON" or "OFF"
            AimButton.BackgroundColor3 = silentAimEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 50, 50)

            -- Hiện nút Aim khi bật chức năng
            MobileAimButton.Visible = silentAimEnabled
            MobileAimButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        end

        AimButton.MouseButton1Click:Connect(ToggleAim)

        -- 🟢 GIỮ NÚT AIM ĐỂ BẬT AIM MOD
        MobileAimButton.MouseButton1Down:Connect(function()
            if silentAimEnabled then
                isAimHeld = true
                MobileAimButton.BackgroundColor3 = Color3.fromRGB(0, 0, 139) -- Chuyển sang màu xanh dương khi giữ
            end
        end)

        MobileAimButton.MouseButton1Up:Connect(function()
            isAimHeld = false
            MobileAimButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100) -- Reset về màu xám
        end)

        -- 🟢 HÀM TÌM VÀ AIM VÀO NGƯỜI CHƠI
        local function GetClosestPlayerHeadInRange()
            local closestHead = nil
            local closestScreenDistance = math.huge
            local crosshairPosition = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
            local maxRadius = 200

            for _, plr in ipairs(game.Players:GetPlayers()) do
                if plr ~= player and plr.Character and plr.Character:FindFirstChild("Head") then
                    local head = plr.Character.Head
                    local screenPoint, onScreen = camera:WorldToViewportPoint(head.Position)
                    if onScreen then
                        local screenPosition = Vector2.new(screenPoint.X, screenPoint.Y)
                        local screenDistance = (screenPosition - crosshairPosition).magnitude
                        if screenDistance < closestScreenDistance and screenDistance <= maxRadius then
                            closestScreenDistance = screenDistance
                            closestHead = head
                        end
                    end
                end
            end

            return closestHead
        end

        -- 🟢 AIM VÀO ĐẦU NGƯỜI CHƠI
        local function AimAtPlayerHead()
            if not silentAimEnabled or not isAimHeld then return end

            local targetHead = GetClosestPlayerHeadInRange()
            if targetHead then
                camera.CFrame = CFrame.new(camera.CFrame.Position, targetHead.Position)
            end
        end

        runService.RenderStepped:Connect(AimAtPlayerHead)

        -- 🟢 RESET TRẠNG THÁI KHI CHẾT
        player.CharacterAdded:Connect(function()
            silentAimEnabled = false
            isAimHeld = false
            AimButton.Text = "OFF"
            AimButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            MobileAimButton.Visible = false
            MobileAimButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        end)
    end

    wait(0.2)

    print("Player tad SUCCESS✅")
end
