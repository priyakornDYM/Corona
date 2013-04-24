-----------------------------------------------------------------------------------------
--
-- level1.lua
--
local storyboard = require( "storyboard" )
local physics = require("physics")
physics.start()
--local scene = storyboard.newScene()
--------------------------------------------------------------------------------------
local myObject	
local optionBtn

local background = display.newImageRect( "lay_bt00-0x.png" , display.contentWidth, display.contentHeight )
	background:setReferencePoint( display.TopLeftReferencePoint )
	background.x, background.y = 0, 0
	onRelease = randomImage
	-- make a crate (off-screen), position it, and rotate slightly
	
	
	--picture = {"FIRE.png","FOREST.png","HEALTH.png","WATER.png","YANG.png","YIN.png"}
	picture = {"BLUE.png","GREEN.png","PINK.png","PURPLE.png","RED.png","YELLOW.png"}
	pointPic = 53
	pointPicy = 53
	i = 0	
--[[	
	while i < 5 do
		j = 0
		while j < 6 do
			picShow = math.random( 1 , 6 )
			--myObject= display.newImageRect( "PINKx.png", 48, 48 )

			--myObject.x,myObject.y = 160,240
			myObject= display.newImageRect( picture[picShow], 48, 48 )
			myObject.x, myObject.y = ( pointPic * j ) + 27 , 452 - ( pointPicy * i)	
						j = j + 1
		end
		i = i + 1
	end
--]]
--row1

myObject1= display.newImageRect( "FIRE.png", 48, 48 )
myObject1.x, myObject1.y =  27 , 452 


myObject2= display.newImageRect( "FOREST.png", 48, 48 )
myObject2.x, myObject2.y =  80 , 452 


myObject3= display.newImageRect( "HEALTH.png", 48, 48 )
myObject3.x, myObject3.y =  133 , 452 


myObject4= display.newImageRect( "WATER.png", 48, 48 )
myObject4.x, myObject4.y =  186 , 452 


myObject5= display.newImageRect( "YANG.png", 48, 48 )
myObject5.x, myObject5.y =  239 , 452 


myObject6= display.newImageRect( "YIN.png", 48, 48 )
myObject6.x, myObject6.y =  292 , 452 

----------------------------------------------

myObject21= display.newImageRect( "PINK.png", 48, 48 )
myObject21.x, myObject21.y =  27 , 399 


myObject31= display.newImageRect( "YELLOW.png", 48, 48 )
myObject31.x, myObject31.y =  27 , 346 


myObject41= display.newImageRect( "RED.png", 48, 48 )
myObject41.x, myObject41.y =  27 , 293 


myObject51= display.newImageRect( "PURPLE.png", 48, 48 )
myObject51.x, myObject51.y =  27 , 240 


physics.addBody( myObject1, "static", { friction=0.5, bounce=0 } ) 

	
-- create object
--local myObject = display.newRect( 0, 0, 100, 100 )
--myObject:setFillColor( 255 )
 
-- touch listener function
function myObject1:touch( event )
   
	
	if event.phase == "began" then
        self.markX = self.x    -- store x location of object
        self.markY = self.y    -- store y location of object
        
        --physics.addBody( myObject1, "static", { friction=0.5, bounce=0 } ) 

     	display.getCurrentStage():setFocus( self )
        self.isFocus = true

    elseif self.isFocus then
    	if event.phase == "moved" then
        local x = (event.x - event.xStart) + self.markX
        --local y =  self.markY
        self.x = x
        
    	elseif event.phase == "ended" or event.phase == "cancelled" then    	
			local eX = event.x --point start touch
			local sX = self.x	-- point end touch
			
			local i = -6
			local xz = 0
			local zz = 0
			
			while i < 13 do
				xz = 27 + (53 * i)
				
         		if sX < xz then
         			zz = sX + ((53 / 2)+1)
         			
         			if zz > xz then
         				self.x = xz
         			else
         					self.x = xz - 53
         			end
         			
         			i = 13
         		end -- end if sX < xz
         			i = i + 1
         		
         	end --end while i < 6 
         	         	
       	end --end if
       	
    end
    
    return true
end

function myObject2:touch( event )

	if event.phase == "began" then
        self.markX = self.x    -- store x location of object
        self.markY = self.y    -- store y location of object
	--	local object1 = display.newRect( self.x-27,self.y-27 ,50,50)
	--	object1:setFillColor( 255 )
	display.getCurrentStage():setFocus( self )
        self.isFocus = true

    elseif self.isFocus then	
    
    if event.phase == "moved" then
        local x = (event.x - event.xStart) + self.markX
        local y = self.markY
        
        self.x, self.y = x, y    -- move object based on calculations above
        
    elseif event.phase == "ended" or event.phase == "cancelled" then
   
				 
			local eX = event.x --point start touch
			local sX = self.x	-- point end touch
			
			local i = -6
			local xz = 0
			local zz = 0
			
			
			while i < 13 do
				xz = 27 + (53 * i)
				
         		if sX < xz then
         			zz = sX + ((53 / 2)+1)
         			
         			if zz > xz then
         				self.x = xz
         			else
         			
         					self.x = xz - 53
         			end
         			
         			i = 13
         		end -- end if sX < xz
         			i = i + 1
         		
         	end --end while i < 6 
         	         	
       	end --end if
    end
    
    return true
end

function myObject3:touch( event )
   
	if event.phase == "began" then
        self.markX = self.x    -- store x location of object
        self.markY = self.y    -- store y location of object
	--	local object1 = display.newRect( self.x-27,self.y-27 ,50,50)
	--	object1:setFillColor( 255 )
	display.getCurrentStage():setFocus( self )
        self.isFocus = true

    elseif self.isFocus then	
    
    if event.phase == "moved" then
        local x = (event.x - event.xStart) + self.markX
        local y = self.markY
        
        self.x, self.y = x, y    -- move object based on calculations above
        
    elseif event.phase == "ended" or event.phase == "cancelled" then
    
			local eX = event.x --point start touch
			local sX = self.x	-- point end touch
			
			local i = -6
			local xz = 0
			local zz = 0
			
			while i < 13 do
				xz = 27 + (53 * i)
				
         		if sX < xz then
         			zz = sX + ((53 / 2)+1)
         			
         			if zz > xz then
         				self.x = xz
         			else
         			
         					self.x = xz - 53
         			end
         			
         			i = 13
         		end -- end if sX < xz
         			i = i + 1
         		
         	end --end while i < 6 
         	         	
       	end --end if
    end
    
    return true
end

function myObject4:touch( event )
  if event.phase == "began" then
        self.markX = self.x    -- store x location of object
        self.markY = self.y    -- store y location of object
	--	local object1 = display.newRect( self.x-27,self.y-27 ,50,50)
	--	object1:setFillColor( 255 )
	display.getCurrentStage():setFocus( self )
        self.isFocus = true

    elseif self.isFocus then	
    
    if event.phase == "moved" then
        local x = (event.x - event.xStart) + self.markX
        local y = self.markY
        
        self.x, self.y = x, y    -- move object based on calculations above
        
    elseif event.phase == "ended" or event.phase == "cancelled" then
   
				 
			local eX = event.x --point start touch
			local sX = self.x	-- point end touch
			
			local i = -6
			local xz = 0
			local zz = 0
			
			while i < 13 do
				xz = 27 + (53 * i)
				
         		if sX < xz then
         			zz = sX + ((53 / 2)+1)
         			
         			if zz > xz then
         				self.x = xz
         			else
         			
         					self.x = xz - 53
         			end
         			
         			i = 13
         		end -- end if sX < xz
         			i = i + 1
         		
         	end --end while i < 6 
         	         	
       	end --end if
    end
    
    return true

end

function myObject5:touch( event )
 if event.phase == "began" then
        self.markX = self.x    -- store x location of object
        self.markY = self.y    -- store y location of object
	--	local object1 = display.newRect( self.x-27,self.y-27 ,50,50)
	--	object1:setFillColor( 255 )
	display.getCurrentStage():setFocus( self )
        self.isFocus = true

    elseif self.isFocus then	
    
    if event.phase == "moved" then
        local x = (event.x - event.xStart) + self.markX
        local y = self.markY
        
        self.x, self.y = x, y    -- move object based on calculations above
        
    elseif event.phase == "ended" or event.phase == "cancelled" then
   
				 
			local eX = event.x --point start touch
			local sX = self.x	-- point end touch
			
			local i = -6
			local xz = 0
			local zz = 0
			
			while i < 13 do
				xz = 27 + (53 * i)
				
         		if sX < xz then
         			zz = sX + ((53 / 2)+1)
         			
         			if zz > xz then
         				self.x = xz
         			else
         			
         					self.x = xz - 53
         			end
         			
         			i = 13
         		end -- end if sX < xz
         			i = i + 1
         		
         	end --end while i < 6 
         	         	
       	end --end if
    end
    
    return true

end

function myObject6:touch( event )
  if event.phase == "began" then
        self.markX = self.x    -- store x location of object
        self.markY = self.y    -- store y location of object
	--	local object1 = display.newRect( self.x-27,self.y-27 ,50,50)
	--	object1:setFillColor( 255 )
	display.getCurrentStage():setFocus( self )
        self.isFocus = true

    elseif self.isFocus then	
    
    if event.phase == "moved" then
        local x = (event.x - event.xStart) + self.markX
        local y = self.markY
        
        self.x, self.y = x, y    -- move object based on calculations above
        
    elseif event.phase == "ended" or event.phase == "cancelled" then
   
				 
			local eX = event.x --point start touch
			local sX = self.x	-- point end touch
			
			local i = -6
			local xz = 0
			local zz = 0
			
			while i < 13 do
				xz = 27 + (53 * i)
				
         		if sX < xz then
         			zz = sX + ((53 / 2)+1)
         			
         			if zz > xz then
         				self.x = xz
         			else
         			
         					self.x = xz - 53
         			end
         			
         			i = 13
         		end -- end if sX < xz
         			i = i + 1
         		
         	end --end while i < 6 
         	         	
       	end --end if
    end
    
    return true

end
-- make 'myObject' listen for touch events
myObject1:addEventListener( "touch", myObject1 )
myObject1:addEventListener( "touch", myObject2 )
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

