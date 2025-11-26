local sea1ID = 85211729168715

local sea2ID = 79091703265657
local sea2ID2 = 4442272183

local sea3ID = 7449423635
local sea3ID2 = 100117331123089

return function(sections)
    local placeId = game.PlaceId

    if placeId == sea1ID then
        local TPPage1 = loadstring(game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/BLOX_FRUIT/refs/heads/main/TP1.lua"))()
        TPPage1(sections)
    elseif placeId == sea2ID or placeId == sea2ID2 then
        local TPPage2 = loadstring(game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/BLOX_FRUIT/refs/heads/main/TP2.lua"))()
        TPPage2(sections)
    elseif placeId == sea3ID or placeId == sea3ID2 then
        local TPPage3 = loadstring(game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/BLOX_FRUIT/refs/heads/main/TP3.lua"))()
        TPPage3(sections)
    else
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/NONE/refs/heads/main/NONE"))()
    end
end
