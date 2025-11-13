return function(sections)
    local HomeFrame = sections["Raid"]

        --RAID------------------------------------------------------------------------------------------------------------------
    do
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local hrp = character:WaitForChild("HumanoidRootPart")
        local TweenService = game:GetService("TweenService")
        local RunService = game:GetService("RunService")
        local camera = workspace.CurrentCamera

        -- 🧩 Nút bật/tắt Auto RAID
        local toggleRaid = Instance.new("TextButton", HomeFrame)
        toggleRaid.Size = UDim2.new(0, 90, 0, 30)
        toggleRaid.Position = UDim2.new(0, 240, 0, 10)
        toggleRaid.Text = "OFF"
        toggleRaid.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        toggleRaid.TextColor3 = Color3.new(1, 1, 1)
        toggleRaid.Font = Enum.Font.SourceSansBold
        toggleRaid.TextScaled = true

        local running = false
        local anchor = nil
        local anchorY = nil
        local lastUpdate = 0

        -- 🧱 Tạo anchor neo camera (vị trí người chơi)
        local function ensureAnchor()
            if not anchor or not anchor.Parent then
                anchor = Instance.new("Part")
                anchor.Anchored = true
                anchor.CanCollide = false
                anchor.Transparency = 1
                anchor.Size = Vector3.new(1, 1, 1)
                anchor.Name = "RaidCameraAnchor"

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
            if not hrp then return end
            local dist = (hrp.Position - pos).Magnitude
            if dist > 10000 then return end
            local tweenTime = math.clamp(dist / 300, 0.5, 5)
            local tween = TweenService:Create(hrp, TweenInfo.new(tweenTime, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)})
            tween:Play()
            tween.Completed:Wait()
        end

        -- 🏝️ Tìm đảo RAID ưu tiên cao nhất
        local function getHighestPriorityIsland()
            local map = workspace:FindFirstChild("Map")
            if map and map:FindFirstChild("RaidMap") then
                for i = 5, 1, -1 do
                    local model = map.RaidMap:FindFirstChild("RaidIsland" .. i)
                    if model and model:IsA("Model") then
                        return model
                    end
                end
            end
            return nil
        end

        -- 👿 Lấy danh sách quái gần
        local function getEnemiesNear(origin)
            local enemies = {}
            local folder = workspace:FindFirstChild("Enemies")
            if not folder then return enemies end
            for _, mob in ipairs(folder:GetChildren()) do
                if mob:IsA("Model") and mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChildOfClass("Humanoid") then
                    local dist = (origin.Position - mob.HumanoidRootPart.Position).Magnitude
                    if dist <= 5000 and mob.Humanoid.Health > 0 then
                        table.insert(enemies, mob)
                    end
                end
            end
            return enemies
        end

        -- ⚔️ Theo quái (mượt, neo camera y như script 1)
        local function followEnemy(enemy)
            local hrpEnemy = enemy:FindFirstChild("HumanoidRootPart")
            local humanoid = enemy:FindFirstChildOfClass("Humanoid")
            if not hrpEnemy or not humanoid then return end

            local anchor = ensureAnchor()

            if not anchorY or (tick() - lastUpdate) > 2 then
                anchorY = hrpEnemy.Position.Y + 25
                lastUpdate = tick()
            end

            camera.CameraType = Enum.CameraType.Custom
            camera.CameraSubject = anchor

            local dist = (hrp.Position - hrpEnemy.Position).Magnitude
            if dist > 200 then
                tweenTo(hrpEnemy.Position + Vector3.new(0, 10, 0))
            else
                while humanoid.Health > 0 and running do
                    if not hrp or not hrpEnemy then break end

                    local targetPos = Vector3.new(hrpEnemy.Position.X, anchorY, hrpEnemy.Position.Z)
                    anchor.Position = anchor.Position:Lerp(targetPos, 0.15)
                    hrp.AssemblyLinearVelocity = Vector3.zero
                    hrp.CFrame = hrp.CFrame:Lerp(CFrame.new(targetPos), 0.25)

                    RunService.RenderStepped:Wait()
                end
            end
        end

        -- ♻️ Reset khi chết
        player.CharacterAdded:Connect(function(newChar)
            character = newChar
            hrp = newChar:WaitForChild("HumanoidRootPart")
            running = false
            anchorY = nil
            if anchor then anchor:Destroy() end
            toggleRaid.Text = "OFF"
            toggleRaid.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
            camera.CameraType = Enum.CameraType.Custom
            camera.CameraSubject = hrp
        end)

        -- 🔘 Nút bật/tắt
        toggleRaid.MouseButton1Click:Connect(function()
            running = not running
            toggleRaid.Text = running and "ON" or "OFF"
            toggleRaid.BackgroundColor3 = running and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 50, 50)
            if not running then
                camera.CameraType = Enum.CameraType.Custom
                camera.CameraSubject = hrp
                if anchor then anchor:Destroy() end
            end
        end)

        -- ⚙️ Auto attack (cực mượt)
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

        -- 🔁 Vòng lặp chính Auto RAID
        task.spawn(function()
            while true do
                RunService.Heartbeat:Wait()
                if not running or not hrp then continue end

                -- Đi tới đảo RAID
                local island = getHighestPriorityIsland()
                if island then
                    local root = island.PrimaryPart or island:FindFirstChildWhichIsA("BasePart")
                    if root then
                        tweenTo(root.Position + Vector3.new(0, 10, 0))
                    end
                end

                -- Tìm và đánh quái
                local enemies = getEnemiesNear(hrp)
                if #enemies > 0 then
                    for _, enemy in ipairs(enemies) do
                        if not running then break end
                        followEnemy(enemy)
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
