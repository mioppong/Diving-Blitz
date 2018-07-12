local composer = require( "composer" )
local functions = require( "functions")
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called
-- -----------------------------------------------------------------------------------------------------------------

-- Local forward references should go here

-- -------------------------------------------------------------------------------

local options;
local gotLvl; --gets level they want to be at
local var = {};
local loadingLevel;

-- "scene:create()"
function scene:create( event )     -- Example: add display objects to "sceneGroup", add touch listeners, etc.
    local sceneGroup = self.view

    rect = display.newRect( halfW, halfH-40, 1000, 100);
    rect:setFillColor( 0.5, 0.5, 0.5 )
    sceneGroup:insert( rect );
    rect.anchorX = 0.5
end

-- "scene:show()"
function scene:show( event )        -- Called when the scene is still off screen (but is about to come on screen)
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then

       composer.removeScene( "play", shouldRecycle )
       gotLvl = event.params.lvl
       var = functions.nextLevel(gotLvl)
       loadingLevel = display.newText("LEVEL: "..var[2], 160, 200, "FREEDOM.ttf", 60 )

    elseif ( phase == "did" ) then         -- Example: start timers, begin animation, play audio, etc.
        transition.to(rect,{time = 10000, rotation = 900, iterations = 9000, transition = easing.continuousLoop})
        transition.to(loadingLevel,{time = 10000, rotation = 900, iterations = 9000, transition = easing.continuousLoop})
        sceneGroup:insert(loadingLevel)

        options = { effect = "fade", time = 500, params = { lvl = var} }

        if(var[1]==100) then
          composer.gotoScene( "soon",options )
        else
          composer.gotoScene( "play", options)
        end
    end
end

-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen)
        -- Insert code here to "pause" the scene
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen
    end
end

-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view

    -- Called prior to the removal of scene's view
    -- Insert code here to clean up the scene
    -- Example: remove display objects, save state, etc.
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene
