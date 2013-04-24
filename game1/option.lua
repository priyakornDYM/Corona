-----------------------------------------------------------------------------------------
--
-- level1.lua
--
local storyboard = require( "storyboard" )
local physics = require("physics")
physics.start()
--local scene = storyboard.newScene()
--------------------------------------------------------------------------------------
local myPicture	= {}

local background = display.newImageRect( "lay_bt00-0x.png" , display.contentWidth, display.contentHeight )
	background:setReferencePoint( display.TopLeftReferencePoint )
	background.x, background.y = 0, 0
	-- make a crate (off-screen), position it, and rotate slightly
	
	
	--picture = {"FIRE.png","FOREST.png","HEALTH.png","WATER.png","YANG.png","YIN.png"}
	picture = {"BLUE.png","GREEN.png","PINK.png","PURPLE.png","RED.png","YELLOW.png"}
	pointPic = 53
	pointPicy = 53
	i = 0		
	
	while i < 5 do
		myPicture[i] = {}
		j = 0
		while j < 6 do
			picShow = math.random( 1 , 6 )
			myPicture[i][j]= display.newImageRect( picture[picShow], 48, 48 )
			myPicture[i][j].x, myPicture[i][j].y = ( pointPic * j ) + 27 , 452 - ( pointPicy * i)	
						j = j + 1
		end
		i = i + 1
	end
	
	--local myObject1 = display.newImageRect( picture[picShow], 48, 60 )
	--myObject1.x, myObject1.y = 80, 100 
 
-- touch listener function
function myPicture:touch( event )
	 local mtext = display.newText("oko111k",250,0,"Helvetica",16)
		mtext:setTextColor( 0 ,255,255)
	if event.phase == "began" then
          
		self.markX = self.x    -- store x location of object
        self.markY = self.y    -- store y location of object
      
     	--display.getCurrentStage():setFocus( self )
      --  self.isFocus = true
         local mtext = display.newText("okok",150,0,"Helvetica",16)
		mtext:setTextColor( 0 ,255,255)
       
  --  elseif self.isFocus then
    	if event.phase == "moved" then
    	   local mtext = display.newText("aaaa",100,0,"Helvetica",16)
		mtext:setTextColor( 0 ,255,255)
        
	
       		--local x = (event.x - event.xStart) + self.markX
       		--local y = (event.y - event.yStart) + self.markY
        	self.x = event.x
        	self.y = event.y
        
        
    	elseif event.phase == "ended" or event.phase == "cancelled" then    	
			local eX = event.x --point start touch
			local sX = self.x	-- point end touch
			
			local i = -1
			local xz = 0
			local zz = 0
			
			while i < 7 do
				xz = 27 + (53 * i)
				
         		if sX < xz then
         			zz = sX + ((53 / 2)+1)
         			
         			if zz > xz then
         				self.x = xz
         			else
         					self.x = xz - 53
         			end
         			
         			i = 7
         		end -- end if sX < xz
         			i = i + 1
         		
         	end --end while i < 6 
         	
         	
         	-- display.getCurrentStage():setFocus( nil )
           -- self.isFocus = false
         	
         	         	
       	end --end if
       	
    end
    
    return true
end
-- make 'myObject' listen for touch events

myPicture[0][0]:addEventListener( "touch", myPicture)

--myObject1:addEventListener( "touch", myObject2 )

--[[
myObject1:addEventListener( "touch", myObject3 )
myObject1:addEventListener( "touch", myObject4 )
myObject1:addEventListener( "touch", myObject5 )
myObject1:addEventListener( "touch", myObject6 )

myObject2:addEventListener( "touch", myObject1 )
myObject2:addEventListener( "touch", myObject2 )
myObject2:addEventListener( "touch", myObject3 )
myObject2:addEventListener( "touch", myObject4 )
myObject2:addEventListener( "touch", myObject5 )
myObject2:addEventListener( "touch", myObject6 )

myObject3:addEventListener( "touch", myObject1 )
myObject3:addEventListener( "touch", myObject2 )
myObject3:addEventListener( "touch", myObject3 )
myObject3:addEventListener( "touch", myObject4 )
myObject3:addEventListener( "touch", myObject5 )
myObject3:addEventListener( "touch", myObject6 )

myObject4:addEventListener( "touch", myObject1 )
myObject4:addEventListener( "touch", myObject2 )
myObject4:addEventListener( "touch", myObject3 )
myObject4:addEventListener( "touch", myObject4 )
myObject4:addEventListener( "touch", myObject5 )
myObject4:addEventListener( "touch", myObject6 )

myObject5:addEventListener( "touch", myObject1 )
myObject5:addEventListener( "touch", myObject2 )
myObject5:addEventListener( "touch", myObject3 )
myObject5:addEventListener( "touch", myObject4 )
myObject5:addEventListener( "touch", myObject5 )
myObject5:addEventListener( "touch", myObject6 )

myObject6:addEventListener( "touch", myObject1 )
myObject6:addEventListener( "touch", myObject2 )
myObject6:addEventListener( "touch", myObject3 )
myObject6:addEventListener( "touch", myObject4 )
myObject6:addEventListener( "touch", myObject5 )
myObject6:addEventListener( "touch", myObject6 )
--]]
