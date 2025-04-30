return function(sections)
    local HomeFrame = sections["Page change"]

    --====================================================================
    -- RAID ---------------------------------------------------------
    do
        local HomeFrame = sections["Raid"]

        local TitleRaid = Instance.new("TextLabel", HomeFrame)
        TitleRaid.Size = UDim2.new(0, 220, 0, 30)
        TitleRaid.Position = UDim2.new(0, 10, 0, 10)
        TitleRaid.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TitleRaid.TextColor3 = Color3.new(1, 1, 1)
        TitleRaid.Text = "AUTO RAID💀"
        TitleRaid.TextScaled = true
        TitleRaid.Font = Enum.Font.SourceSansBold
        TitleRaid.BorderSizePixel = 2
        TitleRaid.BorderColor3 = Color3.new(255, 255, 255)
    end

    -- HOME ---------------------------------------------------------
    do
        local HomeFrame = sections["Home"]

        local TitleHome = Instance.new("TextLabel", HomeFrame)
        TitleHome.Size = UDim2.new(0, 220, 0, 30)
        TitleHome.Position = UDim2.new(0, 10, 0, 60)
        TitleHome.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TitleHome.TextColor3 = Color3.new(1, 1, 1)
        TitleHome.Text = "AUTO FRAM LV🔼"
        TitleHome.TextScaled = true
        TitleHome.Font = Enum.Font.SourceSansBold
        TitleHome.BorderSizePixel = 2
        TitleHome.BorderColor3 = Color3.new(255, 255, 255)

        local TitleBone = Instance.new("TextLabel", HomeFrame)
        TitleBone.Size = UDim2.new(0, 220, 0, 30)
        TitleBone.Position = UDim2.new(0, 10, 0, 110)
        TitleBone.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TitleBone.TextColor3 = Color3.new(1, 1, 1)
        TitleBone.Text = "AUTO FRAM BONE🦴"
        TitleBone.TextScaled = true
        TitleBone.Font = Enum.Font.SourceSansBold
        TitleBone.BorderSizePixel = 2
        TitleBone.BorderColor3 = Color3.new(255, 255, 255)
    end

    -- VISUAL ---------------------------------------------------------
    do
        local HomeFrame = sections["Visual"]

        local TitleESPPlayer = Instance.new("TextLabel", HomeFrame)
        TitleESPPlayer.Size = UDim2.new(0, 220, 0, 30)
        TitleESPPlayer.Position = UDim2.new(0, 10, 0, 10)
        TitleESPPlayer.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TitleESPPlayer.TextColor3 = Color3.new(1, 1, 1)
        TitleESPPlayer.Text = "ESP PLAYER👤"
        TitleESPPlayer.TextScaled = true
        TitleESPPlayer.Font = Enum.Font.SourceSansBold
        TitleESPPlayer.BorderSizePixel = 2
        TitleESPPlayer.BorderColor3 = Color3.new(255, 255, 255)

        local TitleESPNPC = Instance.new("TextLabel", HomeFrame)
        TitleESPNPC.Size = UDim2.new(0, 220, 0, 30)
        TitleESPNPC.Position = UDim2.new(0, 10, 0, 60)
        TitleESPNPC.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TitleESPNPC.TextColor3 = Color3.new(1, 1, 1)
        TitleESPNPC.Text = "ESP ENEMIES🧟"
        TitleESPNPC.TextScaled = true
        TitleESPNPC.Font = Enum.Font.SourceSansBold
        TitleESPNPC.BorderSizePixel = 2
        TitleESPNPC.BorderColor3 = Color3.new(255, 255, 255)

        local TitleLight = Instance.new("TextLabel", HomeFrame)
        TitleLight.Size = UDim2.new(0, 220, 0, 30)
        TitleLight.Position = UDim2.new(0, 10, 0, 110)
        TitleLight.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TitleLight.TextColor3 = Color3.new(1, 1, 1)
        TitleLight.Text = "LIGHT💡"
        TitleLight.TextScaled = true
        TitleLight.Font = Enum.Font.SourceSansBold
        TitleLight.BorderSizePixel = 2
        TitleLight.BorderColor3 = Color3.new(255, 255, 255)
    end

    -- FRUIT ---------------------------------------------------------
    do
        local HomeFrame = sections["Fruit"]

        local TitleFruit = Instance.new("TextLabel", HomeFrame)
        TitleFruit.Size = UDim2.new(0, 220, 0, 30)
        TitleFruit.Position = UDim2.new(0, 10, 0, 10)
        TitleFruit.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TitleFruit.TextColor3 = Color3.new(1, 1, 1)
        TitleFruit.Text = "ESP FRUIT🍇"
        TitleFruit.TextScaled = true
        TitleFruit.Font = Enum.Font.SourceSansBold
        TitleFruit.BorderSizePixel = 2
        TitleFruit.BorderColor3 = Color3.new(255, 255, 255)

        local ColectFruit = Instance.new("TextLabel", HomeFrame)
        ColectFruit.Size = UDim2.new(0, 220, 0, 30)
        ColectFruit.Position = UDim2.new(0, 10, 0, 60)
        ColectFruit.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        ColectFruit.TextColor3 = Color3.new(1, 1, 1)
        ColectFruit.Text = "🏃‍♂️COLECT FRUIT🍇"
        ColectFruit.TextScaled = true
        ColectFruit.Font = Enum.Font.SourceSansBold
        ColectFruit.BorderSizePixel = 2
        ColectFruit.BorderColor3 = Color3.new(255, 255, 255)
    end

    -- PLAYER ---------------------------------------------------------
    do
        local HomeFrame = sections["Player"]

        local TitleSpeed = Instance.new("TextLabel", HomeFrame)
        TitleSpeed.Size = UDim2.new(0, 170, 0, 30)
        TitleSpeed.Position = UDim2.new(0, 10, 0, 10)
        TitleSpeed.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TitleSpeed.TextColor3 = Color3.new(1, 1, 1)
        TitleSpeed.Text = "SPEED⚡"
        TitleSpeed.TextScaled = true
        TitleSpeed.Font = Enum.Font.SourceSansBold
        TitleSpeed.BorderSizePixel = 2
        TitleSpeed.BorderColor3 = Color3.new(255, 255, 255)

        local TitleNoClip = Instance.new("TextLabel", HomeFrame)
        TitleNoClip.Size = UDim2.new(0, 220, 0, 30)
        TitleNoClip.Position = UDim2.new(0, 10, 0, 60)
        TitleNoClip.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TitleNoClip.TextColor3 = Color3.new(1, 1, 1)
        TitleNoClip.Text = "NO CLIP🧱"
        TitleNoClip.TextScaled = true
        TitleNoClip.Font = Enum.Font.SourceSansBold
        TitleNoClip.BorderSizePixel = 2
        TitleNoClip.BorderColor3 = Color3.new(255, 255, 255)

        local TitleTPKey = Instance.new("TextLabel", HomeFrame)
        TitleTPKey.Size = UDim2.new(0, 170, 0, 30)
        TitleTPKey.Position = UDim2.new(0, 10, 0, 110)
        TitleTPKey.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TitleTPKey.TextColor3 = Color3.new(1, 1, 1)
        TitleTPKey.Text = "TP PC🖱️"
        TitleTPKey.TextScaled = true
        TitleTPKey.Font = Enum.Font.SourceSansBold
        TitleTPKey.BorderSizePixel = 2
        TitleTPKey.BorderColor3 = Color3.new(255, 255, 255)

        local TitleTPButton = Instance.new("TextLabel", HomeFrame)
        TitleTPButton.Size = UDim2.new(0, 220, 0, 30)
        TitleTPButton.Position = UDim2.new(0, 10, 0, 160)
        TitleTPButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TitleTPButton.TextColor3 = Color3.new(1, 1, 1)
        TitleTPButton.Text = "TP PE📱"
        TitleTPButton.TextScaled = true
        TitleTPButton.Font = Enum.Font.SourceSansBold
        TitleTPButton.BorderSizePixel = 2
        TitleTPButton.BorderColor3 = Color3.new(255, 255, 255)

        local TitleTPButton = Instance.new("TextLabel", HomeFrame)
        TitleTPButton.Size = UDim2.new(0, 220, 0, 30)
        TitleTPButton.Position = UDim2.new(0, 10, 0, 210)
        TitleTPButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TitleTPButton.TextColor3 = Color3.new(1, 1, 1)
        TitleTPButton.Text = "IFN JUMP🦘"
        TitleTPButton.TextScaled = true
        TitleTPButton.Font = Enum.Font.SourceSansBold
        TitleTPButton.BorderSizePixel = 2
        TitleTPButton.BorderColor3 = Color3.new(255, 255, 255)

        local TitleTPKey = Instance.new("TextLabel", HomeFrame)
        TitleTPKey.Size = UDim2.new(0, 170, 0, 30)
        TitleTPKey.Position = UDim2.new(0, 10, 0, 260)
        TitleTPKey.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TitleTPKey.TextColor3 = Color3.new(1, 1, 1)
        TitleTPKey.Text = "AIMBOT PC🎯🖱️"
        TitleTPKey.TextScaled = true
        TitleTPKey.Font = Enum.Font.SourceSansBold
        TitleTPKey.BorderSizePixel = 2
        TitleTPKey.BorderColor3 = Color3.new(255, 255, 255)

        local TitleTPButton = Instance.new("TextLabel", HomeFrame)
        TitleTPButton.Size = UDim2.new(0, 220, 0, 30)
        TitleTPButton.Position = UDim2.new(0, 10, 0, 310)
        TitleTPButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TitleTPButton.TextColor3 = Color3.new(1, 1, 1)
        TitleTPButton.Text = "AIMBOT PE🎯📱"
        TitleTPButton.TextScaled = true
        TitleTPButton.Font = Enum.Font.SourceSansBold
        TitleTPButton.BorderSizePixel = 2
        TitleTPButton.BorderColor3 = Color3.new(255, 255, 255)
    end

    -- STATUS ---------------------------------------------------------
    do
        local HomeFrame = sections["Status"]

        local TitleMoon = Instance.new("TextLabel", HomeFrame)
        TitleMoon.Size = UDim2.new(0, 220, 0, 80)
        TitleMoon.Position = UDim2.new(0, 10, 0, 10)
        TitleMoon.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TitleMoon.TextColor3 = Color3.new(1, 1, 1)
        TitleMoon.Text = "Moon"
        TitleMoon.TextScaled = true
        TitleMoon.Font = Enum.Font.SourceSansBold
        TitleMoon.BorderSizePixel = 2
        TitleMoon.BorderColor3 = Color3.new(255, 255, 255)

        local TitleCount = Instance.new("TextLabel", HomeFrame)
        TitleCount.Size = UDim2.new(0, 220, 0, 30)
        TitleCount.Position = UDim2.new(0, 10, 0, 110)
        TitleCount.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TitleCount.TextColor3 = Color3.new(1, 1, 1)
        TitleCount.Text = "Player"
        TitleCount.TextScaled = true
        TitleCount.Font = Enum.Font.SourceSansBold
        TitleCount.BorderSizePixel = 2
        TitleCount.BorderColor3 = Color3.new(255, 255, 255)
    end

    -- PVP ---------------------------------------------------------
    do
        local HomeFrame = sections["PVP"]

        local TitleSpeed = Instance.new("TextLabel", HomeFrame)
        TitleSpeed.Size = UDim2.new(0, 170, 0, 30)
        TitleSpeed.Position = UDim2.new(0, 10, 0, 10)
        TitleSpeed.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TitleSpeed.TextColor3 = Color3.new(1, 1, 1)
        TitleSpeed.Text = "FOLLOW PLAYER🚶‍♂️"
        TitleSpeed.TextScaled = true
        TitleSpeed.Font = Enum.Font.SourceSansBold
        TitleSpeed.BorderSizePixel = 2
        TitleSpeed.BorderColor3 = Color3.new(255, 255, 255)
    end

    wait(0.2)

    print("TITLE SUCCESS✅")
end
