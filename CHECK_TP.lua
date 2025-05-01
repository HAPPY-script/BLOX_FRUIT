return function(sections)
    local placeId = game.PlaceId

    local function safeLoadScript(url, retries)
        retries = retries or 3
        for i = 1, retries do
            local success, result = pcall(function()
                return loadstring(game:HttpGet(url))
            end)
            if success and type(result) == "function" then
                return result
            else
                warn("[TP] Lỗi tải script lần " .. i .. ": " .. tostring(result))
                task.wait(0.3)
            end
        end
        warn("[TP] Không thể tải script sau " .. retries .. " lần: " .. url)
        return function() end
    end

    if placeId == 2753915549 then
        local TPPage1 = safeLoadScript("https://raw.githubusercontent.com/HAPPY-script/BLOX_FRUIT/refs/heads/main/TP1.lua")
        TPPage1(sections)
    elseif placeId == 4442272183 then
        local TPPage2 = safeLoadScript("https://raw.githubusercontent.com/HAPPY-script/BLOX_FRUIT/refs/heads/main/TP2.lua")
        TPPage2(sections)
    elseif placeId == 7449423635 then
        local TPPage3 = safeLoadScript("https://raw.githubusercontent.com/HAPPY-script/BLOX_FRUIT/refs/heads/main/TP3.lua")
        TPPage3(sections)
    else
        local NonePage = safeLoadScript("https://raw.githubusercontent.com/HAPPY-script/NONE/refs/heads/main/NONE")
        NonePage(sections)
    end
end
