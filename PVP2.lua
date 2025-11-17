return function(sections)
    local HomeFrame = sections["PVP"]

    --===========FOLLOW PLAYER======================================================
    do
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local player = Players.LocalPlayer

        local followEnabled = false
        local targetPlayer = nil
        local disabledDueLowHP = false

        -----------------------------------------------------
        -- TELEPORT POINTS
        -----------------------------------------------------
        local teleportPoints = {
            Vector3.new(-286.99, 306.18, 597.75),
            Vector3.new(-6508.56, 83.24, -132.84),
            Vector3.new(923.21, 125.11, 32852.83),
            Vector3.new(2284.91, 15.20, 905.62)
        }

        -----------------------------------------------------
        -- UI (giữ nguyên)
        -----------------------------------------------------
        local followButton = Instance.new("TextButton", HomeFrame)
        followButton.Size = UDim2.new(0, 90, 0, 30)
        followButton.Position = UDim2.new(0, 240, 0, 10)
        followButton.Text = "OFF"
        followButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        followButton.TextColor3 = Color3.new(1, 1, 1)
        followButton.Font = Enum.Font.SourceSansBold
        followButton.TextScaled = true

        local nameBox = Instance.new("TextBox", HomeFrame)
        nameBox.Size = UDim2.new(0, 50, 0, 30)
        nameBox.Position = UDim2.new(0, 190, 0, 10)
        nameBox.PlaceholderText = "Enter player name"
        nameBox.Text = ""
        nameBox.TextScaled = true
        nameBox.Font = Enum.Font.SourceSans

        -----------------------------------------------------
        -- Utility
        -----------------------------------------------------
        local function safeHRP()
            local char = player.Character
            if not char then return end
            return char:FindFirstChild("HumanoidRootPart")
        end
        local function safeHumanoid()
            local char = player.Character
            if not char then return end
            return char:FindFirstChildOfClass("Humanoid")
        end

        local function safeTargetHRP()
            if not targetPlayer then return end
            local char = targetPlayer.Character
            if not char then return end
            return char:FindFirstChild("HumanoidRootPart")
        end
        local function safeTargetHumanoid()
            if not targetPlayer then return end
            local char = targetPlayer.Character
            if not char then return end
            return char:FindFirstChildOfClass("Humanoid")
        end

        local function distance(a,b)
            return (a-b).Magnitude
        end

        local function findNearestTP(targetPos)
            local best = nil
            local bestDist = math.huge
            for _,p in pairs(teleportPoints) do
                local d = distance(p, targetPos)
                if d < bestDist then
                    bestDist = d
                    best = p
                end
            end
            return best, bestDist
        end

        -----------------------------------------------------
        -- Movement params
        -----------------------------------------------------
        local STOP_DIST = 4
        local BASE_SPEED = 240
        local MAX_SPEED = 700
        local DIST_MULT = 4
        local HEIGHT_OFFSET = 6

        -----------------------------------------------------
        -- Reset movement
        -----------------------------------------------------
        local function resetMovement()
            local hrp = safeHRP()
            local hum = safeHumanoid()

            if hrp then
                hrp.AssemblyLinearVelocity = Vector3.zero
                hrp.AssemblyAngularVelocity = Vector3.zero
            end

            if hum then
                pcall(function()
                    hum.PlatformStand = false
                    hum.AutoRotate = true
                end)
            end
        end

        -----------------------------------------------------
        -- Instant teleport
        -----------------------------------------------------
        local function teleportSmart(targetPos)
            local hrp = safeHRP()
            if not hrp then return end

            -- bước 1: lên cao 100m
            hrp.CFrame = CFrame.new(hrp.Position + Vector3.new(0, 100, 0))
            RunService.Heartbeat:Wait()

            -- bước 2: tiến thêm 100m về phía target
            local dir = (targetPos - hrp.Position).Unit
            hrp.CFrame = CFrame.new(hrp.Position + dir * 100)
            RunService.Heartbeat:Wait()
        end

        -----------------------------------------------------
        -- FOLLOW LOOP (đã sửa mạnh)
        -----------------------------------------------------
        local function followLoop()
            local hum = safeHumanoid()
            if hum then
                hum.PlatformStand = true
                hum.AutoRotate = false
            end

            while followEnabled do
                local hrp = safeHRP()
                local thrp = safeTargetHRP()
                local thum = safeTargetHumanoid()
                local myHum = safeHumanoid()

                if not hrp or not thrp or not thum then break end

                -------------------------------------------------
                -- CHECK HP (ưu tiên nhất)
                -------------------------------------------------
                if myHum and myHum.Health / myHum.MaxHealth * 100 < 20 then
                    local cur = hrp.Position
                    instantTeleport(Vector3.new(cur.X, cur.Y + 5000, cur.Z))

                    followEnabled = false
                    disabledDueLowHP = true

                    followButton.Text = "OFF"
                    followButton.BackgroundColor3 = Color3.fromRGB(255,50,50)

                    break
                end

                if thum.Health <= 0 then break end

                -------------------------------------------------
                -- FOLLOW NORMAL
                -------------------------------------------------
                local targetPos = thrp.Position + Vector3.new(0,HEIGHT_OFFSET,0)
                local myPos = hrp.Position
                local dist = distance(myPos, targetPos)
                local toTarget = targetPos - myPos

                -------------------------------------------------
                -- smoothFly
                -------------------------------------------------
                local function smoothFlyTo(hrp, targetPos, maxSpeed)
                    if not hrp then return end

                    -- Xoá body cũ nếu có
                    for _,v in ipairs(hrp:GetChildren()) do
                        if v:IsA("BodyVelocity") or v:IsA("BodyGyro") then
                            v:Destroy()
                        end
                    end

                    -- Giữ hướng bay
                    local gyro = Instance.new("BodyGyro")
                    gyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
                    gyro.P = 5000
                    gyro.CFrame = CFrame.new(hrp.Position, targetPos)
                    gyro.Parent = hrp

                    -- Tốc độ bay mượt, không bị chặn
                    local vel = Instance.new("BodyVelocity")
                    vel.MaxForce = Vector3.new(1e6, 1e6, 1e6)
                    vel.Parent = hrp

                    -- Loop cập nhật hướng + vận tốc
                    coroutine.wrap(function()
                        while followEnabled and hrp and hrp.Parent do
                            local dir = (targetPos - hrp.Position)
                            if dir.Magnitude < STOP_DIST then break end
                            vel.Velocity = dir.Unit * maxSpeed
                            gyro.CFrame = CFrame.new(hrp.Position, targetPos)
                            RunService.Heartbeat:Wait()
                        end

                        vel:Destroy()
                        gyro:Destroy()
                        hrp.AssemblyLinearVelocity = Vector3.zero
                    end)()
                end

                -------------------------------------------------
                -- NEAR TELEPORT POINT
                -------------------------------------------------
                local nearest, ndist = findNearestTP(targetPos)
                if nearest and dist > ndist then
                    teleportSmart(nearest)
                    RunService.Heartbeat:Wait()
                    continue
                end

                -------------------------------------------------
                -- SWITCH TO SUPER-STICK MODE (<100m)
                -------------------------------------------------
                if dist < 100 then
                    -- siêu bám sát: update CFrame liên tục
                    while followEnabled do
                        local hrp = safeHRP()
                        local thrp = safeTargetHRP()
                        local thum = safeTargetHumanoid()
                        local myHum = safeHumanoid()
                        if not hrp or not thrp or not thum or not myHum then break end

                        -- check HP
                        if myHum.Health / myHum.MaxHealth * 100 < 20 then
                            local c = hrp.Position
                            instantTeleport(Vector3.new(c.X, c.Y+5000, c.Z))
                            followEnabled = false
                            disabledDueLowHP = true

                            followButton.Text = "OFF"
                            followButton.BackgroundColor3 = Color3.fromRGB(255,50,50)

                            break
                        end

                        if thum.Health <= 0 then break end

                        -- CFrame bám sát (1 stud sau mục tiêu)
                        hrp.CFrame = thrp.CFrame * CFrame.new(0,0,1)

                        RunService.Heartbeat:Wait()
                    end

                    RunService.Heartbeat:Wait()
                    continue
                end

                -------------------------------------------------
                -- NORMAL FOLLOW MOVEMENT
                -------------------------------------------------
                local speed = math.clamp(dist * DIST_MULT, BASE_SPEED, MAX_SPEED)
                local vel = toTarget.Unit * speed
                smoothFlyTo(hrp, targetPos, math.clamp(dist * DIST_MULT, BASE_SPEED, MAX_SPEED))

                RunService.Heartbeat:Wait()
            end

            resetMovement()
        end

        -----------------------------------------------------
        -- PICK TARGET
        -----------------------------------------------------
        local function pickTargetFromName(txt)
            if not txt or txt == "" then return nil end
            local k = txt:lower()
            for _,pl in pairs(Players:GetPlayers()) do
                if pl ~= player and pl.Name:lower():find(k,1,true) then
                    return pl
                end
            end
        end

        -----------------------------------------------------
        -- BUTTON CONTROL (đã fix auto OFF)
        -----------------------------------------------------
        followButton.MouseButton1Click:Connect(function()
            if disabledDueLowHP then return end

            if followEnabled then
                followEnabled = false
                followButton.Text = "OFF"
                followButton.BackgroundColor3 = Color3.fromRGB(255,50,50)
                targetPlayer = nil
                return
            end

            -- try enabling
            local hum = safeHumanoid()
            if hum and hum.Health / hum.MaxHealth * 100 < 20 then
                disabledDueLowHP = true
                return
            end

            if #nameBox.Text < 3 then return end

            local t = pickTargetFromName(nameBox.Text)
            if not t then return end

            targetPlayer = t
            followEnabled = true
            followButton.Text = "ON"
            followButton.BackgroundColor3 = Color3.fromRGB(50,255,50)

            coroutine.wrap(followLoop)()
        end)

        -----------------------------------------------------
        -- CLEAR LOW-HP LOCK WHEN HEALED
        -----------------------------------------------------
        spawn(function()
            while true do
                local hum = safeHumanoid()
                if hum and disabledDueLowHP then
                    if hum.Health / hum.MaxHealth * 100 >= 20 then
                        disabledDueLowHP = false
                    end
                end
                wait(1)
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

    print("PVP_S2-v0.09 tad SUCCESS✅")
end
