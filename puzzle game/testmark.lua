-- 
--   local _W = display.contentWidth
--local _H = display.contentHeight
--   local background = display.newImageRect( "img/background/bg_puzzle_test.tga", _W, _H )
--    background.x, background.y = 160, 30      
--   
---- create object
--local object = display.newImageRect( "img/element/green.png",96,96 )
--
--object.x = 79
--object.y =187
--local chkFtPosit
--
--
-- 
---- touch listener function
--function object:touch( event )
--    if event.phase == "began" then
--	
--        self.markX = self.x    -- store x location of object
--        self.markY = self.y    -- store y location of object
--        
--        display.getCurrentStage():setFocus( event.target )
--        self.isFocus = true
--        
--        --print("began :"..self.x, self.y)
--    elseif self.isFocus then
--        
--        
--        if event.phase == "moved" then            
----            local x = (event.x - event.xStart) + self.markX      
----            local y = (event.y - event.yStart) + self.markY
----
----            self.x, self.y = x, y    -- move object based on calculations above
--            
--            
--            
----            local t = event.target
----
----            if self.markY == t.y then -- move degree X
----                t.x = event.x
----                t.y = self.markY
----                print("oooo: ")
----            if self.markX == t.x then -- move degree Y
----                t.x = self.markX
----                t.y = event.y
----                print("xxxx: ")
----            end
--           
--              ----
--              
--              local posX = (event.x - event.xStart) + self.markX      
--              local posY = (event.y - event.yStart) + self.markY
--              
--              local pathY =event.y-event.yStart
--              local pathX =event.x-event.xStart
--              
--              
--              if ( posY == self.markY ) then -- move X
--                  if chkFtPosit == "" or chkFtPosit == "x" then
--                      posX = event.x
--                      posY = self.markY
--                      chkFtPosit ="x"
--                  else
--                      posX = self.markX
--                      posY = event.y                      
--                  end                
--                  print("xxxx1: "..self.x,event.target.x)                 
--              elseif ( posX == self.markX ) then -- move Y
--                  if chkFtPosit == "" or  chkFtPosit == "y"then
--                      posX = self.markX
--                      posY = event.y
--                      chkFtPosit ="y"
--                  else
--                      posX = event.x
--                      posY = self.markY                     
--                  end                 
----                  print("yyyy1: "..self.markY)                  
--              else
--                  if chkFtPosit == "x" then
--                      posX = event.x
--                      posY = self.markY
--                      chkFtPosit ="x"
----                      print("xxxx2: "..self.markX)                     
--                  elseif chkFtPosit == "y" then
--                      posX = self.markX
--                      posY = event.y
--                      chkFtPosit ="y"
----                      print("yyyy2: "..self.markY)   
--                  else
--                      local dd=""
--                      if (pathY < pathX) then
--                          posX = event.x
--                          posY = self.markY
--                          chkFtPosit ="x" dd="xx"
--                      else
--                          posX = self.markX
--                          posY = event.y
--                          chkFtPosit ="y" dd="yy"
--                      end
--                  end
----                  print ("slope:"..chkFtPosit,dd)
----                  print("x:"..posX.."evX:"..self.x.."mrk:"..self.markX)
----                  print("y:"..posY.."evY:"..self.y.."mrk:"..self.markY)            
--              end
--           
--            self.x, self.y = posX,posY
--          
--             
--              ----------
--            -- print("x: "..event.x ,event.xStart, self.markX,posX,chkFtin) 
--          --    print("x:"..posX.."evX:"..self.x.." y:"..posY.."evY:"..self.y)
--            
--           
--        elseif event.phase == "ended" or event.phase == "cancelled" then   
--           chkFtPosit =""          
----            print("end")         
--           display.getCurrentStage():setFocus( nil )
--           self.isFocus = false
--        end
--    end
--    return true
--end
-- 
---- make 'myObject' listen for touch events
--object:addEventListener( "touch", object )

--local lineY1 = display.newLine( 0,0, 0,40 )
--lineY1.x,lineY1.y=100,200
--lineY1:append( 105 )
--lineY1:setColor( 255, 255, 150, 255 )
--lineY1.width = 3
--
--local lineY2 = display.newLine( 0,0, 0,60 )
--lineY2.x,lineY2.y=130,50
--lineY2:setColor( 255, 255, 150, 255 )
--lineY2.width = 3
--
--
----local lineX = display.newLine( 0,0, 0,40 )
----lineX.x,lineX.y=100,200
----lineX:append( 105 )
----lineX:setColor( 255, 255, 150, 255 )
----lineX.width = 3 
--
 local sizeGem= 48

test=display.newImageRect("img/element/red.png",sizeGem, sizeGem)
test.x,test.y=100,70
test:setStrokeColor(140, 140, 140) 
test.strokeWidth = 5
-----

local square = display.newRect( 0, 0, 100, 100 )
square:setFillColor( 255,255,255 )

local w,h = display.stageWidth, display.stageHeight

local square = display.newRect( 0, 0, 100, 100 )
square:setFillColor( 255,255,255 )

local w,h = display.stageWidth, display.stageHeight

local listener1 = function( obj )
        print( "Transition 1 completed on object: " .. tostring( obj ) )
end

local listener2 = function( obj )
        print( "Transition 2 completed on object: " .. tostring( obj ) )
end

-- (1) move square to bottom right corner; subtract half side-length
--     b/c the local origin is at the square's center; fade out square
transition.to( square, { time=1500, alpha=0, x=(w-50), y=(h-50), onComplete=listener1 } )

-- (2) fade square back in after 2.5 seconds
transition.to( square, { time=500, delay=2500, alpha=1.0, onComplete=listener2 } )


--local g = display.newGroup()
---- Create and position image to be masked, and insert into group
--local image = display.newImageRect( g, "img/element/green.png", 768, 1024 )
--image:translate( display.contentCenterX, display.contentCenterY )
--
--local mask = graphics.newMask("img/element/red.png")
--g:setMask(mask)
--
---- Center the mask over the Display Group
--g:setReferencePoint( display.CenterReferencePoint )
--g.maskX = g.x
--g.maskY = g.y
--------

--local g = display.newGroup()
---- Create and position image to be masked, and insert into group
--local image = display.newImageRect( g, "img/element/green.png", 768, 1024 )
--image.x,image.y = 200,200
--image:setFillColor(50)
----image:translate( display.contentCenterX, display.contentCenterY )
--
--local mask = graphics.newMask("img/element/red.png")
--g:setMask(mask)
--
---- Center the mask over the Display Group
--g:setReferencePoint( display.CenterReferencePoint )
--g.maskX = g.x
--g.maskY = g.y
--------
--
--local bkgd = display.newImage( "img/element/green.png" )
--bkgd.x,bkgd.y = 300,400
--local laser = display.newImage( "img/element/red.png" )
--laser.x,laser.y = 300,400
--
--laser.blendMode = "screen"

--local cards = display.newGroup()     
--
--function bringToFront( event )
--    if event.phase == "began" then
--       event.target:toBack() 
--    end                         
--    return true
--end
--
--for i=1,5 do
--    local cardGroup = display.newGroup()
--
--    -- Card outline
--    local cardRect = display.newRoundedRect(0, 0, 125, 175, 12)
--    cardRect.strokeWidth = 2
--    cardRect:setFillColor(255, 255, 255)    
--    cardRect:setStrokeColor(0,0,0, 75)                                        
--    cardGroup:insert(cardRect)
--
--    -- Card values
--    local cardValue = display.newText(cardGroup, i, cardRect.contentWidth - 25, 0, native.systemFontBold, 24)     
--    cardValue:setTextColor(255, 0, 0)
--    local cardValue2 = display.newText(cardGroup, i, 0, cardRect.contentHeight - 40 , native.systemFontBold, 24)     
--    cardValue2:setTextColor(255, 0, 0)       
--
--    cardGroup.x = (i * 25)      
--
--    cards:insert(cardGroup)
--
--    cardGroup:addEventListener("touch", bringToFront) 
--end
--
--local function handleLowMemory( event ) 
--  print( "memory warning received!" ) 
--end
-- 
--Runtime:addEventListener( "memoryWarning", handleLowMemory )

--object = display.newImageRect( "img/element/green.png",96,96 )
--
--object.x = 79
--object.y =187
-- object:removeSelf()
--object = display.newImage( "img/element/red.png",96,96 )
--
--object.x = 79
--object.y =250
--
--local function spriteListener( event )
--    print( event.name, event.sprite, event.phase, event.sprite.sequence )
--end
--
 --Add sprite listener
--object:addEventListener( "touch", spriteListener )
