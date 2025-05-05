return function(sections)
    local HomeFrame = sections["Shop"]
        --========Buy Cyborg===============================================================================================
    do
        local btnBuyCyborg = Instance.new("TextButton", HomeFrame)
        btnBuyCyborg.Size  = UDim2.new(0, 320, 0, 40)
        btnBuyCyborg.Position = UDim2.new(0, 10, 0, 10)
        btnBuyCyborg.Text  = "🤖 Buy Cyborg Race"
        btnBuyCyborg.BackgroundColor3 = Color3.fromRGB(179, 0, 255)
        btnBuyCyborg.TextColor3 = Color3.new(255, 255, 255)
        btnBuyCyborg.Font = Enum.Font.SourceSansBold
        btnBuyCyborg.TextSize = 20

        btnBuyCyborg.MouseButton1Click:Connect(function()
            local args = {
                "CyborgTrainer",
                "Buy"
            }

            local success, err = pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
            end)

            if not success then
                warn("❌ Không thể mua Cyborg Race: " .. tostring(err))
            end
        end)
    end

        --========BUY MELEE===============================================================================================
    do
        --BuyGodhuman
        local imageId = "113997301355836"

        -- Tạo ImageButton
        local buyButton = Instance.new("ImageButton")
        buyButton.Size = UDim2.new(0, 80, 0, 80)
        buyButton.Position = UDim2.new(0, 230, 0, 160)
        buyButton.Image = "rbxthumb://type=Asset&id=" .. imageId .. "&w=420&h=420"
        buyButton.BackgroundTransparency = 1
        buyButton.Parent = HomeFrame

        -- Khi bấm vào thì gọi mua Godhuman
        buyButton.MouseButton1Click:Connect(function()
        	local args = {
        		"BuyGodhuman"
        	}
        	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
        end)

        --BuyElectricClaw
        local imageId = "12133078008"

        -- Tạo ImageButton
        local buyButton = Instance.new("ImageButton")
        buyButton.Size = UDim2.new(0, 80, 0, 80)
        buyButton.Position = UDim2.new(0, 130, 0, 160)
        buyButton.Image = "rbxthumb://type=Asset&id=" .. imageId .. "&w=420&h=420"
        buyButton.BackgroundTransparency = 1
        buyButton.Parent = HomeFrame

        -- Khi bấm vào thì gọi mua Godhuman
        buyButton.MouseButton1Click:Connect(function()
        	local args = {
        		"BuyElectricClaw"
        	}
        	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
        end)

        --BuySanguineArt
        local imageId = "15355555932"

        -- Tạo ImageButton
        local buyButton = Instance.new("ImageButton")
        buyButton.Size = UDim2.new(0, 80, 0, 80)
        buyButton.Position = UDim2.new(0, 30, 0, 160)
        buyButton.Image = "rbxthumb://type=Asset&id=" .. imageId .. "&w=420&h=420"
        buyButton.BackgroundTransparency = 1
        buyButton.Parent = HomeFrame

        -- Khi bấm vào thì gọi mua Godhuman
        buyButton.MouseButton1Click:Connect(function()
        	local args = {
        		"BuySanguineArt"
        	}
        	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
        end)

        --BuyDragonTalon
        local imageId = "18522661682"

        -- Tạo ImageButton
        local buyButton = Instance.new("ImageButton")
        buyButton.Size = UDim2.new(0, 80, 0, 80)
        buyButton.Position = UDim2.new(0, 230, 0, 250)
        buyButton.Image = "rbxthumb://type=Asset&id=" .. imageId .. "&w=420&h=420"
        buyButton.BackgroundTransparency = 1
        buyButton.Parent = HomeFrame

        -- Khi bấm vào thì gọi mua Godhuman
        buyButton.MouseButton1Click:Connect(function()
        	local args = {
        		"BuyDragonTalon"
        	}
        	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
        end)

        --BuySharkmanKarate
        local imageId = "91137517991866"

        -- Tạo ImageButton
        local buyButton = Instance.new("ImageButton")
        buyButton.Size = UDim2.new(0, 80, 0, 80)
        buyButton.Position = UDim2.new(0, 130, 0, 250)
        buyButton.Image = "rbxthumb://type=Asset&id=" .. imageId .. "&w=420&h=420"
        buyButton.BackgroundTransparency = 1
        buyButton.Parent = HomeFrame

        -- Khi bấm vào thì gọi mua Godhuman
        buyButton.MouseButton1Click:Connect(function()
        	local args = {
        		"BuySharkmanKarate"
        	}
        	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
        end)

        --BuyDeathStep
        local imageId = "89281841390007"

        -- Tạo ImageButton
        local buyButton = Instance.new("ImageButton")
        buyButton.Size = UDim2.new(0, 80, 0, 80)
        buyButton.Position = UDim2.new(0, 30, 0, 250)
        buyButton.Image = "rbxthumb://type=Asset&id=" .. imageId .. "&w=420&h=420"
        buyButton.BackgroundTransparency = 1
        buyButton.Parent = HomeFrame

        -- Khi bấm vào thì gọi mua Godhuman
        buyButton.MouseButton1Click:Connect(function()
        	local args = {
        		"BuyDeathStep"
        	}
        	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
        end)

        --BuySuperhuman
        local imageId = "105999391562192"

        -- Tạo ImageButton
        local buyButton = Instance.new("ImageButton")
        buyButton.Size = UDim2.new(0, 80, 0, 80)
        buyButton.Position = UDim2.new(0, 230, 0, 340)
        buyButton.Image = "rbxthumb://type=Asset&id=" .. imageId .. "&w=420&h=420"
        buyButton.BackgroundTransparency = 1
        buyButton.Parent = HomeFrame

        -- Khi bấm vào thì gọi mua Godhuman
        buyButton.MouseButton1Click:Connect(function()
        	local args = {
        		"BuySuperhuman"
        	}
        	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
        end)

        --BuyFishmanKarate
        local imageId = "84998651228539"

        -- Tạo ImageButton
        local buyButton = Instance.new("ImageButton")
        buyButton.Size = UDim2.new(0, 80, 0, 80)
        buyButton.Position = UDim2.new(0, 130, 0, 340)
        buyButton.Image = "rbxthumb://type=Asset&id=" .. imageId .. "&w=420&h=420"
        buyButton.BackgroundTransparency = 1
        buyButton.Parent = HomeFrame

        -- Khi bấm vào thì gọi mua Godhuman
        buyButton.MouseButton1Click:Connect(function()
        	local args = {
        		"BuyFishmanKarate"
        	}
        	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
        end)

        --BuyElectro
        local imageId = "115966611139129"

        -- Tạo ImageButton
        local buyButton = Instance.new("ImageButton")
        buyButton.Size = UDim2.new(0, 80, 0, 80)
        buyButton.Position = UDim2.new(0, 30, 0, 340)
        buyButton.Image = "rbxthumb://type=Asset&id=" .. imageId .. "&w=420&h=420"
        buyButton.BackgroundTransparency = 1
        buyButton.Parent = HomeFrame

        -- Khi bấm vào thì gọi mua Godhuman
        buyButton.MouseButton1Click:Connect(function()
        	local args = {
        		"BuyElectro"
        	}
        	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
        end)

        --BuyBlackLeg
        local imageId = "78128326461745"

        -- Tạo ImageButton
        local buyButton = Instance.new("ImageButton")
        buyButton.Size = UDim2.new(0, 80, 0, 80)
        buyButton.Position = UDim2.new(0, 230, 0, 430)
        buyButton.Image = "rbxthumb://type=Asset&id=" .. imageId .. "&w=420&h=420"
        buyButton.BackgroundTransparency = 1
        buyButton.Parent = HomeFrame

        -- Khi bấm vào thì gọi mua Godhuman
        buyButton.MouseButton1Click:Connect(function()
        	local args = {
        		"BuyBlackLeg"
        	}
        	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
        end)

        --DragonClaw
        local blackbeardImageId = "85394920794637" -- Thay bằng ID ảnh thật

        -- Tạo ImageButton cho phần thưởng Blackbeard
        local rewardButton = Instance.new("ImageButton")
        rewardButton.Size = UDim2.new(0, 80, 0, 80)
        rewardButton.Position = UDim2.new(0, 130, 0, 430) -- Đặt lệch sang phải để không trùng nút khác
        rewardButton.Image = "rbxthumb://type=Asset&id=" .. blackbeardImageId .. "&w=420&h=420"
        rewardButton.BackgroundTransparency = 1
        rewardButton.Parent = HomeFrame

        -- Gọi phần thưởng khi bấm
        rewardButton.MouseButton1Click:Connect(function()
        	local args = {
        		"BlackbeardReward",
        		"DragonClaw",
        		"2"
        	}
        	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
        end)
    end

    wait(0.2)

    print("Shop tad SUCCESS✅")
end
