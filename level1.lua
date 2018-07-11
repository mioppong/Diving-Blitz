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


function closeApp(event)
    if "clicked" == event.action then
        local i = event.index
        if 1 == i then
            native.requestExit()
       end
   end
end





--function for dragging
function circleTouched(event)

    if event.phase == "began" then
        display.getCurrentStage( ):setFocus(event.target)
    elseif event.phase == "ended" then
        event.target:applyLinearImpulse( ((event.xStart - event.x) / 100), ((event.yStart - event.y) / 20), event.target.x, event.target.y )
        display.getCurrentStage( ):setFocus(nil)

    end
end

function water(event)

    if (event.phase == "began") then

        physics.stop( )
        circle:removeSelf( )
        splash.x = circle.x
        splash.y = circle.y

        composer.gotoScene( "level1" , {effect = "fade", time = 500})
    end
end



--function for when it hits point in pool
function onCollision( event )

    if (event.phase =="began") then
    
       
        --circle:removeSelf( )
        composer.gotoScene( "level2", {effect = "fade", time= 500});

    end
end   

-- "scene:create()"
function scene:create( event )

local sceneGroup = self.view
        composer.removeScene( "main")


    splash =  display.newImageRect( "pictures/splash.png", 500, 500 )
    background = display.newImage( "pictures/Levels/one.png", halfW,halfH );
    point = display.newCircle( 200, 430, 25 )
    floaty = display.newImageRect("pictures/floaty.png", 50, 50 )
    pool1 = display.newRect( halfW,halfH, 280, 10)
    divingBoard = display.newRect(-82, 90, 330, 1 )

    point:setFillColor("black")
    pool1:setFillColor("black")
    divingBoard:setFillColor(0.9,0.8,0.8)


    quitBtn = widget.newButton{
        x = 20,
        y = 440,
        width = 50,
        height = 70,       
        defaultFile = "pictures/buttons/menu.png",
        overFile = "pictures/buttons/menu-over.png",
        onEvent =  mainPage,
    }

    sceneGroup:insert(pool1)
    sceneGroup:insert( background);
    sceneGroup:insert(point);
    sceneGroup:insert(floaty)
    sceneGroup:insert( divingBoard);
    sceneGroup:insert(quitBtn);
    sceneGroup:insert(splash)


    point:addEventListener( "collision", onCollision )
    pool1:addEventListener( "collision", water )

    
       
    --[[triesString= display.newText( "tries", halfW*1.8, halfH*0.05,  "primerprintbold.ttf" ,30 )
    triesString:setFillColor( "black")
    sceneGroup:insert(triesString)

    tries = display.newText("0",halfW*1.8,halfH*0.15,"primerprintbold.ttf",30)
    tries:setFillColor( "black" )
    sceneGroup:insert(tries)


    time= display.newText( "time", halfW*1.8, halfH*0.25 , "primerprintbold.ttf", 30)
    time:setFillColor("black")
    sceneGroup:insert(time)

    clock =display.newText( "0", halfW*1.8, halfH*0.35  ,"primerprintbold.ttf",30 )
    clock:setFillColor( "black" )
    sceneGroup:insert(clock)--]]

    --total =  display.newText("0", halfW*1.8, halfH*0.15, "primerprintbold.ttf", 30)
    --total:setFillColor("black")
    --sceneGroup:insert(total)
       
    --score = display.newText("score", halfW*1.8, halfH*0.05, "primerprintbold.ttf", 30)
    --score:setFillColor( 1, 0.2, 0.2 )
    --sceneGroup:insert(score)

        -- Initialize the scene here
        -- Example: add display objects to "s\eneGroup", add touch listeners, etc.
end

-- "scene:show()"
function scene:show( event )
    require("physics")

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then

        circle = display.newImageRect(  "pictures/penguin.png",  50, 50 )
        circle.anchorX=0.45
        circle:setFillColor("black")
        circle:addEventListener("touch",circleTouched)
        sceneGroup:insert( circle);

        pool1.y = 430
        pool1.x = 180
         
        splash.x = 600;
        splash.y = 500;

        floaty.x = 200
        floaty.y =430
        
        circle.x=60;
        circle.y=70; 
        circle.rotation = 0;

        physics.start();
        physics.addBody(pool1,"static",{bounce = 10})
        physics.addBody(circle, "dynamic",{density= 1, bounce = 1, radius = 10})
        physics.addBody(divingBoard, "static", { bounce = 1});
        physics.addBody(point, "static", {bounce =2})

        --transition.to(point, {time = 1500, iterations = 0, x=25 , transition = easing.continuousLoop})
        --transition.to(floaty, {time = 1500, iterations = 0, x=325 , transition = easing.continuousLoop})


        -- Called when the scene is still off screen (but is about to come on screen)
    elseif ( phase == "did" ) then

    tmr = timer.performWithDelay( 2000, function()  -- Works even for rotated
            local maxRadius = (circle.contentWidth > circle.contentHeight) and circle.contentWidth or circle.contentHeight
            maxRadius = (maxRadius / 2) * math.sqrt(2)
            maxRadius = math.floor( (maxRadius * 10^2) + 0.5) / (10^2)
               if( (circle.x - maxRadius) > right ) then physics.stop()--[[triesCounter()--]] composer.gotoScene( "level1", {effect = "fade", time= 1000}); return false end
               if( (circle.x + maxRadius) < left) then physics.stop()--[[triesCounter()--]] composer.gotoScene( "level1", {effect = "fade", time= 1000}); return false end
               if( (circle.y + maxRadius) < top ) then physics.stop()--[[triesCounter()--]] composer.gotoScene( "level1", {effect = "fade", time= 1000}); return false end
               if( (circle.y - maxRadius) > bottom ) then physics.stop()--[[triesCounter()--]] composer.gotoScene( "level1", {effect = "fade", time= 1000}); return false end

   return true
end  ,0)
 




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

        timer.cancel(tmr)

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
        sceneGroup:removeSelf()
     
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