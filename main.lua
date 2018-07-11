
 halfW = display.contentWidth*0.5;
 halfH = display.contentHeight*0.5;

local composer = require( "composer" ); -- in lua, you need to have this line in the main file, so you can navigate to other pages easily

composer.gotoScene( "menu", {effect = "fade", time= 1000});
display.setStatusBar( display.HiddenStatusBar )
