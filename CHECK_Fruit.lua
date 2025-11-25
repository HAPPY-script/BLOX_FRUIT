local sea1ID = 85211729168715

local sea2ID = 79091703265657
local sea2ID2 = 4442272183

local sea3ID = 7449423635
local sea3ID2 = 100117331123089

return function(sections)
    local placeId = game.PlaceId
    if placeId == sea1ID then
        local FruitPage1 = loadstring(game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/BLOX_FRUIT/refs/heads/main/Fruit1.lua"))()
        FruitPage1(sections)
    elseif placeId == sea2ID or sea2ID2 then
        local FruitPage2 = loadstring(game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/BLOX_FRUIT/refs/heads/main/Fruit2.lua"))()
        FruitPage2(sections)
    elseif placeId == sea3ID or sea3ID2 then
        local FruitPage3 = loadstring(game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/BLOX_FRUIT/refs/heads/main/Fruit3.lua"))()
        FruitPage3(sections)
    else
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/NONE/refs/heads/main/NONE"))()
    end
end
