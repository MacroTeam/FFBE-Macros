package.path = package.path .. ';' .. scriptPath() .. '/macroteamlib/?.lua'

--development resolution
--eventually we'll want this to become a global variable, overwritten by the
--final script
local devRez = Location(720, 1280)
local rezString = devRez:getX() .. 'x' .. devRez:getY()

local lastroundstandard = false
local lastroundspecial = false

local bossimage = Pattern('assets/' .. rezString .. '/ultimaweapon.png'):similar(0.975)
local goldenbomb = Pattern('assets/' .. rezString .. '/goldenbomb.png'):similar(0.975)
local nelapa = Pattern('assets/' .. rezString .. '/nelapa.png'):similar(0.975)

advancedchecks = require("advancedchecks")
clicks = require("clicks")
drags = require("drags")
startmission = require("startmission")
exitmission = require("exitmission")

local function round1()
    --setzer
    drags.unitdrag(2, 'ability')
    wait(1)
    drags.skilldrag(2)
    clicks.clickAbility(4)
    wait(1)

    --olive
    drags.unitdrag(4, 'ability')
    wait(1)
    drags.skilldrag()
    clicks.clickAbility(4)
    wait(1)

    --go
    clicks.clickAuto()
    clicks.clickAuto()

    lastroundstandard = false
    lastroundspecial = false
end

local function standardround()
    if (lastroundstandard == true)
    then
        clicks.clickRepeat()
    else
        --olive
        drags.unitdrag(4, 'ability')
        wait(1)
        drags.skilldrag()
        clicks.clickAbility(6)
        wait(1)
        clicks.clickUnit(4)
        wait(1)

        clicks.clickRepeat()
        lastroundstandard = true
        lastroundspecial = false
    end
end

local function specialround()
    if (lastroundspecial)
    then
        clicks.clickRepeat()
    else
        clicks.attackAll()
    end

    lastroundstandard = false
    lastroundspecial = true
end

local function bossround()
    --olive
    drags.unitdrag(4, 'ability')
    wait(1)
    drags.skilldrag()
    clicks.clickAbility(1)
    wait(1)
    clicks.clickUnit(4)
    wait(1)
    clicks.clickAuto()
end

local function runmission(iter)
    counter = 0

    if (iter == nil)
    then
        limit = 1
    else
        limit = iter
    end

    while (counter < limit)
    do
        startmission.startQuestBonus(1)
        round1()
        advancedchecks.waitUntilNextBattle(15)

        boss = exists(bossimage, 0)

        while (boss == nil)
        do
            if (exists(nelapa, 0.5) == true)
            then
                specialround()
            elseif (exists(goldenbomb, 0.5) == true)
            then
                specialround()
            else
                standardround()
            end

            advancedchecks.waitUntilNextBattle(15)
            
            boss = exists(bossimage, 0.5)
        end

        bossround()
        exitmission.exitMission()

        if (iter ~= nil)
        then
            counter = counter + 1
        end
    end
end

runmission(1)
