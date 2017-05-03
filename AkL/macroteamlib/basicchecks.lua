package.path = package.path .. ';' .. scriptPath() .. '?.lua'

--development resolution
--eventually we'll want this to become a global variable, overwritten by the
--final script
local devRez = Location(720, 1280)
local rezString = devRez:getX() .. 'x' .. devRez:getY()

resconv = require("resconv")

local battlepop = Pattern('assets/' .. rezString .. '/battlepop.png'):similar(0.8)
local dqcompletedpng = Pattern('assets/' .. rezString .. '/dq-completed.png'):similar(0.975)
local expmappng = Pattern('assets/' .. rezString .. '/exploration-map.png'):similar(0.65)
local expresultspng = Pattern('assets/' .. rezString .. '/exploration-results.png'):similar(0.975)
local friendrequestpng = Pattern('assets/' .. rezString .. '/friendrequest.png'):similar(0.975)
local lapispng = Pattern('assets/' .. rezString .. '/lapis.png'):similar(0.975)
local levelbackpng = Pattern('assets/' .. rezString .. '/lapis.png'):similar(0.975)
local menupng = Pattern('assets/' .. rezString .. '/menu.png'):similar(0.95)
local resultspng = Pattern('assets/' .. rezString .. '/results.png'):similar(0.5)
local togglemappng = Pattern('assets/' .. rezString .. '/togglemap.png'):similar(0.975)

--local dqcompletedRegion = 

local mapRegLoc = resconv.convertCoordinates(Location(12, 48), devRez)
local mapRegHW = resconv.convertCoordinates(Location(308, 302), devRez)
local mapRegion = Region(mapRegLoc:getX(), mapRegLoc:getY(), mapRegHW:getX(), mapRegHW:getY())

local explorationResultsRegLoc = resconv.convertCoordinates(Location(225, 365), devRez)
local explorationResultsRegHW = resconv.convertCoordinates(Location(270, 85), devRez)
local explorationResultsRegion = Region(explorationResultsRegLoc:getX(), explorationResultsRegLoc:getY(), explorationResultsRegHW:getX(), explorationResultsRegHW:getY())

local friendrequestRegLoc = resconv.convertCoordinates(Location(30, 870), devRez)
local friendrequestRegHW = resconv.convertCoordinates(Location(330, 130), devRez)
local friendrequestRegion = Region(friendrequestRegLoc:getX(), friendrequestRegLoc:getY(), friendrequestRegHW:getX(), friendrequestRegHW:getY())

local lapisRegLoc = resconv.convertCoordinates(Location(230, 480), devRez)
local lapisRegHW = resconv.convertCoordinates(Location(260, 120), devRez)
local lapisRegion = Region(lapisRegLoc:getX(), lapisRegLoc:getY(), lapisRegHW:getX(), lapisRegHW:getY())

local levelBackRegLoc = resconv.convertCoordinates(Location(230, 480), devRez)
local levelBackRegHW = resconv.convertCoordinates(Location(260, 120), devRez)
local levelBackRegion = Region(levelBackRegLoc:getX(), levelBackRegLoc:getY(), levelBackRegHW:getX(), levelBackRegHW:getY())

local menuRegLoc = resconv.convertCoordinates(Location(540, 1180), devRez)
local menuRegHW = resconv.convertCoordinates(Location(180, 100), devRez)
local menuRegion = Region(menuRegLoc:getX(), menuRegLoc:getY(), menuRegHW:getX(), menuRegHW:getY())

local resultsRegLoc = resconv.convertCoordinates(Location(180, 60), devRez)
local resultsRegHW = resconv.convertCoordinates(Location(360, 360), devRez)
local resultsRegion = Region(resultsRegLoc:getX(), resultsRegLoc:getY(), resultsRegHW:getX(), resultsRegHW:getY())

local toggleMapRegLoc = resconv.convertCoordinates(Location(470, 1180), devRez)
local toggleMapRegHW = resconv.convertCoordinates(Location(150, 100), devRez)
local toggleMapRegion = Region(toggleMapRegLoc:getX(), toggleMapRegLoc:getY(), toggleMapRegHW:getX(), toggleMapRegHW:getY())

local basicchecks = {}

function basicchecks.rgbcheck(rgb1, rgb2)
    return rgb1.r == rgb2.r and rgb1.g == rgb2.g and rgb1.b == rgb2.b
end

function basicchecks.dailyCheck()
    dqcheck = exists(dqcompletedpng, 0)
    if (dqcheck ~= nil)
    then
        return true
    else
        return false
    end
end

function basicchecks.friendRequestCheck()
    friendcheck = friendrequestRegion:exists(friendrequestpng, 0)

    if (friendcheck ~= nil)
    then
        return true
    else
        return false
    end
end

function basicchecks.lapisCheck()
    lapischeck = lapisRegion:exists(lapispng, 0)

    if (lapischeck ~= nil)
    then
        return true
    else
        return false
    end
end

function basicchecks.levelBackButtonCheck()
    levelbackcheck = levelBackRegion:exists(levelbackpng, 0)

    if (levelbackcheck ~= nil)
    then
        return true
    else
        return false
    end
end

function basicchecks.explorationMapCheck()
    explorationmapcheck = mapRegion:exists(expmappng, 0)

    if (explorationmapcheck ~= nil)
    then
        return true
    else
        return false
    end
end

function basicchecks.toggleMapCheck()
    togglemapcheck = toggleMapRegion:exists(togglemappng, 0)

    if (togglemapcheck ~= nil)
    then
        return true
    else
        return false
    end
end

function basicchecks.explorationResultsCheck(timeout)
    if (timeout == nil)
    then
        timeout = 1
    end

    expresult = explorationResultsRegion:exists(expresultspng, timeout)
   
    if (expresult ~= nil)
    then
        return true
    else
        return false
    end
end

function basicchecks.resultsCheck(timeout, exploration)
    if (timeout == nil)
    then
        timeout = 1
    end

    if (exploration == nil)
    then
        exploration = false
    end

    if (exploration)
    then
        if (basicchecks.explorationResultsCheck(timeout))
        then
            return true
        end
    end

    result = resultsRegion:exists(resultspng, timeout)

    if (result ~= nil)
    then
        return true
    else
        return false
    end
end

function basicchecks.menuCheck(timeout)
    if (timeout == nil)
    then
        timeout = 0
    end

    if (menuRegion:exists(menupng, 0) ~= nil)
    then
        return true
    else
        return false
    end
end

--function basicchecks.ExplorationBattleCheck()
--end

return basicchecks
