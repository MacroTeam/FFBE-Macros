package.path = package.path .. ';' .. scriptPath() .. '?.lua'

--development resolution
--eventually we'll want this to become a global variable, overwritten by the
--final script
local devRez = Location(720, 1280)

--basicchecks = require("basicchecks")
clicks = require("clicks")
drags = require("drags")
resconv = require("resconv")

local missionslot1 = resconv.convertCoordinates(Location(360, 440), devRez)
local missionslot2 = resconv.convertCoordinates(Location(360, 625), devRez)
local missionslot3 = resconv.convertCoordinates(Location(360, 810), devRez)
local missionslot4 = resconv.convertCoordinates(Location(360, 1005), devRez)
local missionslot5 = resconv.convertCoordinates(Location(360, 1190), devRez)

local selectmission = {}

--select mission by positional id
--use in the level selection and not
--first vortex screen
function selectmission.selectMissionNumber(idx)
    if (idx < 6)
    then
        if (idx == 1)
        then
            clicks.click(missionslot1)
        elseif (idx == 2)
        then
            clicks.click(missionslot2)
        elseif (idx == 3)
        then
            clicks.click(missionslot3)
        elseif (idx == 4)
        then
            clicks.click(missionslot4)
        elseif (idx == 5)
        then
            clicks.click(missionslot5)
        end
    else
        drags.missiondrag(math.floor(idx / 5))
        clicks.click(missionslot5)
    end

    wait(1)

    --clicks.clickNext()

    return true
end

--find mission by pattern
--probably useful for vortex missions
function selectmission.selectMissionPattern(inpattern)
    result = exists(idx)

    if (result)
    then
        clicks.click(result)
    else
        drags.missiondrag(1)
        
        result = exists(idx)

        if (result)
        then
            clicks.click(result)
        else
            return false
        end
    end
end

--bridge function to allow not having to rewrite loads
--of syntax
function selectmission.selectMission(input)
    if (typeof(input) == 'number')
    then
        return selectmission.selectMissionNumber(input)
    elseif typeof(idx) == 'Pattern'
        return selectmission.selectMissionPattern(input)
    end
end

--verify we're on main screen and select world icon
function selectmission.selectWorldIcon()
end

--verify we're on main screen and select vortex icon
function selectmission.selectVortexIcon()
end

--handles all world map movement
--might be best to use icons and
--set map drag movements
function selectmission.navigateWorldMap()
end

function selectmission.missionPathParser(entry)
    entrytype = typeof(entry)

    if (entrytype == 'number' or entrytype == 'Pattern')
    then
        selectmission.selectMission(entry)
    elseif entrytype == 'string'
    then
        if (entry == 'world')
        then
            selectmission.selectWorldIcon()
        elseif (entry == 'vortex')
            selectmission.selectVortexIcon()
        else
            selectmission
end

function selectmission.navigateToMission(missionpath)
    if (missionpath[1] == 'world')
    then
        selectmission.selectWorld()

        missionpath.remove(a, 1)
    elseif (missionpath[1]) == 'vortex'
    then
        selectmission.selectVortex()

        selectmission.selectMission(missionpath[2])

        selectmission.selectMission(missionpath[3])
    end
end

return selectmission
