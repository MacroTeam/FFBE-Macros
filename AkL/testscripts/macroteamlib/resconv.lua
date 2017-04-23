local resconv = {}

local appscreen = getAppUsableScreenSize()
local realscreen = getRealScreenSize()
local xMin = appscreen:getX() - realscreen:getX()
local yMin = appscreen:getY() - realscreen:getY()

local xMax = appscreen:getX()
local yMax = appscreen:getY()


function resconv.convertCoordinates(coordinates, inputRez)
    return Location(xMin + (coordinates:getX() * (xMax - xMin)) / inputRez:getX(), yMin + (coordinates:getY() * (yMax - yMin)) / inputRez:getY())
end

return resconv
