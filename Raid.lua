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
        toggleRaid.Text = "[⚔️] START"
        toggleRaid.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        toggleRaid.TextColor3 = Color3.new(1, 1, 1)

        -- Trạng thái RAID
        local running = false
        local autoClicking = false

        -- Auto click loop
        task.spawn(function()
            while true do
                if autoClicking then
                    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                end
                task.wait(0.5)
            end
        end)

        -- Cập nhật giao diện về OFF
        local function resetRaidButton()
            running = false
            autoClicking = false
            toggleRaid.Text = "[⚔️] START"
            toggleRaid.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        end

        -- Bật/tắt RAID khi bấm nút
        toggleRaid.MouseButton1Click:Connect(function()
            running = not running
            autoClicking = running
            toggleRaid.Text = running and "[🛑] STOP" or "[⚔️] START"
            toggleRaid.BackgroundColor3 = running and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(0, 170, 255)
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

    wait(1)

    print("Raid tad SUCCESS✅")
end
