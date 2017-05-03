package.path = package.path .. ';' .. scriptPath() .. '/?.lua'

--development resolution
--eventually we'll want this to become a global variable, overwritten by the
--final script
local devRez = Location(720, 1280)
local rezString = devRez:getX() .. 'x' .. devRez:getY()

local basicchecks = require("basicchecks")
local clicks = require("clicks")

local nocompanion = Pattern('assets/' .. rezString .. '/nocompanion.png'):similar(0.99)
local connectionicon = Pattern('assets/' .. rezString .. '/connectionicon.png'):similar(0.99)

local nocompanionRegLoc = resconv.convertCoordinates(Location(0, 338), devRez)
local nocompanionRegHW = resconv.convertCoordinates(Location(720, 720), devRez)
local nocompanionRegion = Region(nocompanionRegLoc:getX(), nocompanionRegLoc:getY(), nocompanionRegHW:getX(), nocompanionRegHW:getY())

local connectioniconRegLoc = resconv.convertCoordinates(Location(0, 0), devRez)
local connectioniconRegHW = resconv.convertCoordinates(Location(70, 42), devRez)
local connectioniconRegion = Region(connectioniconRegLoc:getX(), connectioniconRegLoc:getY(), connectioniconRegHW:getX(), connectioniconRegHW:getY())

local levelnamecheckLoc = resconv.convertCoordinates(Location(0, 140), devRez)
local levelnamecheckHW = resconv.convertCoordinates(Location(70, 42), devRez)
local levelnamecheckRegion = Region(levelnamecheckLoc:getX(), levelnamecheckLoc:getY(), levelnamecheckHW:getX(), levelnamecheckHW:getY())

local errorchecks = {}

function errorchecks.TMstuckfriends()
    if (nocompanionRegion:exists(nocompanion) ~= nil)
    then
        return true
    else
        return false
    end
end

--this is useful in telling if the app is open
function errorchecks.checkforwifisymbol()
    if (connectioniconRegion:exists(connectionicon) ~= nil)
    then
        return true
    end

    return false
end

--open menu, check that the name of the level is correct
function errorchecks.levelnamecheck(levelnamepng)
    if (levelnamepng == nil)
    then
        --raise error here
        return false
    end

    if (basicchecks.menuCheck())
    then
        clicks.clickMenuButton()

        correctname = false

        wait(0.3)

        if (levelnamecheckRegion:exists(levelnamepng, 0) ~= nil)
        then
            correctname = true
        end

        clicks.clickMenuBackButton()

        wait(0.3)

        return correctname
    end

    --if the menu is not present, we need this third choice here
    --for decision making purposes, but we may want to replace
    --with error raising
    return nil
end

return errorchecks
