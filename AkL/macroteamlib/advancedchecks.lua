package.path = package.path .. ';' .. scriptPath() .. '?.lua'

--development resolution
--eventually we'll want this to become a global variable, overwritten by the
--final script
local devRez = Location(720, 1280)
local rezString = devRez:getX() .. 'x' .. devRez:getY()

basicchecks = require("basicchecks")
clicks = require("clicks")
resconv = require("resconv")

local repeatTestLoc = resconv.convertCoordinates(Location(253, 1234), devRez)
local resetTestLoc = resconv.convertCoordinates(Location(389, 1234), devRez)
local menuTestLoc = resconv.convertCoordinates(Location(595, 1234), devRez)

local menuTestRGB = { r = 255, g = 255, b = 255 }
local menuGrayedTestRGB = { r = 100, g = 100, b = 100 }

local menupng = Pattern('assets/' .. rezString .. '/menu.png'):similar(0.95)
--local repeatpng = Pattern('assets/' .. rezString .. '/repeat.png'):similar(0.95)
--local resetpng = Pattern('assets/' .. rezString .. '/reset.png'):similar(0.95)

local menuRegLoc = resconv.convertCoordinates(Location(540, 1180), devRez)
local menuRegHW = resconv.convertCoordinates(Location(180, 100), devRez)
local menuRegion = Region(menuRegLoc:getX(), menuRegLoc:getY(), menuRegHW:getX(), menuRegHW:getY())

--local repeatRegion = 
--local resetRegion = 

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

function advancedchecks.waitUntilBattleBegin(timeout, checkstep)
    if (timeout == nil)
    then
        timeout = 15
    end

    if (checkstep == nil)
    then
        checkstep = 0.1
    end

    timer = Timer()
    
    repeat
        result = menuRegion:exists(menupng, 0)
        
        if (timer:check() >= timeout)
        then
            return false
        end
    until (result ~= nil)

    return true
end

function advancedchecks.waitUntilBattleEnd(timeout, checkstep, exploration)
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
                if (basicchecks.resultsCheck(nil, exploration))
                then
                    return true
                elseif (menuRegion:exists(menupng, 0))
                then
                    wait(checkstep)

                    result = advancedchecks.colorTestPt(menuTestLoc, menuTestRGB)
                else
                    --menu has disappeared, battle is probably over
                    --if (basicchecks.resultsCheck(1) == true)
                    --then
                        --raise error here
                        return true
                    --end
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

    advancedchecks.waitUntilBattleBegin(timeout)

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

            --if (basicchecks.resultsCheck(0) == true)
            --then
                --raise error here
            --    return true
            --end
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

function advancedchecks.waitUntilNextBattle(timeout, exploration)
    timer = Timer()

    result = advancedchecks.waitUntilBattleEnd(timeout, nil, exploration)

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

function advancedchecks.waitUntilExplorationMap(timeout, checkstep)
    if (timeout == nil)
    then
        timeout = 15
    end

    if (checkstep == nil)
    then
        checkstep = 0.1
    end

    timer = Timer()

    repeat
        result = basicchecks.explorationMapCheck()
        
        if(result == true)
        then
            return true
        end

        wait(checkstep)
    until(timer:check() > timeout)

    return false
end

function advancedchecks.waitUntilExplorationOverworld(timeout, checkstep)
    if (timeout == nil)
    then
        timeout = 15
    end

    if (checkstep == nil)
    then
        checkstep = 0.1
    end

    timer = Timer()

    repeat
        result = basicchecks.toggleMapCheck()
        
        if(result == true)
        then
            return true
        end

        wait(checkstep)
    until(timer:check() > timeout)

    return false
end

return advancedchecks
