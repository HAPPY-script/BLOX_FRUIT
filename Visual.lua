return function(sections)
    local HomeFrame = sections["Visual"]
 
        --ESP player---------------------------------------------------------------------------------------------
    do
        local player = game.Players.LocalPlayer
        local camera = workspace.CurrentCamera
        local espEnabled = false
        local espObjects = {}

        -- Nút ESP
        local espButton = Instance.new("TextButton", HomeFrame)
        espButton.Size = UDim2.new(0, 90, 0, 30)
        espButton.Position = UDim2.new(0, 240, 0, 10)
        espButton.Text = "OFF"
        espButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        espButton.TextColor3 = Color3.new(1, 1, 1)
        espButton.Font = Enum.Font.SourceSansBold
        espButton.TextScaled = true

        -- Tạo ESP
        local function createESP(playerObj)
            if playerObj.Character and playerObj.Character:FindFirstChild("HumanoidRootPart") then
                local char = playerObj.Character

                -- Highlight
                local highlight = Instance.new("Highlight")
                highlight.Adornee = char
                highlight.FillColor = Color3.fromRGB(255, 191, 0) -- Vàng cam
                highlight.OutlineColor = Color3.fromRGB(255, 191, 0)
                highlight.FillTransparency = 1
                highlight.OutlineTransparency = 0
                highlight.Parent = char

                -- Billboard
                local billboard = Instance.new("BillboardGui")
                billboard.Adornee = char:FindFirstChild("HumanoidRootPart")
                billboard.Size = UDim2.new(0, 150, 0, 50)
                billboard.StudsOffset = Vector3.new(0, 3, 0)
                billboard.AlwaysOnTop = true
                billboard.Name = "ESP_Billboard"
                billboard.Parent = char

                local text = Instance.new("TextLabel")
                text.Size = UDim2.new(1, 0, 1, 0)
                text.BackgroundTransparency = 1
                text.TextColor3 = Color3.fromRGB(255, 191, 0)
                text.Font = Enum.Font.SourceSansBold
                text.TextScaled = true
                text.Text = ""
                text.Parent = billboard

                local updateConn
                updateConn = game:GetService("RunService").RenderStepped:Connect(function()
                    if not char or not char:FindFirstChild("Humanoid") or not char:FindFirstChild("HumanoidRootPart") then
                        updateConn:Disconnect()
                        return
                    end

                    local hp = math.floor(char.Humanoid.Health)
                    local distance = math.floor((camera.CFrame.Position - char.HumanoidRootPart.Position).Magnitude)
                    text.Text = string.format("%s\nHP: %d | %dm", playerObj.Name, hp, distance)
                end)

                table.insert(espObjects, {highlight, billboard, updateConn})
            end
        end

        -- Bật/tắt toàn bộ ESP
        local function toggleESP(state)
            if state then
                for _, plr in pairs(game.Players:GetPlayers()) do
                    if plr ~= player then
                        createESP(plr)
                    end
                end

                game.Players.PlayerAdded:Connect(function(newPlr)
                    newPlr.CharacterAdded:Connect(function()
                        task.wait(1)
                        if espEnabled then
                            createESP(newPlr)
                        end
                    end)
                end)

            else
                for _, data in pairs(espObjects) do
                    for _, obj in pairs(data) do
                        if typeof(obj) == "Instance" and obj:IsDescendantOf(game) then
                            obj:Destroy()
                        elseif typeof(obj) == "RBXScriptConnection" then
                            obj:Disconnect()
                        end
                    end
                end
                espObjects = {}
            end
        end

        -- Nút ON/OFF
        espButton.MouseButton1Click:Connect(function()
            espEnabled = not espEnabled
            espButton.Text = espEnabled and "ON" or "OFF"
            espButton.BackgroundColor3 = espEnabled and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
            toggleESP(espEnabled)
        end)
    end

        --ESP NPC---------------------------------------------------------------------------------------------
    do
        local player = game.Players.LocalPlayer
        local camera = workspace.CurrentCamera
        local espEnabled = false
        local espObjects = {}

        -- Nút ESP
        local espButton = Instance.new("TextButton", HomeFrame)
        espButton.Size = UDim2.new(0, 90, 0, 30)
        espButton.Position = UDim2.new(0, 240, 0, 60)
        espButton.Text = "OFF"
        espButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        espButton.TextColor3 = Color3.new(1, 1, 1)
        espButton.Font = Enum.Font.SourceSansBold
        espButton.TextScaled = true

        -- Tạo ESP
        local function createESP(model)
            if not model:IsA("Model") or not model:FindFirstChild("HumanoidRootPart") then return end

            -- Highlight
            local highlight = Instance.new("Highlight")
            highlight.Adornee = model
            highlight.FillColor = Color3.fromRGB(255, 0, 0) -- Vàng cam
            highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
            highlight.FillTransparency = 1
            highlight.OutlineTransparency = 0
            highlight.Parent = model

            -- Billboard
            local billboard = Instance.new("BillboardGui")
            billboard.Adornee = model:FindFirstChild("HumanoidRootPart")
            billboard.Size = UDim2.new(0, 150, 0, 50)
            billboard.StudsOffset = Vector3.new(0, 3, 0)
            billboard.AlwaysOnTop = true
            billboard.Name = "ESP_Billboard"
            billboard.Parent = model

            local text = Instance.new("TextLabel")
            text.Size = UDim2.new(1, 0, 1, 0)
            text.BackgroundTransparency = 1
            text.TextColor3 = Color3.fromRGB(255, 0, 0)
            text.Font = Enum.Font.SourceSansBold
            text.TextScaled = true
            text.Text = ""
            text.Parent = billboard

            local updateConn
            updateConn = game:GetService("RunService").RenderStepped:Connect(function()
                if not model or not model.Parent or not model:FindFirstChild("HumanoidRootPart") then
                    updateConn:Disconnect()
                    return
                end

                local distance = math.floor((camera.CFrame.Position - model.HumanoidRootPart.Position).Magnitude)
                local hpText = ""

                if model:FindFirstChild("Humanoid") then
                    local hp = math.floor(model.Humanoid.Health)
                    hpText = " | HP: " .. hp
                end

                text.Text = model.Name .. "\n" .. "Dist: " .. distance .. "m" .. hpText
            end)

            table.insert(espObjects, {highlight, billboard, updateConn})
        end

        -- Bật/tắt toàn bộ ESP
        local function toggleESP(state)
            if state then
                local enemies = workspace:FindFirstChild("Enemies")
                if enemies then
                    for _, model in pairs(enemies:GetChildren()) do
                        createESP(model)
                    end

                    enemies.ChildAdded:Connect(function(child)
                        task.wait(0.5)
                        if espEnabled then
                            createESP(child)
                        end
                    end)
                end
            else
                for _, data in pairs(espObjects) do
                    for _, obj in pairs(data) do
                        if typeof(obj) == "Instance" and obj:IsDescendantOf(game) then
                            obj:Destroy()
                        elseif typeof(obj) == "RBXScriptConnection" then
                            obj:Disconnect()
                        end
                    end
                end
                espObjects = {}
            end
        end

        -- Nút ON/OFF
        espButton.MouseButton1Click:Connect(function()
            espEnabled = not espEnabled
            espButton.Text = espEnabled and "ON" or "OFF"
            espButton.BackgroundColor3 = espEnabled and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
            toggleESP(espEnabled)
        end)
    end

        --LIGHT------------------------------------------------------------------------------------------
    do
        local lighting = game:GetService("Lighting")

        local lightEnabled = false

        -- Tạo nút Light
        local lightButton = Instance.new("TextButton", HomeFrame)
        lightButton.Size = UDim2.new(0, 90, 0, 30)
        lightButton.Position = UDim2.new(0, 240, 0, 110)
        lightButton.Text = "OFF"
        lightButton.Font = Enum.Font.SourceSansBold
        lightButton.TextScaled = true
        lightButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        lightButton.TextColor3 = Color3.new(1, 1, 1)

        -- Bật/tắt ánh sáng
        local function toggleLight(state)
            if state then
                lighting.Brightness = 3
                lighting.Ambient = Color3.new(1, 1, 1)
                lighting.OutdoorAmbient = Color3.new(1, 1, 1)
                lighting.GlobalShadows = false
            else
                lighting.Brightness = 1
                lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
                lighting.OutdoorAmbient = Color3.new(0.5, 0.5, 0.5)
                lighting.GlobalShadows = true
            end
        end

        -- Nút ON/OFF
        lightButton.MouseButton1Click:Connect(function()
            lightEnabled = not lightEnabled
            lightButton.Text = lightEnabled and "ON" or "OFF"
            lightButton.BackgroundColor3 = lightEnabled and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
            toggleLight(lightEnabled)
        end)
    end
end

wait(1)

print(Visual tad SUCCESS✅)
