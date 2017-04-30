package.path = package.path .. ';' .. scriptPath() .. '?.lua'

--development resolution
--eventually we'll want this to become a global variable, overwritten by the
--final script
local devRez = Location(720, 1280)
local rezString = devRez:getX() .. 'x' .. devRez:getY()

resconv = require("resconv")

local lapis = {}

--local useItemButton = resconv.convertCoordinates(Location(210, 660), devRez)
local useLapisButtonLoc = resconv.convertCoordinates(Location(500, 665), devRez)
local backLapisButtonLoc = resconv.convertCoordinates(Location(360, 790), devRez)
local lapisYesButtonLoc = resconv.convertCoordinates(Location(510, 710), devRez)
local lapisNoButtonLoc = resconv.convertCoordinates(Location(210, 710), devRez)

--function lapis.getUseItemButton()
--function lapis.setUseItemButton(loc)

function lapis.getUseLapisButton()
    return useLapisButtonLoc
end

function lapis.setUseLapisButton(loc)
    if (loc == nil) then
        return false
    else
        useLapisButtonLoc = loc
        return true
    end
end

function lapis.getBackLapisButton()
    return backLapisButtonLoc
end

function lapis.setBackLapisButton(loc)
    if (loc == nil) then
        return false
    else
        backLapisButtonLoc = loc
        return true
    end
end

function lapis.getLapisYesButton()
    return lapisYesButtonLoc
end

function lapis.setLapisYesButton(loc)
    if (loc == nil) then
        return false
    else
        lapisYesButtonLoc = loc
        return true
    end
end

function lapis.getLapisNoButton()
    return lapisNoButtonLoc
end

function lapis.setLapisNoButton(loc)
    if (loc == nil) then
        return false
    else
        lapisNoButtonLoc = loc
        return true
    end
end

function lapis.handleLapisPopup(spend, item)
    if (spend == true)
    then
        clicks.click(useLapisButtonLoc)
        wait(1)
        clicks.click(lapisYesButtonLoc)
        wait(3)
        return true
    else
        clicks.click(backLapisButtonLoc)
        wait(1)
        return true
    end
    return false
end

return lapis
