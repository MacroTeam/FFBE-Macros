package.path = package.path .. ';/sdcard/AnkuLua/macroteamlib/?.lua'

local devRez = Location(720, 1280)

resconv = require("resconv")

local akvars = {}

--this will change to a more reliable method of determining origin
--in the future, which will rely on image assets
local origin1 = resconv.convertCoordinates(Location(200, 850), devRez)
local origin2 = resconv.convertCoordinates(Location(200, 955), devRez)
local origin3 = resconv.convertCoordinates(Location(200, 1085), devRez)
local origin4 = resconv.convertCoordinates(Location(520, 850), devRez)
local origin5 = resconv.convertCoordinates(Location(520, 995), devRez)
local origin6 = resconv.convertCoordinates(Location(520, 1085), devRez)

function akvars.getOrigin(idx)
    if (idx == 1) then
        return origin1
    elseif (idx == 2) then
        return origin2
    elseif (idx == 3) then
        return origin3
    elseif (idx == 4) then
        return origin4
    elseif (idx == 5) then
        return origin5
    elseif (idx == 6) then
       return origin6
    end
end

return akvars