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
                player:SetAttribute("FastAttackEnemy", true)
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

        local player = Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local hrp = character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart")

        local autoBtn = Instance.new("TextButton", HomeFrame)
        autoBtn.Size = UDim2.new(0, 90, 0, 30)
        autoBtn.Position = UDim2.new(0, 240, 0, 110)
        autoBtn.Text = "OFF"
        autoBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        autoBtn.TextColor3 = Color3.new(1, 1, 1)
        autoBtn.Font = Enum.Font.SourceSansBold
        autoBtn.TextScaled = true

        -- Cấu hình
        local DISTANCE_LIMIT = 850
        local SCAN_INTERVAL = 0.4        -- interval chính để tìm mục tiêu (nhẹ)
        local TELEPORT_TWEEN_SPEED = 600 -- khoảng tốc độ dùng để tính thời gian tween (distance / speed)

        local autoDungeon = false
        local pauseForExit = false       -- tạm dừng đánh khi cần bay tới Exit Root
        local farmCenter = nil           -- sẽ là hrp.Position (always)
        local anchor -- optional camera anchor if used in followEnemy (kept minimal)

        -- helper: ensure hrp khi respawn
        local function refreshCharacterRefs(newChar)
            character = newChar or player.Character
            if character then
                hrp = character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart")
            else
                hrp = nil
            end
        end

        -- hàm tween di chuyển HRP tới vị trí targetPos (an toàn, dùng CFrame)
        local function tweenToPosition(targetPos)
            if not hrp or not hrp.Parent then return end
            local dist = (hrp.Position - targetPos).Magnitude
            if dist > 10000 then return end
            local time = math.clamp(dist / TELEPORT_TWEEN_SPEED, 0.05, 5)
            local tween = TweenService:Create(hrp, TweenInfo.new(time, Enum.EasingStyle.Linear), {CFrame = CFrame.new(targetPos)})
            local ok, err = pcall(function()
                tween:Play()
                tween.Completed:Wait()
            end)
            pcall(function() tween:Cancel() end)
        end

        -- tìm quái gần nhất trong workspace.Enemies theo centerPos (giữ nguyên logic cũ)
        local function getNearestEnemy(centerPos)
            local folder = workspace:FindFirstChild("Enemies")
            if not folder then return nil end
            local nearest, nearestDist
            for _, mob in ipairs(folder:GetChildren()) do
                if mob:IsA("Model") and mob:FindFirstChild("HumanoidRootPart") then
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

        -- tìm model Dungeon gần nhất trong workspace.Map.Dungeon
        local function getNearestDungeonModel()
            local map = workspace:FindFirstChild("Map")
            if not map then return nil end
            local dungeon = map:FindFirstChild("Dungeon")
            if not dungeon then return nil end

            local nearest, nearestDist
            local myPos = (hrp and hrp.Position) or (player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character.HumanoidRootPart.Position) or Vector3.new(0,0,0)

            for _, mdl in ipairs(dungeon:GetChildren()) do
                if mdl:IsA("Model") then
                    -- try primarypart or pivot
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

            return nearest, nearestDist
        end

        -- kiểm tra model gần nhất có ExitTeleporter -> Root -> TouchInterest không
        local function checkDungeonExitOnModel(mdl)
            if not mdl then return nil end
            -- tìm ExitTeleporter trong model (có thể là con trực tiếp hoặc sâu)
            local exit = mdl:FindFirstChild("ExitTeleporter", true) -- tìm sâu
            if not exit then return nil end
            local rootPart = exit:FindFirstChild("Root")
            if not rootPart or not rootPart:IsA("BasePart") then return nil end
            -- TouchInterest có thể là named "TouchInterest" hoặc dạng TouchTransmitter
            local hasTouch = rootPart:FindFirstChild("TouchInterest") or rootPart:FindFirstChildOfClass("TouchTransmitter")
            if hasTouch then
                return rootPart
            end
            return nil
        end

        -- follow enemy (đơn giản: di chuyển tới enemy dùng tween / lerp giống logic cũ, nhưng ngắn gọn)
        local function followEnemy(enemy)
            if not enemy or not enemy.Parent or not hrp then return end
            local hrpEnemy = enemy:FindFirstChild("HumanoidRootPart")
            local humanoid = enemy:FindFirstChildOfClass("Humanoid")
            if not hrpEnemy or not humanoid then return end

            -- nếu xa quá, tween tới gần
            local dist = (hrp.Position - hrpEnemy.Position).Magnitude
            if dist > 200 then
                tweenToPosition(hrpEnemy.Position + Vector3.new(0, 5, 0))
                return
            end

            -- theo sau đơn giản: lerp đến vị trí mục tiêu trên mỗi RenderStepped cho tới khi mob chết hoặc auto tắt
            while humanoid.Health > 0 and autoDungeon and not pauseForExit and hrp and hrp.Parent do
                local targetPos = Vector3.new(hrpEnemy.Position.X, hrpEnemy.Position.Y + 15, hrpEnemy.Position.Z)
                -- cập nhật hrp để gần mục tiêu (giữ an toàn bằng Lerp)
                hrp.AssemblyLinearVelocity = Vector3.zero
                hrp.CFrame = hrp.CFrame:Lerp(CFrame.new(targetPos), 0.22)
                RunService.RenderStepped:Wait()
                -- break nếu đang pause do Exit detect
                if pauseForExit then break end
            end
        end

        -- Auto attack loop (giống logic cũ) — chỉ chạy khi autoDungeon ON và không pauseForExit
        task.spawn(function()
            while true do
                task.wait(0.4)
                if autoDungeon and not pauseForExit then
                    pcall(function()
                        ReplicatedStorage
                            :WaitForChild("Modules")
                            :WaitForChild("Net")
                            :WaitForChild("RE/RegisterAttack")
                            :FireServer(0.4)
                    end)
                end
            end
        end)

        -- Main loop: tìm dungeon model / kiểm tra Exit -> nếu có thì bay tới Root; nếu không sẽ tìm enemy gần nhất và follow
        task.spawn(function()
            while true do
                task.wait(SCAN_INTERVAL)
                if not autoDungeon then continue end
                if not hrp or not hrp.Parent then continue end

                -- farmCenter luôn là vị trí của chính bạn (cập nhật)
                farmCenter = hrp.Position

                -- 1) kiểm tra Dungeon models (lấy model gần nhất, nếu có Exit Root có TouchInterest -> xử lý)
                local nearestDungeonModel = getNearestDungeonModel()
                if nearestDungeonModel then
                    local rootPart = checkDungeonExitOnModel(nearestDungeonModel)
                    if rootPart then
                        -- pause attack/follow và bay tới giữa Root
                        pauseForExit = true
                        -- di chuyển nhanh đến giữa Root (cách 2-3 studs lên để an toàn)
                        local target = rootPart.Position + Vector3.new(0, 3, 0)
                        pcall(function() tweenToPosition(target) end)
                        -- sau khi tới, chờ cho đến khi TouchInterest biến mất (một ngưỡng an toàn) hoặc 6s tối đa
                        local waited = 0
                        while pauseForExit and rootPart and rootPart.Parent and waited < 6 do
                            local stillTouch = rootPart:FindFirstChild("TouchInterest") or rootPart:FindFirstChildOfClass("TouchTransmitter")
                            if not stillTouch then
                                break
                            end
                            task.wait(0.5)
                            waited = waited + 0.5
                        end
                        -- resume
                        pauseForExit = false
                        -- tiếp vòng lặp tiếp theo
                        continue
                    end
                end

                -- 2) nếu không gặp exit, tìm mục tiêu trong radius và đánh
                local target = getNearestEnemy(farmCenter)
                if target and not pauseForExit then
                    followEnemy(target)
                end
            end
        end)

        -- nhân vật respawn: không reset autoDungeon; tạm nghỉ và resume sau 2s nếu vẫn ON
        player.CharacterAdded:Connect(function(newChar)
            refreshCharacterRefs(newChar)
            -- tạm dừng mọi hành vi theo target cho tới khi nhân vật ổn định
            pauseForExit = true
            task.delay(2, function()
                pauseForExit = false
            end)
        end)

        -- Toggle nút ON/OFF (giữ trạng thái persistent qua respawn)
        autoBtn.MouseButton1Click:Connect(function()
            autoDungeon = not autoDungeon
            autoBtn.Text = autoDungeon and "ON" or "OFF"
            autoBtn.BackgroundColor3 = autoDungeon and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)

            if autoDungeon then
                -- bật ngay: đặt center = hrp vị trí hiện tại
                if hrp and hrp.Parent then
                    farmCenter = hrp.Position
                end
            else
                -- tắt => ngưng
                pauseForExit = false
            end
        end)

        -- lần đầu ensure refs
        refreshCharacterRefs()
    end

    wait(0.2)

    print("Raid tad SUCCESS✅")
end
