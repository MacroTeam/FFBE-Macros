package.path = package.path .. ';' .. scriptPath() .. '?.lua'

--development resolution
--eventually we'll want this to become a global variable, overwritten by the
--final script
local devRez = Location(720, 1280)
local rezString = devRez:getX() .. 'x' .. devRez:getY()

local dqcompletedpng = Pattern('assets/' .. rezString .. '/dq-completed.png'):similar(0.975)
local friendrequestpng = Pattern('assets/' .. rezString .. '/friendrequest.png'):similar(0.975)
local lapispng = Pattern('assets/' .. rezString .. '/lapis.png'):similar(0.975)

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
    friendcheck = exists(friendrequestpng, 0)

    if (friendcheck ~= nil)
    then
        return true
    else
        return false
    end
end

function basicchecks.lapisCheck()
    lapischeck = exists(lapispng, 0)

    if (lapischeck ~= nil)
    then
        return true
    else
        return false
    end
end

return basicchecks
