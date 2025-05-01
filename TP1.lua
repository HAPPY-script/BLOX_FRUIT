return function(sections)
    local HomeFrame = sections["Map"]

    --===========SEA=========================================================================================
    do
        -- Tạo nút "Chạy Script Từ URL"
        CreateButton(HomeFrame, "🚀 Chạy Script", 10, function()
            local url = "https://raw.githubusercontent.com/HAPPY-script/SEA/refs/heads/main/SEA" -- Thay bằng link raw script thật của bạn
            local success, result = pcall(function()
                loadstring(game:HttpGet(url))()
            end)
            if not success then
                warn("Không thể chạy script từ URL:", result)
            end
        end)
    end

end
