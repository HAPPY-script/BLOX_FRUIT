return function(sections)
    local HomeFrame = sections["Shop"]

    do
        local btnBuyCyborg = Instance.new("TextButton", HomeFrame)
        btnBuyCyborg.Size  = UDim2.new(0, 320, 0, 40)
        btnBuyCyborg.Position = UDim2.new(0, 10, 0, 10)
        btnBuyCyborg.Text  = "🤖 Buy Cyborg Race"
        btnBuyCyborg.BackgroundColor3 = Color3.fromRGB(179, 0, 255)
        btnBuyCyborg.TextColor3 = Color3.new(0, 0, 0)
        btnBuyCyborg.Font = Enum.Font.SourceSansBold
        btnBuyCyborg.TextSize = 30

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

    wait(0.2)

    print("Shop tad SUCCESS✅")
end
