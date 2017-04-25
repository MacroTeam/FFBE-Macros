package.path = package.path .. ';/sdcard/AnkuLua/macroteamlib/?.lua'

--development resolution
--eventually we'll want this to become a global variable, overwritten by the
--final script
local devRez = Location(720, 1280)
local rezString = devRez:getX() .. 'x' .. devRez:getY()

basicchecks = require("basicchecks")
clicks = require("clicks")

local menugrayedpng = Pattern('assets/' .. rezString .. '/menu-grayed.png'):similar(0.975)
local menupng = Pattern('assets/' .. rezString .. '/menu.png'):similar(0.975)
local repeatpng = Pattern('assets/' .. rezString .. '/repeat.png'):similar(0.975)
local resetpng = Pattern('assets/' .. rezString .. '/reset.png'):similar(0.975)
local requestpng = Pattern('assets/' .. rezString .. '/results-es.png'):similar(0.7)

local advancedchecks = {}

function advancedchecks.waitUntilRoundReady(timeout)
    if (exists(menugrayedpng, 1))
    then
        waitVanish(menugrayedpng, timeout)
    end

    exists(menupng, timeout)
    exists(repeatpng, timeout)
    exists(resetpng, timeout)

    wait(0.5)

    return true
end

function advancedchecks.findpulse(search, timeout)
    resultscheck = exists(search, timeout)

    if (resultscheck ~= nil)
    then
        return resultscheck
    else
        return false
    end
end

function advancedchecks.resultsCheck(timeout, autofinish)
    if (timeout == nil)
    then
        timeout = 5
    end

    request = advancedchecks.findpulse(requestpng, timeout)

    if (request ~= false)
    then
        return true
    else
        if (autofinish == true)
        then
            clicks.clickAuto()
            return advancedchecks.resultsCheck()
        else
            --raise overall crash handling error here in future
            return false
        end
    end
end

return advancedchecks
