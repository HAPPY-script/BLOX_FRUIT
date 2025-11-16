return function(sections)
    local HomeFrame = sections["PVP"]

    --===========FOLLOW PLAYER======================================================
    
    do
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local player = Players.LocalPlayer

        local followEnabled = false
        local targetPlayer = nil

        -- UI nút bật/tắt
        local followButton = Instance.new("TextButton", HomeFrame)
        followButton.Size = UDim2.new(0, 90, 0, 30)
        followButton.Position = UDim2.new(0, 240, 0, 10)
        followButton.Text = "OFF"
        followButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        followButton.TextColor3 = Color3.new(1, 1, 1)
        followButton.Font = Enum.Font.SourceSansBold
        followButton.TextScaled = true

        -- Ô nhập tên
        local nameBox = Instance.new("TextBox", HomeFrame)
        nameBox.Size = UDim2.new(0, 50, 0, 30)
        nameBox.Position = UDim2.new(0, 190, 0, 10)
        nameBox.PlaceholderText = "Enter name"
        nameBox.Text = ""
        nameBox.TextScaled = true
        nameBox.Font = Enum.Font.SourceSans

        local function getHumanoid(plr)
            if not plr then return nil end
            local char = plr.Character
            if not char then return nil end
            return char:FindFirstChildOfClass("Humanoid")
        end

        local function getHRP(plr)
            if not plr or not plr.Character then return nil end
            return plr.Character:FindFirstChild("HumanoidRootPart")
        end

        local function disableFollow()
            followEnabled = false
            followButton.Text = "OFF"
            followButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        end

        local SAFE_DIST = 15       -- đứng sau mục tiêu 15m
        local SPEED = 280          -- tốc độ lao
        local TP_THRESHOLD = 200   -- nếu xa hơn 200 thì TP tới gần rồi lao

        -- Lunge mượt, không Tween, tracking theo hướng target thật-time
        local function smartLunge()
            local myHRP = getHRP(player)
            local tarHRP = getHRP(targetPlayer)
            if not myHRP or not tarHRP then return end

            while followEnabled do
                myHRP = getHRP(player)
                tarHRP = getHRP(targetPlayer)

                if not myHRP or not tarHRP then
                    disableFollow()
                    break
                end

                -- kiểm tra khi bản thân hoặc mục tiêu chết
                local myHum = getHumanoid(player)
                local tarHum = getHumanoid(targetPlayer)
                if not myHum or myHum.Health <= 0 then disableFollow(); break end
                if not tarHum or tarHum.Health <= 0 then disableFollow(); break end

                local targetPos = tarHRP.Position
                local myPos = myHRP.Position
                local dist = (myPos - targetPos).Magnitude

                if dist > TP_THRESHOLD then
                    -- TP tới sau mục tiêu 200m để đỡ lag
                    myHRP.CFrame = CFrame.new(targetPos - (tarHRP.CFrame.LookVector * 200))
                else
                    -- Lao liên tục nhưng luôn bám hướng mới nhất
                    local behind = targetPos - (tarHRP.CFrame.LookVector * SAFE_DIST)
                    local dir = (behind - myPos).Unit

                    myHRP.CFrame = myHRP.CFrame + dir * (SPEED * RunService.Heartbeat:Wait())
                end

                task.wait()
            end
        end

        -- Bật / tắt theo dõi
        followButton.MouseButton1Click:Connect(function()
            if not targetPlayer then return end
            followEnabled = not followEnabled

            followButton.Text = followEnabled and "ON" or "OFF"
            followButton.BackgroundColor3 =
                followEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 50, 50)

            if followEnabled then
                task.spawn(smartLunge)
            end
        end)

        -- Nhập tên người chơi
        nameBox.FocusLost:Connect(function()
            local input = nameBox.Text:lower()
            if #input < 3 then return end

            targetPlayer = nil
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= player and p.Name:lower():find(input) == 1 then
                    targetPlayer = p
                    break
                end
            end

            -- Auto OFF ngay nếu không tìm được mục tiêu hợp lệ
            if not targetPlayer then
                disableFollow()
            end
        end)

        -- Tự động tắt nếu bản thân chết
        player.CharacterAdded:Connect(function()
            disableFollow()
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
        AimModButton.Position = UDim2.new(0,240,0,60)
        AimModButton.Text  = "OFF"
        AimModButton.BackgroundColor3 = Color3.fromRGB(255,50,50)
        AimModButton.TextColor3 = Color3.fromRGB(255,255,255)
        AimModButton.Font = Enum.Font.SourceSansBold
        AimModButton.TextSize = 30

        -- 🔵 Nút chọn phím Aim Player
        local KeybindButton = Instance.new("TextButton", HomeFrame)
        KeybindButton.Size = UDim2.new(0, 50, 0, 30)
        KeybindButton.Position = UDim2.new(0, 190, 0, 60)
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

        --AIMBOT PE======================================================================================================
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
        AimButton.Position = UDim2.new(0, 240, 0, 110)
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
            AimButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
            MobileAimButton.Visible = false
            MobileAimButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end)
    end

        --FAST ATTACK======================================================================================================
    do
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local Players = game:GetService("Players")
        local Net = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Net")
        local EnemiesFolder = workspace:WaitForChild("Enemies")
        local LocalPlayer = Players.LocalPlayer

        -- Nút Fast Attack Enemy
        local btnFastAttackEnemy = Instance.new("TextButton", HomeFrame)
        btnFastAttackEnemy.Size = UDim2.new(0, 90, 0, 30)
        btnFastAttackEnemy.Position = UDim2.new(0, 240, 0, 160)
        btnFastAttackEnemy.Text = "OFF"
        btnFastAttackEnemy.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        btnFastAttackEnemy.TextColor3 = Color3.new(1, 1, 1)
        btnFastAttackEnemy.Font = Enum.Font.SourceSansBold
        btnFastAttackEnemy.TextSize = 30

        local isFastAttackEnemyEnabled = false

        btnFastAttackEnemy.MouseButton1Click:Connect(function()
        	isFastAttackEnemyEnabled = not isFastAttackEnemyEnabled
        	btnFastAttackEnemy.Text = isFastAttackEnemyEnabled and "ON" or "OFF"
        	btnFastAttackEnemy.BackgroundColor3 = isFastAttackEnemyEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 50, 50)
        end)

        -- Nút Attack Player
        local btnAttackPlayer = Instance.new("TextButton", HomeFrame)
        btnAttackPlayer.Size = UDim2.new(0, 90, 0, 30)
        btnAttackPlayer.Position = UDim2.new(0, 240, 0, 210)
        btnAttackPlayer.Text = "OFF"
        btnAttackPlayer.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        btnAttackPlayer.TextColor3 = Color3.new(1, 1, 1)
        btnAttackPlayer.Font = Enum.Font.SourceSansBold
        btnAttackPlayer.TextSize = 30

        local isAttackPlayerEnabled = false

        btnAttackPlayer.MouseButton1Click:Connect(function()
        	isAttackPlayerEnabled = not isAttackPlayerEnabled
        	btnAttackPlayer.Text = isAttackPlayerEnabled and "ON" or "OFF"
        	btnAttackPlayer.BackgroundColor3 = isAttackPlayerEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 50, 50)
        end)

        -- Tìm Enemy gần nhất
        local function getClosestEnemy()
        	local closest = nil
        	local shortest = math.huge
        	local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        	if not hrp then return nil end
        	for _, enemy in pairs(EnemiesFolder:GetChildren()) do
        		local part = enemy:FindFirstChild("UpperTorso")
        		if part then
        			local dist = (part.Position - hrp.Position).Magnitude
        			if dist < shortest then
        				shortest = dist
        				closest = part
        			end
        		end
        	end
        	return closest
        end

        -- Coroutine tấn công Enemy
        coroutine.wrap(function()
        	while true do
        		if isFastAttackEnemyEnabled then
        			local target = getClosestEnemy()
        			if target then
        				Net:WaitForChild("RE/RegisterHit"):FireServer(target, {}, "3269aee8")
        			end
        		end
        		wait(0.05)
        	end
        end)()

        -- Coroutine tấn công Player (luôn chạy nếu bật)
        coroutine.wrap(function()
        	while true do
        		if isAttackPlayerEnabled then
        			for _, player in pairs(Players:GetPlayers()) do
        				if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
        					Net:WaitForChild("RE/RegisterHit"):FireServer(player.Character.Head, {}, "326880d6")
        				end
        			end
        		end
        		wait(0.05)
        	end
        end)()
    end

    wait(0.2)

    print("PVP tad SUCCESS✅")
end
