return function(sections)
    local HomeFrame = sections["Tracker"]

        --Player view-----------------------------------------------------------------------------------------------------------
    do
        local players = game:GetService("Players")
        local localPlayer = players.LocalPlayer
        local camera = game.Workspace.CurrentCamera

        local buttons = {} -- Lưu các nút của người chơi
        local originalCameraSubject = camera.CameraSubject -- Lưu trạng thái camera ban đầu
        local viewingPlayer = nil -- Người chơi đang được xem

        -- Hàm cập nhật danh sách người chơi
        local function updatePlayerList()
            -- Xóa các nút cũ trước khi tạo mới
            for _, button in pairs(buttons) do
                button:Destroy()
            end
            buttons = {}

            -- Tạo danh sách nút người chơi
            local yOffset = 10 -- Vị trí y ban đầu
            for _, player in pairs(players:GetPlayers()) do
                if player ~= localPlayer then -- Không hiển thị bản thân
                    local PlayerButton = Instance.new("TextButton", HomeFrame)
                    PlayerButton.Size = UDim2.new(0, 300, 0, 40)
                    PlayerButton.Position = UDim2.new(0, 10, 0, yOffset)
                    PlayerButton.Text = player.Name
                    PlayerButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
                    PlayerButton.TextColor3 = Color3.new(1, 1, 1)

                    -- Khi bấm vào nút
                    PlayerButton.MouseButton1Click:Connect(function()
                        if viewingPlayer == player then
                            -- Nếu đang xem người này, quay về bản thân
                            camera.CameraSubject = localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") or camera.CameraSubject
                            viewingPlayer = nil
                        else
                            -- Chuyển camera qua người chơi được chọn
                            if player.Character and player.Character:FindFirstChild("Humanoid") then
                                camera.CameraSubject = player.Character.Humanoid
                                viewingPlayer = player
                            end
                        end
                    end)

                    table.insert(buttons, PlayerButton) -- Lưu nút vào danh sách
                    yOffset = yOffset + 50 -- Dịch vị trí xuống dòng tiếp theo
                end
            end
        end

        -- Khi có người vào hoặc rời khỏi server, cập nhật danh sách
        players.PlayerAdded:Connect(updatePlayerList)
        players.PlayerRemoving:Connect(updatePlayerList)

        -- Cập nhật danh sách ban đầu khi script chạy
        updatePlayerList()
    end
end
