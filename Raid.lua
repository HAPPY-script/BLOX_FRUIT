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

            if running then
                game.Players.LocalPlayer:SetAttribute("FastAttackEnemyMode", "Toggle")
                game.Players.LocalPlayer:SetAttribute("FastAttackEnemy", true)
            end
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

        -- Tìm đảo có độ ưu tiên cao nhất, nhưng loại bỏ đảo quá xa
        local function getHighestPriorityIsland()
            local map = workspace:FindFirstChild("Map")
            if not map then return nil end

            local raidMap = map:FindFirstChild("RaidMap")
            if not raidMap then return nil end

            local bestIsland = nil
            local bestPriority = -1

            for _, island in ipairs(raidMap:GetChildren()) do
                if island:IsA("Model") then

                    -- Detect island index (RaidIsland1 → 1 ... RaidIsland5 → 5)
                    local index = tonumber(island.Name:match("RaidIsland(%d+)"))
                    if index then

                        local root = island.PrimaryPart or island:FindFirstChildWhichIsA("BasePart")
                        if root then
                            local dist = (hrp.Position - root.Position).Magnitude

                            -- Chỉ nhận island trong 3500m
                            if dist <= 3500 then
                                -- Chọn island có index cao nhất (5 → 1)
                                if index > bestPriority then
                                    bestPriority = index
                                    bestIsland = island
                                end
                            end
                        end
                    end
                end
            end

            return bestIsland -- nếu không có island gần → trả nil
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

        --BUY CHIP------------------------------------------------------------------------------------------------------------------
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

        --DUNGEON------------------------------------------------------------------------------------------------------------------
    do
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local TweenService = game:GetService("TweenService")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local workspace = workspace

        local player = Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local hrp = character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart")

        -- UI ON/OFF (đơn giản như mẫu)
        local autoBtn = Instance.new("TextButton", HomeFrame)
        autoBtn.Size = UDim2.new(0, 90, 0, 30)
        autoBtn.Position = UDim2.new(0, 240, 0, 110)
        autoBtn.Text = "OFF"
        autoBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        autoBtn.TextColor3 = Color3.new(1, 1, 1)
        autoBtn.Font = Enum.Font.SourceSansBold
        autoBtn.TextScaled = true

        -- Cấu hình theo yêu cầu
        local DISTANCE_LIMIT = 900
        local SCAN_INTERVAL = 0.08           -- nhỏ để gần như không có delay
        local MOVE_SPEED = 600               -- giữ tốc độ bay như trước (units/sec)
        local FOLLOW_HEIGHT = 35             -- tăng lên 35 stud (bạn có thể đổi lại 75 nếu muốn)
        local ATTACK_INTERVAL = 0.5         -- tăng tốc đánh thành 0.5

        local autoDungeon = false
        local pauseForExit = false

        local lastEquippedToolName = nil
        local toolTrackConn = nil

        -- state helpers
        local farmCenter = nil
        local movementLock = false           -- tránh nhiều movement cùng lúc
        local followLock = false             -- tránh follow chồng chéo
        local currentTarget = nil            -- current enemy model

        local ALLOWED_PLACE = 73902483975735
        local blocked = false

        local IGNORED_ENEMIES = {
            ["Blank Buddy"] = true
        }

        local function isIgnoredEnemy(mob)
            return IGNORED_ENEMIES[mob.Name] == true
        end

        -- Hook tool tracking on a character: listen ChildAdded and capture existing tool
        local function hookToolTracking(char)
            -- disconnect previous connection if any
            if toolTrackConn then
                pcall(function() toolTrackConn:Disconnect() end)
                toolTrackConn = nil
            end
            if not char then return end

            -- capture currently equipped tool immediately (if any)
            local existing = char:FindFirstChildOfClass("Tool")
            if existing and autoDungeon then
                lastEquippedToolName = existing.Name
            end

            -- listen for future equips (player picks up / equips a tool)
            toolTrackConn = char.ChildAdded:Connect(function(obj)
                if obj and obj:IsA("Tool") and autoDungeon then
                    lastEquippedToolName = obj.Name
                end
            end)
        end

        -- ensure refs (respawn safe)
        local function refreshCharacterRefs(newChar)
            character = newChar or player.Character
            if character then
                hrp = character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart")
            else
                hrp = nil
            end
        end

        -- interruptible movement: move hrp towards targetPos at MOVE_SPEED units/sec
        -- returns true if arrived, false if interrupted by a provided interruptFn returning true
        local function moveToPositionInterruptible(targetPos, interruptFn)
            if not hrp or not hrp.Parent then return false end
            movementLock = true
            local arrived = false

            while hrp and hrp.Parent do
                local pos = hrp.Position
                local dir = (targetPos - pos)
                local dist = dir.Magnitude
                if dist <= 1 then
                    arrived = true
                    break
                end

                if interruptFn and interruptFn() then
                    break
                end

                local dt = RunService.Heartbeat:Wait()
                local step = math.min(dist, MOVE_SPEED * dt)
                local newPos = pos + dir.Unit * step
                hrp.AssemblyLinearVelocity = Vector3.new(0,0,0)
                hrp.CFrame = CFrame.new(newPos)
            end

            movementLock = false
            return arrived
        end

        -- tìm enemy đặc biệt PropHitboxPlaceholder trong DISTANCE_LIMIT
        local function getNearestPriorityEnemy(centerPos)
            local folder = workspace:FindFirstChild("Enemies")
            if not folder then return nil end
            local best, bestDist
            for _, mob in ipairs(folder:GetChildren()) do
                if mob:IsA("Model")
                    and mob.Name == "PropHitboxPlaceholder"
                    and not isIgnoredEnemy(mob)
                    and mob:FindFirstChild("HumanoidRootPart") then

                    local hp = mob:FindFirstChildOfClass("Humanoid")
                    if hp and hp.Health > 0 then
                        local dist = (centerPos - mob.HumanoidRootPart.Position).Magnitude
                        if dist <= DISTANCE_LIMIT then
                            if not bestDist or dist < bestDist then
                                best = mob
                                bestDist = dist
                            end
                        end
                    end
                end
            end
            return best
        end

        -- find nearest enemy within DISTANCE_LIMIT around centerPos
        local function getNearestEnemy(centerPos)
            local folder = workspace:FindFirstChild("Enemies")
            if not folder then return nil end
            local nearest, nearestDist
            for _, mob in ipairs(folder:GetChildren()) do
                if mob:IsA("Model")
                    and not isIgnoredEnemy(mob)
                    and mob:FindFirstChild("HumanoidRootPart") then

                    local hp = mob:FindFirstChildOfClass("Humanoid")
                    if hp and hp.Health > 0 then
                        local dist = (centerPos - mob.HumanoidRootPart.Position).Magnitude
                        if dist <= DISTANCE_LIMIT then
                            if not nearestDist or dist < nearestDist then
                                nearest = mob
                                nearestDist = dist
                            end
                        end
                    end
                end
            end
            return nearest
        end

        -- get nearest dungeon model (by model pivot/primarypart)
        local function getNearestDungeonModel()
            local map = workspace:FindFirstChild("Map")
            if not map then return nil end
            local dungeon = map:FindFirstChild("Dungeon")
            if not dungeon then return nil end

            local nearest, nearestDist
            local myPos = (hrp and hrp.Position) or Vector3.new(0,0,0)
            for _, mdl in ipairs(dungeon:GetChildren()) do
                if mdl:IsA("Model") then
                    local pos
                    if mdl.PrimaryPart then
                        pos = mdl.PrimaryPart.Position
                    else
                        local ok, pivot = pcall(function() return mdl:GetPivot().Position end)
                        pos = ok and pivot or nil
                    end
                    if pos then
                        local d = (myPos - pos).Magnitude
                        if not nearestDist or d < nearestDist then
                            nearest = mdl
                            nearestDist = d
                        end
                    end
                end
            end
            return nearest
        end

        -- check ExitTeleporter.Root with TouchInterest
        local function checkDungeonExitOnModel(mdl)
            if not mdl then return nil end
            local exit = mdl:FindFirstChild("ExitTeleporter", true)
            if not exit then return nil end
            local root = exit:FindFirstChild("Root")
            if not root or not root:IsA("BasePart") then return nil end
            local hasTouch = root:FindFirstChild("TouchInterest") or root:FindFirstChildOfClass("TouchTransmitter")
            if hasTouch then return root end
            return nil
        end

        -- followEnemy: prioritise immediate arrival to high pos and then stable lerp follow
        local function followEnemy(enemy)

            local isPriorityTarget = (enemy.Name == "PropHitboxPlaceholder")

            if followLock then return end
            followLock = true
            currentTarget = enemy

            if not enemy or not enemy.Parent or not hrp then
                followLock = false
                currentTarget = nil
                return
            end

            local hrpEnemy = enemy:FindFirstChild("HumanoidRootPart")
            local humanoid = enemy:FindFirstChildOfClass("Humanoid")
            if not hrpEnemy or not humanoid then
                followLock = false
                currentTarget = nil
                return
            end

            -- 1) immediately move to high position above enemy (straight, interruptible)
            local highPos = hrpEnemy.Position + Vector3.new(0, FOLLOW_HEIGHT, 0)
            -- interrupt if during travel: special priority enemy OR new closer enemy appears
            local function interruptIfBetterEnemy()
                if not autoDungeon then return true end

                local center = hrp.Position

                -- PRIORITY luôn được ưu tiên tuyệt đối
                local pri = getNearestPriorityEnemy(center)
                if pri and pri ~= enemy then
                    return true
                end

                -- ❗ Nếu đang đánh PRIORITY → KHÔNG cho enemy thường interrupt
                if isPriorityTarget then
                    return false
                end

                -- chỉ khi đang đánh enemy thường thì mới cho enemy thường khác gần hơn interrupt
                local newNearest = getNearestEnemy(center)
                if newNearest and newNearest ~= enemy then
                    local newDist = (center - newNearest.HumanoidRootPart.Position).Magnitude
                    local curDist = (center - hrpEnemy.Position).Magnitude
                    if newDist + 1 < curDist then
                        return true
                    end
                end

                return false
            end

            moveToPositionInterruptible(highPos, interruptIfBetterEnemy)

            -- if interrupted by a better enemy, we exit here and let main loop handle it
            if not autoDungeon or not hrp or not hrp.Parent then
                followLock = false
                currentTarget = nil
                return
            end

            -- 2) arrived or nearly arrived: perform tight follow loop at high altitude until mob dies or user toggles off or pauseForExit
            while autoDungeon and not pauseForExit and humanoid and humanoid.Health > 0 and hrp and hrp.Parent do
                -- if a priority enemy appears now then break immediately
                local center = hrp.Position
                -- nếu có priority enemy khác → break
                local priNow = getNearestPriorityEnemy(center)
                if priNow and priNow ~= enemy then
                    break
                end

                -- ❗ nếu đang đánh priority → bỏ qua check enemy thường
                if not isPriorityTarget then
                    local newNearest = getNearestEnemy(center)
                    if newNearest and newNearest ~= enemy and newNearest:FindFirstChild("HumanoidRootPart") then
                        local newDist = (center - newNearest.HumanoidRootPart.Position).Magnitude
                        local curDist = (center - hrpEnemy.Position).Magnitude
                        if newDist + 1 < curDist then
                            break
                        end
                    end
                end

                local targetPos = Vector3.new(hrpEnemy.Position.X, hrpEnemy.Position.Y + FOLLOW_HEIGHT, hrpEnemy.Position.Z)
                hrp.AssemblyLinearVelocity = Vector3.zero
                -- lerp instantly (dứt khoát nhưng smooth)
                hrp.CFrame = hrp.CFrame:Lerp(CFrame.new(targetPos), 0.5)
                RunService.RenderStepped:Wait()
            end

            followLock = false
            currentTarget = nil
        end

        -- handle root: move to root; while moving, if enemy appears prioritise it (cancel root)
        local function handleDungeonRoot(rootPart)
            if movementLock then return end
            pauseForExit = true

            -- 🔹 DELAY 1.5s trước khi bay tới Root (có kiểm tra priority + enemy)
            local waited = 0
            while waited < 1.5 do
                if not autoDungeon then
                    pauseForExit = false
                    return
                end
                if not hrp or not hrp.Parent then
                    pauseForExit = false
                    return
                end
                -- nếu trong lúc chờ mà có priority enemy hoặc enemy thường → hủy đi root
                if getNearestPriorityEnemy(hrp.Position) or getNearestEnemy(hrp.Position) then
                    pauseForExit = false
                    return
                end
                task.wait(0.1)
                waited += 0.1
            end

            -- target slightly above root for safety
            local target = rootPart.Position + Vector3.new(0, 3, 0)

            -- interrupt if enemy appears nearby (priority checked first)
            local function interruptIfEnemyAppears()
                if not autoDungeon then return true end
                if getNearestPriorityEnemy(hrp.Position) then return true end
                return getNearestEnemy(hrp.Position) ~= nil
            end

            local arrived = moveToPositionInterruptible(target, interruptIfEnemyAppears)

            if not arrived then
                pauseForExit = false
                return
            end

            -- giữ nguyên logic chờ touch như cũ
            local waitedTouch = 0
            while waitedTouch < 3 and pauseForExit and rootPart and rootPart.Parent do
                local stillTouch = rootPart:FindFirstChild("TouchInterest")
                    or rootPart:FindFirstChildOfClass("TouchTransmitter")
                if not stillTouch then break end

                -- ưu tiên special enemy nếu xuất hiện trong lúc chờ
                if getNearestPriorityEnemy(hrp.Position) then break end
                if getNearestEnemy(hrp.Position) then break end

                task.wait(0.25)
                waitedTouch += 0.25
            end

            pauseForExit = false
        end

        -- Auto attack loop with ATTACK_INTERVAL (dùng biến để đồng bộ)
        task.spawn(function()
            while true do
                task.wait(ATTACK_INTERVAL)
                if autoDungeon and not pauseForExit then
                    pcall(function()
                        ReplicatedStorage
                            :WaitForChild("Modules")
                            :WaitForChild("Net")
                            :WaitForChild("RE/RegisterAttack")
                            :FireServer(ATTACK_INTERVAL)
                    end)
                end
            end
        end)

        -- Main loop: prioritize special enemy, normal enemy, then root
        task.spawn(function()
            while true do
                task.wait(SCAN_INTERVAL)
                if not autoDungeon then continue end
                if not hrp or not hrp.Parent then continue end
                if pauseForExit then continue end

                farmCenter = hrp.Position

                -- Priority 0: special priority enemy (PropHitboxPlaceholder)
                local priorityEnemy = getNearestPriorityEnemy(farmCenter)
                if priorityEnemy then
                    task.spawn(function() pcall(function() followEnemy(priorityEnemy) end) end)
                    continue
                end

                -- Priority 1: normal enemy
                local enemy = getNearestEnemy(farmCenter)
                if enemy then
                    task.spawn(function() pcall(function() followEnemy(enemy) end) end)
                    continue
                end

                -- Priority 2: nearest dungeon model's root check
                local nearestDungeonModel = getNearestDungeonModel()
                if nearestDungeonModel then
                    local rootPart = checkDungeonExitOnModel(nearestDungeonModel)
                    if rootPart then
                        task.spawn(function() pcall(function() handleDungeonRoot(rootPart) end) end)
                        continue
                    end
                end

                -- if nothing, loop again quickly
            end
        end)

        -- respawn handling: pause 1s then resume (state preserved)
        player.CharacterAdded:Connect(function(newChar)
            refreshCharacterRefs(newChar)
            hookToolTracking(newChar) -- start listening on new char
            pauseForExit = true

            -- reset locks
            movementLock = false
            followLock = false
            currentTarget = nil

            -- sau 0.5s: resume + equip tool cũ nếu cần
            task.delay(0.5, function()
                pauseForExit = false

                if autoDungeon and lastEquippedToolName then
                    -- small wait to ensure Backpack is ready
                    task.wait(0.2)
                    -- only equip if player currently has no tool equipped
                    if newChar and not newChar:FindFirstChildOfClass("Tool") then
                        local bp = player:FindFirstChild("Backpack")
                        local tool = bp and bp:FindFirstChild(lastEquippedToolName)
                        if tool then
                            pcall(function()
                                tool.Parent = newChar
                            end)
                        end
                    end
                end
            end)
        end)

        -- when script starts, hook current character tracking
        hookToolTracking(character)

        -- Toggle UI (có block kiểm tra PlaceId)
        autoBtn.MouseButton1Click:Connect(function()
            if blocked then return end

            local newState = not autoDungeon

            -- Nếu đang cố bật và không ở Place hợp lệ -> block
            if newState then
                if game.PlaceId ~= ALLOWED_PLACE then
                    blocked = true
                    -- hiển thị cảnh báo NO DUNGEON
                    autoBtn.Text = "NO DUNGEON"
                    autoBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)

                    -- sau 2s phục hồi về OFF
                    task.spawn(function()
                        task.wait(2)
                        autoBtn.Text = "OFF"
                        autoBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
                        blocked = false
                    end)

                    return
                end
            end

            -- nếu không bị block thì đổi trạng thái bình thường
            autoDungeon = newState
            autoBtn.Text = autoDungeon and "ON" or "OFF"
            autoBtn.BackgroundColor3 = autoDungeon and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)

            if autoDungeon then
                -- start tracking current character (in case user toggles while alive)
                hookToolTracking(character)

                -- chỉ gọi hook khi thực sự bật
                pcall(function()
                    game.Players.LocalPlayer:SetAttribute("FastAttackEnemyMode", "Toggle")
                    game.Players.LocalPlayer:SetAttribute("FastAttackEnemy", true)
                    
                    game.Players.LocalPlayer:SetAttribute("AutoBuso", true)
                    game.Players.LocalPlayer:SetAttribute("AutoObserve", true)
                    game.Players.LocalPlayer:SetAttribute("AutoAbility", true)
                    game.Players.LocalPlayer:SetAttribute("AutoAwakening", true)
                end)

                if hrp and hrp.Parent then
                    farmCenter = hrp.Position
                end
            else
                pauseForExit = false
            end
        end)

        -- ensure initial refs
        refreshCharacterRefs()
    end
    
        --AUTO SELECT BUFF DUNGEON------------------------------------------------------------------------------------------------------------------
    do
        local Players = game:GetService("Players")
        local TweenService = game:GetService("TweenService")
        local RunService = game:GetService("RunService")
        local VirtualInputManager = game:GetService("VirtualInputManager")

        local player = Players.LocalPlayer
        local pg = player:WaitForChild("PlayerGui")

        local gui = pg:WaitForChild("AutoBuffSelectionGui", 5)
        if not gui then
        	error("AutoBuffSelectionGui không tồn tại trong PlayerGui")
        end

        local main = gui:WaitForChild("Main", 5)
        local exec = main:WaitForChild("Execution", 5)             -- ScrollingFrame
        local list = main:WaitForChild("List", 5)                  -- ScrollingFrame
        local titleFrame = main:WaitForChild("TitleFrame", 5)
        local closeBtn = titleFrame:WaitForChild("Close", 5)
        local openBtn = gui:WaitForChild("Open", 5)

        -- CONFIG (theo yêu cầu)
        local TARGET_TEXTS = {
        	"Overflow","Defense","Fortress","Sword","Race Meter",
        	"Melee","Lifesteal","Armor","All Cooldowns","HYPER!","Shadow"
        }

        local SCAN_INTERVAL = 2
        local TWEEN_TIME = 0.25
        local EASING = Enum.EasingStyle.Quad

        -- Execution layout
        local EXEC_ANCHOR = Vector2.new(0.5, 0)
        local EXEC_X = 0.5
        local EXEC_FIRST_Y = 0.015
        local EXEC_STEP_Y = 0.09

        -- ===== DEFAULT CLOSED STATE =====
        main.AnchorPoint = Vector2.new(0.5, 0.5)
        main.Position = UDim2.new(0.5, 0, 2, 0) -- vị trí tắt (dưới màn hình)
        main.Visible = false

        -- STATES
        local busyTween = false   -- chống spam open/close
        local isOpen = false
        local executionOrder = {} -- mảng giữ thứ tự buttons trong Execution (top->bottom)

        -- Auto states
        local autoRunning = false -- mặc định OFF
        local lastClickTime = 0

        -- LƯU metadata gốc để trả về List
        local originalMeta = {}

        -- Helpers --------------------------------------------------------
        local function recordOriginal(btn)
        	if not originalMeta[btn] then
        		originalMeta[btn] = {
        			parent = btn.Parent,
        			position = btn.Position,
        			anchor = Vector2.new(btn.AnchorPoint.X, btn.AnchorPoint.Y)
        		}
        	end
        end

        local function restoreOriginal(btn)
        	local meta = originalMeta[btn]
        	if not meta then
        		btn.Parent = list
        		return
        	end
        	btn.AnchorPoint = meta.anchor
        	btn.Position = meta.position
        	btn.Parent = meta.parent
        end

        local function indexOf(tbl, value)
        	for i = 1, #tbl do
        		if tbl[i] == value then return i end
        	end
        	return nil
        end

        local function updateExecutionPositions()
        	for i = 1, #executionOrder do
        		local btn = executionOrder[i]
        		if btn and btn.Parent == exec then
        			btn.AnchorPoint = EXEC_ANCHOR
        			local y = EXEC_FIRST_Y + (i - 1) * EXEC_STEP_Y
        			btn.Position = UDim2.new(EXEC_X, 0, y, 0)
        		end
        	end
        end

        local function addToExecution(btn)
        	recordOriginal(btn)
        	if btn.Parent == exec then return end

        	local freeIndex = nil
        	for i = 1, #executionOrder do
        		if executionOrder[i] == nil then
        			freeIndex = i
        			break
        		end
        	end
        	if not freeIndex then
        		freeIndex = #executionOrder + 1
        	end

        	if freeIndex <= #executionOrder then
        		table.insert(executionOrder, freeIndex, btn)
        	else
        		executionOrder[freeIndex] = btn
        	end

        	btn.Parent = exec
        	btn.AnchorPoint = EXEC_ANCHOR
        	updateExecutionPositions()
        end

        local function removeFromExecution(btn)
        	local idx = indexOf(executionOrder, btn)
        	if not idx then return end
        	table.remove(executionOrder, idx)
        	restoreOriginal(btn)
        	updateExecutionPositions()
        end

        -- Attach handlers to List/Execution buttons
        local function attachToggleHandler(btn)
        	if not btn:IsA("TextButton") then return end
        	if btn:GetAttribute("attached") then return end
        	btn:SetAttribute("attached", true)
        	recordOriginal(btn)

        	btn.MouseButton1Click:Connect(function()
        		if busyTween then return end
        		if not main.Visible then return end

        		if btn.Parent == exec then
        			removeFromExecution(btn)
        		else
        			addToExecution(btn)
        		end
        	end)
        end

        for _, child in ipairs(list:GetChildren()) do attachToggleHandler(child) end
        for _, child in ipairs(exec:GetChildren()) do attachToggleHandler(child) end

        local function initializeExistingExecution()
        	local items = {}
        	for _, c in ipairs(exec:GetChildren()) do
        		if c:IsA("GuiObject") then
        			table.insert(items, c)
        		end
        	end
        	table.sort(items, function(a, b)
        		return a.Position.Y.Scale < b.Position.Y.Scale
        	end)
        	executionOrder = {}
        	for i, v in ipairs(items) do executionOrder[i] = v end
        	updateExecutionPositions()
        end
        initializeExistingExecution()

        list.ChildAdded:Connect(function(c) attachToggleHandler(c) end)
        exec.ChildAdded:Connect(function(c)
        	attachToggleHandler(c)
        	if not indexOf(executionOrder, c) then
        		table.insert(executionOrder, c)
        		updateExecutionPositions()
        	end
        end)

        -- OPEN / CLOSE logic ----------------------------------------------
        local function tweenPosition(targetPos)
        	local info = TweenInfo.new(TWEEN_TIME, EASING)
        	local tween = TweenService:Create(main, info, {Position = targetPos})
        	busyTween = true
        	tween:Play()
        	tween.Completed:Wait()
        	busyTween = false
        end

        local function openMain()
        	if busyTween or isOpen then return end
        	busyTween = true
        	main.Visible = true
        	main.AnchorPoint = Vector2.new(0.5, 0.5)
        	main.Position = UDim2.new(0.5, 0, 2, 0)
        	local tween = TweenService:Create(main, TweenInfo.new(TWEEN_TIME, EASING), { Position = UDim2.new(0.5, 0, 0.5, 0) })
        	tween:Play()
        	tween.Completed:Wait()
        	isOpen = true
        	busyTween = false
        end

        local function closeMain()
        	if busyTween or not isOpen then return end
        	busyTween = true
        	main.AnchorPoint = Vector2.new(0.5, 0.5)
        	local curXScale, curXOffset = main.Position.X.Scale, main.Position.X.Offset
        	local target = UDim2.new(curXScale, curXOffset, 2, 0)
        	local tween = TweenService:Create(main, TweenInfo.new(TWEEN_TIME, EASING), { Position = target })
        	tween:Play()
        	tween.Completed:Wait()
        	main.Visible = false
        	isOpen = false
        	busyTween = false
        end

        openBtn.MouseButton1Click:Connect(openMain)
        closeBtn.MouseButton1Click:Connect(closeMain)

        spawn(function()
        	while true do
        		-- guard in case buttons removed
        		if openBtn and closeBtn then
        			openBtn.Active = not (busyTween or isOpen)
        			closeBtn.Active = not (busyTween or (not isOpen))
        		end
        		task.wait(0.05)
        	end
        end)

        -- ======================
        -- AUTO SYSTEM (uses executionOrder as priority)
        -- ======================

        -- helper: extract plain text
        local function getPlainText(text)
        	return text:gsub("<[^>]+>", "")
        end

        -- build priority list from executionOrder (top->bottom)
        local function buildPriorityList()
        	local listNames = {}
        	for i = 1, #executionOrder do
        		local btn = executionOrder[i]
        		if btn and btn:IsA("GuiObject") then
        			-- try to find label inside button named DisplayName (or use button.Text)
        			local label = btn:FindFirstChild("DisplayName")
        			local nameText
        			if label and label:IsA("TextLabel") then
        				nameText = getPlainText(label.Text)
        			else
        				-- fallback to button.Text
        				if btn:IsA("TextButton") then
        					nameText = getPlainText(btn.Text)
        				end
        			end
        			if nameText and nameText ~= "" then
        				table.insert(listNames, nameText)
        			end
        		end
        	end
        	return listNames
        end

        local function clickButtonAtGui(btn)
        	local p, s = btn.AbsolutePosition, btn.AbsoluteSize
        	local x, y = p.X + s.X/2, p.Y + s.Y/2
        	VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, game, 1)
        	task.wait()
        	VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, game, 1)
        end

        local function getPriorityIndexFromList(priorityList, text)
        	for i, v in ipairs(priorityList) do
        		if v == text then
        			return i
        		end
        	end
        	return nil
        end

        -- main scanning & clicking logic (searches PlayerGui for ScreenGui -> "1" -> "2" -> DisplayName)
        local function tryAutoClick()
        	if not autoRunning then return end
        	if os.clock() - lastClickTime < SCAN_INTERVAL then return end

        	-- build dynamic priority from executionOrder
        	local priorityList = buildPriorityList()

        	local pgLocal = player:FindFirstChild("PlayerGui")
        	if not pgLocal then return end

        	local bestBtn, bestPriority
        	local allValidButtons = {}

        	for _, sg in ipairs(pgLocal:GetChildren()) do
        		if not sg:IsA("ScreenGui") or not sg.Enabled then continue end

        		local frame = sg:FindFirstChild("1")
        		if not frame then continue end

        		local btn = frame:FindFirstChild("2")
        		if not btn or not btn:IsA("TextButton") or not btn.Visible or not btn.Active then
        			continue
        		end

        		local label = btn:FindFirstChild("DisplayName")
        		if not label or not label:IsA("TextLabel") then
        			continue
        		end

        		table.insert(allValidButtons, btn)

        		local text = getPlainText(label.Text)
        		local priority = getPriorityIndexFromList(priorityList, text)

        		if priority and (not bestPriority or priority < bestPriority) then
        			bestPriority = priority
        			bestBtn = btn
        		end
        	end

        	-- click best priority found
        	if bestBtn then
        		lastClickTime = os.clock()
        		clickButtonAtGui(bestBtn)
        		return
        	end

        	-- fallback: if no priority match, but there are valid buttons, click a random one
        	if #allValidButtons > 0 then
        		lastClickTime = os.clock()
        		clickButtonAtGui(allValidButtons[math.random(#allValidButtons)])
        	end
        end

        -- Heartbeat loop to drive auto (lightweight)
        RunService.Heartbeat:Connect(function()
        	-- call non-blocking: tryAutoClick uses os.clock gating
        	pcall(tryAutoClick)
        end)

        -- ADD UI BUTTON =================--

        -- create Auto toggle button (btnFastAttackEnemy)
        local btnFastAttackEnemy = HomeFrame:FindFirstChild("btnFastAttackEnemy")
        if not btnFastAttackEnemy then
        	btnFastAttackEnemy = Instance.new("TextButton", HomeFrame)
        	btnFastAttackEnemy.Name = "btnFastAttackEnemy"
        end
        btnFastAttackEnemy.Size = UDim2.new(0, 90, 0, 30)
        btnFastAttackEnemy.Position = UDim2.new(0, 240, 0, 160)
        btnFastAttackEnemy.Text = "OFF"
        btnFastAttackEnemy.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        btnFastAttackEnemy.TextColor3 = Color3.new(1, 1, 1)
        btnFastAttackEnemy.Font = Enum.Font.SourceSansBold
        btnFastAttackEnemy.TextSize = 30

        -- create small Mode/Main toggle button (btnModeEnemy)
        local btnModeEnemy = HomeFrame:FindFirstChild("btnModeEnemy")
        if not btnModeEnemy then
        	btnModeEnemy = Instance.new("TextButton", HomeFrame)
        	btnModeEnemy.Name = "btnModeEnemy"
        end
        btnModeEnemy.Size = UDim2.new(0, 90, 0, 30) -- match a bit larger for clarity
        btnModeEnemy.Position = UDim2.new(0, 190, 0, 160)
        btnModeEnemy.Text = "Open Main"
        btnModeEnemy.Font = Enum.Font.SourceSans
        btnModeEnemy.TextSize = 14
        btnModeEnemy.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        btnModeEnemy.TextColor3 = Color3.new(1,1,1)
        btnModeEnemy.TextScaled = true
        btnModeEnemy.TextWrapped = true

        -- Auto toggle behaviour
        local function setAutoState(on)
        	autoRunning = on
        	if on then
        		btnFastAttackEnemy.Text = "ON"
        		btnFastAttackEnemy.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        	else
        		btnFastAttackEnemy.Text = "OFF"
        		btnFastAttackEnemy.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        	end
        end
        setAutoState(false) -- default OFF

        btnFastAttackEnemy.MouseButton1Click:Connect(function()
        	-- toggle state, but prevent toggling while tweening main (optional)
        	if busyTween then return end
        	setAutoState(not autoRunning)
        end)

        -- Mode/Main button toggles Main open/close (uses openMain/closeMain)
        btnModeEnemy.MouseButton1Click:Connect(function()
        	if busyTween then return end
        	if isOpen then
        		closeMain()
        		btnModeEnemy.Text = "Open Main"
        	else
        		openMain()
        		btnModeEnemy.Text = "Close Main"
        	end
        end)

        -- seed RNG once
        math.randomseed(tick())
    end
    
    wait(0.2)

    print("Raid tad V0.15 SUCCESS✅")
end
