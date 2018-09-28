-- menu.lua for 10StepsToSchool
-- (c) 2018, Jericho Crosby <jericho.crosby227@gmail.com>
local composer = require('composer')
local widget = require('widget')
local colors = require('modules.colors-rgb')
local sounds = require('libraries.sounds')
local data_handler = require('modules.data_handler')
local scene = composer.newScene()

local count
local tasks = {}

-- Common Screen Coordinates
local centerX = display.contentCenterX
local centerY = display.contentCenterY
local screenTop = display.screenOriginY
local screenHeight = display.viewableContentHeight - screenTop * 2

local labels = {}
labels[1] = {"BREAKFAST", 10}
labels[2] = {"WIPE PLACEMAT", 10}
labels[3] = {"PLATE ON BENCH", 10}
labels[4] = {"GET DRESSED", 10}
labels[5] = {"PUT PJ'S\n ON BED", 10}
labels[6] = {"BRUSH TEETH", 10}
labels[7] = {"PACK SCHOOL BAG", 10}
labels[8] = {"TOYS AWAY\nTHEN PLAY", 10}
labels[9] = {"SHOES ON", 10}
labels[10] = {"BAG AT DOOR", 10}

local function setUpDisplay(Group)
    -- menu background, menu buttons and other menu screen objects
    -- MAIN BACKGROUND --
    local bg_group = display.newGroup()
    local screen_adjustment = 0.5
    local background = display.newImage(bg_group, "images/backgrounds/background.png")
    background.xScale = (screen_adjustment * background.contentWidth) / background.contentWidth
    background.yScale = background.xScale
    background.x = centerX
    background.y = centerY - 50
    background:scale(0.6, 0.6)
    background.alpha = 0.75
    -- TITLE LOGO --
    local title = display.newImage(bg_group, "images/miscellaneous/title_logo.png")
    title.xScale = (screen_adjustment * background.contentWidth) / background.contentWidth
    title.yScale = background.xScale
    title.x = centerX
    title.y = centerY - 115
    title:scale(1, 1.3)
    title.alpha = 1
    --==========================================================================================================
    --==========================================================================================================
    -- BUTTONS --
    local buttons = {}
    local x, y = -2, 0
    local button_spacing = 95
    for i = 1, #labels do
        buttons[i] = widget.newButton ({
            label = labels[i][1],
            id = i,
            labelColor = {default = {colorsRGB.RGB("blue")}, over = {colorsRGB.RGB("white")}},
            font = native.systemFontBold,
            fontSize = labels[i][2],
            labelYOffset = -5,
            defaultFile = 'images/buttons/button.png',
            overFile = 'images/buttons/button-over.png',
            width = 115, height = 74,
            x = x * button_spacing + 240,
            y = 110 + y * button_spacing + 25,
            onRelease = function(object)
                if data_handler['button' .. i] == true then
                    data_handler['button' .. i] = false
                    checkmark(buttons[i], true)
                else
                    data_handler['button' .. i] = true
                    if (count >= 0 or count == nil) and (count < #labels - 1) then
                        sounds.play('onClick')
                    elseif (count == #labels - 1) then
                        sounds.play('onComplete')
                        background:removeSelf()
                        title:removeSelf()
                        for j = 1, #labels do buttons[j]:removeSelf() end
                        composer.gotoScene("scenes.finish")
                    end
                    checkmark(buttons[i], false)
                    tasks_completed(1)
                end
            end
        })
        buttons[i]:scale(0.75, 0.90)
        if data_handler['button' .. i] then checkmark(buttons[i], false) end
        x = x + 1
        local row_spacing = .05
        if x == 3 then
            x = -2
            y = y + 1 + row_spacing
        end
    end
end
--==========================================================================================================
--==========================================================================================================

function tasks_completed(number)
    for k, v in pairs(tasks["tasks"]) do
        if v.total >= 0 then
            tasks["tasks"][k].total = tasks["tasks"][k].total + number
            count = tasks["tasks"][k].total
        end
    end
    saveStatus(count)
end

function loadStatus()
    local path = system.pathForFile("tasks.txt", system.DocumentsDirectory)
    local file = io.open (path, "r")
    local sum
    if file == nil then return 0 end
    local contents = file:read( "*a" )
    file:close()
    for i = 1, string.len(contents) do sum = tonumber(contents) end
    if sum == 0 or sum == nil then sum = 0 end
    return sum
end

function saveStatus(total)
    local path = system.pathForFile( "tasks.txt", system.DocumentsDirectory)
    local file = io.open (path, "w")
    local contents = tostring(total)
    file:write(contents)
    file:close()
end

function checkmark(button, status)
    if status == true then
        button.alpha = 1
    else
        button.alpha = 0.5
    end
end

--------------------------------------------------------------------------------------------------------------------------------------------------
function scene:create( event )
    local sceneGroup = self.view
    tasks = {["tasks"] = {}}
    tasks["tasks"][1] = {["total"] = 0}
    count = loadStatus()
    if count < #labels then setUpDisplay(sceneGroup)
    elseif count >= 10 then
        composer.gotoScene("scenes.finish")
    end
end
function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase
    if (phase == "will") then
        -- scene begin
    elseif (phase == "did") then
        -- scene end
    end
end

function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase
    if (phase == "will") then
        -- scene begin
    elseif (phase == "did") then
        -- scene end
    end
end

function scene:destroy( event )
    local sceneGroup = self.view
    local phase = event.phase
    if (phase == "will") then
        -- scene begin
    elseif (phase == "did") then
        -- scene end
    end
end
--------------------------------------------------------------------------------------------------------------------------------------------------
-- Initialize scene listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
return scene
