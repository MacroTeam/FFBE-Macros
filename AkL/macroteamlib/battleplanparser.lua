package.path = package.path .. ';' .. scriptPath() .. '/?.lua'

--development resolution
--eventually we'll want this to become a global variable, overwritten by the
--final script
local devRez = Location(720, 1280)
local rezString = devRez:getX() .. 'x' .. devRez:getY()

local lastunit = nil
local lasttrigger = 0
local planend = false

advancedchecks = require("advancedchecks")
checkenemyname = require("checkenemyname")
clicks = require("clicks")
drags = require("drags")
exitmission = require("exitmission")

local battleplanparser = {}

function battleplanparser.executePlan(plan)
    if (plan == nil)
    then
        return false
    elseif (plan == 'attackAll')
    then
        clicks.attackAll()
        return true
    elseif (plan == 'auto')
    then
        clicks.clickAuto()
        wait(0.01)
        clicks.clickAuto()
    end

    if (plan["unit"] ~= nil)
    then
        lastunit = plan["unit"]

        if (plan["func"] ~= nil)
        then
            if (plan["func"] == 'attack' or plan["func"] == 'click')
            then
                clicks.clickUnit(plan["unit"])
            else
                drags.unitdrag(plan["unit"], plan["func"])
                wait(0.8)
            end
        end
    end

    if (plan["drag"] ~= nil)
    then
        drags.skilldrag(plan["drag"])
        wait(0.8)
    end

    if (plan["click"] ~= nil)
    then
        clicks.clickOrigin(plan["click"])
        wait(0.8)
    end

    return true
end

function battleplanparser.executeFinish(finishstr)
    --for now only use auto in a final battle
    if (finishstr == 'auto')
    then
        clicks.clickAuto()
        wait(0.01)
        clicks.clickAuto()
    elseif (finishstr == 'attackAll')
    then
        clicks.attackAll()
    elseif (finishstr == 'repeat')
    then
        clicks.clickRepeat()
    elseif (finishstr == 'autoFinish')
    then
        clicks.clickAuto()
    end

    return true
end

function battleplanparser.executeBattlePlan(battleplan, norepeat)
    storedplan = {}
    triggers = {}

    for k, v in ipairs(battleplan)
    do
        if (v["trigger"] ~= 'default')
        then
            table.insert(triggers, v["trigger"])
        end

        storedplan[v["trigger"]] = {v["finish"], v["plan"]}
    end

    advancedchecks.waitUntilRoundBegin(15)

    while(basicchecks.resultsCheck() ~= true)
    do
        local foundtrigger = false

        for k, v in ipairs(triggers)
        do
            if (checkenemyname.checkEnemyName(v) == true)
            then
                if (norepeat ~= true and lasttrigger == v)
                then
                    clicks.clickRepeat()
                else
                    stopauto = true
                    --this is for evaluating shortcut strings in the
                    --battle plan
                    if (typeOf(storedplan[v][2]) == "string")
                    then
                        battleplanparser.executePlan(storedplan[v][2])
                    else
                        for k2, v2 in ipairs(storedplan[v][2])
                        do
                            result = battleplanparser.executePlan(v2)
                        end
                    end
            
                    battleplanparser.executeFinish(storedplan[v][1])

                    lasttrigger = v
                    foundtrigger = true
                end
            end
        end

        if (foundtrigger ~= true)
        then
            if (norepeat ~= true and lasttrigger == 'default')
            then
                clicks.clickRepeat()
            else
                for k, v in ipairs(storedplan['default'][2])
                do
                    result = battleplanparser.executePlan(v)

                    if (result == false)
                    then
                        planend = true
                        break
                    end
                end

                battleplanparser.executeFinish(storedplan['default'][1])

                if (planend == true)
                then
                    lastunit = nil
                    lasttrigger = 0
                    planend = false
                    break
                else
                    lasttrigger = 'default'
                end
            end
        end

        advancedchecks.waitUntilNextBattle(60)

        --later we'll break this down and insert a
        --check to turn auto off
    end

    exitmission.exitMission()
end

return battleplanparser
