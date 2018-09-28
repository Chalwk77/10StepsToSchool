-- main.lua (entry point) for 10StepsToSchool
-- (c) 2018, Jericho Crosby <jericho.crosby227@gmail.com>
display.setStatusBar(display.HiddenStatusBar)
local composer = require('composer')
local data_handler = require('modules.data_handler')
data_handler({})
-- Keeps the screen ON while idle.
system.setIdleTimer( false )

function fullScreenListener()
    local platform = system.getInfo('platformName')
    if platform == 'Win' then
        Runtime:addEventListener('key',
            function(event)
                if event.phase == 'down' and ((platform == 'Win' and (event.keyName == 'f11' or (event.keyName == 'enter' and event.isAltDown)))) then
                    if native.getProperty('windowMode') == 'fullscreen' then
                        native.setProperty('windowMode', 'normal')
                    else
                        native.setProperty('windowMode', 'fullscreen')
                    end
                end
            end
        )
    end
end

if data_handler['finished'] == true then
    data_handler['finished'] = false
    local path = system.pathForFile( "tasks.txt", system.DocumentsDirectory)
    local file = io.open (path, "w")
    local value = 0
    file:write(value)
    file:close()
    composer.gotoScene("scenes.menu")
else
    composer.gotoScene("scenes.menu")
end

-- Load Features
fullScreenListener()

--
