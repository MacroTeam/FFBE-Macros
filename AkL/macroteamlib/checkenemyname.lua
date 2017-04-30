package.path = package.path .. ';' .. scriptPath() .. '?.lua'

--development resolution
--eventually we'll want this to become a global variable, overwritten by the
--final script
local devRez = Location(720, 1280)
local rezString = devRez:getX() .. 'x' .. devRez:getY()

clicks = require("clicks")
resconv = require("resconv")

local enemynameRegLoc = resconv.convertCoordinates(Location(40, 680), devRez)
local enemynameRegHW = resconv.convertCoordinates(Location(400, 50), devRez)
--410, 730
local enemynameRegion = Region(enemynameRegLoc:getX(), enemynameRegLoc:getY(), enemynameRegHW:getX(), enemynameRegHW:getY())

local checkenemyname = {}

function checkenemyname.checkEnemyName(search, timeout)
    if (timeout == nil)
    then
        timeout = 1
    end

    if(enemynameRegion:exists(search, timeout) ~= nil)
    then
        return true
    else
        return false
    end

    return false
end

return checkenemyname
