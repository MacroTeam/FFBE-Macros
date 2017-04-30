package.path = package.path .. ';' .. scriptPath() .. '/macroteamlib/?.lua'

--development resolution
--eventually we'll want this to become a global variable, overwritten by the
--final script
local devRez = Location(720, 1280)
local rezString = devRez:getX() .. 'x' .. devRez:getY()

battleplanparser = require("battleplanparser")
clicks = require("clicks")
drags = require("drags")
emdoorcheck = require("emdoorcheck")
exitmission = require("exitmission")
resconv = require("resconv")
startmission = require("startmission")

local endmap = Pattern('assets/' .. rezString .. '/endmap.png'):similar(0.925)

local mapRegLoc = resconv.convertCoordinates(Location(12, 48), devRez)
local mapRegHW = resconv.convertCoordinates(Location(308, 302), devRez)
local mapRegion = Region(mapRegLoc:getX(), mapRegLoc:getY(), mapRegHW:getX(), mapRegHW:getY())

local battleplan = { { trigger = 'default', finish = 'auto', plan = { { unit = nil, func = nil, drag = nil, click = nil } } } }

function checkend()
    result = mapRegion:exists(endmap, 1)

    if (result ~= nil)
    then
        return false
    else
        return true
    end
end

function explorestart()
    drags.dpadMove('up', 10)
    wait(1)
    advancedchecks.waitUntilExplorationMap(5)
end

function exploreRoom1()
    drags.dpadMove('up', 3)
    advancedchecks.waitUntilBattleBegin()
    battleplanparser.executeFinish('auto')
    advancedchecks.waitUntilBattleEnd(60, nil, true)
    clicks.clickNext()
    wait(1)
    advancedchecks.waitUntilExplorationMap(5)

    drags.dpadMove('up', 5)
    --check mid
    if (emdoorcheck.checkdoors())
    then
        drags.dpadMove('up', 1)
        wait(1)
    advancedchecks.waitUntilExplorationMap(5)

        return checkend()
    end

    drags.dpadMove('left', 8)
    --check left
    if (emdoorcheck.checkdoors())
    then
        drags.dpadMove('up', 1)
        wait(1)
    advancedchecks.waitUntilExplorationMap(5)

        return checkend()
    end

    drags.dpadMove('right', 14)
    --default right
    drags.dpadMove('up', 1)

    wait(1)
    advancedchecks.waitUntilExplorationMap(5)

    return checkend()
end

function exploreRoom2()
    drags.dpadMove('up', 2)
    advancedchecks.waitUntilBattleBegin()
    battleplanparser.executeFinish('auto')
    advancedchecks.waitUntilBattleEnd(60, nil, true)
    clicks.clickNext()
    wait(1)
    advancedchecks.waitUntilExplorationMap(5)

    drags.dpadMove('up', 6)
    --check mid
    if (emdoorcheck.checkdoors())
    then
        drags.dpadMove('up', 1)
        wait(1)
    advancedchecks.waitUntilExplorationMap(5)

        return checkend()
    end

    drags.dpadMove('left', 2)
    --check left
    if (emdoorcheck.checkdoors())
    then
        drags.dpadMove('down', 4)
        drags.dpadMove('left', 2)
        drags.dpadMove('up', 1)
        wait(1)
    advancedchecks.waitUntilExplorationMap(5)

        return checkend()
    end

    drags.dpadMove('right', 4)
    --default right
    drags.dpadMove('down', 4)
    drags.dpadMove('right', 2)
    drags.dpadMove('up', 1)

    wait(1)
    advancedchecks.waitUntilExplorationMap(5)

    return checkend()
end

function exploreRoom3()
    drags.dpadMove('up', 2)
    advancedchecks.waitUntilBattleBegin()
    battleplanparser.executeFinish('auto')
    advancedchecks.waitUntilBattleEnd(60, nil, true)
    clicks.clickNext()
    wait(1)
    advancedchecks.waitUntilExplorationMap(5)

    drags.dpadMove('up', 6)
    --check mid
    if (emdoorcheck.checkdoors())
    then
        drags.dpadMove('left', 2)
        drags.dpadMove('up', 1)
        wait(1)
        advancedchecks.waitUntilExplorationMap(5)

        return checkend()
    end

    drags.dpadMove('left', 4)
    --check left
    if (emdoorcheck.checkdoors())
    then
        drags.dpadMove('down', 5)
        drags.dpadMove('left', 2)
        drags.dpadMove('up', 1)
        wait(1)
        advancedchecks.waitUntilExplorationMap(5)

        return checkend()
    end

    --default right
    drags.dpadMove('down', 3)
    drags.dpadMove('right', 9)
    drags.dpadMove('up', 1)

    wait(1)
    advancedchecks.waitUntilExplorationMap(5)

    return checkend()
end

function exploreRoom4()
    drags.dpadMove('up', 2)
    advancedchecks.waitUntilBattleBegin()
    battleplanparser.executeFinish('auto')
    advancedchecks.waitUntilBattleEnd(60, nil, true)
    clicks.clickNext()
    wait(1)
    advancedchecks.waitUntilExplorationMap(5)

    drags.dpadMove('up', 2)

    --check mid
    if (emdoorcheck.checkdoors())
    then
        drags.dpadMove('right', 2)
        drags.dpadMove('up', 5)
        wait(1)
    advancedchecks.waitUntilExplorationMap(5)

        return checkend()
    end

    drags.dpadMove('left', 7)
    --check left
    if (emdoorcheck.checkdoors())
    then
        drags.dpadMove('up', 2)
        wait(1)
        advancedchecks.waitUntilExplorationMap(5)

        return checkend()
    end

    drags.dpadMove('right', 11)
    --default right
    drags.dpadMove('down', 1)
    drags.dpadMove('right', 2)
    drags.dpadMove('up', 1)

    wait(1)
    advancedchecks.waitUntilExplorationMap(5)

    return checkend()
end

function exploreRoom4()
    drags.dpadMove('up', 2)
    advancedchecks.waitUntilBattleBegin()
    battleplanparser.executeFinish('auto')
    advancedchecks.waitUntilBattleEnd(60, nil, true)
    clicks.clickNext()
    wait(1)
    advancedchecks.waitUntilExplorationMap(5)

    drags.dpadMove('up', 2)

    --check mid
    if (emdoorcheck.checkdoors())
    then
        drags.dpadMove('right', 2)
        drags.dpadMove('up', 5)
        wait(1)
        advancedchecks.waitUntilExplorationMap(5)

        return checkend()
    end

    drags.dpadMove('left', 7)
    --check left
    if (emdoorcheck.checkdoors())
    then
        drags.dpadMove('up', 2)
        wait(1)
        advancedchecks.waitUntilExplorationMap(5)

        return checkend()
    end

    drags.dpadMove('right', 11)
    --default right
    drags.dpadMove('down', 1)
    drags.dpadMove('right', 2)
    drags.dpadMove('up', 1)

    wait(1)
    advancedchecks.waitUntilExplorationMap(5)

    return checkend()
end

function exploreRoom5()
    drags.dpadMove('up', 3)
    advancedchecks.waitUntilBattleBegin()
    battleplanparser.executeFinish('auto')
    advancedchecks.waitUntilBattleEnd(60, nil, true)
    clicks.clickNext()
    wait(1)
    advancedchecks.waitUntilExplorationMap(5)

    drags.dpadMove('up', 2)

    flip = math.random(2)

    if (flip == 1)
    then
        drags.dpadMove('left', 9)
    else
        drags.dpadMove('right', 9)
    end

    drags.dpadMove('up', 9)
    wait(1)
    advancedchecks.waitUntilExplorationMap(5)
end

function exploreend()
    drags.dpadMove('up', 5)
    advancedchecks.waitUntilBattleBegin()
    battleplanparser.executeFinish('auto')
    advancedchecks.waitUntilBattleEnd(60, nil, true)
    clicks.clickNext()
    exitmission.exitMission()
end

function explore(iter)
    for i=1, iter, 1
    do
        startmission.startExploration()
        
        explorestart()

        result = exploreRoom1()

        if (result)
        then
            result = exploreRoom2()

            if(result)
            then
                result = exploreRoom3()

                if (result)
                then
                    result = exploreRoom4()

                    if (result)
                    then
                        exploreRoom5()
                        exploreend()
                    else
                        exploreend()
                    end
                else
                    exploreend()
                end
            else
                exploreend()
            end
        else
            exploreend()
        end
    end
end

explore(5)
