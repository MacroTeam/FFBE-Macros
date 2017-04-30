package.path = package.path .. ';' .. scriptPath() .. '?.lua'

--development resolution
--eventually we'll want this to become a global variable, overwritten by the
--final script
local devRez = Location(720, 1280)

akvars = require("akvars")
resconv = require("resconv")

local autoButtonLoc = resconv.convertCoordinates(Location(90, 1235), devRez)
local repeatButtonLoc = resconv.convertCoordinates(Location(265, 1235), devRez)

local nextButtonLoc = resconv.convertCoordinates(Location(360, 1125), devRez)

local topFriendLoc = resconv.convertCoordinates(Location(360, 445), devRez)

local clicks = {}

function clicks.setAutoButton(loc)
    if (loc == nil) then
        return false
    else
        autoButtonLoc = loc
    end
    return true
end

function clicks.getAutoButton()
    return autoButtonLoc
end

function clicks.setRepeatButton(loc)
    if (loc == nil) then
        return false
    else
        repeatButtonLoc = loc
    end
    return true
end

function clicks.getRepeatButton()
    return repeatButtonLoc
end

function clicks.setNextButton(loc)
    if (loc == nil) then
        return false
    else
        nextButtonLoc = loc
    end
    return true
end

function clicks.getNextButton()
    return nextButtonLoc
end

function clicks.setTopFriend(loc)
    if (loc == nil) then
        return false
    else
        topFriendLoc = loc
    end
    return true
end

function clicks.getTopFriend()
    return topFriendLoc
end

function clicks.click(loc)
    continueClick(loc:getX(), loc:getY(), 0, 0, 1)
end

function clicks.clickOrigin(idx)
    origin = akvars.getOrigin(idx)
    clicks.click(origin)
end

function clicks.clickUnit(idx)
    clicks.clickOrigin(idx)
end

function clicks.clickAbility(idx)
    clicks.clickOrigin(idx)
end

function clicks.clickAuto()
    clicks.click(autoButtonLoc)
end

function clicks.clickRepeat()
    clicks.click(repeatButtonLoc)
end

function clicks.clickNext()
    clicks.click(nextButtonLoc)
end

function clicks.clickTopFriend()
    clicks.click(topFriendLoc)
end

function clicks.attack(originarray)
    for i, v in ipairs(originarray)
    do
        clicks.clickUnit(v)
    end

    return true
end

function clicks.attackAll()
    clicks.attack({1, 2, 3, 4, 5, 6})

    return true
end

return clicks
