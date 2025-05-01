return function(sections)
    local placeId = game.PlaceId

    -- Hàm kiểm tra và tải script an toàn
    local function safeLoadScript(url)
        local success, result = pcall(function()
            return loadstring(game:HttpGet(url))()
        end)
        if success then
            return result
        else
            warn("[H] Lỗi khi tải script từ URL: " .. url)
            return nil
        end
    end

    if placeId == 2753915549 then
        -- Sea 1
        local TPPage1 = safeLoadScript("https://raw.githubusercontent.com/HAPPY-script/BLOX_FRUIT/refs/heads/main/TP1.lua")
        if TPPage1 then TPPage1(sections) end
    elseif placeId == 4442272183 then
        -- Sea 2
        local TPPage2 = safeLoadScript("https://raw.githubusercontent.com/HAPPY-script/BLOX_FRUIT/refs/heads/main/TP2.lua")
        if TPPage2 then TPPage2(sections) end
    elseif placeId == 7449423635 then
        -- Sea 3
        local TPPage3 = safeLoadScript("https://raw.githubusercontent.com/HAPPY-script/BLOX_FRUIT/refs/heads/main/TP3.lua")
        if TPPage3 then TPPage3(sections) end
    else
        -- Nếu không phải cả 3 Sea trên, chạy script ngoại lệ
        local noneScript = safeLoadScript("https://raw.githubusercontent.com/HAPPY-script/NONE/refs/heads/main/NONE")
        if noneScript then noneScript(sections) end
    end
end
