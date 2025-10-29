local sea3ID = 100117331123089

return function(sections)
    local placeId = game.PlaceId

    if placeId == 2753915549 then
        local TPPage1 = loadstring(game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/BLOX_FRUIT/refs/heads/main/TP1.lua"))()
        TPPage1(sections)
    elseif placeId == 4442272183 then
        local TPPage2 = loadstring(game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/BLOX_FRUIT/refs/heads/main/TP2.lua"))()
        TPPage2(sections)
    elseif placeId == sea3ID then
        local TPPage3 = loadstring(game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/BLOX_FRUIT/refs/heads/main/TP3.lua"))()
        TPPage3(sections)
    else
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/NONE/refs/heads/main/NONE"))()
    end
end
