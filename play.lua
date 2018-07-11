local composer = require( "composer" )
 local physics= require("physics");
local scene = composer.newScene()
local widget = require("widget");
local functions = require( "functions")
local releaseBuild = true   -- Set to true to suppress popup message




-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called
-- -----------------------------------------------------------------------------------------------------------------

-- Local forward references should go here

-- -------------------------------------------------------------------------------
local background;
local divingBoard;
local circle;
local quitBtn;
local point;
local halfW = display.contentWidth*0.5;
local halfH = display.contentHeight*0.5;
local left    = 0-(display.actualContentWidth - display.contentWidth)/2
local top     = 0-(display.actualContentHeight - display.contentHeight)/2
local right   = display.contentWidth + (display.actualContentWidth - display.contentWidth)/2
local bottom  = display.contentHeight + (display.actualContentHeight - display.contentHeight)/2
local floaty;
local tmr;
local splash;
local pool1;
local track;
local tbl;
local exam = {};
local test;
local finger;

function mainPage( event )
     if event.phase == "ended" then
       finger:removeSelf()
        composer.gotoScene("menu")

    end
end

--function when youre out of bounds
function reput()
        circle:removeSelf( )
        composer.gotoScene( "play" , {effect = "fade", time = 500, params = {lvl= exam}})

end

--function when you hit the water and respawn back
function water(event)

    if (event.phase == "began") then
        circle:removeSelf( )
        splash.x = circle.x
        splash.y = circle.y
        splash.isVisible = true;
        composer.gotoScene( "play" , {effect = "fade", time = 500, params = {lvl= exam}})
    end
end

--function for when it hits point in floaty, then you go to loading...
function onCollision( event )
           -- timer.cancel(tmr)
    if (event.phase =="began") then

        pool1:removeSelf( )
        background = display.newImage(exam[1], halfW,halfH );
        composer.gotoScene( "loading", {effect = "fade", time= 500,params = {lvl= exam[2]}});
        background.isVisible = nil;
    end
end


function circleTouched(event)

    if event.phase == "began" then
        display.getCurrentStage( ):setFocus(event.target)
      finger.isVisible  = nil

    elseif event.phase == "ended" then
        event.target:applyLinearImpulse( ((event.xStart - event.x) / 100), ((event.yStart - event.y) / 20), event.target.x, event.target.y )
        display.getCurrentStage( ):setFocus(nil)
            physics.start( )

    end
end
-- "scene:create()"
function scene:create( event )
  local sceneGroup = self.view

    point = display.newCircle( 40, 420, 25 )
    floaty = display.newImageRect("pictures/floaty.png", 50, 50 )
    pool1 = display.newRect( halfW,halfH, 280, 10)
    divingBoard = display.newRect(-82, 90, 330, 1 )

    splash =  display.newImageRect( "pictures/splash.png", 500, 500 )
    splash.isVisible = false;

    floaty.x = 500
    floaty.y = 500
    point:setFillColor("black")
    pool1:setFillColor("black")
    divingBoard:setFillColor("black")

    point:addEventListener( "collision", onCollision )
    pool1:addEventListener( "collision", water )

    sceneGroup:insert(pool1)
    sceneGroup:insert( divingBoard);

end

-- "scene:show()"
function scene:show( event )
    require("physics")
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then

        exam = event.params.lvl;
        print( exam[2],"this is background" )

        composer.removeScene( "loading", shouldRecycle )

        circle = display.newImageRect(  "pictures/penguin.png",  50, 50 )

        circle.anchorX=0.45
        circle:addEventListener("touch",circleTouched)


        pool1.y = 450
        pool1.x = 180

        point.x= exam[3]

        splash.x = 600;
        splash.y = 500;

        floaty.x = point.x
        floaty.y = point.y

        circle.x=60;
        circle.y=70;
        circle.rotation = 0;

        physics.start();
        physics.addBody(pool1,"static",{bounce = 10})
        physics.addBody(circle, "dynamic",{density= 1, bounce = 1, radius = 10})
        physics.addBody(divingBoard, "static", { bounce = 1});
        physics.addBody(point, "static", {bounce =0.2})

        background = display.newImage(exam[1], halfW,halfH );

        quitBtn = widget.newButton{
          x = 30,
          y = 460,
          width = 50,
          height = 50,
          defaultFile = "pictures/buttons/menu.png",
          overFile = "pictures/buttons/menu-over.png",
          onEvent =  mainPage,
        }

        finger = display.newImageRect( "pictures/finger.png", 40,40)
        finger.x = circle.x+20
        finger.y = circle.y+40

        transition.to( finger,{time = 1000, iterations = 0, x= 0, transition = easing.linear})

    sceneGroup:insert( background);
    sceneGroup:insert(point);
    sceneGroup:insert(floaty)
    sceneGroup:insert(quitBtn);
    sceneGroup:insert( circle);
    sceneGroup:insert(splash)

    if(exam[2]>4) then --MOVE THE LIFE PERSERVER
        point.x = exam[3]
        floaty.x = point.x
        transition.to(point, {time = exam[4], iterations = 0, x=300 , transition = easing.linear })
        transition.to(floaty, {time = exam[4], iterations = 0, x=300 , transition = easing.linear })
    end

        -- Called when the scene is still off screen (but is about to come on screen)
    elseif ( phase == "did" ) then
      tmr = timer.performWithDelay( 2000, function()  -- Works even for rotated
            local maxRadius = (circle.contentWidth > circle.contentHeight) and circle.contentWidth or circle.contentHeight
            maxRadius = (maxRadius / 2) * math.sqrt(2)
            maxRadius = math.floor( (maxRadius * 10^2) + 0.5) / (10^2)
               if( (circle.x - maxRadius) > right ) then physics.stop() reput() return false end
               if( (circle.x + maxRadius) < left) then physics.stop() reput() return false end
               if( (circle.y + maxRadius) < top ) then physics.stop() reput() return false end
               if( (circle.y - maxRadius) > bottom ) then physics.stop() reput() return false end

               return true
             end  ,0)
    end
end

-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
                timer.cancel(tmr)

    elseif ( phase == "did" ) then



    end
end

-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view

        sceneGroup:removeSelf()
        background:removeSelf( )
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
