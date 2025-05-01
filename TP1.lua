return function(sections)

    local HomeFrame = sections["TP"]

    --===========SEA=========================================================================================
    do
        -- Tạo nút "SEA" trong HomeFrame
        local btnSEA = Instance.new("TextButton", HomeFrame)
        btnSEA.Size = UDim2.new(0, 320, 0, 40)
        btnSEA.Position = UDim2.new(0, 10, 0, 10) -- Vị trí có thể thay đổi nếu cần
        btnSEA.Text = "SEA"
        btnSEA.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        btnSEA.TextColor3 = Color3.new(1, 1, 1)
        btnSEA.Font = Enum.Font.SourceSansBold
        btnSEA.TextSize = 20

        btnSEA.MouseButton1Click:Connect(function()
            local url = "https://raw.githubusercontent.com/HAPPY-script/SEA/refs/heads/main/SEA"
            local success, result = pcall(function()
                return loadstring(game:HttpGet(url))()
            end)
            if not success then
                warn("[TP] Không thể chạy SEA:", result)
            end
        end)
    end

    --===========PIRATE=========================================================================================
    do
        -- Tạo nút "PIRATE" trong HomeFrame
        local btnPIRATE = Instance.new("TextButton", HomeFrame)
        btnPIRATE.Size = UDim2.new(0, 320, 0, 40)
        btnPIRATE.Position = UDim2.new(0, 10, 0, 60) -- Cách SEA 100px theo chiều ngang
        btnPIRATE.Text = "PIRATE"
        btnPIRATE.BackgroundColor3 = Color3.fromRGB(255, 85, 0)
        btnPIRATE.TextColor3 = Color3.new(1, 1, 1)
        btnPIRATE.Font = Enum.Font.SourceSansBold
        btnPIRATE.TextSize = 20

        btnPIRATE.MouseButton1Click:Connect(function()
            local url = "https://raw.githubusercontent.com/HAPPY-script/PIRATE/refs/heads/main/PIRATE"
            local success, result = pcall(function()
                return loadstring(game:HttpGet(url))()
            end)
            if not success then
                warn("[TP] Không thể chạy PIRATE:", result)
            end
        end)
    end

    --===========FOUNTAIN=========================================================================================
    do
        -- Tạo nút "FOUNTAIN" trong HomeFrame
        local btnFOUNTAIN = Instance.new("TextButton", HomeFrame)
        btnFOUNTAIN.Size = UDim2.new(0, 320, 0, 40)
        btnFOUNTAIN.Position = UDim2.new(0, 10, 0, 110) -- Đặt nút đầu tiên ở vị trí đầu tiên
        btnFOUNTAIN.Text = "FOUNTAIN"
        btnFOUNTAIN.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        btnFOUNTAIN.TextColor3 = Color3.new(1, 1, 1)
        btnFOUNTAIN.Font = Enum.Font.SourceSansBold
        btnFOUNTAIN.TextSize = 20

        btnFOUNTAIN.MouseButton1Click:Connect(function()
            local url = "https://raw.githubusercontent.com/HAPPY-script/FOUNTAIN/refs/heads/main/FOUNTAIN"
            local success, result = pcall(function()
                return loadstring(game:HttpGet(url))()
            end)
            if not success then
                warn("[TP] Không thể chạy FOUNTAIN:", result)
            end
        end)
    end

    --===========SKY=========================================================================================
    do
        -- Tạo nút "SKY" trong HomeFrame
        local btnSKY = Instance.new("TextButton", HomeFrame)
        btnSKY.Size = UDim2.new(0, 320, 0, 40)
        btnSKY.Position = UDim2.new(0, 10, 0, 160) -- Đặt nút này cách nút FOUNTAIN 40px theo chiều dọc
        btnSKY.Text = "SKY"
        btnSKY.BackgroundColor3 = Color3.fromRGB(135, 206, 235)
        btnSKY.TextColor3 = Color3.new(1, 1, 1)
        btnSKY.Font = Enum.Font.SourceSansBold
        btnSKY.TextSize = 20

        btnSKY.MouseButton1Click:Connect(function()
            local url = "https://raw.githubusercontent.com/HAPPY-script/SKY/refs/heads/main/SKY"
            local success, result = pcall(function()
                return loadstring(game:HttpGet(url))()
            end)
            if not success then
                warn("[TP] Không thể chạy SKY:", result)
            end
        end)
    end

    --===========ARENA=========================================================================================
    do
        -- Tạo nút "ARENA" trong HomeFrame
        local btnARENA = Instance.new("TextButton", HomeFrame)
        btnARENA.Size = UDim2.new(0, 320, 0, 40)
        btnARENA.Position = UDim2.new(0, 10, 0, 210) -- Đặt nút này cách nút SKY 40px theo chiều dọc
        btnARENA.Text = "ARENA"
        btnARENA.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
        btnARENA.TextColor3 = Color3.new(1, 1, 1)
        btnARENA.Font = Enum.Font.SourceSansBold
        btnARENA.TextSize = 20

        btnARENA.MouseButton1Click:Connect(function()
            local url = "https://raw.githubusercontent.com/HAPPY-script/ARENA/refs/heads/main/ARENA"
            local success, result = pcall(function()
                return loadstring(game:HttpGet(url))()
            end)
            if not success then
                warn("[TP] Không thể chạy ARENA:", result)
            end
        end)
    end

    --===========MIRANE=========================================================================================
    do
        -- Tạo nút "MIRANE" trong HomeFrame
        local btnMIRANE = Instance.new("TextButton", HomeFrame)
        btnMIRANE.Size = UDim2.new(0, 320, 0, 40)
        btnMIRANE.Position = UDim2.new(0, 10, 0, 260) -- Đặt nút này cách nút ARENA 40px theo chiều dọc
        btnMIRANE.Text = "MIRANE"
        btnMIRANE.BackgroundColor3 = Color3.fromRGB(255, 99, 71)
        btnMIRANE.TextColor3 = Color3.new(1, 1, 1)
        btnMIRANE.Font = Enum.Font.SourceSansBold
        btnMIRANE.TextSize = 20

        btnMIRANE.MouseButton1Click:Connect(function()
            local url = "https://raw.githubusercontent.com/HAPPY-script/MIRANE/refs/heads/main/MIRANE"
            local success, result = pcall(function()
                return loadstring(game:HttpGet(url))()
            end)
            if not success then
                warn("[TP] Không thể chạy MIRANE:", result)
            end
        end)
    end

    --===========MONKEY=========================================================================================
    do
        -- Tạo nút "MONKEY" trong HomeFrame
        local btnMONKEY = Instance.new("TextButton", HomeFrame)
        btnMONKEY.Size = UDim2.new(0, 320, 0, 40)
        btnMONKEY.Position = UDim2.new(0, 10, 0, 310) -- Vị trí của nút MONKEY
        btnMONKEY.Text = "MONKEY"
        btnMONKEY.BackgroundColor3 = Color3.fromRGB(255, 223, 0)
        btnMONKEY.TextColor3 = Color3.new(1, 1, 1)
        btnMONKEY.Font = Enum.Font.SourceSansBold
        btnMONKEY.TextSize = 20

        btnMONKEY.MouseButton1Click:Connect(function()
            local url = "https://raw.githubusercontent.com/HAPPY-script/MONKEY/refs/heads/main/MONKEY"
            local success, result = pcall(function()
                return loadstring(game:HttpGet(url))()
            end)
            if not success then
                warn("[TP] Không thể chạy MONKEY:", result)
            end
        end)
    end

    --===========VILLAGE=========================================================================================
    do
        -- Tạo nút "VILLAGE" trong HomeFrame
        local btnVILLAGE = Instance.new("TextButton", HomeFrame)
        btnVILLAGE.Size = UDim2.new(0, 320, 0, 40)
        btnVILLAGE.Position = UDim2.new(0, 10, 0, 360) -- Vị trí của nút VILLAGE
        btnVILLAGE.Text = "VILLAGE"
        btnVILLAGE.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
        btnVILLAGE.TextColor3 = Color3.new(1, 1, 1)
        btnVILLAGE.Font = Enum.Font.SourceSansBold
        btnVILLAGE.TextSize = 20

        btnVILLAGE.MouseButton1Click:Connect(function()
            local url = "https://raw.githubusercontent.com/HAPPY-script/VILLAGE/refs/heads/main/VILLAGE"
            local success, result = pcall(function()
                return loadstring(game:HttpGet(url))()
            end)
            if not success then
                warn("[TP] Không thể chạy VILLAGE:", result)
            end
        end)
    end

    --===========PRISON=========================================================================================
    do
        -- Tạo nút "PRISON" trong HomeFrame
        local btnPRISON = Instance.new("TextButton", HomeFrame)
        btnPRISON.Size = UDim2.new(0, 320, 0, 40)
        btnPRISON.Position = UDim2.new(0, 10, 0, 410) -- Vị trí của nút PRISON
        btnPRISON.Text = "PRISON"
        btnPRISON.BackgroundColor3 = Color3.fromRGB(255, 99, 71)
        btnPRISON.TextColor3 = Color3.new(1, 1, 1)
        btnPRISON.Font = Enum.Font.SourceSansBold
        btnPRISON.TextSize = 20

        btnPRISON.MouseButton1Click:Connect(function()
            local url = "https://raw.githubusercontent.com/HAPPY-script/PRISON/refs/heads/main/PRISON"
            local success, result = pcall(function()
                return loadstring(game:HttpGet(url))()
            end)
            if not success then
                warn("[TP] Không thể chạy PRISON:", result)
            end
        end)
    end

    --===========VOLCANO=========================================================================================
    do
        -- Tạo nút "VOLCANO" trong HomeFrame
        local btnVOLCANO = Instance.new("TextButton", HomeFrame)
        btnVOLCANO.Size = UDim2.new(0, 320, 0, 40)
        btnVOLCANO.Position = UDim2.new(0, 10, 0, 460) -- Vị trí của nút VOLCANO
        btnVOLCANO.Text = "VOLCANO"
        btnVOLCANO.BackgroundColor3 = Color3.fromRGB(255, 69, 0)
        btnVOLCANO.TextColor3 = Color3.new(1, 1, 1)
        btnVOLCANO.Font = Enum.Font.SourceSansBold
        btnVOLCANO.TextSize = 20

        btnVOLCANO.MouseButton1Click:Connect(function()
            local url = "https://raw.githubusercontent.com/HAPPY-script/VOLCANO/refs/heads/main/VOLCANO"
            local success, result = pcall(function()
                return loadstring(game:HttpGet(url))()
            end)
            if not success then
                warn("[TP] Không thể chạy VOLCANO:", result)
            end
        end)
    end

    --===========FORTRESS=========================================================================================
    do
        -- Tạo nút "FORTRESS" trong HomeFrame
        local btnFORTRESS = Instance.new("TextButton", HomeFrame)
        btnFORTRESS.Size = UDim2.new(0, 320, 0, 40)
        btnFORTRESS.Position = UDim2.new(0, 10, 0, 510) -- Vị trí của nút FORTRESS
        btnFORTRESS.Text = "FORTRESS"
        btnFORTRESS.BackgroundColor3 = Color3.fromRGB(128, 0, 128)
        btnFORTRESS.TextColor3 = Color3.new(1, 1, 1)
        btnFORTRESS.Font = Enum.Font.SourceSansBold
        btnFORTRESS.TextSize = 20

        btnFORTRESS.MouseButton1Click:Connect(function()
            local url = "https://raw.githubusercontent.com/HAPPY-script/FORTRESS/refs/heads/main/FORTRESS"
            local success, result = pcall(function()
                return loadstring(game:HttpGet(url))()
            end)
            if not success then
                warn("[TP] Không thể chạy FORTRESS:", result)
            end
        end)
    end

    --===========DESERT=========================================================================================
    do
        -- Tạo nút "DESERT" trong HomeFrame
        local btnDESERT = Instance.new("TextButton", HomeFrame)
        btnDESERT.Size = UDim2.new(0, 320, 0, 40)
        btnDESERT.Position = UDim2.new(0, 10, 0, 560) -- Vị trí của nút DESERT
        btnDESERT.Text = "DESERT"
        btnDESERT.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
        btnDESERT.TextColor3 = Color3.new(1, 1, 1)
        btnDESERT.Font = Enum.Font.SourceSansBold
        btnDESERT.TextSize = 20

        btnDESERT.MouseButton1Click:Connect(function()
            local url = "https://raw.githubusercontent.com/HAPPY-script/DESERT/refs/heads/main/DESERT"
            local success, result = pcall(function()
                return loadstring(game:HttpGet(url))()
            end)
            if not success then
                warn("[TP] Không thể chạy DESERT:", result)
            end
        end)
    end

    --===========TOWN=========================================================================================
    do
        -- Tạo nút "TOWN" trong HomeFrame
        local btnTOWN = Instance.new("TextButton", HomeFrame)
        btnTOWN.Size = UDim2.new(0, 90, 0, 40)
        btnTOWN.Position = UDim2.new(0, 10, 0, 610) -- Vị trí của nút TOWN
        btnTOWN.Text = "TOWN"
        btnTOWN.BackgroundColor3 = Color3.fromRGB(0, 128, 0)
        btnTOWN.TextColor3 = Color3.new(1, 1, 1)
        btnTOWN.Font = Enum.Font.SourceSansBold
        btnTOWN.TextSize = 20

        btnTOWN.MouseButton1Click:Connect(function()
            local url = "https://raw.githubusercontent.com/HAPPY-script/TOWN/refs/heads/main/TOWN"
            local success, result = pcall(function()
                return loadstring(game:HttpGet(url))()
            end)
            if not success then
                warn("[TP] Không thể chạy TOWN:", result)
            end
        end)
    end

    --===========ON_SKY=========================================================================================
    do
        -- Tạo nút "ON_SKY" trong HomeFrame
        local btnON_SKY = Instance.new("TextButton", HomeFrame)
        btnON_SKY.Size = UDim2.new(0, 90, 0, 40)
        btnON_SKY.Position = UDim2.new(0, 10, 0, 660) -- Vị trí của nút ON_SKY
        btnON_SKY.Text = "ON_SKY"
        btnON_SKY.BackgroundColor3 = Color3.fromRGB(135, 206, 235)
        btnON_SKY.TextColor3 = Color3.new(1, 1, 1)
        btnON_SKY.Font = Enum.Font.SourceSansBold
        btnON_SKY.TextSize = 20

        btnON_SKY.MouseButton1Click:Connect(function()
            local url = "https://raw.githubusercontent.com/HAPPY-script/ON_SKY/refs/heads/main/ON_SKY"
            local success, result = pcall(function()
                return loadstring(game:HttpGet(url))()
            end)
            if not success then
                warn("[TP] Không thể chạy ON_SKY:", result)
            end
        end)
    end

    --===========SNOW=========================================================================================
    do
        -- Tạo nút "SNOW" trong HomeFrame
        local btnSNOW = Instance.new("TextButton", HomeFrame)
        btnSNOW.Size = UDim2.new(0, 90, 0, 40)
        btnSNOW.Position = UDim2.new(0, 10, 0, 710) -- Vị trí của nút SNOW
        btnSNOW.Text = "SNOW"
        btnSNOW.BackgroundColor3 = Color3.fromRGB(255, 250, 250)
        btnSNOW.TextColor3 = Color3.new(1, 1, 1)
        btnSNOW.Font = Enum.Font.SourceSansBold
        btnSNOW.TextSize = 20

        btnSNOW.MouseButton1Click:Connect(function()
            local url = "https://raw.githubusercontent.com/HAPPY-script/SNOW/refs/heads/main/SNOW"
            local success, result = pcall(function()
                return loadstring(game:HttpGet(url))()
            end)
            if not success then
                warn("[TP] Không thể chạy SNOW:", result)
            end
        end)
    end

    wait(0.2)
    print("TP tad SUCCESS✅")
end
