return function(sections)
    local HomeFrame = sections["TP"]

--===========CAFE=========================================================================================
do
    local btnCAFE = Instance.new("TextButton", HomeFrame)
    btnCAFE.Size = UDim2.new(0, 320, 0, 40)
    btnCAFE.Position = UDim2.new(0, 10, 0, 10)
    btnCAFE.Text = "CAFE"
    btnCAFE.BackgroundColor3 = Color3.fromRGB(165, 42, 42)
    btnCAFE.TextColor3 = Color3.new(1, 1, 1)
    btnCAFE.Font = Enum.Font.SourceSansBold
    btnCAFE.TextSize = 20

    btnCAFE.MouseButton1Click:Connect(function()
        local url = "https://raw.githubusercontent.com/HAPPY-script/CAFE/refs/heads/main/CAFE"
        local success, result = pcall(function()
            return loadstring(game:HttpGet(url))()
        end)
        if not success then
            warn("[TP] Không thể chạy CAFE:", result)
        end
    end)
end

--===========DARK=========================================================================================
do
    local btnDARK = Instance.new("TextButton", HomeFrame)
    btnDARK.Size = UDim2.new(0, 320, 0, 40)
    btnDARK.Position = UDim2.new(0, 10, 0, 60)
    btnDARK.Text = "DARK"
    btnDARK.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    btnDARK.TextColor3 = Color3.new(1, 1, 1)
    btnDARK.Font = Enum.Font.SourceSansBold
    btnDARK.TextSize = 20

    btnDARK.MouseButton1Click:Connect(function()
        local url = "https://raw.githubusercontent.com/HAPPY-script/DARK/refs/heads/main/DARK"
        local success, result = pcall(function()
            return loadstring(game:HttpGet(url))()
        end)
        if not success then
            warn("[TP] Không thể chạy DARK:", result)
        end
    end)
end

--===========FACTORY=========================================================================================
do
    local btnFACTORY = Instance.new("TextButton", HomeFrame)
    btnFACTORY.Size = UDim2.new(0, 320, 0, 40)
    btnFACTORY.Position = UDim2.new(0, 10, 0, 110)
    btnFACTORY.Text = "FACTORY"
    btnFACTORY.BackgroundColor3 = Color3.fromRGB(112, 128, 144)
    btnFACTORY.TextColor3 = Color3.new(1, 1, 1)
    btnFACTORY.Font = Enum.Font.SourceSansBold
    btnFACTORY.TextSize = 20

    btnFACTORY.MouseButton1Click:Connect(function()
        local url = "https://raw.githubusercontent.com/HAPPY-script/FACTORY/refs/heads/main/FACTORY"
        local success, result = pcall(function()
            return loadstring(game:HttpGet(url))()
        end)
        if not success then
            warn("[TP] Không thể chạy FACTORY:", result)
        end
    end)
end

--===========FORGOTTEN=========================================================================================
do
    local btnFORGOTTEN = Instance.new("TextButton", HomeFrame)
    btnFORGOTTEN.Size = UDim2.new(0, 320, 0, 40)
    btnFORGOTTEN.Position = UDim2.new(0, 10, 0, 160)
    btnFORGOTTEN.Text = "FORGOTTEN"
    btnFORGOTTEN.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
    btnFORGOTTEN.TextColor3 = Color3.new(1, 1, 1)
    btnFORGOTTEN.Font = Enum.Font.SourceSansBold
    btnFORGOTTEN.TextSize = 20

    btnFORGOTTEN.MouseButton1Click:Connect(function()
        local url = "https://raw.githubusercontent.com/HAPPY-script/FORGOTTEN/refs/heads/main/FORGOTTEN"
        local success, result = pcall(function()
            return loadstring(game:HttpGet(url))()
        end)
        if not success then
            warn("[TP] Không thể chạy FORGOTTEN:", result)
        end
    end)
end

--===========GREEN_ZONE=========================================================================================
do
    local btnGREEN = Instance.new("TextButton", HomeFrame)
    btnGREEN.Size = UDim2.new(0, 320, 0, 40)
    btnGREEN.Position = UDim2.new(0, 10, 0, 210)
    btnGREEN.Text = "GREEN_ZONE"
    btnGREEN.BackgroundColor3 = Color3.fromRGB(34, 139, 34)
    btnGREEN.TextColor3 = Color3.new(1, 1, 1)
    btnGREEN.Font = Enum.Font.SourceSansBold
    btnGREEN.TextSize = 20

    btnGREEN.MouseButton1Click:Connect(function()
        local url = "https://raw.githubusercontent.com/HAPPY-script/GREEN_ZONE/refs/heads/main/GREEN_ZONE"
        local success, result = pcall(function()
            return loadstring(game:HttpGet(url))()
        end)
        if not success then
            warn("[TP] Không thể chạy GREEN_ZONE:", result)
        end
    end)
end

--===========HOT_COLD=========================================================================================
do
    local btn = Instance.new("TextButton", HomeFrame)
    btn.Size = UDim2.new(0, 320, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, 260)
    btn.Text = "HOT_COLD"
    btn.BackgroundColor3 = Color3.fromRGB(255, 99, 71)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 20

    btn.MouseButton1Click:Connect(function()
        local url = "https://raw.githubusercontent.com/HAPPY-script/HOT_COLD/refs/heads/main/HOT_COLD"
        local success, result = pcall(function()
            return loadstring(game:HttpGet(url))()
        end)
        if not success then
            warn("Không thể chạy HOT_COLD:", result)
        end
    end)
end

--===========ICE_CASTLE=========================================================================================
do
    local btn = Instance.new("TextButton", HomeFrame)
    btn.Size = UDim2.new(0, 320, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, 310)
    btn.Text = "ICE_CASTLE"
    btn.BackgroundColor3 = Color3.fromRGB(173, 216, 230)
    btn.TextColor3 = Color3.new(0, 0, 0)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 20

    btn.MouseButton1Click:Connect(function()
        local url = "https://raw.githubusercontent.com/HAPPY-script/ICE_CASTLE/refs/heads/main/ICE_CASTLE"
        local success, result = pcall(function()
            return loadstring(game:HttpGet(url))()
        end)
        if not success then
            warn("Không thể chạy ICE_CASTLE:", result)
        end
    end)
end

--===========SHIP=========================================================================================
do
    local btn = Instance.new("TextButton", HomeFrame)
    btn.Size = UDim2.new(0, 320, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, 360)
    btn.Text = "SHIP"
    btn.BackgroundColor3 = Color3.fromRGB(0, 0, 128)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 20

    btn.MouseButton1Click:Connect(function()
        local url = "https://raw.githubusercontent.com/HAPPY-script/SHIP/refs/heads/main/SHIP"
        local success, result = pcall(function()
            return loadstring(game:HttpGet(url))()
        end)
        if not success then
            warn("Không thể chạy SHIP:", result)
        end
    end)
end

--===========MOUNTAIN=========================================================================================
do
    local btn = Instance.new("TextButton", HomeFrame)
    btn.Size = UDim2.new(0, 320, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, 410)
    btn.Text = "MOUNTAIN"
    btn.BackgroundColor3 = Color3.fromRGB(139, 69, 19)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 20

    btn.MouseButton1Click:Connect(function()
        local url = "https://raw.githubusercontent.com/HAPPY-script/MOUNTAIN/refs/heads/main/MOUNTAIN"
        local success, result = pcall(function()
            return loadstring(game:HttpGet(url))()
        end)
        if not success then
            warn("Không thể chạy MOUNTAIN:", result)
        end
    end)
end

--===========SWAN=========================================================================================
do
    local btn = Instance.new("TextButton", HomeFrame)
    btn.Size = UDim2.new(0, 320, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, 510)
    btn.Text = "SWAN"
    btn.BackgroundColor3 = Color3.fromRGB(255, 182, 193)
    btn.TextColor3 = Color3.new(0, 0, 0)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 20

    btn.MouseButton1Click:Connect(function()
        local url = "https://raw.githubusercontent.com/HAPPY-script/SWAN/refs/heads/main/SWAN"
        local success, result = pcall(function()
            return loadstring(game:HttpGet(url))()
        end)
        if not success then
            warn("Không thể chạy SWAN:", result)
        end
    end)
end

--===========ZOMBIE=========================================================================================
do
    local btn = Instance.new("TextButton", HomeFrame)
    btn.Size = UDim2.new(0, 320, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, 560)
    btn.Text = "ZOMBIE"
    btn.BackgroundColor3 = Color3.fromRGB(34, 139, 34)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 20

    btn.MouseButton1Click:Connect(function()
        local url = "https://raw.githubusercontent.com/HAPPY-script/ZOMBIE/refs/heads/main/ZOMBIE"
        local success, result = pcall(function()
            return loadstring(game:HttpGet(url))()
        end)
        if not success then
            warn("Không thể chạy ZOMBIE:", result)
        end
    end)
end

    wait(0.2)
    print("TP tad SUCCESS✅")
end
