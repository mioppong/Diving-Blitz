local M = {}

function M.nextLevel(level)

  local myTable = {
    "pictures/Levels/one.png",
    "pictures/Levels/two.png",
    "pictures/Levels/three.png",
    "pictures/Levels/four.png"};

  local result = {};




if (level == 0) then --level 1
  result[1] = myTable[1];
  result[2] = level+1
  result[3] = 150

end

if (level == 1) then --level 2
      result[1] = myTable[2];
      result[2] = level+1
      result[3] = 200

end

if (level == 2) then --level 3
      result[1] = myTable[3];
      result[2] = level+1
      result[3] = 250

end

if (level == 3) then --level 4
      result[1] = myTable[4];
      result[2] = level+1
      result[3] = 300

end

if (level == 4) then --level 5 or 1h
      result[1] = myTable[1];
      result[2] = level+1
      result[3] = 25
      result[4] = 4000

  end

  if (level == 5) then --level 6 or 2h
      result[1] = myTable[2];
      result[2] = level+1
      result[3] = 25
      result[4] = 3000
  end

   if (level == 6) then --level 7 or 3h
      result[1] = myTable[3];
      result[2] = level+1
      result[3] = 25
      result[4] = 3000
  end

   if (level == 7) then --level 8 or 4h
      result[1] = myTable[4];
      result[2] = level+1
      result[3] = 25
      result[4] = 2000
  end

 if(level ==8) then
   result[1] = 100
   result[2] = level+1
   result[3] = 25
   result[4] = 2000
 end

          return result;

end



M.yes = 0;
M.score = 0  -- Set the initial score to 0

function M.init( options )
   local customOptions = options
   local opt = {}
   opt.fontSize =  30
   opt.font =native.systemFontBold
   opt.x = display.contentWidth*1.8
   opt.y =  display.contentHeight*0.15
   opt.maxDigits =  3
   opt.leadingZeros = false
   M.filename =  "scorefile.txt"

   local prefix = ""
   if ( opt.leadingZeros ) then
      prefix = "0"
   end
   M.format = "%" .. prefix .. opt.maxDigits .. "d"

   M.scoreText = display.newText( string.format(M.format, 0), opt.x, opt.y, opt.font, opt.fontSize )

   return M.scoreText

end


function M.set( value )
   M.score = value
   M.scoreText.text = string.format( M.format, M.score )
end

function M.get()
   return M.score
end

function M.add( amount )
   M.score = M.score + amount
   M.scoreText.text = string.format( M.format, M.score )
end


function M.save()
   local path = system.pathForFile( M.scorefile, system.DocumentsDirectory )
   local file = io.open(path, "w")
   if ( file ) then
      local contents = tostring( M.score )
      file:write( contents )
      io.close( file )
      return true
   else
      print( "Error: could not read ", M.filename, "." )
      return false
   end
end

function M.load()
   local path = system.pathForFile( M.filename, system.DocumentsDirectory )
   local contents = ""
   local file = io.open( path, "r" )
   if ( file ) then
      -- Read all contents of file into a string
      local contents = file:read( "*a" )
      local score = tonumber(contents);
      io.close( file )
      return score
   else
      print( "Error: could not read scores from ", M.filename, "." )
   end
   return nil
end




--function for dragging
function M.circleTouched(event)

    if event.phase == "began" then
        display.getCurrentStage( ):setFocus(event.target)

    elseif event.phase == "ended" then
        event.target:applyLinearImpulse( ((event.xStart - event.x) / 100), ((event.yStart - event.y) / 20), event.target.x, event.target.y )
        display.getCurrentStage( ):setFocus(nil)
            physics.start( )

    end
end

function M.closeApp(event)
    if "clicked" == event.action then
        local i = event.index
        if 1 == i then
            native.requestExit()
       end
   end
end



function M.yes()
  print( "yes it works" )
end




return M
