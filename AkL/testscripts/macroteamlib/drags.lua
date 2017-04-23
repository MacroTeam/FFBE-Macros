package.path = package.path .. ';/sdcard/AnkuLua/macroteamlib/?.lua'

--development resolution
--eventually we'll want this to become a global variable, overwritten by the
--final script
local devRez = Location(720, 1280)

resconv = require("resconv")
akvars = require("akvars")

local drags = {}

local dragTimingMove = 500
local dragTimingPause = 20
local dragTimingSteps = 10
local dragTimingInterval = 50
local skillScrollValue = -365

local attackChange = resconv.convertCoordinates(Location(0, -100), devRez)
local abilityChange = resconv.convertCoordinates(Location(100, 0), devRez)
local itemChange = resconv.convertCoordinates(Location(-100, 0), devRez)
local guardChange = resconv.convertCoordinates(Location(0, 100), devRez)

local skillScrollOrigin = resconv.convertCoordinates(Location(360, 1140), devRez)
local skillScrollChange = resconv.convertCoordinates(Location(0, skillScrollValue), devRez)

--unit origin points
function drags.unitdrag(unit, type)
    local change = nil
    local origin = nil

    if (type == 'attack') then
        change = attackChange
    elseif (type == 'ability') then
        change = abilityChange
    elseif (type == 'item') then
        change = itemChange
    elseif (type == 'guard') then
        change = guardChange
    end

    origin = akvars.getOrigin(unit)

    --drag parameters, can localize and change if needed
    setDragDropTiming(dragTimingMove, dragTimingPause)
    setDragDropStepCount(dragTimingSteps)
    setDragDropStepInterval(dragTimingInterval)

    --drag move, removed old version why converted each time
    --dragDrop(resconv.convertCoordinates(origin, devRez), resconv.convertCoordinates(origin:offset(change), devRez))
    dragDrop(origin, origin:offset(change))
end

--drag one skill screen
function drags.skilldrag()
    --drag parameters, we can change these later if we need to localize
    setDragDropTiming(100, 20)
    setDragDropStepCount(200)
    setDragDropStepInterval(5)
    
    dragDrop(skillScrollOrigin, skillScrollOrigin:offset(skillScrollChange))
end

return drags