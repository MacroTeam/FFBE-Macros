package.path = package.path .. ';/sdcard/AnkuLua/macroteamlib/?.lua'

--development resolution
--eventually we'll want this to become a global variable, overwritten by the
--final script
local devRez = Location(720, 1280)

akvars = require("akvars")
resconv = require("resconv")

local autoButtonLoc = resconv.convertCoordinates(Location(90, 1235), devRez)
local repeatButtonLoc = resconv.convertCoordinates(Location(265, 1235), devRez)

local clicks = {}

function clicks.clickOrigin(idx)
    origin = akvars.getOrigin(idx)
    click(origin)
end

function clicks.clickUnit(idx)
    clicks.clickOrigin(idx)
end

function clicks.clickAbility(idx)
    clicks.clickOrigin(idx)
end

function clicks.clickAuto()
    click(autoButtonLoc)
end

function clicks.clickRepeat()
    click(repeatButtonLoc)
end

return clicks