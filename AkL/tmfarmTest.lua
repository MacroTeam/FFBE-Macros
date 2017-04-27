package.path = package.path .. ';' .. scriptPath() .. '/macroteamlib/?.lua'

--development resolution
--eventually we'll want this to become a global variable, overwritten by the
--final script
local devRez = Location(720, 1280)
local rezString = devRez:getX() .. 'x' .. devRez:getY()

advancedchecks = require("advancedchecks")
clicks = require("clicks")
drags = require("drags")
startmission = require("startmission")
exitmission = require("exitmission")

local function tmfarm(iter)
    counter = 0

    if (iter == nil)
    then
        limit = 1
    else
        limit = iter
    end

    while (counter < limit)
    do
        startmission.startQuest(3)
        clicks.attack1and3()
        advancedchecks.waitUntilNextBattle(15)
        clicks.attack1and3()
        exitmission.exitMission()        

        if (iter ~= nil)
        then
            counter = counter + 1
        end
    end
end

tmfarm()
