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
        --========Buy Ghoul===============================================================================================
    do
        local btnBuyGhoul = Instance.new("TextButton", HomeFrame)
        btnBuyGhoul.Size = UDim2.new(0, 320, 0, 40)
        btnBuyGhoul.Position = UDim2.new(0, 10, 0, 60)
        btnBuyGhoul.Text = "👻 Buy Ghoul Race"
        btnBuyGhoul.BackgroundColor3 = Color3.fromRGB(128, 0, 128)
        btnBuyGhoul.TextColor3 = Color3.new(1, 1, 1)
        btnBuyGhoul.Font = Enum.Font.SourceSansBold
        btnBuyGhoul.TextSize = 20

        btnBuyGhoul.MouseButton1Click:Connect(function()
            local args = {
                "Ectoplasm",
                "Change",
                4
            }

            local success, err = pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
            end)

            if not success then
                warn("❌ Không thể mua Ghoul Race: " .. tostring(err))
            end
        end)
    end

        --RANDUM RACE==============================================================================================================
    do
        local btnRandRace = Instance.new("TextButton", HomeFrame)
        btnRandRace.Size = UDim2.new(0, 320, 0, 40)
        btnRandRace.Position = UDim2.new(0, 10, 0, 110)
        btnRandRace.Text = "🎲 Random Race"
        btnRandRace.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
        btnRandRace.TextColor3 = Color3.new(1, 1, 1)
        btnRandRace.Font = Enum.Font.SourceSansBold
        btnRandRace.TextSize = 20

        btnRandRace.MouseButton1Click:Connect(function()
            local args = {
                "BlackbeardReward",
                "Reroll",
                "2"
            }

            local success, err = pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
            end)

            if not success then
                warn("❌ Không thể random race: " .. tostring(err))
            end
        end)
    end

        --========BUY MELEE===============================================================================================
    do
        --BuyGodhuman==============================================================================================================

        local player = game.Players.LocalPlayer
        local playerGui = player:WaitForChild("PlayerGui")

        -- Tạo GUI chứa TextLabel hiển thị giá
        local screenGui = playerGui:FindFirstChild("GodhumanGui") or Instance.new("ScreenGui")
        screenGui.Name = "GodhumanGui"
        screenGui.ResetOnSpawn = false
        screenGui.Parent = playerGui

        -- ID ảnh nút
        local imageId = "113997301355836"

        -- Nút ảnh
        local buyButton = Instance.new("ImageButton")
        buyButton.Size = UDim2.new(0, 80, 0, 80)
        buyButton.Position = UDim2.new(0, 230, 0, 160)
        buyButton.Image = "rbxthumb://type=Asset&id=" .. imageId .. "&w=420&h=420"
        buyButton.BackgroundTransparency = 1
        buyButton.Parent = sections["Shop"]

        -- GUI bảng giá nhỏ
        local priceGui = Instance.new("TextLabel")
        priceGui.Size = UDim2.new(0, 160, 0, 30)
        priceGui.BackgroundTransparency = 0.3
        priceGui.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        priceGui.TextScaled = true
        priceGui.Visible = false
        priceGui.ZIndex = 999
        priceGui.Font = Enum.Font.GothamBold
        priceGui.TextColor3 = Color3.new(1, 1, 1)
        priceGui.RichText = true
        priceGui.Text = [[<font color="rgb(0,255,0)">$ 5,000,000</font> <font color="rgb(255,80,255)">f 5,000</font>]]
        priceGui.Parent = screenGui

        -- Theo dõi vị trí chuột/cảm ứng
        local userInput = game:GetService("UserInputService")
        local runService = game:GetService("RunService")
        local mouse = player:GetMouse()

        local followMouse = false

        runService.RenderStepped:Connect(function()
        	if followMouse and priceGui.Visible then
        		local pos
        		if userInput.TouchEnabled and #userInput:GetTouchPositions() > 0 then
        			pos = userInput:GetTouchPositions()[1]
        		else
        			pos = Vector2.new(mouse.X, mouse.Y)
        		end
        		priceGui.Position = UDim2.new(0, pos.X + 10, 0, pos.Y + 10)
        	end
        end)

        -- Rê chuột hiện giá
        buyButton.MouseEnter:Connect(function()
        	priceGui.Visible = true
        	followMouse = true
        end)
        buyButton.MouseLeave:Connect(function()
        	priceGui.Visible = false
        	followMouse = false
        end)

        -- Mobile cảm ứng
        buyButton.InputBegan:Connect(function(input)
        	if input.UserInputType == Enum.UserInputType.Touch then
        		priceGui.Visible = true
        		followMouse = true
        	end
        end)
        buyButton.InputEnded:Connect(function(input)
        	if input.UserInputType == Enum.UserInputType.Touch then
        		priceGui.Visible = false
        		followMouse = false
        	end
        end)

        -- Khi bấm vào thì mua
        buyButton.MouseButton1Click:Connect(function()
        	local args = {
        		"BuyGodhuman"
        	}
        	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
        end)

        --BuyElectricClaw==============================================================================================================

        local player = game.Players.LocalPlayer
        local playerGui = player:WaitForChild("PlayerGui")

        -- Tạo GUI chứa TextLabel hiển thị giá
        local screenGui = playerGui:FindFirstChild("ElectricClawGui") or Instance.new("ScreenGui")
        screenGui.Name = "ElectricClawGui"
        screenGui.ResetOnSpawn = false
        screenGui.Parent = playerGui

        -- ID ảnh nút
        local imageId = "12133078008"

        -- Nút ảnh
        local buyButton = Instance.new("ImageButton")
        buyButton.Size = UDim2.new(0, 80, 0, 80)
        buyButton.Position = UDim2.new(0, 130, 0, 160)
        buyButton.Image = "rbxthumb://type=Asset&id=" .. imageId .. "&w=420&h=420"
        buyButton.BackgroundTransparency = 1
        buyButton.Parent = sections["Shop"]

        -- GUI bảng giá nhỏ
        local priceGui = Instance.new("TextLabel")
        priceGui.Size = UDim2.new(0, 160, 0, 30)
        priceGui.BackgroundTransparency = 0.3
        priceGui.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        priceGui.TextScaled = true
        priceGui.Visible = false
        priceGui.ZIndex = 999
        priceGui.Font = Enum.Font.GothamBold
        priceGui.TextColor3 = Color3.new(1, 1, 1)
        priceGui.RichText = true
        priceGui.Text = [[<font color="rgb(0,255,0)">$ 3,000,000</font> <font color="rgb(255,80,255)">f 5,000</font>]]
        priceGui.Parent = screenGui

        -- Theo dõi vị trí chuột/cảm ứng
        local userInput = game:GetService("UserInputService")
        local runService = game:GetService("RunService")
        local mouse = player:GetMouse()

        local followMouse = false

        runService.RenderStepped:Connect(function()
        	if followMouse and priceGui.Visible then
        		local pos
        		if userInput.TouchEnabled and #userInput:GetTouchPositions() > 0 then
        			pos = userInput:GetTouchPositions()[1]
        		else
        			pos = Vector2.new(mouse.X, mouse.Y)
        		end
        		priceGui.Position = UDim2.new(0, pos.X + 10, 0, pos.Y + 10)
        	end
        end)

        -- Rê chuột hiện giá
        buyButton.MouseEnter:Connect(function()
        	priceGui.Visible = true
        	followMouse = true
        end)
        buyButton.MouseLeave:Connect(function()
        	priceGui.Visible = false
        	followMouse = false
        end)

        -- Mobile cảm ứng
        buyButton.InputBegan:Connect(function(input)
        	if input.UserInputType == Enum.UserInputType.Touch then
        		priceGui.Visible = true
        		followMouse = true
        	end
        end)
        buyButton.InputEnded:Connect(function(input)
        	if input.UserInputType == Enum.UserInputType.Touch then
        		priceGui.Visible = false
        		followMouse = false
        	end
        end)

        -- Khi bấm vào thì mua
        buyButton.MouseButton1Click:Connect(function()
        	local args = {
        		"BuyElectricClaw"
        	}
        	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
        end)

        --BuySanguineArt==============================================================================================================

        local player = game.Players.LocalPlayer
        local playerGui = player:WaitForChild("PlayerGui")

        -- Tạo GUI chứa TextLabel hiển thị giá
        local screenGui = playerGui:FindFirstChild("SanguineArtGui") or Instance.new("ScreenGui")
        screenGui.Name = "SanguineArtGui"
        screenGui.ResetOnSpawn = false
        screenGui.Parent = playerGui

        -- ID ảnh nút
        local imageId = "15355555932"

        -- Nút ảnh
        local buyButton = Instance.new("ImageButton")
        buyButton.Size = UDim2.new(0, 80, 0, 80)
        buyButton.Position = UDim2.new(0, 30, 0, 160)
        buyButton.Image = "rbxthumb://type=Asset&id=" .. imageId .. "&w=420&h=420"
        buyButton.BackgroundTransparency = 1
        buyButton.Parent = sections["Shop"]

        -- GUI bảng giá nhỏ
        local priceGui = Instance.new("TextLabel")
        priceGui.Size = UDim2.new(0, 160, 0, 30)
        priceGui.BackgroundTransparency = 0.3
        priceGui.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        priceGui.TextScaled = true
        priceGui.Visible = false
        priceGui.ZIndex = 999
        priceGui.Font = Enum.Font.GothamBold
        priceGui.TextColor3 = Color3.new(1, 1, 1)
        priceGui.RichText = true
        priceGui.Text = [[<font color="rgb(0,255,0)">$ 5,000,000</font> <font color="rgb(255,80,255)">f 5,000</font>]]
        priceGui.Parent = screenGui

        -- Theo dõi vị trí chuột/cảm ứng
        local userInput = game:GetService("UserInputService")
        local runService = game:GetService("RunService")
        local mouse = player:GetMouse()

        local followMouse = false

        runService.RenderStepped:Connect(function()
        	if followMouse and priceGui.Visible then
        		local pos
        		if userInput.TouchEnabled and #userInput:GetTouchPositions() > 0 then
        			pos = userInput:GetTouchPositions()[1]
        		else
        			pos = Vector2.new(mouse.X, mouse.Y)
        		end
        		priceGui.Position = UDim2.new(0, pos.X + 10, 0, pos.Y + 10)
        	end
        end)

        -- Rê chuột hiện giá
        buyButton.MouseEnter:Connect(function()
        	priceGui.Visible = true
        	followMouse = true
        end)
        buyButton.MouseLeave:Connect(function()
        	priceGui.Visible = false
        	followMouse = false
        end)

        -- Mobile cảm ứng
        buyButton.InputBegan:Connect(function(input)
        	if input.UserInputType == Enum.UserInputType.Touch then
        		priceGui.Visible = true
        		followMouse = true
        	end
        end)
        buyButton.InputEnded:Connect(function(input)
        	if input.UserInputType == Enum.UserInputType.Touch then
        		priceGui.Visible = false
        		followMouse = false
        	end
        end)

        -- Khi bấm vào thì mua
        buyButton.MouseButton1Click:Connect(function()
        	local args = {
        		"BuySanguineArt"
        	}
        	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
        end)

        --BuyDragonTalon==============================================================================================================

        local player = game.Players.LocalPlayer
        local playerGui = player:WaitForChild("PlayerGui")

        -- Tạo GUI chứa TextLabel hiển thị giá
        local screenGui = playerGui:FindFirstChild("DragonTalonGui") or Instance.new("ScreenGui")
        screenGui.Name = "DragonTalonGui"
        screenGui.ResetOnSpawn = false
        screenGui.Parent = playerGui

        -- ID ảnh nút
        local imageId = "18522661682"

        -- Nút ảnh
        local buyButton = Instance.new("ImageButton")
        buyButton.Size = UDim2.new(0, 80, 0, 80)
        buyButton.Position = UDim2.new(0, 230, 0, 250)
        buyButton.Image = "rbxthumb://type=Asset&id=" .. imageId .. "&w=420&h=420"
        buyButton.BackgroundTransparency = 1
        buyButton.Parent = sections["Shop"]

        -- GUI bảng giá nhỏ
        local priceGui = Instance.new("TextLabel")
        priceGui.Size = UDim2.new(0, 160, 0, 30)
        priceGui.BackgroundTransparency = 0.3
        priceGui.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        priceGui.TextScaled = true
        priceGui.Visible = false
        priceGui.ZIndex = 999
        priceGui.Font = Enum.Font.GothamBold
        priceGui.TextColor3 = Color3.new(1, 1, 1)
        priceGui.RichText = true
        priceGui.Text = [[<font color="rgb(0,255,0)">$ 3,000,000</font> <font color="rgb(255,80,255)">f 5,000</font>]]
        priceGui.Parent = screenGui

        -- Theo dõi vị trí chuột/cảm ứng
        local userInput = game:GetService("UserInputService")
        local runService = game:GetService("RunService")
        local mouse = player:GetMouse()

        local followMouse = false

        runService.RenderStepped:Connect(function()
        	if followMouse and priceGui.Visible then
        		local pos
        		if userInput.TouchEnabled and #userInput:GetTouchPositions() > 0 then
        			pos = userInput:GetTouchPositions()[1]
        		else
        			pos = Vector2.new(mouse.X, mouse.Y)
        		end
        		priceGui.Position = UDim2.new(0, pos.X + 10, 0, pos.Y + 10)
        	end
        end)

        -- Rê chuột hiện giá
        buyButton.MouseEnter:Connect(function()
        	priceGui.Visible = true
        	followMouse = true
        end)
        buyButton.MouseLeave:Connect(function()
        	priceGui.Visible = false
        	followMouse = false
        end)

        -- Mobile cảm ứng
        buyButton.InputBegan:Connect(function(input)
        	if input.UserInputType == Enum.UserInputType.Touch then
        		priceGui.Visible = true
        		followMouse = true
        	end
        end)
        buyButton.InputEnded:Connect(function(input)
        	if input.UserInputType == Enum.UserInputType.Touch then
        		priceGui.Visible = false
        		followMouse = false
        	end
        end)

        -- Khi bấm vào thì mua
        buyButton.MouseButton1Click:Connect(function()
        	local args = {
        		"BuyDragonTalon"
        	}
        	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
        end)

        --BuySharkmanKarate==============================================================================================================

        local player = game.Players.LocalPlayer
        local playerGui = player:WaitForChild("PlayerGui")

        -- Tạo GUI chứa TextLabel hiển thị giá
        local screenGui = playerGui:FindFirstChild("SharkmanKarateGui") or Instance.new("ScreenGui")
        screenGui.Name = "SharkmanKarateGui"
        screenGui.ResetOnSpawn = false
        screenGui.Parent = playerGui

        -- ID ảnh nút
        local imageId = "91137517991866"

        -- Nút ảnh
        local buyButton = Instance.new("ImageButton")
        buyButton.Size = UDim2.new(0, 80, 0, 80)
        buyButton.Position = UDim2.new(0, 130, 0, 250)
        buyButton.Image = "rbxthumb://type=Asset&id=" .. imageId .. "&w=420&h=420"
        buyButton.BackgroundTransparency = 1
        buyButton.Parent = sections["Shop"]

        -- GUI bảng giá nhỏ
        local priceGui = Instance.new("TextLabel")
        priceGui.Size = UDim2.new(0, 160, 0, 30)
        priceGui.BackgroundTransparency = 0.3
        priceGui.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        priceGui.TextScaled = true
        priceGui.Visible = false
        priceGui.ZIndex = 999
        priceGui.Font = Enum.Font.GothamBold
        priceGui.TextColor3 = Color3.new(1, 1, 1)
        priceGui.RichText = true
        priceGui.Text = [[<font color="rgb(0,255,0)">$ 2,500,000</font> <font color="rgb(255,80,255)">f 5,000</font>]]
        priceGui.Parent = screenGui

        -- Theo dõi vị trí chuột/cảm ứng
        local userInput = game:GetService("UserInputService")
        local runService = game:GetService("RunService")
        local mouse = player:GetMouse()

        local followMouse = false

        runService.RenderStepped:Connect(function()
        	if followMouse and priceGui.Visible then
        		local pos
        		if userInput.TouchEnabled and #userInput:GetTouchPositions() > 0 then
        			pos = userInput:GetTouchPositions()[1]
        		else
        			pos = Vector2.new(mouse.X, mouse.Y)
        		end
        		priceGui.Position = UDim2.new(0, pos.X + 10, 0, pos.Y + 10)
        	end
        end)

        -- Rê chuột hiện giá
        buyButton.MouseEnter:Connect(function()
        	priceGui.Visible = true
        	followMouse = true
        end)
        buyButton.MouseLeave:Connect(function()
        	priceGui.Visible = false
        	followMouse = false
        end)

        -- Mobile cảm ứng
        buyButton.InputBegan:Connect(function(input)
        	if input.UserInputType == Enum.UserInputType.Touch then
        		priceGui.Visible = true
        		followMouse = true
        	end
        end)
        buyButton.InputEnded:Connect(function(input)
        	if input.UserInputType == Enum.UserInputType.Touch then
        		priceGui.Visible = false
        		followMouse = false
        	end
        end)

        -- Khi bấm vào thì mua
        buyButton.MouseButton1Click:Connect(function()
        	local args = {
        		"BuySharkmanKarate"
        	}
        	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
        end)

        --BuyDeathStep==============================================================================================================

        local player = game.Players.LocalPlayer
        local playerGui = player:WaitForChild("PlayerGui")

        -- Tạo GUI chứa TextLabel hiển thị giá
        local screenGui = playerGui:FindFirstChild("DeathStepGui") or Instance.new("ScreenGui")
        screenGui.Name = "DeathStepGui"
        screenGui.ResetOnSpawn = false
        screenGui.Parent = playerGui

        -- ID ảnh nút
        local imageId = "89281841390007"

        -- Nút ảnh
        local buyButton = Instance.new("ImageButton")
        buyButton.Size = UDim2.new(0, 80, 0, 80)
        buyButton.Position = UDim2.new(0, 30, 0, 250)
        buyButton.Image = "rbxthumb://type=Asset&id=" .. imageId .. "&w=420&h=420"
        buyButton.BackgroundTransparency = 1
        buyButton.Parent = sections["Shop"]

        -- GUI bảng giá nhỏ
        local priceGui = Instance.new("TextLabel")
        priceGui.Size = UDim2.new(0, 160, 0, 30)
        priceGui.BackgroundTransparency = 0.3
        priceGui.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        priceGui.TextScaled = true
        priceGui.Visible = false
        priceGui.ZIndex = 999
        priceGui.Font = Enum.Font.GothamBold
        priceGui.TextColor3 = Color3.new(1, 1, 1)
        priceGui.RichText = true
        priceGui.Text = [[<font color="rgb(0,255,0)">$ 2,500,000</font> <font color="rgb(255,80,255)">f 5,000</font>]]
        priceGui.Parent = screenGui

        -- Theo dõi vị trí chuột/cảm ứng
        local userInput = game:GetService("UserInputService")
        local runService = game:GetService("RunService")
        local mouse = player:GetMouse()

        local followMouse = false

        runService.RenderStepped:Connect(function()
        	if followMouse and priceGui.Visible then
        		local pos
        		if userInput.TouchEnabled and #userInput:GetTouchPositions() > 0 then
        			pos = userInput:GetTouchPositions()[1]
        		else
        			pos = Vector2.new(mouse.X, mouse.Y)
        		end
        		priceGui.Position = UDim2.new(0, pos.X + 10, 0, pos.Y + 10)
        	end
        end)

        -- Rê chuột hiện giá
        buyButton.MouseEnter:Connect(function()
        	priceGui.Visible = true
        	followMouse = true
        end)
        buyButton.MouseLeave:Connect(function()
        	priceGui.Visible = false
        	followMouse = false
        end)

        -- Mobile cảm ứng
        buyButton.InputBegan:Connect(function(input)
        	if input.UserInputType == Enum.UserInputType.Touch then
        		priceGui.Visible = true
        		followMouse = true
        	end
        end)
        buyButton.InputEnded:Connect(function(input)
        	if input.UserInputType == Enum.UserInputType.Touch then
        		priceGui.Visible = false
        		followMouse = false
        	end
        end)

        -- Khi bấm vào thì mua
        buyButton.MouseButton1Click:Connect(function()
        	local args = {
        		"BuyDeathStep"
        	}
        	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
        end)

        --BuySuperhuman==============================================================================================================

        local player = game.Players.LocalPlayer
        local playerGui = player:WaitForChild("PlayerGui")

        -- Tạo GUI chứa TextLabel hiển thị giá
        local screenGui = playerGui:FindFirstChild("SuperhumanGui") or Instance.new("ScreenGui")
        screenGui.Name = "SuperhumanGui"
        screenGui.ResetOnSpawn = false
        screenGui.Parent = playerGui

        -- ID ảnh nút
        local imageId = "105999391562192"

        -- Nút ảnh
        local buyButton = Instance.new("ImageButton")
        buyButton.Size = UDim2.new(0, 80, 0, 80)
        buyButton.Position = UDim2.new(0, 230, 0, 340)
        buyButton.Image = "rbxthumb://type=Asset&id=" .. imageId .. "&w=420&h=420"
        buyButton.BackgroundTransparency = 1
        buyButton.Parent = sections["Shop"]

        -- GUI bảng giá nhỏ
        local priceGui = Instance.new("TextLabel")
        priceGui.Size = UDim2.new(0, 160, 0, 30)
        priceGui.BackgroundTransparency = 0.3
        priceGui.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        priceGui.TextScaled = true
        priceGui.Visible = false
        priceGui.ZIndex = 999
        priceGui.Font = Enum.Font.GothamBold
        priceGui.TextColor3 = Color3.new(1, 1, 1)
        priceGui.RichText = true
        priceGui.Text = [[<font color="rgb(0,255,0)">$ 3,000,000</font> <font color="rgb(255,80,255)">f 0</font>]]
        priceGui.Parent = screenGui

        -- Theo dõi vị trí chuột/cảm ứng
        local userInput = game:GetService("UserInputService")
        local runService = game:GetService("RunService")
        local mouse = player:GetMouse()

        local followMouse = false

        runService.RenderStepped:Connect(function()
        	if followMouse and priceGui.Visible then
        		local pos
        		if userInput.TouchEnabled and #userInput:GetTouchPositions() > 0 then
        			pos = userInput:GetTouchPositions()[1]
        		else
        			pos = Vector2.new(mouse.X, mouse.Y)
        		end
        		priceGui.Position = UDim2.new(0, pos.X + 10, 0, pos.Y + 10)
        	end
        end)

        -- Rê chuột hiện giá
        buyButton.MouseEnter:Connect(function()
        	priceGui.Visible = true
        	followMouse = true
        end)
        buyButton.MouseLeave:Connect(function()
        	priceGui.Visible = false
        	followMouse = false
        end)

        -- Mobile cảm ứng
        buyButton.InputBegan:Connect(function(input)
        	if input.UserInputType == Enum.UserInputType.Touch then
        		priceGui.Visible = true
        		followMouse = true
        	end
        end)
        buyButton.InputEnded:Connect(function(input)
        	if input.UserInputType == Enum.UserInputType.Touch then
        		priceGui.Visible = false
        		followMouse = false
        	end
        end)

        -- Khi bấm vào thì mua
        buyButton.MouseButton1Click:Connect(function()
        	local args = {
        		"BuySuperhuman"
        	}
        	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
        end)

        --BuyFishmanKarate==============================================================================================================

        local player = game.Players.LocalPlayer
        local playerGui = player:WaitForChild("PlayerGui")

        -- Tạo GUI chứa TextLabel hiển thị giá
        local screenGui = playerGui:FindFirstChild("FishmanKarateGui") or Instance.new("ScreenGui")
        screenGui.Name = "FishmanKarateGui"
        screenGui.ResetOnSpawn = false
        screenGui.Parent = playerGui

        -- ID ảnh nút
        local imageId = "84998651228539"

        -- Nút ảnh
        local buyButton = Instance.new("ImageButton")
        buyButton.Size = UDim2.new(0, 80, 0, 80)
        buyButton.Position = UDim2.new(0, 130, 0, 340)
        buyButton.Image = "rbxthumb://type=Asset&id=" .. imageId .. "&w=420&h=420"
        buyButton.BackgroundTransparency = 1
        buyButton.Parent = sections["Shop"]

        -- GUI bảng giá nhỏ
        local priceGui = Instance.new("TextLabel")
        priceGui.Size = UDim2.new(0, 160, 0, 30)
        priceGui.BackgroundTransparency = 0.3
        priceGui.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        priceGui.TextScaled = true
        priceGui.Visible = false
        priceGui.ZIndex = 999
        priceGui.Font = Enum.Font.GothamBold
        priceGui.TextColor3 = Color3.new(1, 1, 1)
        priceGui.RichText = true
        priceGui.Text = [[<font color="rgb(0,255,0)">$ 750,000</font> <font color="rgb(255,80,255)">f 0</font>]]
        priceGui.Parent = screenGui

        -- Theo dõi vị trí chuột/cảm ứng
        local userInput = game:GetService("UserInputService")
        local runService = game:GetService("RunService")
        local mouse = player:GetMouse()

        local followMouse = false

        runService.RenderStepped:Connect(function()
        	if followMouse and priceGui.Visible then
        		local pos
        		if userInput.TouchEnabled and #userInput:GetTouchPositions() > 0 then
        			pos = userInput:GetTouchPositions()[1]
        		else
        			pos = Vector2.new(mouse.X, mouse.Y)
        		end
        		priceGui.Position = UDim2.new(0, pos.X + 10, 0, pos.Y + 10)
        	end
        end)

        -- Rê chuột hiện giá
        buyButton.MouseEnter:Connect(function()
        	priceGui.Visible = true
        	followMouse = true
        end)
        buyButton.MouseLeave:Connect(function()
        	priceGui.Visible = false
        	followMouse = false
        end)

        -- Mobile cảm ứng
        buyButton.InputBegan:Connect(function(input)
        	if input.UserInputType == Enum.UserInputType.Touch then
        		priceGui.Visible = true
        		followMouse = true
        	end
        end)
        buyButton.InputEnded:Connect(function(input)
        	if input.UserInputType == Enum.UserInputType.Touch then
        		priceGui.Visible = false
        		followMouse = false
        	end
        end)

        -- Khi bấm vào thì mua
        buyButton.MouseButton1Click:Connect(function()
        	local args = {
        		"BuyFishmanKarate"
        	}
        	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
        end)

        --BuyElectro==============================================================================================================

        local player = game.Players.LocalPlayer
        local playerGui = player:WaitForChild("PlayerGui")

        -- Tạo GUI chứa TextLabel hiển thị giá
        local screenGui = playerGui:FindFirstChild("ElectroGui") or Instance.new("ScreenGui")
        screenGui.Name = "ElectroGui"
        screenGui.ResetOnSpawn = false
        screenGui.Parent = playerGui

        -- ID ảnh nút
        local imageId = "115966611139129"

        -- Nút ảnh
        local buyButton = Instance.new("ImageButton")
        buyButton.Size = UDim2.new(0, 80, 0, 80)
        buyButton.Position = UDim2.new(0, 30, 0, 340)
        buyButton.Image = "rbxthumb://type=Asset&id=" .. imageId .. "&w=420&h=420"
        buyButton.BackgroundTransparency = 1
        buyButton.Parent = sections["Shop"]

        -- GUI bảng giá nhỏ
        local priceGui = Instance.new("TextLabel")
        priceGui.Size = UDim2.new(0, 160, 0, 30)
        priceGui.BackgroundTransparency = 0.3
        priceGui.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        priceGui.TextScaled = true
        priceGui.Visible = false
        priceGui.ZIndex = 999
        priceGui.Font = Enum.Font.GothamBold
        priceGui.TextColor3 = Color3.new(1, 1, 1)
        priceGui.RichText = true
        priceGui.Text = [[<font color="rgb(0,255,0)">$ 500,000</font> <font color="rgb(255,80,255)">f 0</font>]]
        priceGui.Parent = screenGui

        -- Theo dõi vị trí chuột/cảm ứng
        local userInput = game:GetService("UserInputService")
        local runService = game:GetService("RunService")
        local mouse = player:GetMouse()

        local followMouse = false

        runService.RenderStepped:Connect(function()
        	if followMouse and priceGui.Visible then
        		local pos
        		if userInput.TouchEnabled and #userInput:GetTouchPositions() > 0 then
        			pos = userInput:GetTouchPositions()[1]
        		else
        			pos = Vector2.new(mouse.X, mouse.Y)
        		end
        		priceGui.Position = UDim2.new(0, pos.X + 10, 0, pos.Y + 10)
        	end
        end)

        -- Rê chuột hiện giá
        buyButton.MouseEnter:Connect(function()
        	priceGui.Visible = true
        	followMouse = true
        end)
        buyButton.MouseLeave:Connect(function()
        	priceGui.Visible = false
        	followMouse = false
        end)

        -- Mobile cảm ứng
        buyButton.InputBegan:Connect(function(input)
        	if input.UserInputType == Enum.UserInputType.Touch then
        		priceGui.Visible = true
        		followMouse = true
        	end
        end)
        buyButton.InputEnded:Connect(function(input)
        	if input.UserInputType == Enum.UserInputType.Touch then
        		priceGui.Visible = false
        		followMouse = false
        	end
        end)

        -- Khi bấm vào thì mua
        buyButton.MouseButton1Click:Connect(function()
        	local args = {
        		"BuyElectro"
        	}
        	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
        end)

        --BuyBlackLeg==============================================================================================================

        local player = game.Players.LocalPlayer
        local playerGui = player:WaitForChild("PlayerGui")

        -- Tạo GUI chứa TextLabel hiển thị giá
        local screenGui = playerGui:FindFirstChild("BlackLegGui") or Instance.new("ScreenGui")
        screenGui.Name = "BlackLegGui"
        screenGui.ResetOnSpawn = false
        screenGui.Parent = playerGui

        -- ID ảnh nút
        local imageId = "78128326461745"

        -- Nút ảnh
        local buyButton = Instance.new("ImageButton")
        buyButton.Size = UDim2.new(0, 80, 0, 80)
        buyButton.Position = UDim2.new(0, 230, 0, 430)
        buyButton.Image = "rbxthumb://type=Asset&id=" .. imageId .. "&w=420&h=420"
        buyButton.BackgroundTransparency = 1
        buyButton.Parent = sections["Shop"]

        -- GUI bảng giá nhỏ
        local priceGui = Instance.new("TextLabel")
        priceGui.Size = UDim2.new(0, 160, 0, 30)
        priceGui.BackgroundTransparency = 0.3
        priceGui.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        priceGui.TextScaled = true
        priceGui.Visible = false
        priceGui.ZIndex = 999
        priceGui.Font = Enum.Font.GothamBold
        priceGui.TextColor3 = Color3.new(1, 1, 1)
        priceGui.RichText = true
        priceGui.Text = [[<font color="rgb(0,255,0)">$ 150,000</font> <font color="rgb(255,80,255)">f 0</font>]]
        priceGui.Parent = screenGui

        -- Theo dõi vị trí chuột/cảm ứng
        local userInput = game:GetService("UserInputService")
        local runService = game:GetService("RunService")
        local mouse = player:GetMouse()

        local followMouse = false

        runService.RenderStepped:Connect(function()
        	if followMouse and priceGui.Visible then
        		local pos
        		if userInput.TouchEnabled and #userInput:GetTouchPositions() > 0 then
        			pos = userInput:GetTouchPositions()[1]
        		else
        			pos = Vector2.new(mouse.X, mouse.Y)
        		end
        		priceGui.Position = UDim2.new(0, pos.X + 10, 0, pos.Y + 10)
        	end
        end)

        -- Rê chuột hiện giá
        buyButton.MouseEnter:Connect(function()
        	priceGui.Visible = true
        	followMouse = true
        end)
        buyButton.MouseLeave:Connect(function()
        	priceGui.Visible = false
        	followMouse = false
        end)

        -- Mobile cảm ứng
        buyButton.InputBegan:Connect(function(input)
        	if input.UserInputType == Enum.UserInputType.Touch then
        		priceGui.Visible = true
        		followMouse = true
        	end
        end)
        buyButton.InputEnded:Connect(function(input)
        	if input.UserInputType == Enum.UserInputType.Touch then
        		priceGui.Visible = false
        		followMouse = false
        	end
        end)

        -- Khi bấm vào thì mua
        buyButton.MouseButton1Click:Connect(function()
        	local args = {
        		"BuyBlackLeg"
        	}
        	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
        end)

        --DragonClaw==============================================================================================================

        local player = game.Players.LocalPlayer
        local playerGui = player:WaitForChild("PlayerGui")

        -- Tạo GUI chứa TextLabel hiển thị giá
        local screenGui = playerGui:FindFirstChild("DragonClawGui") or Instance.new("ScreenGui")
        screenGui.Name = "DragonClawGui"
        screenGui.ResetOnSpawn = false
        screenGui.Parent = playerGui

        -- ID ảnh nút
        local imageId = "85394920794637"

        -- Nút ảnh
        local rewardButton = Instance.new("ImageButton")
        rewardButton.Size = UDim2.new(0, 80, 0, 80)
        rewardButton.Position = UDim2.new(0, 130, 0, 430)
        rewardButton.Image = "rbxthumb://type=Asset&id=" .. imageId .. "&w=420&h=420"
        rewardButton.BackgroundTransparency = 1
        rewardButton.Parent = sections["Shop"]

        -- GUI bảng giá nhỏ
        local priceGui = Instance.new("TextLabel")
        priceGui.Size = UDim2.new(0, 160, 0, 30)
        priceGui.BackgroundTransparency = 0.3
        priceGui.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        priceGui.TextScaled = true
        priceGui.Visible = false
        priceGui.ZIndex = 999
        priceGui.Font = Enum.Font.GothamBold
        priceGui.TextColor3 = Color3.new(1, 1, 1)
        priceGui.RichText = true
        priceGui.Text = [[<font color="rgb(0,255,0)">$ 0</font> <font color="rgb(255,80,255)">f 1,500</font>]]
        priceGui.Parent = screenGui

        -- Theo dõi vị trí chuột/cảm ứng
        local userInput = game:GetService("UserInputService")
        local runService = game:GetService("RunService")
        local mouse = player:GetMouse()

        local followMouse = false

        runService.RenderStepped:Connect(function()
        	if followMouse and priceGui.Visible then
        		local pos
        		if userInput.TouchEnabled and #userInput:GetTouchPositions() > 0 then
        			pos = userInput:GetTouchPositions()[1]
        		else
        			pos = Vector2.new(mouse.X, mouse.Y)
        		end
        		priceGui.Position = UDim2.new(0, pos.X + 10, 0, pos.Y + 10)
        	end
        end)

        -- Rê chuột hiện giá
        rewardButton.MouseEnter:Connect(function()
        	priceGui.Visible = true
        	followMouse = true
        end)
        rewardButton.MouseLeave:Connect(function()
        	priceGui.Visible = false
        	followMouse = false
        end)

        -- Mobile cảm ứng
        rewardButton.InputBegan:Connect(function(input)
        	if input.UserInputType == Enum.UserInputType.Touch then
        		priceGui.Visible = true
        		followMouse = true
        	end
        end)
        rewardButton.InputEnded:Connect(function(input)
        	if input.UserInputType == Enum.UserInputType.Touch then
        		priceGui.Visible = false
        		followMouse = false
        	end
        end)

        -- Khi bấm vào thì mua
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
