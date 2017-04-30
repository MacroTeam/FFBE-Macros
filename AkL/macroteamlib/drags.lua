package.path = package.path .. ';' .. scriptPath() .. '?.lua'

--development resolution
--eventually we'll want this to become a global variable, overwritten by the
--final script
local devRez = Location(720, 1280)
local rezString = devRez:getX() .. 'x' .. devRez:getY()

resconv = require("resconv")
akvars = require("akvars")

local drags = {}

local dragTimingMove = 500
local dragTimingPause = 20
local dragTimingSteps = 10
local dragTimingInterval = 50
local skillScrollValue = -365
local missionScrollValue = -190
local friendsScrollValue = -850
local largeDpadMoveValue = 76
local largeDpadDiagonalValue = math.sqrt((largeDpadMoveValue * largeDpadMoveValue) / 2)
--local smallDpadMoveValue = 1

local attackChange = resconv.convertCoordinates(Location(0, -100), devRez)
local abilityChange = resconv.convertCoordinates(Location(100, 0), devRez)
local itemChange = resconv.convertCoordinates(Location(-100, 0), devRez)
local guardChange = resconv.convertCoordinates(Location(0, 100), devRez)

local skillScrollOrigin = resconv.convertCoordinates(Location(360, 1140), devRez)
local skillScrollChange = resconv.convertCoordinates(Location(0, skillScrollValue), devRez)

local missionScrollOrigin = resconv.convertCoordinates(Location(350, 1180), devRez)
local missionScrollChange = resconv.convertCoordinates(Location(0, missionScrollValue), devRez)

local friendsScrollOrigin = resconv.convertCoordinates(Location(360, 1140), devRez)
local friendsScrollChange = resconv.convertCoordinates(Location(0, friendsScrollValue), devRez)

local largeDpadOrigin = resconv.convertCoordinates(Location(496, 1008), devRez)
local largeDpadUp = resconv.convertCoordinates(Location(0, 0 - largeDpadMoveValue), devRez)
local largeDpadUpRight = resconv.convertCoordinates(Location(largeDpadDiagonalValue, 0 - largeDpadDiagonalValue), devRez)
local largeDpadRight = resconv.convertCoordinates(Location(largeDpadMoveValue, 0), devRez)
local largeDpadDownRight = resconv.convertCoordinates(Location(largeDpadDiagonalValue, largeDpadDiagonalValue), devRez)
local largeDpadDown = resconv.convertCoordinates(Location(0, largeDpadMoveValue), devRez)
local largeDpadDownLeft = resconv.convertCoordinates(Location(0 - largeDpadDiagonalValue, largeDpadDiagonalValue), devRez)
local largeDpadLeft = resconv.convertCoordinates(Location(0 - largeDpadMoveValue, 0), devRez)
local largeDpadUpLeft = resconv.convertCoordinates(Location(0 - largeDpadDiagonalValue, 0 - largeDpadDiagonalValue), devRez)

--local smallDPadOrigin

--unit origin points
function drags.unitdrag(unit, type)
    local change = nil
    local origin = nil

    if (type == 'attack')
    then
        change = attackChange
    elseif (type == 'ability')
    then
        change = abilityChange
    elseif (type == 'item')
    then
        change = itemChange
    elseif (type == 'guard')
    then
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

    return true
end

--drag one skill screen
function drags.skilldrag(count)
    --drag parameters, we can change these later if we need to localize
    setDragDropTiming(100, 20)
    setDragDropStepCount(200)
    setDragDropStepInterval(5)

    if (count == nil)
    then
        count = 0
    end
    
    if (count > 0)
    then
        for i=1, count, 1
        do
            dragDrop(skillScrollOrigin, skillScrollOrigin:offset(skillScrollChange))
        end
    else
        --insert scroll up code here
    end
end

--drag one mission slot
function drags.missiondrag(count)
    --drag parameters, we can change these later if we need to localize
    setDragDropTiming(100, 20)
    setDragDropStepCount(100)
    setDragDropStepInterval(5)

    if (count == nil)
    then
        count = 1
    end
    
    for i=1, count, 1
    do
        dragDrop(missionScrollOrigin, missionScrollOrigin:offset(missionScrollChange))
    end
end

--drag one friend screen
function drags.friendsdrag(count)
    --drag parameters, we can change these later if we need to localize
    setDragDropTiming(100, 20)
    setDragDropStepCount(200)
    setDragDropStepInterval(5)

    if (count == nil)
    then
        count = 1
    end
    
    for i=1, count, 1
    do
        dragDrop(friendsScrollOrigin, friendsScrollOrigin:offset(friendsScrollChange))
    end
end

function drags.dpadMove(direction, count, size)
    if (size == nil)
    then
        size = 'large'
    end

    if (count == nil)
    then
        count = 1
    end

    origin = nil
    originmove = nil

    if (size == 'large')
    then
        origin = largeDpadOrigin

        if (direction == 'up')
        then
            originmove = largeDpadUp
        elseif (direction == 'upright')
        then
            originmove = largeDpadUpRight
        elseif (direction == 'right')
        then
            originmove = largeDpadRight
        elseif (direction == 'downright')
        then
            originmove = largeDpadRight
        elseif (direction == 'down')
        then
            originmove = largeDpadDown
        elseif (direction == 'downleft')
        then
            originmove = largeDpadDownLeft
        elseif (direction == 'left')
        then
            originmove = largeDpadLeft
        elseif (direction == 'upleft')
        then
            originmove = largeDpadUpLeft
        end
    elseif(size == 'small')
    then
    end

    setDragDropTiming(10, 20)
    setDragDropStepCount(20)
    setDragDropStepInterval(5)

    for i = 1, count, 1
    do
        dragDrop(origin, origin:offset(originmove))
    end
end

return drags
