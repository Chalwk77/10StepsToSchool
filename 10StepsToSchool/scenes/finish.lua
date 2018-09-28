-- finish.lua for 10StepsToSchool
-- (c) 2018, Jericho Crosby <jericho.crosby227@gmail.com>
local composer = require('composer')
local widget = require('widget')
local colors = require('modules.colors-rgb')
local sounds = require('libraries.sounds')
local data_handler = require('modules.data_handler')
local scene = composer.newScene()

local function setUpDisplay(Group)
    local bg_group = display.newGroup()
    local screen_adjustment = 0.5
    local background = display.newImage(bg_group, "images/backgrounds/background2.png")
    background.xScale = (screen_adjustment * background.contentWidth) / background.contentWidth
    background.yScale = background.xScale
    background.x = display.contentCenterX
    background.y = display.contentCenterY - 50
    background.alpha = 1
end

function scene:create( event )
    local sceneGroup = self.view
    setUpDisplay(sceneGroup)
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
