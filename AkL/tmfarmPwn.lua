package.path = package.path .. ';' .. scriptPath() .. '/macroteamlib/?.lua'

--development resolution
--eventually we'll want this to become a global variable, overwritten by the
--final script
local devRez = Location(720, 1280)
local rezString = devRez:getX() .. 'x' .. devRez:getY()

local basicchecks = require("basicchecks")
local clicks = require("clicks")
local crashhandling = require("crashhandling")
local errorchecks = require("errorchecks")
local lapis = require("lapis")
local resconv = require("resconv")

local pt1 = resconv.convertCoordinates(Location(441, 780), devRez)
local pt2 = resconv.convertCoordinates(Location(482, 742), devRez)
local pt3 = resconv.convertCoordinates(Location(349, 1093), devRez)
local pt4 = resconv.convertCoordinates(Location(223, 789), devRez)
local pt5 = resconv.convertCoordinates(Location(330, 879), devRez)

local levelnamepng = Pattern('assets/' .. rezString .. '/earthshrine/entrance.png'):similar(0.99)

--local vortexpath = {'vortex', '1', 2}
local levelpath = {'world', 'grandshelt', 'grandshelt', 'earth shrine'}

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
        --error handling breaks
        if (counter % 250 == 0)
        then
            --check for lapis popup
            if (basicchecks.lapisCheck())
            then
                lapis.handleLapisPopup(spendlapis)
            end

            --check to see if friends list is too short
            --for standard points
            if (errorchecks.TMstuckfriends())
            then
                clicks.clickTopFriend()
            end
            
            --check to see if app has crashed
            crashhandling.checkAppCrash()


            --implement checks to see if we're on
            --the main app screen, and if so
            --we'll need to navigate back to the app


            --checks to see if we're in the wrong
            --level and if so we'll quit and return to TM
            if (errorchecks.levelnamecheck(levelnamepng) == false)
            then
                crashhandling.exitLevel()

                --implement ability to find way back to level

                return false
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
