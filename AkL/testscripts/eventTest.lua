package.path = package.path .. ';/sdcard/AnkuLua/macroteamlib/?.lua'

--development resolution
--eventually we'll want this to become a global variable, overwritten by the
--final script
local devRez = Location(720, 1280)

clicks = require("clicks")
drags = require("drags")

local function round1()
    --setzer
    drags.unitdrag(2, 'ability')
    wait(1)
    drags.skilldrag()
    drags.skilldrag()
    clicks.clickAbility(1)
    wait(1)

    --olive
    drags.unitdrag(4, 'ability')
    wait(1)
    clicks.clickAbility(6)
    wait(1)

    --go
    clicks.clickAuto()
    clicks.clickAuto()
end

local function round2()
    --olive
    drags.unitdrag(4, 'ability')
    wait(1)
    --drags.skilldrag()
    clicks.clickAbility(3)
    wait(1)
    clicks.clickUnit(4)
    wait(1)

    clicks.clickRepeat()
end

local function round3()
    --olive
    drags.unitdrag(4, 'ability')
    wait(1)
    drags.skilldrag()
    clicks.clickAbility(5)
    wait(1)
    clicks.clickUnit(4)
    wait(1)

    clicks.clickRepeat()
end

local function standardround()
    clicks.clickRepeat()
end

local function bossround()
    --olive
    drags.unitdrag(4, 'ability')
    wait(1)
    clicks.clickAbility(3)
    clicks.clickUnit(4)
    wait(1)
    clicks.clickRepeat()
    wait(20)

    --olive
    drags.unitdrag(4, 'ability')
    wait(1)
    --insert if check here for limit or true shot
    clicks.clickAbility(1)
    --drags.skilldrag()
    --clicks.clickAbility(5)
    wait(1)
    clicks.clickUnit(4)
    wait(1)
    --clicks.clickRepeat()
    clicks.clickAuto()
    clicks.clickAuto()
end

local function runreg()
    round1()
    wait(15)
    round2()
    wait(15)
    round3()
    wait(15)
    round2()
    wait(15)
    bossround()
end

runreg()
