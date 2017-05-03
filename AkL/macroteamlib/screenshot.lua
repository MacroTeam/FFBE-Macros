package.path = package.path .. ';' .. scriptPath() .. '/?.lua'

--development resolution
--eventually we'll want this to become a global variable, overwritten by the
--final script
--local devRez = Location(720, 1280)

local screenshot = {}

function screenshot.screenshot(outpath)
    if (outpath == nil)
    then
        outpath = '/sdcard/Pictures/Screenshots/fullscreen-' .. os.date('%Y/%m/%d %X') .. '.png'
    end

    local appscreen = getAppUsableScreenSize()
    local realscreen = getRealScreenSize()
    local xMin = appscreen:getX() - realscreen:getX()
    local yMin = appscreen:getY() - realscreen:getY()

    local xMax = appscreen:getX()
    local yMax = appscreen:getY()

    reg = Region(xMin, yMin, xMax, yMax) -- change to your resolution
    reg:save(outpath)
end

return screenshot
