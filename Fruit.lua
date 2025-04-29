return function(sections)
    local HomeFrame = sections["Fruit"]

        --ESP FRUIT-------------------------------------------------------------------------------------------
    do
        local player = game.Players.LocalPlayer
        local camera = workspace.CurrentCamera

        local fruitESPEnabled = false
        local fruitESPObjects = {}

        -- Nút bật/tắt ESP Fruit
        local espFruitButton = Instance.new("TextButton", HomeFrame)
        espFruitButton.Size = UDim2.new(0, 90, 0, 30)
        espFruitButton.Position = UDim2.new(0, 240, 0, 10)
        espFruitButton.Text = "OFF"
        espFruitButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        espFruitButton.TextColor3 = Color3.new(1, 1, 1)
        espFruitButton.Font = Enum.Font.SourceSansBold
        espFruitButton.TextScaled = true

        -- Kiểm tra xem object có phải là Fruit
        local function isFruit(obj)
            return obj:IsA("Model") and obj.Name:lower():find("fruit") and not obj:IsA("Folder")
        end

        -- Tạo ESP Fruit
        local function createFruitESP(obj)
            if not obj:FindFirstChild("Handle") and not obj:FindFirstChild("Main") and not obj:FindFirstChild("Part") then return end

            local part = obj:FindFirstChild("Handle") or obj:FindFirstChild("Main") or obj:FindFirstChild("Part") or obj:FindFirstChildWhichIsA("BasePart")
            if not part then return end

            local billboard = Instance.new("BillboardGui")
            billboard.Adornee = part
            billboard.Size = UDim2.new(0, 100, 0, 40)
            billboard.StudsOffset = Vector3.new(0, 3, 0)
            billboard.AlwaysOnTop = true
            billboard.Parent = obj

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.TextColor3 = Color3.fromRGB(0, 255, 0)
            label.Font = Enum.Font.SourceSansBold
            label.TextScaled = true
            label.Text = ""
            label.Parent = billboard

            local conn
            conn = game:GetService("RunService").RenderStepped:Connect(function()
                if not obj or not obj.Parent or not part then
                    conn:Disconnect()
                    return
                end

                local dist = math.floor((camera.CFrame.Position - part.Position).Magnitude)
                label.Text = obj.Name .. "\n" .. "Dist: " .. dist .. "m"
            end)

            table.insert(fruitESPObjects, {billboard, conn})
        end

        -- Cập nhật tất cả Fruit hiện có
        local function scanFruits()
            for _, obj in pairs(workspace:GetChildren()) do
                if isFruit(obj) then
                    createFruitESP(obj)
                end
            end

            workspace.ChildAdded:Connect(function(child)
                task.wait(0.2)
                if fruitESPEnabled and isFruit(child) then
                    createFruitESP(child)
                end
            end)
        end

        -- Bật/tắt ESP Fruit
        local function toggleFruitESP(state)
            if state then
                scanFruits()
            else
                for _, item in pairs(fruitESPObjects) do
                    for _, obj in pairs(item) do
                        if typeof(obj) == "Instance" and obj:IsDescendantOf(game) then
                            obj:Destroy()
                        elseif typeof(obj) == "RBXScriptConnection" then
                            obj:Disconnect()
                        end
                    end
                end
                fruitESPObjects = {}
            end
        end

        -- Gán sự kiện cho nút bật/tắt
        espFruitButton.MouseButton1Click:Connect(function()
            fruitESPEnabled = not fruitESPEnabled
            espFruitButton.Text = fruitESPEnabled and "ON" or "OFF"
            espFruitButton.BackgroundColor3 = fruitESPEnabled and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
            toggleFruitESP(fruitESPEnabled)
        end)
    end

        --COLECT FRUIT-------------------------------------------------------------------------------------------
    do
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local player = Players.LocalPlayer

        local collectFruitEnabled = false
        local teleportPoints = {
            Vector3.new(-286.99, 306.18, 597.75), --cafe
            Vector3.new(-6508.56, 83.24, -132.84), --ngoài ship
            Vector3.new(923.21, 125.11, 32852.83), --trong ship
            Vector3.new(2284.91, 15.20, 905.62) --swan
        }

        -- Nút bật/tắt nhặt Fruit
        local collectFruitButton = Instance.new("TextButton", HomeFrame)
        collectFruitButton.Size = UDim2.new(0, 90, 0, 30)
        collectFruitButton.Position = UDim2.new(0, 240, 0, 60)
        collectFruitButton.Text = "OFF"
        collectFruitButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        collectFruitButton.TextColor3 = Color3.new(1, 1, 1)
        collectFruitButton.Font = Enum.Font.SourceSansBold
        collectFruitButton.TextScaled = true

        local function calculateDistance(a, b)
            return (a - b).Magnitude
        end

        local function teleportRepeatedly(pos, duration)
            local hrp = player.Character:WaitForChild("HumanoidRootPart")
            local t0 = tick()
            while tick() - t0 < duration do
                hrp.CFrame = CFrame.new(pos)
                RunService.Heartbeat:Wait()
            end
        end

        local function performLunge(targetPos)
            local character = player.Character or player.CharacterAdded:Wait()
            local hrp = character:WaitForChild("HumanoidRootPart")
            local dir = (targetPos - hrp.Position).Unit
            local dist = (targetPos - hrp.Position).Magnitude
            local lungeSpeed = 330
            local tpThreshold = 250
            local t0 = tick()

            while tick() - t0 < dist / lungeSpeed do
                local remaining = (targetPos - hrp.Position).Magnitude
                if remaining <= tpThreshold then
                    hrp.CFrame = CFrame.new(targetPos)
                    break
                end
                hrp.CFrame = hrp.CFrame + dir * (lungeSpeed * RunService.Heartbeat:Wait())
            end
        end

        local function isFruit(obj)
            return obj:IsA("Model") and obj.Name:lower():find("fruit")
        end

        local function findNearestTeleportPoint(fruitPos)
            local myPos = player.Character:WaitForChild("HumanoidRootPart").Position
            local closestPoint, closestDist = nil, math.huge
            for _, tpPos in pairs(teleportPoints) do
                local dist = calculateDistance(tpPos, fruitPos)
                if dist < closestDist then
                    closestPoint = tpPos
                    closestDist = dist
                end
            end
            return closestPoint, closestDist, calculateDistance(myPos, fruitPos)
        end

        local function goToFruit(fruit)
            local fruitPart = fruit:FindFirstChild("Handle") or fruit:FindFirstChild("Main") or fruit:FindFirstChild("Part") or fruit:FindFirstChildWhichIsA("BasePart")
            if not fruitPart then return end

            local fruitPos = fruitPart.Position
            local tpPos, tpToFruitDist, playerToFruitDist = findNearestTeleportPoint(fruitPos)

            if playerToFruitDist < tpToFruitDist then
                -- Gần hơn các tọa độ tắt, lướt thẳng
                performLunge(fruitPos)
            else
                -- Dùng đường tắt
                teleportRepeatedly(tpPos, 2)
                teleportRepeatedly(tpPos + Vector3.new(0, 100, 0), 0.3)
                task.wait(0.1)
                performLunge(fruitPos)
            end
        end

        local function scanAndCollect()
            while collectFruitEnabled do
                for _, obj in pairs(workspace:GetChildren()) do
                    if isFruit(obj) then
                        goToFruit(obj)
                        break -- chỉ đi đến 1 trái đầu tiên tìm được
                    end
                end
                task.wait(1)
            end
        end

        collectFruitButton.MouseButton1Click:Connect(function()
            collectFruitEnabled = not collectFruitEnabled
            collectFruitButton.Text = collectFruitEnabled and "ON" or "OFF"
            collectFruitButton.BackgroundColor3 = collectFruitEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 50, 50)

            if collectFruitEnabled then
                task.spawn(scanAndCollect)
            end
        end)
    end

    wait(0.2)

    print("Fruit tad SUCCESS✅")
end
