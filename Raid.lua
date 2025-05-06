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

        -- Bật/tắt RAID khi bấm nút
        toggleRaid.MouseButton1Click:Connect(function()
            running = not running
            autoClicking = running
            toggleRaid.Text = running and "ON" or "OFF"
            toggleRaid.BackgroundColor3 = running and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 50, 50)
        end)

        -- Tween đến vị trí
        local function tweenTo(pos)
            local dist = (hrp.Position - pos).Magnitude
            if dist > 5000 then return end
            local tween = TweenService:Create(hrp, TweenInfo.new(dist/300, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)})
            tween:Play()
            tween.Completed:Wait()
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
                    if dist <= 5000 and mob.Humanoid.Health > 0 then
                        table.insert(enemies, mob)
                    end
                end
            end
            return enemies
        end

        -- Theo dõi và đánh quái
        local function followEnemy(enemy)
            local hrpEnemy = enemy:FindFirstChild("HumanoidRootPart")
            if not hrpEnemy then return end
            while enemy:FindFirstChildOfClass("Humanoid") and enemy:FindFirstChildOfClass("Humanoid").Health > 0 and running do
                if not hrp then break end
                hrp.CFrame = CFrame.new(hrpEnemy.Position + Vector3.new(0, 30, 0))
                RunService.RenderStepped:Wait()
            end
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
                if not running or not hrp then continue end

                local island = getHighestPriorityIsland()
                if island then
                    local root = island:IsA("Model") and island:FindFirstChild("PrimaryPart") or island.PrimaryPart or island:FindFirstChild("HumanoidRootPart")
                    if not root then
                        root = island:FindFirstChildWhichIsA("BasePart")
                    end
                    if root then
                        tweenTo(root.Position + Vector3.new(0, 10, 0))
                    end
                end

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

        --BUY CHIP------------------------------------------------------------------------------------------------------------------
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

            -- Kiểm tra ClickDetector Sea 3 trước
            local sea3 = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Boat Castle")
            if sea3 and sea3:FindFirstChild("RaidSummon2") then
                clickDetector = sea3.RaidSummon2:FindFirstChild("Button") and sea3.RaidSummon2.Button:FindFirstChild("Main") and sea3.RaidSummon2.Button.Main:FindFirstChild("ClickDetector")
            end

            -- Nếu không tìm thấy ở Sea 3 thì thử Sea 2
            if not clickDetector then
                local sea2 = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("CircleIsland")
                if sea2 and sea2:FindFirstChild("RaidSummon2") then
                    clickDetector = sea2.RaidSummon2:FindFirstChild("Button") and sea2.RaidSummon2.Button:FindFirstChild("Main") and sea2.RaidSummon2.Button.Main:FindFirstChild("ClickDetector")
                end
            end

            if clickDetector then
                fireclickdetector(clickDetector)
            else
                warn("❌ Không tìm thấy ClickDetector để Start Raid (không phải Sea 2 hoặc Sea 3).")
            end
        end)
    end

    do
    wait(0.2)

    print("Raid tad SUCCESS✅")
end
