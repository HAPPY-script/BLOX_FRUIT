return function(sections)
    local HomeFrame = sections["Player"]

        --SPEED================================================================================================f
    do
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        local runService = game:GetService("RunService")

        local isActive = false
        local speedValue = 3 -- Tốc độ mặc định
        local distancePerTeleport = 1.5

        -- Nút bật/tắt
        local toggleButton = Instance.new("TextButton")
        toggleButton.Name = "ToggleSpeed"
        toggleButton.Parent = HomeFrame
        toggleButton.Size = UDim2.new(0, 90, 0, 30)
        toggleButton.Position = UDim2.new(0, 240, 0, 10)
        toggleButton.Text = "OFF"
        toggleButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        toggleButton.TextColor3 = Color3.new(1, 1, 1)
        toggleButton.Font = Enum.Font.SourceSansBold
        toggleButton.TextScaled = true

        -- Ô nhập tốc độ
        local speedBox = Instance.new("TextBox")
        speedBox.Name = "SpeedInput"
        speedBox.Parent = HomeFrame
        speedBox.Size = UDim2.new(0, 50, 0, 30)
        speedBox.Position = UDim2.new(0, 190, 0, 10)
        speedBox.Text = tostring(speedValue)
        speedBox.PlaceholderText = "Speed"
        speedBox.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        speedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        speedBox.Font = Enum.Font.SourceSansBold
        speedBox.TextScaled = true

        -- Cập nhật tốc độ từ ô nhập
        speedBox.FocusLost:Connect(function()
        	local newSpeed = tonumber(speedBox.Text)
        	if newSpeed and newSpeed > 0 and newSpeed <= 10 then
        		speedValue = newSpeed
        	else
        		speedBox.Text = tostring(speedValue)
        	end
        end)

        -- Toggle nút ON/OFF
        toggleButton.MouseButton1Click:Connect(function()
        	isActive = not isActive
        	toggleButton.Text = isActive and "ON" or "OFF"
        	toggleButton.BackgroundColor3 = isActive and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
        end)

        -- Hàm dịch chuyển
        local function TeleportStep()
        	if not isActive or not character or not humanoidRootPart then return end
        	local moveDirection = character:FindFirstChild("Humanoid") and character.Humanoid.MoveDirection or Vector3.zero
        	if moveDirection.Magnitude > 0 then
        		local newPos = humanoidRootPart.Position + (moveDirection * distancePerTeleport)
        		humanoidRootPart.CFrame = CFrame.new(newPos, newPos + moveDirection)
        	end
        end

        -- Gọi dịch chuyển mỗi frame
        runService.RenderStepped:Connect(function()
        	if isActive then
        		for _ = 1, speedValue do
        			TeleportStep()
        		end
        	end
        end)

        -- Cập nhật khi respawn
        player.CharacterAdded:Connect(function(char)
        	character = char
        	humanoidRootPart = char:WaitForChild("HumanoidRootPart")
        end)
    end
        --NO CLIP================================================================================================
    do
        local player = game.Players.LocalPlayer
        local userInputService = game:GetService("UserInputService")
        local runService = game:GetService("RunService")

        local noclipEnabled = false
        local character = player.Character or player.CharacterAdded:Wait()
        local noclipConnection

        -- Hàm bật/tắt No Clip
        local function setNoclip(state)
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = not state
                    end
                end
            end
        end

        -- Nút No Clip trong tab Home
        local noclipButton = Instance.new("TextButton", HomeFrame)
        noclipButton.Size = UDim2.new(0, 90, 0, 30)
        noclipButton.Position = UDim2.new(0, 240, 0, 60)
        noclipButton.Text = "OFF"
        noclipButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        noclipButton.TextColor3 = Color3.new(1, 1, 1)
        noclipButton.Font = Enum.Font.SourceSansBold
        noclipButton.TextScaled = true

        -- Bật/Tắt No Clip
        noclipButton.MouseButton1Click:Connect(function()
            noclipEnabled = not noclipEnabled
            noclipButton.Text = noclipEnabled and "ON" or "OFF"
            noclipButton.BackgroundColor3 = noclipEnabled and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)

            if noclipEnabled then
                if noclipConnection then noclipConnection:Disconnect() end
                noclipConnection = runService.Stepped:Connect(function()
                    if noclipEnabled and character then
                        setNoclip(true)
                    end
                end)
            else
                if noclipConnection then noclipConnection:Disconnect() end
                setNoclip(false)
            end
        end)

        -- Reset khi nhân vật hồi sinh
        player.CharacterAdded:Connect(function(newChar)
            character = newChar
            noclipEnabled = false
            if noclipConnection then noclipConnection:Disconnect() end
            noclipButton.Text = "OFF"
            noclipButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        end)
    end
        --TP KEY PC================================================================================================
    do
        local player = game.Players.LocalPlayer
        local userInputService = game:GetService("UserInputService")

        -- Biến trạng thái (không reset khi respawn)
        local teleportEnabled = false
        local selectedKey = nil
        local listeningForKey = false

        -- Animation ID để phát khi teleport
        local TP_ANIM_ID = "17555632156"

        -- Nút ON/OFF
        local TeleportButton = Instance.new("TextButton", HomeFrame)
        TeleportButton.Size = UDim2.new(0, 90, 0, 30)
        TeleportButton.Position = UDim2.new(0, 240, 0, 110)
        TeleportButton.Text = "OFF"
        TeleportButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        TeleportButton.TextColor3 = Color3.new(1, 1, 1)
        TeleportButton.Font = Enum.Font.SourceSansBold
        TeleportButton.TextScaled = true

        -- Ô chọn phím
        local KeySelectBox = Instance.new("TextButton", HomeFrame)
        KeySelectBox.Size = UDim2.new(0, 50, 0, 30)
        KeySelectBox.Position = UDim2.new(0, 190, 0, 110)
        KeySelectBox.Text = "Select Key"
        KeySelectBox.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        KeySelectBox.TextColor3 = Color3.new(1, 1, 1)
        KeySelectBox.Font = Enum.Font.SourceSans
        KeySelectBox.TextScaled = true

        -- Hiển thị ban đầu theo selectedKey (nếu đã có)
        if selectedKey then
            KeySelectBox.Text = selectedKey
        end
        -- Hiển thị ban đầu theo teleportEnabled
        TeleportButton.Text = teleportEnabled and "ON" or "OFF"
        TeleportButton.BackgroundColor3 = teleportEnabled and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)

        -- Xử lý chọn phím
        KeySelectBox.MouseButton1Click:Connect(function()
            if listeningForKey then return end
            listeningForKey = true
            KeySelectBox.Text = "Press a key..."

            local conn
            conn = userInputService.InputBegan:Connect(function(input, gameProcessed)
                if gameProcessed then return end

                local inputName
                if input.UserInputType == Enum.UserInputType.Keyboard then
                    inputName = input.KeyCode.Name
                elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                    inputName = "MouseButton1"
                elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
                    inputName = "MouseButton2"
                end

                if inputName then
                    selectedKey = inputName
                    KeySelectBox.Text = inputName
                    conn:Disconnect()
                    listeningForKey = false
                end
            end)
        end)

        -- Hàm phát animation khi teleport (tự xử lý Animator/Humanoid)
        local function playTpAnim(character)
            if not character or not character.Parent then character = player.Character end
            if not character then return end

            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if not humanoid then return end

            -- tạo Animation instance
            local anim = Instance.new("Animation")
            anim.Name = "TP_Anim"
            anim.AnimationId = "rbxassetid://" .. TP_ANIM_ID

            local ok, track = pcall(function()
                local animator = humanoid:FindFirstChildOfClass("Animator")
                if animator then
                    return animator:LoadAnimation(anim)
                else
                    return humanoid:LoadAnimation(anim)
                end
            end)

            if ok and track then
                -- đảm bảo ưu tiên action để phát rõ
                pcall(function() track.Priority = Enum.AnimationPriority.Action end)
                track:Play()
                -- cleanup: dừng track & destroy Animation object sau timeout ngắn để tránh rò rỉ
                delay(8, function()
                    pcall(function()
                        if track.IsPlaying then track:Stop() end
                        anim:Destroy()
                    end)
                end)
            else
                -- không load được -> hủy Animation object
                pcall(function() anim:Destroy() end)
            end
        end

        local function teleportToMouse()
            if not teleportEnabled or not selectedKey then return end

            local character = player.Character
            if not character then return end

            local hrp = character:FindFirstChild("HumanoidRootPart")
            if not hrp then return end

            local mouse = player:GetMouse()
            local pos = mouse.Hit.Position

            -- Giới hạn khoảng cách theo XZ
            local dx = hrp.Position.X - pos.X
            local dz = hrp.Position.Z - pos.Z
            if (dx * dx + dz * dz) ^ 0.5 > 250 then return end

            local yOffset = 4

            -- Thực hiện teleport
            hrp.CFrame = CFrame.new(
                pos.X,
                pos.Y + yOffset,
                pos.Z
            )

            -- Sau khi teleport thành công -> phát animation
            playTpAnim(character)
        end

        TeleportButton.MouseButton1Click:Connect(function()
            teleportEnabled = not teleportEnabled
            TeleportButton.Text = teleportEnabled and "ON" or "OFF"
            TeleportButton.BackgroundColor3 = teleportEnabled and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
        end)

        userInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed or not teleportEnabled or not selectedKey then return end

            local inputName
            if input.UserInputType == Enum.UserInputType.Keyboard then
                inputName = input.KeyCode.Name
            elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                inputName = "MouseButton1"
            elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
                inputName = "MouseButton2"
            end

            if inputName == selectedKey then
                teleportToMouse()
            end
        end)

        player.CharacterAdded:Connect(function(newChar)
            newChar:WaitForChild("HumanoidRootPart")
            TeleportButton.Text = teleportEnabled and "ON" or "OFF"
            TeleportButton.BackgroundColor3 = teleportEnabled and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
            if selectedKey then
                KeySelectBox.Text = selectedKey
            end
        end)
    end

        --TP BUTTON PE================================================================================================
    do
        local player = game.Players.LocalPlayer
        local userInputService = game:GetService("UserInputService")
        local mouse = player:GetMouse()
        local teleportEnabled = false
        local tpButtonActive = false

        -- Nút bật/tắt chính trong Home
        local TeleportPEButton = Instance.new("TextButton", HomeFrame)
        TeleportPEButton.Size = UDim2.new(0, 90, 0, 30)
        TeleportPEButton.Position = UDim2.new(0, 240, 0, 160)
        TeleportPEButton.Text = "OFF"
        TeleportPEButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        TeleportPEButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TeleportPEButton.Font = Enum.Font.SourceSansBold
        TeleportPEButton.TextSize = 30

        -- Tạo nút TP trên màn hình (Không bị mất khi chết)
        local screenGui = Instance.new("ScreenGui", game.CoreGui) -- Chuyển qua CoreGui để tránh bị reset khi chết
        local MobileTPButton = Instance.new("TextButton", screenGui)
        MobileTPButton.Size = UDim2.new(0, 40, 0, 40) -- Nhỏ lại 1/3
        MobileTPButton.Position = UDim2.new(0.92, 0, 0.5, -13) -- Trung điểm cạnh phải
        MobileTPButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        MobileTPButton.BackgroundTransparency = 0.5 -- Xám trong suốt
        MobileTPButton.Text = "⚡"
        MobileTPButton.TextScaled = true
        MobileTPButton.TextColor3 = Color3.new(1, 1, 1)
        MobileTPButton.Visible = false

        -- Bo tròn nút TP
        local UICorner = Instance.new("UICorner", MobileTPButton)
        UICorner.CornerRadius = UDim.new(1, 0)

        -- Khi bật chức năng TP
        local function ToggleTeleport()
            teleportEnabled = not teleportEnabled
            TeleportPEButton.Text = teleportEnabled and "ON" or "OFF"
            TeleportPEButton.BackgroundColor3 = teleportEnabled and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)

            -- Hiện/ẩn nút tròn trên màn hình
            MobileTPButton.Visible = teleportEnabled
            tpButtonActive = false
            MobileTPButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        end

        TeleportPEButton.MouseButton1Click:Connect(ToggleTeleport)

        -- Khi bấm nút tròn TP
        MobileTPButton.MouseButton1Click:Connect(function()
            if tpButtonActive then
                -- Nếu đang chờ TP -> Hủy TP
                tpButtonActive = false
                MobileTPButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100) -- Reset lại xám
            else
                -- Bật trạng thái chờ TP
                tpButtonActive = true
                MobileTPButton.BackgroundColor3 = Color3.fromRGB(0, 0, 139) -- Xanh dương
            end
        end)

        -- Khi click vào màn hình để TP
        local function TeleportToMouse()
            if teleportEnabled and tpButtonActive then
                local targetPosition = mouse.Hit.Position
                local character = player.Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    local rootPart = character.HumanoidRootPart
                    local distance = (rootPart.Position - targetPosition).Magnitude
                    if distance <= 250 then
                        rootPart.CFrame = CFrame.new(targetPosition)
                        tpButtonActive = false
                        MobileTPButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100) -- Reset lại xám
                    end
                end
            end
        end

        -- Cho PC: Bấm chuột trái để TP
        mouse.Button1Down:Connect(TeleportToMouse)

        -- Cho PE: Chạm vào màn hình để TP
        userInputService.TouchTap:Connect(function(_, processed)
            if not processed then
                TeleportToMouse()
            end
        end)

        --reset
        player.CharacterAdded:Connect(function()
            teleportEnabled = false
            tpButtonActive = false
            TeleportPEButton.Text = "OFF"
            TeleportPEButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
            MobileTPButton.Visible = false
            MobileTPButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        end)
    end

        --IFN JUMP======================================================================================================
    do
        local player = game.Players.LocalPlayer
        local userInputService = game:GetService("UserInputService")

        local infiniteJumpEnabled = false
        local jumpConnection

        -- Nút bật/tắt Infinite Jump
        local jumpButton = Instance.new("TextButton", HomeFrame)
        jumpButton.Size = UDim2.new(0, 90, 0, 30)
        jumpButton.Position = UDim2.new(0, 240, 0, 210)
        jumpButton.Text = "OFF"
        jumpButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        jumpButton.TextColor3 = Color3.new(1, 1, 1)
        jumpButton.Font = Enum.Font.SourceSansBold
        jumpButton.TextSize = 30

        -- Kết nối sự kiện nhảy
        jumpConnection = userInputService.JumpRequest:Connect(function()
            if infiniteJumpEnabled then
                local char = player.Character
                if char and char:FindFirstChildOfClass("Humanoid") then
                    char:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)

        -- Xử lý bật/tắt
        jumpButton.MouseButton1Click:Connect(function()
            infiniteJumpEnabled = not infiniteJumpEnabled
            jumpButton.Text = infiniteJumpEnabled and "ON" or "OFF"
            jumpButton.BackgroundColor3 = infiniteJumpEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(250, 50, 50)
        end)
    end

        --Auto Buso======================================================================================================
    do
        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local Workspace = game:GetService("Workspace")

        local player = Players.LocalPlayer
        local CHECK_INTERVAL = 3

        -- internal state (đồng bộ với Attribute "AutoBuso")
        local autoBuso = true

        -- ===== UI =====
        local busoButton = Instance.new("TextButton", HomeFrame)
        busoButton.Size = UDim2.new(0, 90, 0, 30)
        busoButton.Position = UDim2.new(0, 240, 0, 260)
        busoButton.TextColor3 = Color3.new(1,1,1)
        busoButton.Font = Enum.Font.SourceSansBold
        busoButton.TextScaled = true

        local function updateButtonUI(state)
            busoButton.Text = state and "ON" or "OFF"
            busoButton.BackgroundColor3 = state and Color3.fromRGB(50,255,50) or Color3.fromRGB(255,50,50)
        end

        -- init UI from default/attribute
        do
            local attr = player:GetAttribute("AutoBuso")
            if attr ~= nil then
                autoBuso = (attr == true)
            else
                -- nếu chưa có attribute, khởi tạo attribute theo giá trị mặc định của script
                player:SetAttribute("AutoBuso", autoBuso)
            end
            updateButtonUI(autoBuso)
        end

        -- ===== Helpers =====
        local function getCharacterModel()
            local chars = Workspace:FindFirstChild("Characters")
            return chars and chars:FindFirstChild(player.Name)
        end

        local function isBusoOn()
            local char = getCharacterModel()
            return char and char:FindFirstChild("HasBuso") ~= nil
        end

        local function turnOnBuso()
            -- pcall để tránh lỗi nếu remote không tồn tại / bị thay đổi
            pcall(function()
                ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
            end)
        end

        -- ===== Auto Loop =====
        task.spawn(function()
            while true do
                if autoBuso then
                    -- chỉ gọi khi chắc chắn chưa bật
                    if not isBusoOn() then
                        turnOnBuso()
                    end
                end
                task.wait(CHECK_INTERVAL)
            end
        end)

        -- ===== UI Toggle (bấm bằng chuột) =====
        busoButton.MouseButton1Click:Connect(function()
            -- không set local variable trực tiếp nữa, set Attribute để đồng bộ với external hooks
            local newVal = not (player:GetAttribute("AutoBuso") == true)
            player:SetAttribute("AutoBuso", newVal)
        end)

        -- ===== Attribute listener: khi script khác set Attribute hoặc UI đổi attribute sẽ vào đây =====
        player:GetAttributeChangedSignal("AutoBuso"):Connect(function()
            local v = player:GetAttribute("AutoBuso")
            autoBuso = (v == true)
            updateButtonUI(autoBuso)
        end)

        -- ===== Polling lightweight: hỗ trợ legacy shared.AutoBuso = true/false =====
        task.spawn(function()
            local lastShared = nil
            while true do
                task.wait(0.15)
                local s = (shared and shared.AutoBuso)
                if s ~= lastShared then
                    lastShared = s
                    if s ~= nil then
                        -- push vào Attribute (giữ Attribute là nguồn chân thực)
                        player:SetAttribute("AutoBuso", s == true)
                    end
                end
            end
        end)

        shared = shared or {}
        shared.ToggleAutoBuso = function(val)
            player:SetAttribute("AutoBuso", val == true)
        end
    end
    --[[HOOK
game.Players.LocalPlayer:SetAttribute("AutoBuso", true)  -- bật
game.Players.LocalPlayer:SetAttribute("AutoBuso", false) -- tắt
    ]]
        --Auto Observe======================================================================================================
    do
        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")

        local player = Players.LocalPlayer
        local INTERVAL = 5 -- 5 giây / lần

        -- internal state (nguồn chân thực là Attribute)
        local autoObserve = false

        -- ===== UI =====
        local observeButton = Instance.new("TextButton", HomeFrame)
        observeButton.Size = UDim2.new(0, 90, 0, 30)
        observeButton.Position = UDim2.new(0, 240, 0, 310)
        observeButton.TextColor3 = Color3.new(1, 1, 1)
        observeButton.Font = Enum.Font.SourceSansBold
        observeButton.TextScaled = true

        local function updateButtonUI(state)
            observeButton.Text = state and "ON" or "OFF"
            observeButton.BackgroundColor3 =
                state and Color3.fromRGB(50,255,50) or Color3.fromRGB(255,50,50)
        end

        -- ===== Khởi tạo từ Attribute nếu có =====
        do
            local attr = player:GetAttribute("AutoObserve")
            if attr ~= nil then
                autoObserve = (attr == true)
            else
                player:SetAttribute("AutoObserve", autoObserve)
            end
            updateButtonUI(autoObserve)
        end

        -- ===== Gọi bật Observe =====
        local function enableObserve()
            pcall(function()
                ReplicatedStorage.Remotes.CommE:FireServer("Ken", true)
            end)
        end

        -- ===== Auto Loop (giữ logic cũ, nhẹ CPU) =====
        task.spawn(function()
            while true do
                if autoObserve then
                    enableObserve()
                    task.wait(INTERVAL)
                else
                    task.wait(0.3)
                end
            end
        end)

        -- ===== UI Toggle (chỉ set Attribute) =====
        observeButton.MouseButton1Click:Connect(function()
            local newVal = not (player:GetAttribute("AutoObserve") == true)
            player:SetAttribute("AutoObserve", newVal)
        end)

        -- ===== Attribute listener (UI + script khác đều đi qua đây) =====
        player:GetAttributeChangedSignal("AutoObserve"):Connect(function()
            local v = player:GetAttribute("AutoObserve")
            autoObserve = (v == true)
            updateButtonUI(autoObserve)

            -- bật là gọi Observe ngay lập tức (giữ đúng hành vi cũ)
            if autoObserve then
                enableObserve()
            end
        end)

        -- ===== Polling nhẹ: hỗ trợ legacy shared.AutoObserve =====
        task.spawn(function()
            local lastShared = nil
            while true do
                task.wait(0.15)
                local s = (shared and shared.AutoObserve)
                if s ~= lastShared then
                    lastShared = s
                    if s ~= nil then
                        player:SetAttribute("AutoObserve", s == true)
                    end
                end
            end
        end)

        -- ===== Optional helper cho script rất cũ =====
        shared = shared or {}
        shared.ToggleAutoObserve = function(val)
            player:SetAttribute("AutoObserve", val == true)
        end
    end
    --[[HOOK
game.Players.LocalPlayer:SetAttribute("AutoObserve", true)   -- bật
game.Players.LocalPlayer:SetAttribute("AutoObserve", false)  -- tắt
    ]]
        --AUTO Auto Ability & Auto Awakening===============================================================================
    do
        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local UIS = game:GetService("UserInputService")

        local player = Players.LocalPlayer
        local INTERVAL = 5

        -- internal state (ui chỉ hiển thị; logic chính đọc Attribute trực tiếp)
        local awakeningBusy = false

        -- ===== UI: Auto Ability =====
        local abilityBtn = Instance.new("TextButton", HomeFrame)
        abilityBtn.Size = UDim2.new(0, 90, 0, 30)
        abilityBtn.Position = UDim2.new(0, 240, 0, 360)
        abilityBtn.TextColor3 = Color3.new(1,1,1)
        abilityBtn.Font = Enum.Font.SourceSansBold
        abilityBtn.TextScaled = true

        -- ===== UI: Auto Awakening =====
        local awakenBtn = Instance.new("TextButton", HomeFrame)
        awakenBtn.Size = UDim2.new(0, 90, 0, 30)
        awakenBtn.Position = UDim2.new(0, 240, 0, 410)
        awakenBtn.TextColor3 = Color3.new(1,1,1)
        awakenBtn.Font = Enum.Font.SourceSansBold
        awakenBtn.TextScaled = true

        local function updateAbilityUI(state)
            abilityBtn.Text = state and "ON" or "OFF"
            abilityBtn.BackgroundColor3 =
                state and Color3.fromRGB(50,255,50) or Color3.fromRGB(255,50,50)
        end

        local function updateAwakenUI(state)
            awakenBtn.Text = state and "ON" or "OFF"
            awakenBtn.BackgroundColor3 =
                state and Color3.fromRGB(50,255,50) or Color3.fromRGB(255,50,50)
        end

        -- ===== Init từ Attribute nếu có =====
        do
            local a = player:GetAttribute("AutoAbility")
            local w = player:GetAttribute("AutoAwakening")

            if a ~= nil then updateAbilityUI(a == true) else player:SetAttribute("AutoAbility", false) end
            if w ~= nil then updateAwakenUI(w == true) else player:SetAttribute("AutoAwakening", false) end
        end

        -- ===== Actions =====
        local function fireAbility()
            -- non-blocking fire (FireServer không yield)
            pcall(function()
                if ReplicatedStorage and ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CommE") then
                    ReplicatedStorage.Remotes.CommE:FireServer("ActivateAbility")
                end
            end)
        end

        -- Awakening: non-blocking attempt, đảm bảo awakeningBusy luôn reset
        local function fireAwakening()
            if awakeningBusy then return end
            awakeningBusy = true

            task.spawn(function()
                local success = false
                local startT = tick()

                -- chờ Backpack + item Awakening tối đa 3s (như trước)
                local bp = player:FindFirstChild("Backpack")
                local waited = 0
                while waited < 3 and (not bp or not bp:FindFirstChild("Awakening")) do
                    task.wait(0.2)
                    waited = waited + 0.2
                    bp = player:FindFirstChild("Backpack")
                end

                local awak = bp and bp:FindFirstChild("Awakening")
                if awak then
                    local rf = awak:FindFirstChild("RemoteFunction")
                    if rf and typeof(rf.InvokeServer) == "function" then
                        -- pcall để tránh error văng ra; làm non-blocking bằng task.spawn phía trên
                        local ok, err = pcall(function()
                            -- InvokeServer có thể yield lâu; nhưng đang chạy trong task.spawn
                            rf:InvokeServer(true)
                        end)
                        if ok then success = true end
                    end
                end

                awakeningBusy = false
                return success
            end)
        end

        -- ===== Auto Loops (đọc Attribute trực tiếp) =====
        task.spawn(function()
            while true do
                local enabled = (player:GetAttribute("AutoAbility") == true)
                if enabled then
                    -- gọi ngay rồi chờ interval
                    fireAbility()
                    task.wait(INTERVAL)
                else
                    task.wait(0.25)
                end
            end
        end)

        task.spawn(function()
            while true do
                local enabled = (player:GetAttribute("AutoAwakening") == true)
                if enabled then
                    fireAwakening()
                    task.wait(INTERVAL)
                else
                    task.wait(0.25)
                end
            end
        end)

        -- ===== Attribute listeners (UI sync) =====
        player:GetAttributeChangedSignal("AutoAbility"):Connect(function()
            local v = player:GetAttribute("AutoAbility")
            updateAbilityUI(v == true)
            if v == true then
                -- kích hoạt ngay
                fireAbility()
            end
        end)

        player:GetAttributeChangedSignal("AutoAwakening"):Connect(function()
            local v = player:GetAttribute("AutoAwakening")
            updateAwakenUI(v == true)
            if v == true then
                fireAwakening()
            end
        end)

        -- ===== UI chỉ set Attribute =====
        abilityBtn.MouseButton1Click:Connect(function()
            local cur = player:GetAttribute("AutoAbility")
            player:SetAttribute("AutoAbility", not (cur == true))
        end)

        awakenBtn.MouseButton1Click:Connect(function()
            local cur = player:GetAttribute("AutoAwakening")
            player:SetAttribute("AutoAwakening", not (cur == true))
        end)

        -- ===== Respawn / humanoid died fixes =====
        -- ensure awakeningBusy reset and UI re-sync
        local function onCharacter(c)
            awakeningBusy = false
            -- re-sync UI from attributes in case something changed while dead
            updateAbilityUI(player:GetAttribute("AutoAbility") == true)
            updateAwakenUI(player:GetAttribute("AutoAwakening") == true)

            -- optional: listen to Humanoid.Died to reset
            local hum = c:WaitForChild("Humanoid", 5)
            if hum then
                hum.Died:Connect(function()
                    awakeningBusy = false
                end)
            end
        end

        if player.Character then
            onCharacter(player.Character)
        end
        player.CharacterAdded:Connect(onCharacter)

        -- ===== shared hook (legacy) =====
        task.spawn(function()
            local lastA, lastW = nil, nil
            while true do
                task.wait(0.15)
                local sa = shared and shared.AutoAbility
                local sw = shared and shared.AutoAwakening

                if sa ~= lastA then
                    lastA = sa
                    if sa ~= nil then
                        -- support boolean or string values (true/false or "on"/"off")
                        if type(sa) == "string" then
                            local low = string.lower(sa)
                            if low == "on" or low == "true" then
                                player:SetAttribute("AutoAbility", true)
                            elseif low == "off" or low == "false" then
                                player:SetAttribute("AutoAbility", false)
                            end
                        else
                            player:SetAttribute("AutoAbility", sa == true)
                        end
                    end
                end

                if sw ~= lastW then
                    lastW = sw
                    if sw ~= nil then
                        if type(sw) == "string" then
                            local low = string.lower(sw)
                            if low == "on" or low == "true" then
                                player:SetAttribute("AutoAwakening", true)
                            elseif low == "off" or low == "false" then
                                player:SetAttribute("AutoAwakening", false)
                            end
                        else
                            player:SetAttribute("AutoAwakening", sw == true)
                        end
                    end
                end
            end
        end)

        -- helper optional
        shared = shared or {}
        shared.ToggleAutoAbility = function(v)
            player:SetAttribute("AutoAbility", v == true)
        end
        shared.ToggleAutoAwakening = function(v)
            player:SetAttribute("AutoAwakening", v == true)
        end
    end

    --[[HOOK
game.Players.LocalPlayer:SetAttribute("AutoAbility", true)
game.Players.LocalPlayer:SetAttribute("AutoAwakening", false)
    ]]

        --SELECT TEAM======================================================================================================
    do
        -- Tạo frame chứa 2 nút
        local teamFrame = Instance.new("Frame", HomeFrame)
        teamFrame.Size = UDim2.new(0, 320, 0, 40)
        teamFrame.Position = UDim2.new(0, 10, 0, 455)
        teamFrame.BackgroundTransparency = 1

        -- Marines Button
        local btnMarines = Instance.new("TextButton", teamFrame)
        btnMarines.Size = UDim2.new(0, 160, 0, 40)
        btnMarines.Position = UDim2.new(0, 0, 0, 0)
        btnMarines.Text = "Marines"
        btnMarines.BackgroundColor3 = Color3.fromRGB(52, 152, 219)
        btnMarines.TextColor3 = Color3.new(1, 1, 1)
        btnMarines.Font = Enum.Font.SourceSansBold
        btnMarines.TextSize = 20
        btnMarines.BorderSizePixel = 0

        -- Pirates Button
        local btnPirates = Instance.new("TextButton", teamFrame)
        btnPirates.Size = UDim2.new(0, 160, 0, 40)
        btnPirates.Position = UDim2.new(0, 160, 0, 0)
        btnPirates.Text = "Pirates"
        btnPirates.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
        btnPirates.TextColor3 = Color3.new(1, 1, 1)
        btnPirates.Font = Enum.Font.SourceSansBold
        btnPirates.TextSize = 20
        btnPirates.BorderSizePixel = 0

        -- Overlay để chặn bấm + countdown
        local cooldownOverlay = Instance.new("TextLabel", teamFrame)
        cooldownOverlay.Size = UDim2.new(1, 0, 1, 0)
        cooldownOverlay.Position = UDim2.new(0, 0, 0, 0)
        cooldownOverlay.BackgroundColor3 = Color3.new(0, 0, 0)
        cooldownOverlay.BackgroundTransparency = 0.4
        cooldownOverlay.TextColor3 = Color3.new(1, 1, 1)
        cooldownOverlay.Font = Enum.Font.SourceSansBold
        cooldownOverlay.TextSize = 20
        cooldownOverlay.Text = ""
        cooldownOverlay.Visible = false

        -- Hàm cooldown 10s
        local isCooldown = false
        local function handleCooldown()
        	isCooldown = true
        	btnMarines.Active = false
        	btnMarines.AutoButtonColor = false
        	btnPirates.Active = false
        	btnPirates.AutoButtonColor = false
        	cooldownOverlay.Visible = true

        	for i = 10, 1, -1 do
        		cooldownOverlay.Text = "Wait " .. i .. "s"
        		wait(1)
        	end

        	cooldownOverlay.Text = ""
        	cooldownOverlay.Visible = false
        	btnMarines.Active = true
        	btnMarines.AutoButtonColor = true
        	btnPirates.Active = true
        	btnPirates.AutoButtonColor = true
        	isCooldown = false
        end

        -- Xử lý nút
        btnMarines.MouseButton1Click:Connect(function()
        	if isCooldown then return end
        	local args = { "SetTeam", "Marines" }
        	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
        	handleCooldown()
        end)

        btnPirates.MouseButton1Click:Connect(function()
        	if isCooldown then return end
        	local args = { "SetTeam", "Pirates" }
        	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
        	handleCooldown()
        end)
    end

    wait(0.2)

    print("Player_v0.10 tad SUCCESS✅")
end
