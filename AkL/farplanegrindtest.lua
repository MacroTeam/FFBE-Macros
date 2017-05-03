package.path = package.path .. ';' .. scriptPath() .. '/macroteamlib/?.lua'

--development resolution
--eventually we'll want this to become a global variable, overwritten by the
--final script
local devRez = Location(720, 1280)
local rezString = devRez:getX() .. 'x' .. devRez:getY()

runmission = require("runmission")

local bossimage = Pattern('assets/' .. rezString .. '/ultimaweapon.png'):similar(0.975)
local goldenbomb = Pattern('assets/' .. rezString .. '/goldenbomb.png'):similar(0.975)
local nelapa = Pattern('assets/' .. rezString .. '/nelapa.png'):similar(0.975)
local platinumdragon = Pattern('assets/' .. rezString .. '/platinumdragon.png'):similar(0.975)

--{ {trigger = nil, finish = 'auto', plan = {
--    {unit = 2, function = 'ability', drag = 1, click = 2},
--    {unit = nil, function = nil, drag = -1, click = 2},
--    {unit = nil, function = nil, drag = 0, click = 2},
--    {unit = 2, drag = 3, click = 1} }} }

battleplan = { {trigger = 'default', finish = 'attackAll',
                plan = {} } }

local function execute(iter)
    counter = 0

    if (iter == nil)
    then
        limit = 1
    else
        limit = iter
    end

    while (counter < limit)
    do
        runmission.runMission(2, battleplan)

        if (iter ~= nil)
        then
            counter = counter + 1
        end
    end
end

execute()
