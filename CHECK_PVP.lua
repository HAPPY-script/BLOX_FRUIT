local sea1ID = 85211729168715
local sea2ID = 79091703265657
local sea3ID = 100117331123089
return function(sections)
    local placeId = game.PlaceId
    if placeId == sea1ID then
        local PVPPage1 = loadstring(game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/BLOX_FRUIT/refs/heads/main/PVP1.lua"))()
        PVPPage1(sections)
    elseif placeId == sea2ID then
        local PVPPage2 = loadstring(game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/BLOX_FRUIT/refs/heads/main/PVP2.lua"))()
        PVPPage2(sections)
    elseif placeId == sea3ID then
        local PVPPage3 = loadstring(game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/BLOX_FRUIT/refs/heads/main/PVP3.lua"))()
        PVPPage3(sections)
    elseif placeId == sea3ID then
        --[[ Even
        local PVPPage3 = loadstring(game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/BLOX_FRUIT/refs/heads/main/PVP3.lua"))()
        PVPPage3(sections)]]
    else
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/NONE/refs/heads/main/NONE"))()
    end
end
