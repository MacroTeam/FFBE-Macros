package.path = package.path .. ';' .. scriptPath() .. '/macroteamlib/?.lua'

--development resolution
--eventually we'll want this to become a global variable, overwritten by the
--final script
local devRez = Location(720, 1280)
local rezString = devRez:getX() .. 'x' .. devRez:getY()

local rezconv = require("resconv")
local emdoorcheck = require("emdoorcheck")

emdoorcheck.checkdoors()
