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
    pt1 = click(akvars.getOrigin(1))
    pt2 = click(akvars.getOrigin(2))
    pt3 = click(akvars.getOrigin(3))
    pt4 = click(akvars.getOrigin(4))
    pt5 = click(akvars.getOrigin(5))
    pt6 = click(akvars.getOrigin(6))

    actionList = { {action = "touchDown", target = p1},
                   {action = "touchUp", target = p1},
                   {action = "wait", target = 0.01}, 
                   {action = "touchDown", target = p2},
                   {action = "touchUp", target = p2},
                   {action = "wait", target = 0.01}, 
                   {action = "touchDown", target = p3},
                   {action = "touchUp", target = p3},
                   {action = "wait", target = 0.01}, 
                   {action = "touchDown", target = p4},
                   {action = "touchUp", target = p4},
                   {action = "wait", target = 0.01}, 
                   {action = "touchDown", target = p5},
                   {action = "touchUp", target = p5},
                   {action = "wait", target = 0.01}, 
                   {action = "touchDown", target = p6},
                   {action = "touchUp", target = p6} }

    manualTouch(actionList)

    return true
end

function clicks.attack1and3()
    pt1 = click(akvars.getOrigin(1))
    pt3 = click(akvars.getOrigin(3))

    actionList = { {action = "touchDown", target = p1},
                   {action = "touchUp", target = p1},
                   {action = "wait", target = 0.01}, 
                   {action = "touchDown", target = p3},
                   {action = "touchUp", target = p3} }

    manualTouch(actionList)

    return true
end

return clicks
