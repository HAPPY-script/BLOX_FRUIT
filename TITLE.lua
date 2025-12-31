return function(sections)
    local HomeFrame = sections["Page change"]

    --====================================================================
    -- RAID ---------------------------------------------------------
    do
        local HomeFrame = sections["Raid"]

        local TitleRaid = Instance.new("TextLabel", HomeFrame)
        TitleRaid.Size = UDim2.new(0, 170, 0, 30)
        TitleRaid.Position = UDim2.new(0, 10, 0, 10)
        TitleRaid.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TitleRaid.TextColor3 = Color3.new(1, 1, 1)
        TitleRaid.Text = "AUTO RAID💀"
        TitleRaid.TextScaled = true
        TitleRaid.Font = Enum.Font.SourceSansBold
        TitleRaid.BorderSizePixel = 2
        TitleRaid.BorderColor3 = Color3.new(255, 255, 255)

        local DungeonUI = Instance.new("TextLabel", HomeFrame)
        DungeonUI.Size = UDim2.new(0, 220, 0, 30)
        DungeonUI.Position = UDim2.new(0, 10, 0, 110)
        DungeonUI.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        DungeonUI.TextColor3 = Color3.new(1, 1, 1)
        DungeonUI.Text = "AUTO DUNGEON🪓"
        DungeonUI.TextScaled = true
        DungeonUI.Font = Enum.Font.SourceSansBold
        DungeonUI.BorderSizePixel = 2
        DungeonUI.BorderColor3 = Color3.new(255, 255, 255)

        local BuffDungeonUI = Instance.new("TextLabel", HomeFrame)
        BuffDungeonUI.Size = UDim2.new(0, 220, 0, 30)
        BuffDungeonUI.Position = UDim2.new(0, 10, 0, 160)
        BuffDungeonUI.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        BuffDungeonUI.TextColor3 = Color3.new(1, 1, 1)
        BuffDungeonUI.Text = "AUTO BUFF SELECT💫 (testing)"
        BuffDungeonUI.TextScaled = true
        BuffDungeonUI.Font = Enum.Font.SourceSansBold
        BuffDungeonUI.BorderSizePixel = 2
        BuffDungeonUI.BorderColor3 = Color3.new(255, 255, 255)
    end

    -- HOME ---------------------------------------------------------
    do
        local HomeFrame = sections["Home"]

        local TitleHome = Instance.new("TextLabel", HomeFrame)
        TitleHome.Size = UDim2.new(0, 220, 0, 30)
        TitleHome.Position = UDim2.new(0, 10, 0, 60)
        TitleHome.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TitleHome.TextColor3 = Color3.new(1, 1, 1)
        TitleHome.Text = "AUTO FARM LV🔼"
        TitleHome.TextScaled = true
        TitleHome.Font = Enum.Font.SourceSansBold
        TitleHome.BorderSizePixel = 2
        TitleHome.BorderColor3 = Color3.new(255, 255, 255)

        local TitleBone = Instance.new("TextLabel", HomeFrame)
        TitleBone.Size = UDim2.new(0, 220, 0, 30)
        TitleBone.Position = UDim2.new(0, 10, 0, 110)
        TitleBone.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TitleBone.TextColor3 = Color3.new(1, 1, 1)
        TitleBone.Text = "AUTO FARM BONE🦴"
        TitleBone.TextScaled = true
        TitleBone.Font = Enum.Font.SourceSansBold
        TitleBone.BorderSizePixel = 2
        TitleBone.BorderColor3 = Color3.new(255, 255, 255)

        local TitleBone = Instance.new("TextLabel", HomeFrame)
        TitleBone.Size = UDim2.new(0, 220, 0, 30)
        TitleBone.Position = UDim2.new(0, 10, 0, 160)
        TitleBone.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TitleBone.TextColor3 = Color3.new(1, 1, 1)
        TitleBone.Text = "FARM ARENA🧟"
        TitleBone.TextScaled = true
        TitleBone.Font = Enum.Font.SourceSansBold
        TitleBone.BorderSizePixel = 2
        TitleBone.BorderColor3 = Color3.new(255, 255, 255)

        local TitleBone = Instance.new("TextLabel", HomeFrame)
        TitleBone.Size = UDim2.new(0, 220, 0, 30)
        TitleBone.Position = UDim2.new(0, 10, 0, 210)
        TitleBone.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TitleBone.TextColor3 = Color3.new(1, 1, 1)
        TitleBone.Text = "FARM ARENA DISTANCE LIMIT"
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

        local TitleTPMobile = Instance.new("TextLabel", HomeFrame)
        TitleTPMobile.Size = UDim2.new(0, 220, 0, 30)
        TitleTPMobile.Position = UDim2.new(0, 10, 0, 160)
        TitleTPMobile.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TitleTPMobile.TextColor3 = Color3.new(1, 1, 1)
        TitleTPMobile.Text = "TP PE📱"
        TitleTPMobile.TextScaled = true
        TitleTPMobile.Font = Enum.Font.SourceSansBold
        TitleTPMobile.BorderSizePixel = 2
        TitleTPMobile.BorderColor3 = Color3.new(255, 255, 255)

        local TitleInfJump = Instance.new("TextLabel", HomeFrame)
        TitleInfJump.Size = UDim2.new(0, 220, 0, 30)
        TitleInfJump.Position = UDim2.new(0, 10, 0, 210)
        TitleInfJump.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TitleInfJump.TextColor3 = Color3.new(1, 1, 1)
        TitleInfJump.Text = "IFN JUMP🦘"
        TitleInfJump.TextScaled = true
        TitleInfJump.Font = Enum.Font.SourceSansBold
        TitleInfJump.BorderSizePixel = 2
        TitleInfJump.BorderColor3 = Color3.new(255, 255, 255)

        local TitleAutoBuso = Instance.new("TextLabel", HomeFrame)
        TitleAutoBuso.Size = UDim2.new(0, 220, 0, 30)
        TitleAutoBuso.Position = UDim2.new(0, 10, 0, 260)
        TitleAutoBuso.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TitleAutoBuso.TextColor3 = Color3.new(1, 1, 1)
        TitleAutoBuso.Text = "AUTO BUSO✊"
        TitleAutoBuso.TextScaled = true
        TitleAutoBuso.Font = Enum.Font.SourceSansBold
        TitleAutoBuso.BorderSizePixel = 2
        TitleAutoBuso.BorderColor3 = Color3.new(255, 255, 255)

        local TitleAutoObserve = Instance.new("TextLabel", HomeFrame)
        TitleAutoObserve.Size = UDim2.new(0, 220, 0, 30)
        TitleAutoObserve.Position = UDim2.new(0, 10, 0, 310)
        TitleAutoObserve.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TitleAutoObserve.TextColor3 = Color3.new(1, 1, 1)
        TitleAutoObserve.Text = "AUTO OBSERVE👀"
        TitleAutoObserve.TextScaled = true
        TitleAutoObserve.Font = Enum.Font.SourceSansBold
        TitleAutoObserve.BorderSizePixel = 2
        TitleAutoObserve.BorderColor3 = Color3.new(255, 255, 255)

        local TitleAutoAbility = Instance.new("TextLabel", HomeFrame)
        TitleAutoAbility.Size = UDim2.new(0, 220, 0, 30)
        TitleAutoAbility.Position = UDim2.new(0, 10, 0, 360)
        TitleAutoAbility.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TitleAutoAbility.TextColor3 = Color3.new(1, 1, 1)
        TitleAutoAbility.Text = "AUTO ABILITY🌟"
        TitleAutoAbility.TextScaled = true
        TitleAutoAbility.Font = Enum.Font.SourceSansBold
        TitleAutoAbility.BorderSizePixel = 2
        TitleAutoAbility.BorderColor3 = Color3.new(255, 255, 255)

        local TitleAutoAwakening = Instance.new("TextLabel", HomeFrame)
        TitleAutoAwakening.Size = UDim2.new(0, 220, 0, 30)
        TitleAutoAwakening.Position = UDim2.new(0, 10, 0, 410)
        TitleAutoAwakening.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TitleAutoAwakening.TextColor3 = Color3.new(1, 1, 1)
        TitleAutoAwakening.Text = "AUTO AWAKENING🔥"
        TitleAutoAwakening.TextScaled = true
        TitleAutoAwakening.Font = Enum.Font.SourceSansBold
        TitleAutoAwakening.BorderSizePixel = 2
        TitleAutoAwakening.BorderColor3 = Color3.new(255, 255, 255)
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

        local TitleTPKey = Instance.new("TextLabel", HomeFrame)
        TitleTPKey.Size = UDim2.new(0, 170, 0, 30)
        TitleTPKey.Position = UDim2.new(0, 10, 0, 60)
        TitleTPKey.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TitleTPKey.TextColor3 = Color3.new(1, 1, 1)
        TitleTPKey.Text = "AIMBOT PC🎯🖱️"
        TitleTPKey.TextScaled = true
        TitleTPKey.Font = Enum.Font.SourceSansBold
        TitleTPKey.BorderSizePixel = 2
        TitleTPKey.BorderColor3 = Color3.new(255, 255, 255)

        local TitleButton = Instance.new("TextLabel", HomeFrame)
        TitleButton.Size = UDim2.new(0, 220, 0, 30)
        TitleButton.Position = UDim2.new(0, 10, 0, 110)
        TitleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TitleButton.TextColor3 = Color3.new(1, 1, 1)
        TitleButton.Text = "AIMBOT PE🎯📱"
        TitleButton.TextScaled = true
        TitleButton.Font = Enum.Font.SourceSansBold
        TitleButton.BorderSizePixel = 2
        TitleButton.BorderColor3 = Color3.new(255, 255, 255)

        local TitleButton = Instance.new("TextLabel", HomeFrame)
        TitleButton.Size = UDim2.new(0, 170, 0, 30)
        TitleButton.Position = UDim2.new(0, 10, 0, 160)
        TitleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TitleButton.TextColor3 = Color3.new(1, 1, 1)
        TitleButton.Text = "⚡Fast Attack Enemy🧟"
        TitleButton.TextScaled = true
        TitleButton.Font = Enum.Font.SourceSansBold
        TitleButton.BorderSizePixel = 2
        TitleButton.BorderColor3 = Color3.new(255, 255, 255)

        local TitleButton = Instance.new("TextLabel", HomeFrame)
        TitleButton.Size = UDim2.new(0, 170, 0, 30)
        TitleButton.Position = UDim2.new(0, 10, 0, 210)
        TitleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TitleButton.TextColor3 = Color3.new(1, 1, 1)
        TitleButton.Text = "⚡Fast Attack Player🧍"
        TitleButton.TextScaled = true
        TitleButton.Font = Enum.Font.SourceSansBold
        TitleButton.BorderSizePixel = 2
        TitleButton.BorderColor3 = Color3.new(255, 255, 255)

        local TitleButton = Instance.new("TextLabel", HomeFrame)
        TitleButton.Size = UDim2.new(0, 170, 0, 30)
        TitleButton.Position = UDim2.new(0, 10, 0, 260)
        TitleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TitleButton.TextColor3 = Color3.new(1, 1, 1)
        TitleButton.Text = "Auto Escape💨"
        TitleButton.TextScaled = true
        TitleButton.Font = Enum.Font.SourceSansBold
        TitleButton.BorderSizePixel = 2
        TitleButton.BorderColor3 = Color3.new(255, 255, 255)

        local TitleButton = Instance.new("TextLabel", HomeFrame)
        TitleButton.Size = UDim2.new(0, 220, 0, 30)
        TitleButton.Position = UDim2.new(0, 10, 0, 310)
        TitleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TitleButton.TextColor3 = Color3.new(1, 1, 1)
        TitleButton.Text = "Return to original height🔂"
        TitleButton.TextScaled = true
        TitleButton.Font = Enum.Font.SourceSansBold
        TitleButton.BorderSizePixel = 2
        TitleButton.BorderColor3 = Color3.new(255, 255, 255)
    end

    wait(0.2)

    print("TITLE SUCCESS✅")
end
