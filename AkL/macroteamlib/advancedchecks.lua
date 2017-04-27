package.path = package.path .. ';' .. scriptPath() .. '?.lua'

--development resolution
--eventually we'll want this to become a global variable, overwritten by the
--final script
local devRez = Location(720, 1280)
local rezString = devRez:getX() .. 'x' .. devRez:getY()

basicchecks = require("basicchecks")
clicks = require("clicks")

local repeatTestLoc = resconv.convertCoordinates(Location(253, 1234), devRez)
local resetTestLoc = resconv.convertCoordinates(Location(389, 1234), devRez)
local menuTestLoc = resconv.convertCoordinates(Location(595, 1234), devRez)

local menuTestRGB = { r = 255, g = 255, b = 255 }
local menuGrayedTestRGB = { r = 100, g = 100, b = 100 }

--local menuTestRGB = { r = 166, g = 239, b = 255 }

local menupng = Pattern('assets/' .. rezString .. '/menu.png'):similar(0.95)
local repeatpng = Pattern('assets/' .. rezString .. '/repeat.png'):similar(0.95)
local resetpng = Pattern('assets/' .. rezString .. '/reset.png'):similar(0.95)
local resultspng = Pattern('assets/' .. rezString .. '/results.png'):similar(0.6)

local advancedchecks = {}

function advancedchecks.colorTestPt(loc, inRGB)
    if (inRGB == nil or loc == nil)
    then
        --raise error here
        return false
    end

    r2, g2, b2 = getColor(loc)
    locRGB = { r = r2, g = g2, b = b2 }

    return basicchecks.rgbcheck(inRGB, locRGB)
end

function advancedchecks.waitUntilBattleEnd(timeout, checkstep)
    --we need to make sure that the menu grayed exists
    --or we should raise an error, since that means we
    --haven't ended the previous round. we also don't
    --want to wait forever here, so timeouts are applied
    --manually. please also note that we do some heavy
    --lifting to speed up the checks, forcing a check every
    --10ms to lose as little time as possible

    if (timeout == nil)
    then
        timeout = 5
    end

    if (checkstep == nil)
    then
        checkstep = 0.01
    end

    timer = Timer()

    --wait until menu grayed

    result = advancedchecks.colorTestPt(menuTestLoc, menuGrayedTestRGB)

    while (result ~= true)
    do
        if (timer:check() <= timeout)
        then
            wait(checkstep)
            
            result = advancedchecks.colorTestPt(menuTestLoc, menuGrayedTestRGB)
        else
            return false
        end
    end

    if (timer:check() <= timeout)
    then
        result = advancedchecks.colorTestPt(menuTestLoc, menuTestRGB)

        while (result ~= true)
        do
            if (timer:check() <= timeout)
            then
                if (exists(menupng, 0))
                then
                    wait(checkstep)

                    result = advancedchecks.colorTestPt(menuTestLoc, menuTestRGB)
                else
                    --menu has disappeared, battle is probably over
                    return true
                end
            else
                return false
            end
        end
    else
        return false
    end

    return true
end

function advancedchecks.waitUntilRoundBegin(timeout, checkstep)
    if (timeout == nil)
    then
        timeout = 15
    end

    if (checkstep == nil)
    then
        checkstep = 0.1
    end

    timer = Timer()

    result = advancedchecks.colorTestPt(menuTestLoc, menuTestRGB)

    while (result ~= true)
    do
        if (timer:check() <= timeout)
        then
            wait(checkstep)

            result = advancedchecks.colorTestPt(menuTestLoc, menuTestRGB)
        else
            return false
        end
    end

    if (timer:check() <= timeout)
    then
        result = advancedchecks.colorTestPt(repeatTestLoc, menuTestRGB)

        while (result ~= true)
        do
            if (timer:check() <= timeout)
            then
                wait(checkstep)

                result = advancedchecks.colorTestPt(repeatTestLoc, menuTestRGB)
            else
                return false
            end
        end
    end

    if (timer:check() <= timeout)
    then
        result = advancedchecks.colorTestPt(resetTestLoc, menuTestRGB)

        while(result == nil)
        do
            if (timer:check() <= timeout)
            then
                wait(checkstep)

                result = advancedchecks.colorTestPt(resetTestLoc, menuTestRGB)
            else
                return false
            end
        end
    end

    --try to give ourselves a little extra
    --bit to make sure that things have come
    --up properly
    if (timer:check() + 1 <= timeout)
    then
        wait(1)
    elseif (timer:check() <= timeout)
    then
        wait(timeout - timer:check())
    end

    return true
end

function advancedchecks.waitUntilNextBattle(timeout)
    timer = Timer()

    result = advancedchecks.waitUntilBattleEnd(timeout)

    if (timer:check() > timeout or result == false)
    then
        return false
    else
        result = advancedchecks.waitUntilRoundBegin(timeout - timer:check())

        if (timer:check() > timeout or result == false)
        then
            return false
        else
            if (timer:check() + 1 < timeout)
            then
                wait(1)
            elseif (timer:check() < timeout)
            then
                wait(timeout - timer.check())
            else
                return false
            end

            return true
        end
    end
end

function advancedchecks.waitUntilExplorationBegin(timeout)
    --stub
    wait(timeout)
    return true
end

function advancedchecks.findpulse(search, timeout, checkstep)
    if (timeout == nil)
    then
        timeout = 2
    end

    if (checkstep == nil)
    then
        checkstep = 0.1
    end

    timer = Timer()

    result = exists(search, 0)

    if (result ~= nil)
    then
        return result
    else
        while (timer:check() <= timeout)
        do
            wait(checkstep)

            result = exists(search, 0)
          
            if (result ~= nil)
            then
                return result
            end
        end
    end
end

function advancedchecks.resultsCheck(timeout)
    if (timeout == nil)
    then
        timeout = 1
    end

    timer = Timer()

    result = exists(resultspng, timeout)

    if (result ~= nil)
    then
        return true
    else
        return false
    end
end

return advancedchecks
