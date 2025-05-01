return function(sections)
    local HomeFrame = sections["PVP"]

    --===========FOLLOW PLAYER======================================================
    do
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local player = Players.LocalPlayer

        local followEnabled = false
        local targetPlayer = nil
        local teleportPoints = {
            Vector3.new(-286.99, 306.18, 597.75),
            Vector3.new(-6508.56, 83.24, -132.84),
            Vector3.new(923.21, 125.11, 32852.83),
            Vector3.new(2284.91, 15.20, 905.62)
        }

        -- Button bật/tắt theo dõi
        local followButton = Instance.new("TextButton", HomeFrame)
        followButton.Size = UDim2.new(0, 90, 0, 30)
        followButton.Position = UDim2.new(0, 240, 0, 10)
        followButton.Text = "OFF"
        followButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        followButton.TextColor3 = Color3.new(1, 1, 1)
        followButton.Font = Enum.Font.SourceSansBold
        followButton.TextScaled = true

        -- Ô nhập tên player
        local nameBox = Instance.new("TextBox", HomeFrame)
        nameBox.Size = UDim2.new(0, 50, 0, 30)
        nameBox.Position = UDim2.new(0, 190, 0, 10)
        nameBox.PlaceholderText = "Enter player name"
        nameBox.Text = ""
        nameBox.TextScaled = true
        nameBox.Font = Enum.Font.SourceSans

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
            local lungeSpeed = 320
            local tpThreshold = 200
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

        local function findNearestTeleportPoint(targetPos)
            local myPos = player.Character:WaitForChild("HumanoidRootPart").Position
            local closestPoint, closestDist = nil, math.huge
            for _, tpPos in pairs(teleportPoints) do
                local dist = calculateDistance(tpPos, targetPos)
                if dist < closestDist then
                    closestPoint = tpPos
                    closestDist = dist
                end
            end
            return closestPoint, closestDist, calculateDistance(myPos, targetPos)
        end

        local function getHealthPercent()
            local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.MaxHealth > 0 then
                return hum.Health / hum.MaxHealth
            end
            return 1
        end

        local function followTarget()
            while followEnabled do
                if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local targetPos = targetPlayer.Character.HumanoidRootPart.Position
                    local myPos = player.Character:WaitForChild("HumanoidRootPart").Position

                    local dist = calculateDistance(myPos, targetPos)
                    if getHealthPercent() < 0.35 then
                        task.wait(0.1)
                        continue
                    end

                    local tpPos, tpToTargetDist, playerToTargetDist = findNearestTeleportPoint(targetPos)

                    if playerToTargetDist < tpToTargetDist then
                        performLunge(targetPos - (targetPos - myPos).Unit * 1)
                    else
                        teleportRepeatedly(tpPos, 1.5)
                        teleportRepeatedly(tpPos + Vector3.new(0, 100, 0), 0.3)
                        task.wait(0.1)
                        performLunge(targetPos - (targetPos - myPos).Unit * 1)
                    end
                end
                task.wait(0.01)
            end
        end

        followButton.MouseButton1Click:Connect(function()
            if not targetPlayer then return end
            followEnabled = not followEnabled
            followButton.Text = followEnabled and "ON" or "OFF"
            followButton.BackgroundColor3 = followEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 50, 50)

            if followEnabled then
                task.spawn(followTarget)
            end
        end)

        nameBox.FocusLost:Connect(function()
            local input = nameBox.Text:lower()
            if #input >= 3 then
                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= player and p.Name:lower():find(input) == 1 then
                        targetPlayer = p
                        break
                    end
                end
            end
        end)
    end

    wait(0.2)

    print("PVP tad SUCCESS✅")
end
