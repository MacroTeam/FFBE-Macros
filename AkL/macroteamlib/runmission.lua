package.path = package.path .. ';' .. scriptPath() .. '/?.lua'

--development resolution
--eventually we'll want this to become a global variable, overwritten by the
--final script
local devRez = Location(720, 1280)
local rezString = devRez:getX() .. 'x' .. devRez:getY()

battleplanparser = require("battleplanparser")
startmission = require("startmission")

local runmission = {}

function runmission.runMission(idx, battleplan, bonus)
    if (bonus == true)
    then
        startmission.startQuestBonus(1)
    else
        startmission.startQuest()
    end

    battleplanparser.executeBattlePlan(battleplan)
end

return runmission
