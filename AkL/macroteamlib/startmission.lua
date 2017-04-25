package.path = package.path .. ';/sdcard/AnkuLua/macroteamlib/?.lua'

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
        end

        selectfriend.selectFriend(friendsearch)
    
        clicks.clickNext()
        
        advancedchecks.waitUntilRoundReady(15)
        return true
    end
    return false
end

function startmission.startMissionBonus(idx)
    if (idx == nil) then
        return false
    else
        return startmission.startMission(idx, bonuspng)
    end
end

return startmission
