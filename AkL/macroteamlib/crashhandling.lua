package.path = package.path .. ';' .. scriptPath() .. '?.lua'

--development resolution
--eventually we'll want this to become a global variable, overwritten by the
--final script
local devRez = Location(720, 1280)

--akvars = require("akvars")
--resconv = require("resconv")

local crashhandling = {}

function crashhandling.startApp()
    --needs to handle Amazon and any other app versions as well
    startApp("com.square_enix.android_googleplay.FFBEWW")
end

return crashhandling
