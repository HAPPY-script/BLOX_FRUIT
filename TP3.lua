return function(sections)
    local HomeFrame = sections["TP"]

--===========PORT=========================================================================================
do
    local btnCAFE = Instance.new("TextButton", HomeFrame)
    btnCAFE.Size = UDim2.new(0, 320, 0, 40)
    btnCAFE.Position = UDim2.new(0, 10, 0, 10)
    btnCAFE.Text = "PORT"
    btnCAFE.BackgroundColor3 = Color3.fromRGB(165, 42, 42)
    btnCAFE.TextColor3 = Color3.new(1, 1, 1)
    btnCAFE.Font = Enum.Font.SourceSansBold
    btnCAFE.TextSize = 20

    btnCAFE.MouseButton1Click:Connect(function()
        local url = "https://raw.githubusercontent.com/HAPPY-script/PORT/refs/heads/main/PORT"
        local success, result = pcall(function()
            return loadstring(game:HttpGet(url))()
        end)
        if not success then
            warn("[TP] Không thể chạy PORT:", result)
        end
    end)
end

--===========TREE=========================================================================================
do
    local btnDARK = Instance.new("TextButton", HomeFrame)
    btnDARK.Size = UDim2.new(0, 320, 0, 40)
    btnDARK.Position = UDim2.new(0, 10, 0, 60)
    btnDARK.Text = "TREE"
    btnDARK.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    btnDARK.TextColor3 = Color3.new(1, 1, 1)
    btnDARK.Font = Enum.Font.SourceSansBold
    btnDARK.TextSize = 20

    btnDARK.MouseButton1Click:Connect(function()
        local url = "https://raw.githubusercontent.com/HAPPY-script/TREE/refs/heads/main/TREE"
        local success, result = pcall(function()
            return loadstring(game:HttpGet(url))()
        end)
        if not success then
            warn("[TP] Không thể chạy TREE:", result)
        end
    end)
end

--===========CAKE=========================================================================================
do
    local btnFACTORY = Instance.new("TextButton", HomeFrame)
    btnFACTORY.Size = UDim2.new(0, 320, 0, 40)
    btnFACTORY.Position = UDim2.new(0, 10, 0, 110)
    btnFACTORY.Text = "CAKE"
    btnFACTORY.BackgroundColor3 = Color3.fromRGB(112, 128, 144)
    btnFACTORY.TextColor3 = Color3.new(1, 1, 1)
    btnFACTORY.Font = Enum.Font.SourceSansBold
    btnFACTORY.TextSize = 20

    btnFACTORY.MouseButton1Click:Connect(function()
        local url = "https://raw.githubusercontent.com/HAPPY-script/CAKE/refs/heads/main/CAKE"
        local success, result = pcall(function()
            return loadstring(game:HttpGet(url))()
        end)
        if not success then
            warn("[TP] Không thể chạy CAKE:", result)
        end
    end)
end

--===========ICE_CREAM=========================================================================================
do
    local btnFORGOTTEN = Instance.new("TextButton", HomeFrame)
    btnFORGOTTEN.Size = UDim2.new(0, 320, 0, 40)
    btnFORGOTTEN.Position = UDim2.new(0, 10, 0, 160)
    btnFORGOTTEN.Text = "ICE_CREAM"
    btnFORGOTTEN.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
    btnFORGOTTEN.TextColor3 = Color3.new(1, 1, 1)
    btnFORGOTTEN.Font = Enum.Font.SourceSansBold
    btnFORGOTTEN.TextSize = 20

    btnFORGOTTEN.MouseButton1Click:Connect(function()
        local url = "https://raw.githubusercontent.com/HAPPY-script/ICE_CREAM/refs/heads/main/ICE_CREAM"
        local success, result = pcall(function()
            return loadstring(game:HttpGet(url))()
        end)
        if not success then
            warn("[TP] Không thể chạy ICE_CREAM:", result)
        end
    end)
end

--===========CANDY=========================================================================================
do
    local btnGREEN = Instance.new("TextButton", HomeFrame)
    btnGREEN.Size = UDim2.new(0, 320, 0, 40)
    btnGREEN.Position = UDim2.new(0, 10, 0, 210)
    btnGREEN.Text = "CANDY"
    btnGREEN.BackgroundColor3 = Color3.fromRGB(34, 139, 34)
    btnGREEN.TextColor3 = Color3.new(1, 1, 1)
    btnGREEN.Font = Enum.Font.SourceSansBold
    btnGREEN.TextSize = 20

    btnGREEN.MouseButton1Click:Connect(function()
        local url = "https://raw.githubusercontent.com/HAPPY-script/CANDY/refs/heads/main/CANDY"
        local success, result = pcall(function()
            return loadstring(game:HttpGet(url))()
        end)
        if not success then
            warn("[TP] Không thể chạy CANDY:", result)
        end
    end)
end

--===========MANSION=========================================================================================
do
    local btn = Instance.new("TextButton", HomeFrame)
    btn.Size = UDim2.new(0, 320, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, 260)
    btn.Text = "MANSION"
    btn.BackgroundColor3 = Color3.fromRGB(255, 99, 71)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 20

    btn.MouseButton1Click:Connect(function()
        local url = "https://raw.githubusercontent.com/HAPPY-script/MANSION/refs/heads/main/MANSION"
        local success, result = pcall(function()
            return loadstring(game:HttpGet(url))()
        end)
        if not success then
            warn("Không thể chạy MANSION:", result)
        end
    end)
end

--===========DOJO=========================================================================================
do
    local btn = Instance.new("TextButton", HomeFrame)
    btn.Size = UDim2.new(0, 320, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, 310)
    btn.Text = "DOJO"
    btn.BackgroundColor3 = Color3.fromRGB(173, 216, 230)
    btn.TextColor3 = Color3.new(0, 0, 0)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 20

    btn.MouseButton1Click:Connect(function()
        local url = "https://raw.githubusercontent.com/HAPPY-script/DOJO/refs/heads/main/DOJO"
        local success, result = pcall(function()
            return loadstring(game:HttpGet(url))()
        end)
        if not success then
            warn("Không thể chạy DOJO:", result)
        end
    end)
end

--===========DARK_CASTLE=========================================================================================
do
    local btn = Instance.new("TextButton", HomeFrame)
    btn.Size = UDim2.new(0, 320, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, 360)
    btn.Text = "DARK_CASTLE"
    btn.BackgroundColor3 = Color3.fromRGB(0, 0, 128)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 20

    btn.MouseButton1Click:Connect(function()
        local url = "https://raw.githubusercontent.com/HAPPY-script/DARK_CASTLE/refs/heads/main/DARK_CASTLE"
        local success, result = pcall(function()
            return loadstring(game:HttpGet(url))()
        end)
        if not success then
            warn("Không thể chạy DARK_CASTLE:", result)
        end
    end)
end

--===========CASTLE=========================================================================================
do
    local btn = Instance.new("TextButton", HomeFrame)
    btn.Size = UDim2.new(0, 320, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, 410)
    btn.Text = "CASTLE"
    btn.BackgroundColor3 = Color3.fromRGB(139, 69, 19)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 20

    btn.MouseButton1Click:Connect(function()
        local url = "https://raw.githubusercontent.com/HAPPY-script/CASTLE/refs/heads/main/CASTLE"
        local success, result = pcall(function()
            return loadstring(game:HttpGet(url))()
        end)
        if not success then
            warn("Không thể chạy CASTLE:", result)
        end
    end)
end

--===========WOMEN=========================================================================================
do
    local btn = Instance.new("TextButton", HomeFrame)
    btn.Size = UDim2.new(0, 320, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, 460)
    btn.Text = "WOMEN"
    btn.BackgroundColor3 = Color3.fromRGB(255, 182, 193)
    btn.TextColor3 = Color3.new(0, 0, 0)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 20

    btn.MouseButton1Click:Connect(function()
        local url = "https://raw.githubusercontent.com/HAPPY-script/WOMEN/refs/heads/main/WOMEN"
        local success, result = pcall(function()
            return loadstring(game:HttpGet(url))()
        end)
        if not success then
            warn("Không thể chạy WOMEN:", result)
        end
    end)
end

--===========TIKI=========================================================================================
do
    local btn = Instance.new("TextButton", HomeFrame)
    btn.Size = UDim2.new(0, 320, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, 510)
    btn.Text = "TIKI"
    btn.BackgroundColor3 = Color3.fromRGB(34, 139, 34)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 20

    btn.MouseButton1Click:Connect(function()
        local url = "https://raw.githubusercontent.com/HAPPY-script/TIKI/refs/heads/main/TIKI"
        local success, result = pcall(function()
            return loadstring(game:HttpGet(url))()
        end)
        if not success then
            warn("Không thể chạy TIKI:", result)
        end
    end)
end

--===========ON_TREE=========================================================================================
do
    local btn = Instance.new("TextButton", HomeFrame)
    btn.Size = UDim2.new(0, 320, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, 560)
    btn.Text = "ON_TREE"
    btn.BackgroundColor3 = Color3.fromRGB(34, 139, 34)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 20

    btn.MouseButton1Click:Connect(function()
        local url = "https://raw.githubusercontent.com/HAPPY-script/ON_TREE/refs/heads/main/ON_TREE"
        local success, result = pcall(function()
            return loadstring(game:HttpGet(url))()
        end)
        if not success then
            warn("Không thể chạy ON_TREE:", result)
        end
    end)
end

--===========UNDERSEA=========================================================================================
    
do
    local btn = Instance.new("TextButton", HomeFrame)
    btn.Size = UDim2.new(0, 320, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, 610)
    btn.Text = "Unsersea"
    btn.BackgroundColor3 = Color3.fromRGB(0, 110, 255)
    btn.TextColor3 = Color3.new(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 20

    btn.MouseButton1Click:Connect(function()
        local url = "https://raw.githubusercontent.com/HAPPY-script/UNDERSEA/refs/heads/main/UNDERSEA"
        local success, result = pcall(function()
            return loadstring(game:HttpGet(url))()
        end)
        if not success then
            warn("Không thể chạy Undersea:", result)
        end
    end)
end

    wait(0.2)
    print("TP tad SUCCESS✅")
end
