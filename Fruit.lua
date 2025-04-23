local FEATURE_NAME = "Fruit tad"

local ok = pcall(function()

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
end

--=========DEBUG===========================================================
end)

if ok then
    print(FEATURE_NAME .. " SUCCESS✅")
end
