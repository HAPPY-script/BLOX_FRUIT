return function(sections)
    local HomeFrame = sections["PVP"]

    --===========FOLLOW PLAYER======================================================
    
    do
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local hrp = character:WaitForChild("HumanoidRootPart")
        local RunService = game:GetService("RunService")
        local TweenService = game:GetService("TweenService")
        local camera = workspace.CurrentCamera

        -- 🧩 Nút bật/tắt
        local toggleFarm = Instance.new("TextButton", HomeFrame)
        toggleFarm.Size = UDim2.new(0, 90, 0, 30)
        toggleFarm.Position = UDim2.new(0, 240, 0, 160)
        toggleFarm.Text = "OFF"
        toggleFarm.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        toggleFarm.TextColor3 = Color3.new(1, 1, 1)
        toggleFarm.Font = Enum.Font.SourceSansBold
        toggleFarm.TextScaled = true

        local LOW_HP_THRESHOLD = 0.35       -- < 35% sẽ kích hoạt chạy trốn
        local MAX_Y_SPEED = 5000            -- (studs/giây) Y có thể thay đổi rất nhanh (gần teleport)
        local XZ_SPEED = 300                -- (studs/giây) tốc độ giới hạn cho trục X/Z (tween)
        local ESCAPE_Y_DELTA = 10000        -- số đơn vị Y muốn di chuyển lên khi chạy trốn (cộng vào Y hiện tại)


        local running = false
        local farmCenter = nil
        local anchor = nil
        local anchorY = nil
        local lastUpdate = 0
        local anchorUpdateInterval = 1
        local lastAnchorUpdate = 0
        local currentHighlight = nil
        local highlightTween = nil

        local function getMyHealthPercent()
            local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.MaxHealth > 0 then
                return hum.Health / hum.MaxHealth
            end
            return 1
        end

        -- 🧱 Tạo part làm tâm camera
        local function ensureAnchor()
            if not anchor or not anchor.Parent then
                anchor = Instance.new("Part")
                anchor.Anchored = true
                anchor.CanCollide = false
                anchor.Transparency = 1
                anchor.Size = Vector3.new(1, 1, 1)
                anchor.Name = "CameraAnchor"
        
                -- 🧭 Tạo ngay tại vị trí hiện tại của người chơi
                if hrp and hrp:IsDescendantOf(workspace) then
                    anchor.Position = hrp.Position
                else
                    anchor.Position = Vector3.new(0, 10, 0)
                end
        
                anchor.Parent = workspace
            end
            return anchor
        end

        -- 🧭 Tween tiện ích
        local function tweenTo(pos)
            local dist = (hrp.Position - pos).Magnitude
            if dist > 10000 then return end
            local tween = TweenService:Create(hrp, TweenInfo.new(dist / 300, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)})
            tween:Play()
            tween.Completed:Wait()
        end

        -- 🔍 Tìm enemy gần nhất
        local function getNearestEnemy(centerPos)
            local folder = workspace:FindFirstChild("Enemies")
            if not folder then return nil end
            local nearest, nearestDist
            for _, mob in ipairs(folder:GetChildren()) do
                if mob:IsA("Model") and mob:FindFirstChild("HumanoidRootPart") then
                    local hp = mob:FindFirstChildOfClass("Humanoid")
                    if hp and hp.Health > 0 then
                        local dist = (centerPos - mob.HumanoidRootPart.Position).Magnitude
                        if not nearestDist or dist < nearestDist then
                            nearest = mob
                            nearestDist = dist
                        end
                    end
                end
            end
            return nearest
        end

        -- 🌈 Highlight theo HP
        local function updateHighlight(enemy)
            if not enemy then return end
            local humanoid = enemy:FindFirstChildOfClass("Humanoid")
            if not humanoid then return end

            -- Nếu đổi enemy → xoá highlight cũ
            if currentHighlight and currentHighlight.Adornee ~= enemy then
                currentHighlight:Destroy()
                currentHighlight = nil
            end

            -- Nếu chưa có highlight → tạo mới
            if not currentHighlight then
                currentHighlight = Instance.new("Highlight")
                currentHighlight.FillTransparency = 0.2
                currentHighlight.OutlineTransparency = 0.9
                currentHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                currentHighlight.Parent = enemy
                currentHighlight.Adornee = enemy
            end

            -- Cập nhật màu theo HP
            local percent = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)

            -- Xanh lá → Đỏ
            local targetColor = Color3.fromRGB(
                255 * (1 - percent), -- Red
                255 * percent,       -- Green
                0                    -- Blue
            )

            if highlightTween then
                highlightTween:Cancel()
            end

            highlightTween = TweenService:Create(
                currentHighlight,
                TweenInfo.new(0.15, Enum.EasingStyle.Linear),
                {FillColor = targetColor}
            )
            highlightTween:Play()

            -- Auto remove khi enemy chết
            task.spawn(function()
                local thisEnemy = enemy
                while thisEnemy.Parent and humanoid.Health > 0 and running do
                    task.wait(0.1)

                    -- Cập nhật màu liên tục
                    local percent2 = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
                    local targetColor2 = Color3.fromRGB(
                        255 * (1 - percent2),
                        255 * percent2,
                        0
                    )

                    currentHighlight.FillColor = targetColor2
                end

                -- Enemy die hoặc bị đổi enemy
                if currentHighlight and currentHighlight.Adornee == thisEnemy then
                    currentHighlight:Destroy()
                    currentHighlight = nil
                end
            end)
        end

        -- 🧠 Theo dõi enemy với anchor camera
        local function followEnemy(enemy)
            if not enemy or not enemy.Parent then return end
            local hrpEnemy = enemy:FindFirstChild("HumanoidRootPart")
            local humanoid = enemy:FindFirstChildOfClass("Humanoid")
            if not hrpEnemy or not humanoid then return end

            -- đảm bảo highlight và anchor
            updateHighlight(enemy)
            local anchor = ensureAnchor()
            local camera = workspace.CurrentCamera

            -- lần đầu set anchorY nếu cần
            if not anchorY or (tick() - lastAnchorUpdate) > anchorUpdateInterval then
                anchorY = hrpEnemy.Position.Y + 25
                lastAnchorUpdate = tick()
            end

            camera.CameraType = Enum.CameraType.Custom
            camera.CameraSubject = anchor

            local lastTick = tick()
            -- main loop: nếu enemy sống và running thì bám theo
            while humanoid.Health > 0 and running do
                if not hrp or not hrp:IsDescendantOf(workspace) then break end

                -- tính dt an toàn
                local now = tick()
                local dt = math.clamp(now - lastTick, 0, 0.1)
                lastTick = now

                -- Luôn update highlight để chính xác
                updateHighlight(enemy)

                -- nếu HP bản thân thấp => bật chế độ chạy trốn
                if getMyHealthPercent() < LOW_HP_THRESHOLD then
                    -- camera theo người chơi khi chạy trốn
                    camera.CameraSubject = hrp

                    -- mục tiêu XZ: theo enemy, Y: cao + large delta
                    local targetXZ = Vector3.new(hrpEnemy.Position.X, 0, hrpEnemy.Position.Z)
                    local currentPos = hrp.Position
                    local desiredY = currentPos.Y + ESCAPE_Y_DELTA

                    -- di chuyển XZ mượt với giới hạn speed
                    local dirXZ = Vector3.new(targetXZ.X - currentPos.X, 0, targetXZ.Z - currentPos.Z)
                    local distXZ = dirXZ.Magnitude
                    local moveXZ = Vector3.new(0,0,0)
                    if distXZ > 0.001 then
                        local maxMove = XZ_SPEED * dt
                        local t = math.min(1, maxMove / distXZ)
                        moveXZ = dirXZ * t
                    end

                    -- di chuyển Y nhanh (không bị giới hạn tween chậm) nhưng vẫn giới hạn tốc độ theo MAX_Y_SPEED
                    local dy = desiredY - currentPos.Y
                    local maxYMove = MAX_Y_SPEED * dt
                    local moveY = math.clamp(dy, -maxYMove, maxYMove)

                    local newPos = Vector3.new(currentPos.X + moveXZ.X, currentPos.Y + moveY, currentPos.Z + moveXZ.Z)

                    -- cập nhật HRP (teleport-y style nhưng X/Z mượt)
                    hrp.AssemblyLinearVelocity = Vector3.zero
                    hrp.CFrame = CFrame.new(newPos)

                    -- chờ frame tiếp theo
                    RunService.RenderStepped:Wait()
                    continue
                end

                -- Nếu không ở chế độ low HP -> bình thường bám theo anchor (giữ Y cố định theo anchorY)
                anchorY = hrpEnemy.Position.Y + 25
                local targetPos = Vector3.new(hrpEnemy.Position.X, anchorY, hrpEnemy.Position.Z)

                -- neo camera mượt (anchor di chuyển mềm)
                anchor.Position = anchor.Position:Lerp(targetPos, 0.15)

                -- di chuyển người chơi X/Z mượt, Y được giữ theo anchorY (hạn chế trượt)
                hrp.AssemblyLinearVelocity = Vector3.zero
                hrp.CFrame = hrp.CFrame:Lerp(CFrame.new(targetPos), 0.25)

                RunService.RenderStepped:Wait()
            end

            -- khi enemy chết hoặc vòng while kết thúc, trả camera về HRP nếu tồn tại
            if hrp and hrp:IsDescendantOf(workspace) then
                camera.CameraSubject = hrp
            end
        end

        -- 🧩 Reset khi chết
        player.CharacterAdded:Connect(function(newChar)
            character = newChar
            hrp = newChar:WaitForChild("HumanoidRootPart")
            running = false
            anchorY = nil
            if anchor then anchor:Destroy() end
            toggleFarm.Text = "OFF"
            toggleFarm.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
            camera.CameraType = Enum.CameraType.Custom
            camera.CameraSubject = hrp
        end)

        -- 🔘 Nút bật/tắt
        toggleFarm.MouseButton1Click:Connect(function()
            running = not running
            toggleFarm.Text = running and "ON" or "OFF"
            toggleFarm.BackgroundColor3 = running and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 50, 50)
            farmCenter = running and hrp.Position or nil
            if not running then
                camera.CameraType = Enum.CameraType.Custom
                camera.CameraSubject = hrp
                if anchor then anchor:Destroy() end
            end
        end)

        -- ♻️ Auto farm
        task.spawn(function()
            while true do
                task.wait()
                if not running or not hrp then continue end
                local target = getNearestEnemy(hrp.Position)
                if target then
                    followEnemy(target)
                end
            end
        end)

        -- ⚔️ Auto đánh
        task.spawn(function()
            while true do
                task.wait(0.4)
                if running then
                    pcall(function()
                        game:GetService("ReplicatedStorage")
                            :WaitForChild("Modules")
                            :WaitForChild("Net")
                            :WaitForChild("RE/RegisterAttack")
                            :FireServer(0.4)
                    end)
                end
            end
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
