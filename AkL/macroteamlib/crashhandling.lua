package.path = package.path .. ';' .. scriptPath() .. '?.lua'

--development resolution
--eventually we'll want this to become a global variable, overwritten by the
--final script
local devRez = Location(720, 1280)

--akvars = require("akvars")
--resconv = require("resconv")
local basichecks = require("basicchecks")
local errorchecks = require("errorchecks")

local crashhandling = {}

function crashhandling.startApp(version)
    if (version == nil)
    then
        version = 'google'
    end

    --needs to handle any other app versions as well
    if (version == 'google')
    then
        startApp("com.square_enix.android_googleplay.FFBEWW")
        return true
    elseif (version == 'amazon')
    then
        startApp("com.square_enix.android_amazon.FFBEWW")
        return true
    end
    
    return false
end

function crashhandling.checkAppCrash()
    if (not errorchecks.checkforwifisymbol())
    then
        return startApp()
    end

    return true
end

function crashhandling.exitLevel()
    clicks.clickGiveUp()
    wait(0.3)
    clicks.clickYesButton()

    while(basicchecks.levelBackButtonCheck())
    do
        clicks.clickLevelBackButton()
        wait(0.5)
    end

    return true
end

return crashhandling
