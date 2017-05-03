package.path = package.path .. ';' .. scriptPath() .. '?.lua'

--development resolution
--eventually we'll want this to become a global variable, overwritten by the
--final script
local devRez = Location(720, 1280)
local rezString = devRez:getX() .. 'x' .. devRez:getY()

advancedchecks = require("advancedchecks")
basicchecks = require("basicchecks")
clicks = require("clicks")
lapis = require("lapis")
resconv = require("resconv")
selectmission = require("selectmission")
selectfriend = require("selectfriend")

--local departButtonLoc = 350, 1125

local startmission = {}

local lapisspend = true

local nolapiswait = 60

local bonuspng = Pattern('assets/' .. rezString .. '/bonus-onus.png'):similar(0.8)

function startmission.startMission(idx, friendsearch)
    if (idx == nil) then
        return false
    else
        selectmission.selectMission(idx)
        
        if (basicchecks.lapisCheck())
        then
            lapis.handleLapisPopup(lapisspend)

            if (lapisspend == false)
            then
                wait(nolapiswait)
                return startmission.startMission(idx, friendsearch)
            end

            selectmission.selectMission(idx)

            clicks.clickNext()
        end

        wait(1)
        selectfriend.selectFriend(friendsearch)
    
        clicks.clickNext()

        wait(1)
        return true
    end
    return false
end

function startmission.startQuest(idx, friendsearch)
    if (startmission.startMission(idx, friendsearch) == true)
    then
        advancedchecks.waitUntilRoundBegin(15)
        return true
    end
end

function startmission.startQuestBonus(idx)
    if (idx == nil) then
        return false
    else
        return startmission.startQuest(idx, bonuspng)
    end
end

function startmission.startExploration(friendsearch, idx)
    if (idx == nil)
    then
        idx = 1
    end

    if (startmission.startMission(idx, friendsearch) == true)
    then
        advancedchecks.waitUntilExplorationOverworld(15)
        return true
    end
end

return startmission
