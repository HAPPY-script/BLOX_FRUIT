return function(sections)
    local placeId = game.PlaceId

    if placeId == 2753915549 then
        -- Sea 1
        local PVPPage1 = loadstring(game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/BLOX_FRUIT/refs/heads/main/PVP1.lua"))()
        PVPPage1(sections)
    elseif placeId == 4442272183 then
        -- Sea 2
        local PVPPage2 = loadstring(game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/BLOX_FRUIT/refs/heads/main/PVP2.lua"))()
        PVPPage2(sections)
    elseif placeId == 7449423635 then
        -- Sea 3
        local PVPPage3 = loadstring(game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/BLOX_FRUIT/refs/heads/main/PVP3.lua"))()
        PVPPage3(sections)
    else
        -- Nếu không phải cả 3 Sea trên, chạy script ngoại lệ
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/NONE/refs/heads/main/NONE"))()
    end
end
