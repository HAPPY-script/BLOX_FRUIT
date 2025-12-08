local HPEspaceScreen = Instance.new("ScreenGui")
HPEspaceScreen.Name = "HPEspaceScreen"
HPEspaceScreen.ResetOnSpawn = false
HPEspaceScreen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
HPEspaceScreen.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Name = "Frame"
Frame.Position = UDim2.new(0.5, 0, -0, 0)
Frame.Size = UDim2.new(0.13, 0, 0.13, 0)
Frame.BackgroundColor3 = Color3.new(0.117647, 0, 0.223529)
Frame.BorderSizePixel = 0
Frame.BorderColor3 = Color3.new(0, 0, 0)
Frame.Visible = false
Frame.AnchorPoint = Vector2.new(0.5, 0)
Frame.Parent = HPEspaceScreen

local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint.Name = "UIAspectRatioConstraint"
UIAspectRatioConstraint.AspectRatio = 4
UIAspectRatioConstraint.Parent = Frame

local UIStroke = Instance.new("UIStroke")
UIStroke.Name = "UIStroke"
UIStroke.Color = Color3.new(0.8, 0, 1)
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = Frame

local a = Instance.new("TextLabel")
a.Name = "%"
a.Position = UDim2.new(0.875, 0, 0.5, 0)
a.Size = UDim2.new(0.25, 0, 0.55, 0)
a.BackgroundColor3 = Color3.new(1, 1, 1)
a.BackgroundTransparency = 1
a.BorderSizePixel = 0
a.BorderColor3 = Color3.new(0, 0, 0)
a.AnchorPoint = Vector2.new(0.5, 0.5)
a.TextTransparency = 0
a.Text = "100%"
a.TextColor3 = Color3.new(1, 0, 1)
a.TextSize = 14
a.FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
a.TextScaled = true
a.TextWrapped = true
a.Parent = Frame

local HPFrame = Instance.new("Frame")
HPFrame.Name = "HPFrame"
HPFrame.Position = UDim2.new(0.375, 0, 0.5, 0)
HPFrame.Size = UDim2.new(0.675, 0, 0.3, 0)
HPFrame.BackgroundColor3 = Color3.new(0, 0, 0)
HPFrame.BackgroundTransparency = 0.5
HPFrame.BorderSizePixel = 0
HPFrame.BorderColor3 = Color3.new(0, 0, 0)
HPFrame.AnchorPoint = Vector2.new(0.5, 0.5)
HPFrame.Transparency = 0.5
HPFrame.Parent = Frame

local UIStroke2 = Instance.new("UIStroke")
UIStroke2.Name = "UIStroke"
UIStroke2.Color = Color3.new(1, 1, 1)
UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke2.Parent = HPFrame

local Load = Instance.new("Frame")
Load.Name = "Load"
Load.Size = UDim2.new(1, 0, 1, 0)
Load.BackgroundColor3 = Color3.new(0.196078, 1, 0.196078)
Load.BorderSizePixel = 0
Load.BorderColor3 = Color3.new(0, 0, 0)
Load.Parent = HPFrame

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
            Vector3.new(-12463.61, 374.91, -7549.53),
            Vector3.new(-5073.83, 314.51, -3152.52),
            Vector3.new(5661.53, 1013.04, -334.96),
            Vector3.new(28286.36, 14896.56, 102.62)
        }

        -----------------------------------------------------
        -- UI
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
        local function instantTeleport(pos)
            local hrp = safeHRP()
            if not hrp then return end
            hrp.CFrame = CFrame.new(pos + Vector3.new(0,60,0))
            hrp.AssemblyLinearVelocity = Vector3.zero
            hrp.AssemblyAngularVelocity = Vector3.zero
            RunService.Heartbeat:Wait()
            hrp.CFrame += Vector3.new(0,3,0)
        end

        -----------------------------------------------------
        -- Tween
        -----------------------------------------------------
        local function SmoothFlyTo(targetPos)
            local hrp = safeHRP()
            local myHum = safeHumanoid()
            if not hrp then return end

            local targetHRP = safeTargetHRP()
            if targetHRP then
                local p = hrp.Position
                hrp.CFrame = CFrame.new(p.X, targetHRP.Position.Y, p.Z)
                hrp.AssemblyLinearVelocity = Vector3.zero
                hrp.AssemblyAngularVelocity = Vector3.zero
                RunService.Heartbeat:Wait()
            end

            local startPos = hrp.Position
            local dist = (startPos - targetPos).Magnitude
            if dist <= STOP_DIST then return end

            local duration = math.max(0.05, dist / 320) -- tránh duration = 0
            local t = 0

            -- final offset: luôn dừng trước target một khoảng nhỏ và hơi lệch về phía sau mục tiêu
            local dir = (targetPos - startPos).Unit
            local finalOffset = 3 -- dừng cách mục tiêu 3 studs (thay đổi nếu cần)
            local adjustedTarget = targetPos - dir * finalOffset
            -- nếu adjustedTarget quá thấp so với mục tiêu thì đảm bảo độ cao:
            if adjustedTarget.Y < targetPos.Y - 10 then
                adjustedTarget = Vector3.new(adjustedTarget.X, targetPos.Y + 2, adjustedTarget.Z)
            end

            local prevDist = (hrp.Position - targetPos).Magnitude

            while t < 1 and followEnabled do
                hrp = safeHRP()
                if not hrp then break end

                -- break sớm nếu đã gần đủ
                local curDist = (hrp.Position - targetPos).Magnitude
                if curDist <= STOP_DIST then break end

                -- nếu khoảng cách đang tăng (overshoot / bị đẩy), thoát để tránh loop
                if curDist > prevDist + 10 then
                    break
                end
                prevDist = curDist

                t += RunService.Heartbeat:Wait() / duration
                if t > 1 then t = 1 end

                local newPos = startPos:Lerp(adjustedTarget, t)
                -- giữ hướng nhìn về target nhưng không đặt thẳng vào target
                hrp.CFrame = CFrame.new(newPos, targetPos)
            end
        end

        -----------------------------------------------------
        -- FOLLOW LOOP
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
                if myHum and myHum.Health / myHum.MaxHealth * 100 < 25 then
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
                -- NEAR TELEPORT POINT
                -------------------------------------------------
                local nearest, ndist = findNearestTP(targetPos)
                if nearest then
                    local d_tp_to_target = distance(nearest, targetPos)
                    local d_direct = distance(myPos, targetPos)

                    -- Nếu TP point rút ngắn đường → dùng
                    if d_tp_to_target < d_direct then
                        local hrp = safeHRP()
                        if hrp then
                            -- Lặp teleport 20 lần trong 2s
                            for i = 1, 20 do
                                hrp.CFrame = CFrame.new(nearest + Vector3.new(0,60,0))
                                hrp.AssemblyLinearVelocity = Vector3.zero
                                hrp.AssemblyAngularVelocity = Vector3.zero
                                RunService.Heartbeat:Wait()
                            end

                            -- tăng cao 1 chút để tránh chạm đất
                            hrp.CFrame = hrp.CFrame + Vector3.new(0, 100, 0)
                            RunService.Heartbeat:Wait()
                        end

                        -- tiếp tục bay mượt đến mục tiêu
                        SmoothFlyTo(targetPos)
                        continue
                    end
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
                SmoothFlyTo(targetPos)
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

    -- AUTO ESCAPE===============================================================================================================
    do
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local player = Players.LocalPlayer

        local autoEscapeEnabled = false
        local escapeThreshold = 30
        local isEscaping = false
        local safeTimer = 0

        -- Lưu trục Y ban đầu
        local initialY = 0

        -- Biến để tránh spam ESCAPING!
        local returnCooldown = false

        -----------------------------------------------------
        -- UI HP ESCAPE PROGRESS
        -----------------------------------------------------
        local gui = player:WaitForChild("PlayerGui"):WaitForChild("HPEspaceScreen")
        local hpFrame = gui.Frame
        local hpFill = hpFrame.HPFrame.Load
        local hpText = hpFrame["%"]

        -- Tọa độ mở / đóng
        local OPEN_POS = UDim2.new(0.5, 0, 0, 0)
        local CLOSE_POS = UDim2.new(0.5, 0, -0.5, 0)

        -- ban đầu đóng
        hpFrame.Position = CLOSE_POS
        hpFrame.Visible = false

        local TweenService = game:GetService("TweenService")

        local function OpenHPFrame()
            hpFrame.Visible = true
            TweenService:Create(hpFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
                Position = OPEN_POS
            }):Play()
        end

        local function CloseHPFrame()
            TweenService:Create(hpFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
                Position = CLOSE_POS
            }):Play()
            task.delay(0.3, function()
                hpFrame.Visible = false
            end)
        end

        local function UpdateHPBar(ratio)
            hpFill.Size = UDim2.new(ratio, 0, 1, 0)
            hpText.Text = tostring(math.floor(ratio * 100)) .. "%"
        end

        -----------------------------------------------------
        -- UI
        -----------------------------------------------------
        local escapeButton = Instance.new("TextButton", HomeFrame)
        escapeButton.Size = UDim2.new(0, 90, 0, 30)
        escapeButton.Position = UDim2.new(0, 240, 0, 260)
        escapeButton.Text = "OFF"
        escapeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        escapeButton.TextColor3 = Color3.new(1, 1, 1)
        escapeButton.Font = Enum.Font.SourceSansBold
        escapeButton.TextScaled = true

        local thresholdBox = Instance.new("TextBox", HomeFrame)
        thresholdBox.Size = UDim2.new(0, 50, 0, 30)
        thresholdBox.Position = UDim2.new(0, 190, 0, 260)
        thresholdBox.PlaceholderText = "%"
        thresholdBox.Text = "30"
        thresholdBox.TextScaled = true
        thresholdBox.Font = Enum.Font.SourceSans
        thresholdBox.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        thresholdBox.TextColor3 = Color3.new(1,1,1)

        -----------------------------------------------------
        -- NÚT QUAY VỀ TRỤC Y BAN ĐẦU
        -----------------------------------------------------
        local returnButton = Instance.new("TextButton", HomeFrame)
        returnButton.Size = UDim2.new(0, 90, 0, 30)
        returnButton.Position = UDim2.new(0, 240, 0, 310)
        returnButton.Text = "Y = ?"
        returnButton.TextScaled = true
        returnButton.Font = Enum.Font.SourceSansBold
        returnButton.BackgroundColor3 = Color3.fromRGB(80, 80, 180)
        returnButton.TextColor3 = Color3.new(1,1,1)

        -----------------------------------------------------
        -- BUTTON RETURN — KHÔNG CHO BẤM KHI ESCAPING
        -----------------------------------------------------
        returnButton.MouseButton1Click:Connect(function()
            -- Nếu đang ESCAPE → cảnh báo, không teleport
            if isEscaping then
                if returnCooldown then return end
                returnCooldown = true

                local oldColor = returnButton.BackgroundColor3
                local oldText = returnButton.Text

                returnButton.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
                returnButton.Text = "ESCAPING !"

                task.delay(1, function()
                    returnButton.BackgroundColor3 = oldColor
                    returnButton.Text = oldText
                    returnCooldown = false
                end)

                return
            end

            -- Bình thường → Teleport về Y ban đầu
            local char = player.Character
            if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart")
            if not root then return end

            root.CFrame = CFrame.new(root.Position.X, initialY, root.Position.Z)
        end)

        -----------------------------------------------------
        -- BUTTON ON/OFF
        -----------------------------------------------------
        escapeButton.MouseButton1Click:Connect(function()
            autoEscapeEnabled = not autoEscapeEnabled

            escapeButton.Text = autoEscapeEnabled and "ON" or "OFF"
            escapeButton.BackgroundColor3 =
                autoEscapeEnabled and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)

            if not autoEscapeEnabled then
                CloseHPFrame()
                UpdateHPBar(0)
                isEscaping = false
                safeTimer = 0
            end
        end)

        -----------------------------------------------------
        -- XỬ LÝ NHẬP %
        -----------------------------------------------------
        thresholdBox.FocusLost:Connect(function()
            local val = tonumber(thresholdBox.Text)

            if val then
                val = math.clamp(val, 0.1, 100)
                val = math.floor(val * 10 + 0.5) / 10
                escapeThreshold = val
                thresholdBox.Text = tostring(val)
            else
                thresholdBox.Text = tostring(escapeThreshold)
            end
        end)

        -----------------------------------------------------
        -- AUTO ESCAPE LOGIC
        -----------------------------------------------------
        RunService.Heartbeat:Connect(function(dt)
            if not autoEscapeEnabled then return end

            local char = player.Character
            if not char then return end

            local humanoid = char:FindFirstChild("Humanoid")
            local root = char:FindFirstChild("HumanoidRootPart")
            if not humanoid or not root then return end

            local maxHP = humanoid.MaxHealth
            local hp = humanoid.Health
            local percent = (hp / maxHP) * 100

            -- Kháng bug chết
            if hp <= 0 then
                isEscaping = false
                safeTimer = 0
                return
            end

            -----------------------------------------------------
            -- LƯU TRỤC Y KHI BẮT ĐẦU ESCAPE
            -----------------------------------------------------
            if percent < escapeThreshold then
                OpenHPFrame()
                if not isEscaping then
                    initialY = root.Position.Y
                    returnButton.Text = "Y = " .. tostring(math.floor(initialY))
                end

                isEscaping = true
                safeTimer = 0
            end

            -----------------------------------------------------
            -- ESCAPING
            -----------------------------------------------------
            if isEscaping then

                -- cập nhật phần trăm HP so với ngưỡng escape
                local ratio = percent / escapeThreshold
                ratio = math.clamp(ratio, 0, 1)
                UpdateHPBar(ratio)

                root.CFrame = root.CFrame + Vector3.new(0, 200, 0)

                if percent >= escapeThreshold then
                    UpdateHPBar(1)
                    safeTimer += dt
                    if safeTimer >= 1 then
                        isEscaping = false
                    end
                    
                    if not isEscaping then
                        CloseHPFrame()
                    end
                else
                    safeTimer = 0
                end

                task.wait(0.1)
            end
        end)
    end

    wait(0.2)

    print("PVP_S3-v0.2 tad SUCCESS✅")
end
