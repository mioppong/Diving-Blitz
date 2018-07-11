local composer = require( "composer" )
local scene = composer.newScene()
local widget = require("widget");
local physics= require("physics");



-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called
-- -----------------------------------------------------------------------------------------------------------------

-- Local forward references should go here

-- -------------------------------------------------------------------------------
local background;
local playBtn;
local authors;


 halfW = display.contentWidth*0.5;
 halfH = display.contentHeight*0.5;






 function changeScene( event )
    if event.phase == "ended" then
    composer.removeScene( "menu" )
    composer.removeScene( "level1")
    composer.removeScene( "level2")
    composer.removeScene( "level3")
    composer.removeScene( "level4")
    composer.removeScene( "soon")
        composer.gotoScene( "controls" , {effect = "fade", time = 500})
    end
end

function mainPage( event )
     if event.phase == "ended" then
        composer.gotoScene("menu")
        
    end
end

-- "scene:create()"



function scene:create( event )

    local sceneGroup = self.view


background= display.newImage("pictures/DivingBlitz1.png",halfW,halfH);
sceneGroup:insert(background); 




words = display.newImageRect( "title.gif", 300, 60 )
sceneGroup:insert(words)



cloud1 = display.newImageRect( "pictures/cloud1.png", 30, 30 )  
cloud1.x = -5
cloud1.y = 90; 
transition.to(cloud1, {time = 150000, iterations = 0, x=325 , transition = easing.continuousLoop})
    

 

 --[[local square = display.newRect( 0, 0, 100, 100 )

local w,h = display.contentWidth, display.contentHeight

local function listener1( obj )
    print( "Transition 1 completed on object: " .. tostring( obj ) )
end

local function listener2( obj )
    print( "Transition 2 completed on object: " .. tostring( obj ) )
end

-- (1) move square to bottom right corner; subtract half side-length
transition.to( square, { time=1500, alpha=0, x=(w-50), y=(h-50), onComplete=listener1, iterations = 0 } )

-- (2) fade square back in after 2.5 seconds
transition.to( square, { time=500, delay=2500, alpha=1.0, onComplete=listener2, iterations = 0,transition = easing.continuousLoop} )
--]]



bob=   display.newImageRect(  "pictures/penguin.png",  100, 100 )
  bob:setFillColor( "green" )
  sceneGroup:insert(bob)



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


   -- playBtn = widget.newButton{
     --   x = halfW,
       -- y = halfH,
        --width = halfW,
        --height = halfH*.5,       
        --defaultFile = "pictures/play.png",
       -- onEvent = changeScene
    --}
    --sceneGroup:insert(playBtn);


    
    -- Initialize the scene here
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then

  transition.to(cloud1, {time = 150000, iterations = 0, x=325 , transition = easing.continuousLoop})

    composer.removeScene( "level1")
    composer.removeScene( "level2")
    composer.removeScene( "level3")
    composer.removeScene( "level4")
    composer.removeScene( "soon")

    bob.x = halfW
    bob.y = 300
    

               
        -- Called when the scene is still off screen (but is about to come on screen)
    elseif ( phase == "did" ) then


    composer.removeScene( "level1")
    composer.removeScene( "level2")
    composer.removeScene( "level3")
    composer.removeScene( "level4")
    composer.removeScene( "soon")

words.x, words.y = halfW, halfH*0.3
words:setFillColor(0, 0, 1)
words.anchorX = 0.5
transition.to(words,{time = 10000, rotation = 900, iterations = 3, transition = easing.continuousLoop})


 

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




       


        -- Called immediately after scene goes off screen
    end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view


        bob:removeSelf()
        --words:removeSelf( )
        cloud1:removeSelf( );


        --words = nil;
        bob = nil;
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