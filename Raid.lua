return function(sections)
    local HomeFrame = sections["Raid"]

        --RAID------------------------------------------------------------------------------------------------------------------
    do
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local hrp = character:WaitForChild("HumanoidRootPart")
        local TweenService = game:GetService("TweenService")
        local RunService = game:GetService("RunService")
        local VirtualInputManager = game:GetService("VirtualInputManager")

        -- Nút bật/tắt Auto RAID
        local toggleRaid = Instance.new("TextButton", HomeFrame)
        toggleRaid.Size = UDim2.new(0, 90, 0, 30)
        toggleRaid.Position = UDim2.new(0, 240, 0, 10)
        toggleRaid.Text = "OFF"
        toggleRaid.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        toggleRaid.TextColor3 = Color3.new(1, 1, 1)
    	toggleRaid.Font = Enum.Font.SourceSansBold
        toggleRaid.TextScaled = true
        local currentHighlight = nil
        local highlightTween = nil
        local isClearingIsland = false

        local anchor = nil
        local function ensureAnchor()
            if not anchor or not anchor.Parent then
                anchor = Instance.new("Part")
                anchor.Anchored = true
                anchor.CanCollide = false
                anchor.Transparency = 1
                anchor.Size = Vector3.new(1, 1, 1)
                anchor.CFrame = hrp.CFrame
                anchor.Parent = workspace
            end
            return anchor
        end

        -- Trạng thái RAID
        local running = false
        local autoClicking = false

        -- Auto click remote
        spawn(function()
            while true do
                task.wait(0.4)
                if running then
                    pcall(function()
                        local args = {
                            0.4000000059604645
                        }
                        game:GetService("ReplicatedStorage")
                            :WaitForChild("Modules")
                            :WaitForChild("Net")
                            :WaitForChild("RE/RegisterAttack")
                            :FireServer(unpack(args))
                    end)
                end
            end
        end)

        -- Cập nhật giao diện về OFF
        local function resetRaidButton()
            running = false
            autoClicking = false
            toggleRaid.Text = "OFF"
            toggleRaid.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        end

        local islandPlatform = nil
        local rainbowConn = nil

        local function getIslandCenter(model)
            if not model then return nil end
    
            local cf, size = model:GetBoundingBox()
            local center = cf.Position

            -- đúng chuẩn: đặt platform trên mặt đảo
            center = center + Vector3.new(0, size.Y/2, 0)

            return center
        end

        local function hasIslandNearby()
            local map = workspace:FindFirstChild("Map")
            if not map then return false end
            local raidMap = map:FindFirstChild("RaidMap")
            if not raidMap then return false end
    
            for _, island in ipairs(raidMap:GetChildren()) do
                if island:IsA("Model") then
                    local root = island.PrimaryPart or island:FindFirstChildWhichIsA("BasePart")
                    if root then
                        if (hrp.Position - root.Position).Magnitude <= 4000 then
                            return true
                        end
                    end
                end
            end

            return false
        end

        -- Bật/tắt RAID khi bấm nút
        local blocked = false
        toggleRaid.MouseButton1Click:Connect(function()
            if blocked then return end
            if not running and not hasIslandNearby() then
                blocked = true
                toggleRaid.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
                toggleRaid.Text = "NO ISLAND"
                task.delay(0.35, function()
                    toggleRaid.Text = "OFF"
                    toggleRaid.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
                    blocked = false
                end)
                return
            end
            running = not running
            autoClicking = running
            toggleRaid.Text = running and "ON" or "OFF"
            toggleRaid.BackgroundColor3 = running and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 50, 50)
        end)

        -- Tween đến vị trí
        local function tweenCloseTo(targetPos, stopDist, isEnemy)
            if not hrp then return end
            stopDist = stopDist or 40
            local currentPos = hrp.Position

            -- Nếu là enemy → nâng trục Y lên +100
            local targetY = targetPos.Y
            if isEnemy then
                targetY = targetPos.Y + 100
            end

            hrp.CFrame = CFrame.new(currentPos.X, targetY, currentPos.Z)

            local horizontalDist = (Vector2.new(currentPos.X, currentPos.Z)
                                   - Vector2.new(targetPos.X, targetPos.Z)).Magnitude

            if horizontalDist > stopDist then
                local direction = (Vector2.new(targetPos.X, targetPos.Z)
                                 - Vector2.new(hrp.Position.X, hrp.Position.Z)).Unit

                local targetXZ = Vector2.new(targetPos.X, targetPos.Z) - direction * stopDist
                local targetPoint = Vector3.new(targetXZ.X, targetY, targetXZ.Y)

                local time = horizontalDist / 300

                local tween = TweenService:Create(
                    hrp,
                    TweenInfo.new(time, Enum.EasingStyle.Linear),
                    { CFrame = CFrame.new(targetPoint) }
                )
                tween:Play()
                tween.Completed:Wait()
            end
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
                    if dist <= 2500 and mob.Humanoid.Health > 0 then
                        table.insert(enemies, mob)
                    end
                end
            end
            return enemies
        end

        -- 🌈 Highlight theo HP
        local function updateHighlight(enemy)
            if not enemy then return end
            local humanoid = enemy:FindFirstChildOfClass("Humanoid")
            if not humanoid then return end

            -- Nếu enemy đã có highlight → dùng lại
            if not enemy:FindFirstChild("RaidHighlight") then
                local highlight = Instance.new("Highlight")
                highlight.Name = "RaidHighlight"
                highlight.FillTransparency = 0.2
                highlight.OutlineTransparency = 0.9
                highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                highlight.Adornee = enemy
                highlight.Parent = enemy
            end

            local highlight = enemy:FindFirstChild("RaidHighlight")

            -- Update màu theo HP trong vòng lặp RenderStepped
            local conn
            conn = RunService.RenderStepped:Connect(function()
                if not running or not humanoid.Parent or humanoid.Health <= 0 or not highlight or highlight.Parent ~= enemy then
                    if highlight then highlight:Destroy() end
                    conn:Disconnect()
                    return
                end

                local percent = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
                highlight.FillColor = Color3.fromRGB(255 * (1 - percent), 255 * percent, 0)
            end)
        end

        -- Theo dõi và đánh quái
        local function followEnemy(enemy)
            if not enemy or not enemy.Parent then return end

            isClearingIsland = true -- 🔥 báo rằng đang đánh → KHÔNG ĐƯỢC TỚI ISLAND

            local hrpEnemy = enemy:FindFirstChild("HumanoidRootPart")
            local humanoid = enemy:FindFirstChildOfClass("Humanoid")
            if not hrpEnemy or not humanoid then return end

            updateHighlight(enemy)
            local anchor = ensureAnchor()
            local camera = workspace.CurrentCamera

            camera.CameraType = Enum.CameraType.Custom
            camera.CameraSubject = anchor

            while humanoid.Health > 0 and running do
                if not hrp then break end

                updateHighlight(enemy)

                local anchorY = hrpEnemy.Position.Y + 25
                local targetPos = Vector3.new(hrpEnemy.Position.X, anchorY, hrpEnemy.Position.Z)

                anchor.Position = anchor.Position:Lerp(targetPos, 0.15)
                hrp.AssemblyLinearVelocity = Vector3.zero
                hrp.CFrame = hrp.CFrame:Lerp(CFrame.new(targetPos), 0.25)

                RunService.RenderStepped:Wait()
            end

            -- Enemy đã chết
            if hrp then
                camera.CameraSubject = hrp
            end

            isClearingIsland = false -- 🔥 cho phép tới Island tiếp theo
        end

        -- Reset khi hồi sinh
        player.CharacterAdded:Connect(function(newChar)
            character = newChar
            hrp = character:WaitForChild("HumanoidRootPart")
            resetRaidButton()
        end)

        -- Vòng lặp chính Auto RAID
        task.spawn(function()
            while true do
                RunService.Heartbeat:Wait()
                if not hrp then continue end

                -- 🛡️ Anti Fall
                if running and hrp.Position.Y < -1 then
                    hrp.CFrame = hrp.CFrame + Vector3.new(0, 200, 0)
                end

                -- 🔹 Kiểm tra nếu đang bật nhưng không còn đảo → tự tắt
                if running and not hasIslandNearby() then
                    resetRaidButton()
                    continue
                end

                if not running then continue end

                local island = getHighestPriorityIsland()
                if island and not isClearingIsland then

                    -- Lấy vị trí Island
                    local root = island:FindFirstChild("PrimaryPart") or island:FindFirstChildWhichIsA("BasePart")
                    if root then

                        -- Tween tới đảo
                        local islandCenter = getIslandCenter(island)
                            
                        tweenCloseTo(islandCenter, 1)
                        RunService.RenderStepped:Wait()

                        -----------------------------------------
                        -- ⏳ ĐỢI 1 GIÂY SAU KHI TỚI ISLAND
                        -- (nếu đang đánh enemy thì không đếm)
                        -----------------------------------------
                        local timer = 0
                        while timer < 1 do
                            if #getEnemiesNear(hrp) > 0 then
                                break -- có enemy → dừng đếm ngay
                            end
                            timer += task.wait(1)
                        end
                    end
                end

                local enemies = getEnemiesNear(hrp)
                if #enemies > 0 then
                    for _, enemy in ipairs(enemies) do

                        -- 🔥 Tween tới gần enemy trước (còn 100m)
                        local enemyHRP = enemy:FindFirstChild("HumanoidRootPart")
                        if enemyHRP then
                            tweenCloseTo(enemyHRP.Position, 250, true)
                        end

                        followEnemy(enemy)
                        if not running then break end
                    end
                end
            end
        end)
    end

        --[[START RAID------------------------------------------------------------------------------------------------------------------
    do
        local btnStartRaid = Instance.new("TextButton", HomeFrame)
        btnStartRaid.Size = UDim2.new(0, 320, 0, 40)
        btnStartRaid.Position = UDim2.new(0, 10, 0, 110)
        btnStartRaid.Text = "Start Raid▶️"
        btnStartRaid.BackgroundColor3 = Color3.fromRGB(51, 19, 145)
        btnStartRaid.TextColor3 = Color3.new(1, 1, 1)
        btnStartRaid.Font = Enum.Font.SourceSansBold
        btnStartRaid.TextSize = 20

        btnStartRaid.MouseButton1Click:Connect(function()
            local clickDetector

            -- SEA 3: Boat Castle
            local map = workspace:FindFirstChild("Map")
            local boatCastle = map and map:FindFirstChild("Boat Castle")
            if boatCastle then
                local raid = boat Castle:FindFirstChild("RaidSummon2")
                if raid then
                    local button = raid:FindFirstChild("Button")
                    if button then
                        local main = button:FindFirstChild("Main")
                        if main then
                            clickDetector = main:FindFirstChild("ClickDetector")
                        end
                    end
                end
            end

            -- SEA 2: CircleIsland
            if not clickDetector then
                local circleIsland = map and map:FindFirstChild("CircleIsland")
                if circleIsland then
                    local raid = circleIsland:FindFirstChild("RaidSummon2")
                    if raid then
                        local button = raid:FindFirstChild("Button")
                        if button then
                            local main = button:FindFirstChild("Main")
                            if main then
                                clickDetector = main:FindFirstChild("ClickDetector")
                            end
                        end
                    end
                end
            end

            if clickDetector then
                fireclickdetector(clickDetector)
            else
                warn("❌ Không tìm thấy ClickDetector để Start Raid (không phải Sea 2 hoặc Sea 3).")
            end
        end)

        ]]--BUY CHIP------------------------------------------------------------------------------------------------------------------
    do
        local selectedChip = "Flame" -- mặc định ban đầu

        -- Dropdown chọn loại Microchip
        local dropdown = Instance.new("TextButton", HomeFrame)
        dropdown.Size = UDim2.new(0, 220, 0, 40)
        dropdown.Position = UDim2.new(0, 10, 0, 55)
        dropdown.Text = "🧩Microchip: " .. selectedChip
        dropdown.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
        dropdown.TextColor3 = Color3.new(1, 1, 1)
        dropdown.Font = Enum.Font.SourceSansBold
        dropdown.TextSize = 18

        -- Danh sách loại Microchip
        local chipList = {
            "Flame", "Ice", "Quake", "Light", "Dark",
            "Spider", "Rumble", "Magma", "Buddha", "Sand"
        }

        -- Menu chọn chip
        local chipMenu = Instance.new("Frame", HomeFrame)
        chipMenu.Size = UDim2.new(0, 220, 0, #chipList * 30)
        chipMenu.Position = UDim2.new(0, 10, 0, 95)
        chipMenu.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        chipMenu.Visible = false

        -- Tạo nút chọn cho từng loại chip
        for i, chipName in ipairs(chipList) do
            local btn = Instance.new("TextButton", chipMenu)
            btn.Size = UDim2.new(1, 0, 0, 30)
            btn.Position = UDim2.new(0, 0, 0, (i - 1) * 30)
            btn.Text = chipName
            btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.Font = Enum.Font.SourceSans
            btn.TextSize = 18

            btn.MouseButton1Click:Connect(function()
                selectedChip = chipName
                dropdown.Text = "🧩Microchip: " .. selectedChip
                chipMenu.Visible = false
            end)
        end

        -- Toggle hiện/ẩn menu khi nhấn dropdown
        dropdown.MouseButton1Click:Connect(function()
            chipMenu.Visible = not chipMenu.Visible
        end)

        -- Nút mua microchip
        local btnBuyChip = Instance.new("TextButton", HomeFrame)
        btnBuyChip.Size = UDim2.new(0, 90, 0, 30)
        btnBuyChip.Position = UDim2.new(0, 240, 0, 60)
        btnBuyChip.Text = "Buy🛒"
        btnBuyChip.BackgroundColor3 = Color3.fromRGB(50, 50, 255)
        btnBuyChip.TextColor3 = Color3.new(1, 1, 1)
        btnBuyChip.Font = Enum.Font.SourceSansBold
        btnBuyChip.TextSize = 18

        btnBuyChip.MouseButton1Click:Connect(function()
            local args = {
                "RaidsNpc",
                "Select",
                selectedChip
            }

            local success, err = pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
            end)

            if not success then
                warn("❌ Không thể mua microchip: " .. tostring(err))
            end
        end)
    end

    wait(0.2)

    print("Raid tad SUCCESS✅")
end
