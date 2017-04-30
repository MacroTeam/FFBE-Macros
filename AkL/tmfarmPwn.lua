package.path = package.path .. ';' .. scriptPath() .. '/macroteamlib/?.lua'

--development resolution
--eventually we'll want this to become a global variable, overwritten by the
--final script
local devRez = Location(720, 1280)
local rezString = devRez:getX() .. 'x' .. devRez:getY()

basicchecks = require("basicchecks")
clicks = require("clicks")
crashhandling = require("crashhandling")
lapis = require("lapis")
resconv = require("resconv")

local pt1 = resconv.convertCoordinates(Location(441, 780), devRez)
local pt2 = resconv.convertCoordinates(Location(482, 742), devRez)
local pt3 = resconv.convertCoordinates(Location(349, 1093), devRez)
local pt4 = resconv.convertCoordinates(Location(223, 789), devRez)
local pt5 = resconv.convertCoordinates(Location(330, 879), devRez)

local spendlapis = true

function farming(iter)
    counter = 0
    if (iter == nil)
    then
        limit = 1
    else
        limit = iter
    end

    while (iter == nil or counter < limit)
    do
        if (counter % 200 == 0)
        then
            if(basicchecks.lapisCheck())
            then
                lapis.handleLapisPopup(spendlapis)
            end
        end

        clicks.click(pt1)
        wait(0.01)
        clicks.click(pt2)
        wait(0.01)
        clicks.click(pt3)
        wait(0.01)
        clicks.click(pt4)
        wait(0.01)
        clicks.click(pt5)
        wait(0.01)

        counter = counter + 1
    end
end

farming(nil)
