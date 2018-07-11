local composer = require( "composer" )
local scene = composer.newScene()
local widget = require("widget");
local physics= require("physics");
local releaseBuild = true   -- Set to true to suppress popup message



-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called
-- -----------------------------------------------------------------------------------------------------------------

-- Local forward references should go here

-- -------------------------------------------------------------------------------
local background;
local playBtn;
local future


 halfW = display.contentWidth*0.5;
 halfH = display.contentHeight*0.5;


function mainPage( event )
     if event.phase == "ended" then
        composer.removeScene( "level1" )
        composer.removeScene( "level4" )

        composer.gotoScene("menu")
        --composer.removeScene( sceneName, shouldRecycle )
      
    end
end



-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view

      background= display.newImage("pictures/Levels/hard.png",halfW,halfH);
    sceneGroup:insert(background); 

    

   

   
    
    -- Initialize the scene here
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then

 composer.removeScene( "level4")

                  
        -- Called when the scene is still off screen (but is about to come on screen)
    elseif ( phase == "did" ) then

         var = event.params.lvl
            
        

         options = { effect = "fade", time = 500, params = { lvl = var} }
        composer.gotoScene( "play", options)


        -- Called when the scene is now on screen
        -- Insert code here to make the scene come alive
        -- Example: start timers, begin animation, play audio, etc.
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


        composer.removeScene( "level4")

  
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