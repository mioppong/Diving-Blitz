local composer = require( "composer" )
local scene = composer.newScene()
local widget = require("widget");
local physics= require("physics");

local background;
local playBtn;
local authors;
local bob

--local options = { effect = "crossFade", time = 500, params = { lvl= 1} }
--composer.gotoScene("loading", options)

 halfW = display.contentWidth*0.5;
 halfH = display.contentHeight*0.5;

-- Error handler
 function myUnhandledErrorListener( event )

    if releaseBuild then

        local alert = native.showAlert( "Sorry", "Close and Re-open app" , { "Close" }, closeApp )
    else
        print( "Not handling the unhandled error >>>\n", event.errorMessage )
    end

    return releaseBuild
end

Runtime:addEventListener("unhandledError", myUnhandledErrorListener)


--when you press play on menu
 function changeScene( event )
    if event.phase == "ended" then
    composer.removeScene( "menu" )
    composer.removeScene( "soon")

    local options = { effect = "fade", time = 500, params = { lvl= 0} }
        composer.gotoScene( "loading" , options)
    end
end

-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view

    background= display.newImage("pictures/DivingBlitz1.png",halfW,halfH);
    sceneGroup:insert(background);

    words = display.newImageRect( "title.gif", 300, 60 )
    sceneGroup:insert(words)

    bob = display.newImageRect( "pictures/penguin.png", 120,120 )
    sceneGroup:insert(bob)
    bob.x = halfW
    bob.y = halfH+60

    cloud1 = display.newImageRect( "pictures/cloud1.png", 30, 30 )-- the cloud on the main screen
    cloud1.x = -5
    cloud1.y = 90;
    transition.to(cloud1, {time = 150000, iterations = 0, x=325 , transition = easing.continuousLoop})

    playBtn = widget.newButton{
        x = halfW,
        y = halfH-70,
        width = 96,
        height = 105,
        defaultFile = "pictures/buttons/resume.png",
        overFile = "pictures/buttons/resume-over.png",
        onEvent =changeScene
      }

    sceneGroup:insert(playBtn);
    -- Initialize the scene here
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
  end

-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then         -- Called when the scene is still off screen (but is about to come on screen)
        transition.to(cloud1, {time = 150000, iterations = 0, x=325 , transition = easing.continuousLoop})
        composer.removeScene( "level1")
        composer.removeScene( "level2")
        composer.removeScene( "level3")
        composer.removeScene( "level4")
        composer.removeScene( "soon")

     elseif ( phase == "did" ) then -- Example: start timers, begin animation, play audio, etc.        -- Called when the scene is now on screen


          composer.removeScene( "level1")
          composer.removeScene( "level2")
          composer.removeScene( "level3")
          composer.removeScene( "level4")
          composer.removeScene( "soon")

          words.x, words.y = halfW, halfH*0.3
          words:setFillColor(0, 0, 1)
          words.anchorX = 0.5
          transition.to(words,{time = 10000, rotation = 900, iterations = 3, transition = easing.continuousLoop})
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
        --words:removeSelf( )
        cloud1:removeSelf( );

        cloud1 = nil;
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
