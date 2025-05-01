return function(sections)
    local HomeFrame = sections["TP"]

    --===========CAFE=========================================================================================
    do
        -- Tạo nút "Chạy Script Từ URL"
        CreateButton(HomeFrame, "CAFE", 10, function()
            local url = "https://raw.githubusercontent.com/HAPPY-script/CAFE/refs/heads/main/CAFE"
            local success, result = pcall(function()
                loadstring(game:HttpGet(url))()
            end)
            if not success then
                warn("Không thể chạy script từ URL:", result)
            end
        end)
    end

    --===========DARK=========================================================================================
    do
        -- Tạo nút "Chạy Script Từ URL"
        CreateButton(HomeFrame, "DARK", 60, function()
            local url = "https://raw.githubusercontent.com/HAPPY-script/DARK/refs/heads/main/DARK"
            local success, result = pcall(function()
                loadstring(game:HttpGet(url))()
            end)
            if not success then
                warn("Không thể chạy script từ URL:", result)
            end
        end)
    end

    --===========FACTORY=========================================================================================
    do
        -- Tạo nút "Chạy Script Từ URL"
        CreateButton(HomeFrame, "FACTORY", 110, function()
            local url = "https://raw.githubusercontent.com/HAPPY-script/FACTORY/refs/heads/main/FACTORY"
            local success, result = pcall(function()
                loadstring(game:HttpGet(url))()
            end)
            if not success then
                warn("Không thể chạy script từ URL:", result)
            end
        end)
    end

    --===========FORGOTTEN=========================================================================================
    do
        -- Tạo nút "Chạy Script Từ URL"
        CreateButton(HomeFrame, "FORGOTTEN", 160, function()
            local url = "https://raw.githubusercontent.com/HAPPY-script/FORGOTTEN/refs/heads/main/FORGOTTEN"
            local success, result = pcall(function()
                loadstring(game:HttpGet(url))()
            end)
            if not success then
                warn("Không thể chạy script từ URL:", result)
            end
        end)
    end

    --===========GREEN_ZONE=========================================================================================
    do
        -- Tạo nút "Chạy Script Từ URL"
        CreateButton(HomeFrame, "GREEN_ZONE", 210, function()
            local url = "https://raw.githubusercontent.com/HAPPY-script/GREEN_ZONE/refs/heads/main/GREEN_ZONE"
            local success, result = pcall(function()
                loadstring(game:HttpGet(url))()
            end)
            if not success then
                warn("Không thể chạy script từ URL:", result)
            end
        end)
    end

    --===========HOT_COLD=========================================================================================
    do
        -- Tạo nút "Chạy Script Từ URL"
        CreateButton(HomeFrame, "HOT_COLD", 260, function()
            local url = "https://raw.githubusercontent.com/HAPPY-script/HOT_COLD/refs/heads/main/HOT_COLD"
            local success, result = pcall(function()
                loadstring(game:HttpGet(url))()
            end)
            if not success then
                warn("Không thể chạy script từ URL:", result)
            end
        end)
    end

    --===========ICE_CASTLE=========================================================================================
    do
        -- Tạo nút "Chạy Script Từ URL"
        CreateButton(HomeFrame, "ICE_CASTLE", 310, function()
            local url = "https://raw.githubusercontent.com/HAPPY-script/ICE_CASTLE/refs/heads/main/ICE_CASTLE"
            local success, result = pcall(function()
                loadstring(game:HttpGet(url))()
            end)
            if not success then
                warn("Không thể chạy script từ URL:", result)
            end
        end)
    end

    --===========SHIP=========================================================================================
    do
        -- Tạo nút "Chạy Script Từ URL"
        CreateButton(HomeFrame, "SHIP", 360, function()
            local url = "https://raw.githubusercontent.com/HAPPY-script/SHIP/refs/heads/main/SHIP"
            local success, result = pcall(function()
                loadstring(game:HttpGet(url))()
            end)
            if not success then
                warn("Không thể chạy script từ URL:", result)
            end
        end)
    end

    --===========PRISON=========================================================================================
    do
        -- Tạo nút "Chạy Script Từ URL"
        CreateButton(HomeFrame, "MOUNTAIN", 410, function()
            local url = "https://raw.githubusercontent.com/HAPPY-script/MOUNTAIN/refs/heads/main/MOUNTAIN"
            local success, result = pcall(function()
                loadstring(game:HttpGet(url))()
            end)
            if not success then
                warn("Không thể chạy script từ URL:", result)
            end
        end)
    end

    --===========SWAN=========================================================================================
    do
        -- Tạo nút "Chạy Script Từ URL"
        CreateButton(HomeFrame, "SWAN", 510, function()
            local url = "https://raw.githubusercontent.com/HAPPY-script/SWAN/refs/heads/main/SWAN"
            local success, result = pcall(function()
                loadstring(game:HttpGet(url))()
            end)
            if not success then
                warn("Không thể chạy script từ URL:", result)
            end
        end)
    end

    --===========ZOMBIE=========================================================================================
    do
        -- Tạo nút "Chạy Script Từ URL"
        CreateButton(HomeFrame, "ZOMBIE", 560, function()
            local url = "https://raw.githubusercontent.com/HAPPY-script/ZOMBIE/refs/heads/main/ZOMBIE"
            local success, result = pcall(function()
                loadstring(game:HttpGet(url))()
            end)
            if not success then
                warn("Không thể chạy script từ URL:", result)
            end
        end)
    end

    wait(0.2)
    print("Map tad SUCCESS✅")
end
