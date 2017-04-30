package.path = package.path .. ';' .. scriptPath() .. '?.lua'

--development resolution
--eventually we'll want this to become a global variable, overwritten by the
--final script
local devRez = Location(720, 1280)

--basicchecks = require("basicchecks")
clicks = require("clicks")
drags = require("drags")
resconv = require("resconv")

local missionslot1 = resconv.convertCoordinates(Location(360, 440), devRez)
local missionslot2 = resconv.convertCoordinates(Location(360, 625), devRez)
local missionslot3 = resconv.convertCoordinates(Location(360, 810), devRez)
local missionslot4 = resconv.convertCoordinates(Location(360, 1005), devRez)
local missionslot5 = resconv.convertCoordinates(Location(360, 1190), devRez)

local selectmission = {}

function selectmission.selectMission(idx)
    if (idx < 6)
    then
        if (idx == 1)
        then
            clicks.click(missionslot1)
        elseif (idx == 2)
        then
            clicks.click(missionslot2)
        elseif (idx == 3)
        then
            clicks.click(missionslot3)
        elseif (idx == 4)
        then
            clicks.click(missionslot4)
        elseif (idx == 5)
        then
            clicks.click(missionslot5)
        end
    else
        drags.missiondrag(idx - 5)
        clicks.click(missionslot5)
    end

    wait(1)

    clicks.clickNext()

    return true
end

return selectmission
