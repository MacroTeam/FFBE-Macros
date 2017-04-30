package.path = package.path .. ';' .. scriptPath() .. '?.lua'

--development resolution
--eventually we'll want this to become a global variable, overwritten by the
--final script
local devRez = Location(720, 1280)
local rezString = devRez:getX() .. 'x' .. devRez:getY()

local rezconv = require("resconv")

local doorregionOffsetXY = resconv.convertCoordinates(Location(-25, -30), devRez)
local doorregionOffsetHW = resconv.convertCoordinates(Location(295, 246), devRez)

local emdoor = Pattern('assets/' .. rezString .. '/emdoor.png'):similar(0.6)
local emmoogle1 = Pattern('assets/' .. rezString .. '/emmoogle1.png'):similar(0.9)
local emmoogle2 = Pattern('assets/' .. rezString .. '/emmoogle2.png'):similar(0.9)
local emmoogle3 = Pattern('assets/' .. rezString .. '/emmoogle3.png'):similar(0.9)
local emmoogle4 = Pattern('assets/' .. rezString .. '/emmoogle4.png'):similar(0.9)

local emdoorcheck = {}

function emdoorcheck.checkmoogles(region)
    if (region:exists(emmoogle1, 0.5))
    then
        return true
    elseif (region:exists(emmoogle2, 0.5))
    then
        return true
    elseif (region:exists(emmoogle3, 0.5))
    then
        return true
    elseif (region:exists(emmoogle4, 0.5))
    then
        return true
    else
        return false
    end
end

function emdoorcheck.checkdoors()
    doors = findAllNoFindException(emdoor, 1)

    for i, m in ipairs(doors) do
        offsetDoorLoc = Location(m:getX(), m:getY()):offset(doorregionOffsetXY)
        offsetDoorHW = Location(m:getH(), m:getW()):offset(doorregionOffsetHW)
        doorregion = Region(offsetDoorLoc:getX(), offsetDoorLoc:getY(), offsetDoorHW:getX(), offsetDoorHW:getY())

        if(emdoorcheck.checkmoogles(doorregion))
        then
            return true
        end
    end

    return false
end

return emdoorcheck
