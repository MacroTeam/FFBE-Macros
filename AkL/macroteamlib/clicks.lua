package.path = package.path .. ';/sdcard/AnkuLua/macroteamlib/?.lua'

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

function clicks.clickOrigin(idx)
    origin = akvars.getOrigin(idx)
    click(origin)
end

function clicks.clickUnit(idx)
    clicks.clickOrigin(idx)
end

function clicks.clickAbility(idx)
    clicks.clickOrigin(idx)
end

function clicks.clickAuto()
    click(autoButtonLoc)
end

function clicks.clickRepeat()
    click(repeatButtonLoc)
end

function clicks.clickNext()
    click(nextButtonLoc)
end

function clicks.clickTopFriend()
    click(topFriendLoc)
end

function clicks.attackAll()
    click(akvars.getOrigin(1))
    click(akvars.getOrigin(2))
    click(akvars.getOrigin(3))
    click(akvars.getOrigin(4))
    click(akvars.getOrigin(5))
    click(akvars.getOrigin(6))
end

return clicks
