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



local function markToDestroyORi( self )       
      print(">>>>>> count ".. countSlide .." i"..gemsTable[self.i][self.j].i.." j"..gemsTable[self.i][self.j].j )
           -- check on the left
      self.isMarkedToDestroy = true
      
      if self.i>1 then
        print("i"..self.i-1 .."j"..self.j.."self.i-1color ".. gemsTable[self.i-1][self.j].gemType)
          if (gemsTable[self.i-1][self.j]).isMarkedToDestroy == false  then    
              print("isMark")
              if (gemsTable[self.i-1][self.j]).gemType == self.gemType then   
                  print("self.gemType ".. self.gemType)
                  numberOfMarkedToDestroy = numberOfMarkedToDestroy + 1
                  markToDestroy( gemsTable[self.i-1][self.j] )
              end	   
          else     --- testy                     
              print("notMark "..self.i-1,self.j)
          end
      end

      -- check on the right
      if self.i<gemX then         
     --   print("i"..self.i+1 .."j"..self.j.."self.i+1color ".. gemsTable[self.i+1][self.j].gemType)
          if (gemsTable[self.i+1][self.j]).isMarkedToDestroy == false  then              
              if (gemsTable[self.i+1][self.j]).gemType == self.gemType then        
                  numberOfMarkedToDestroy = numberOfMarkedToDestroy + 1
                  markToDestroy( gemsTable[self.i+1][self.j] )
              end	 
          else     --- testy             
              print("notMark "..self.i+1,self.j)
          end
      end

      -- check above
      if self.j>1 then
     --   print("i"..self.i.."j"..self.j-1 .."self.j-1color ".. gemsTable[self.i][self.j-1].gemType)
          if (gemsTable[self.i][self.j-1]).isMarkedToDestroy == false  then                  
              if (gemsTable[self.i][self.j-1]).gemType == self.gemType then      
                  numberOfMarkedToDestroy = numberOfMarkedToDestroy + 1
                  markToDestroy( gemsTable[self.i][self.j-1] )
              end	 
          else     --- testy                       
              print("notMark "..self.i,self.j-1)
          end
      end

      -- check below
      if self.j<gemY then
    --     print("i"..self.i .."j"..self.j+1 .."self.j+1color ".. gemsTable[self.i][self.j+1].gemType)
          if (gemsTable[self.i][self.j+1]).isMarkedToDestroy== false  then   
              if (gemsTable[self.i][self.j+1]).gemType == self.gemType then     
                  numberOfMarkedToDestroy = numberOfMarkedToDestroy + 1
                  markToDestroy( gemsTable[self.i][self.j+1] )
              end	 
          else     --- testy
              
              print("notMark "..self.i,self.j+1)              
          end
      end  
     
  --print(numberOfMarkedToDestroy.." ".. gemsTable[self.i][self.j].gemType,gemsTable[self.i][self.j].i)
end

------- master

local function markPreDestory (i,j)
     --print("markPreDestory ".. gemsTable[i][j].gemType)
      if (gemsTable[i][j].gemType == "RED") then
          groupGem[1] = groupGem[1] + 1 
      elseif (gemsTable[i][j].gemType == "GREEN") then
          groupGem[2] = groupGem[2] + 1 
      elseif (gemsTable[i][j].gemType == "BLUE") then
          groupGem[3] = groupGem[3] + 1 
      elseif (gemsTable[i][j].gemType == "PURPLE") then
          groupGem[4] = groupGem[4] + 1 
      elseif (gemsTable[i][j].gemType == "PINK") then
          groupGem[5] = groupGem[5] + 1 
      elseif (gemsTable[i][j].gemType == "YELLOW") then
          groupGem[6] = groupGem[6] + 1 
      end 
end

local function markLR(self,i,j)      
      local chkMaxY =j -1
                        print(chkMaxY)
      if (chkMaxY > 0) then
          local chkL = i - 1              
      print("chkL"..chkL,i,j.." :: "..chkL,j-1)
          while chkL > 0  and chkL <= gemX  and gemsTable[i][j-1].gemType == gemsTable[chkL][j-1].gemType do                                                         
              gemsTable[chkL][j-1].isMarkedToDestroy = true  --- main     
           
              markPreDestory(chkL,j-1)    
              local chkLJ = j-2
          print("chkLJ!0  ".. chkLJ)
              if(chkLJ ~= 0) then
                  print("ffff"..i,j)  
                  if (gemsTable[chkL][j-1].gemType == gemsTable[chkL][j-2].gemType) then
                      gemsTable[chkL][j-2].isMarkedToDestroy = true  --- main     
                      print("gemType"..gemsTable[chkL][j-2].gemType.." ij "..chkL,j-2)
                       markPreDestory(chkL,j-2)   
                       
                      markLR(self,chkL,j-1) --- simple FATCAT
                
                      print("eee" ..chkL,j-1) --
                  end
              end
            
              chkL = chkL - 1                             
          end
          
          local chkR =  i + 1                       
          while chkR > 0  and chkR <= gemX  and gemsTable[i][j-1].gemType == gemsTable[chkR][j-1].gemType do                                                           
              gemsTable[chkR][j-1].isMarkedToDestroy = true  --- main                                        
              markPreDestory(chkR,j-1)    
              local chkRJ = j-2
              
              if(chkRJ ~= 0) then                                           
                  if (gemsTable[chkR][j-1].gemType == gemsTable[chkR][j-2].gemType) then
                      gemsTable[chkR][j-2].isMarkedToDestroy = true  --- main     
                      markPreDestory(chkR,j-2)   
                      markLR(self,chkR,j-2) --- simple FATCAT
                  end                                          
              end
              
              chkR = chkR + 1                             
          end    
      else
          
      end
      
end

local function markToDestroy(self)
 -- checkMemory()  
      self.startGem = self.startGem+1           
     -- print(">>>>>> count "..self.startGem ,self.chkFtPosit) -- now  
      
      if(self.chkFtPosit == "x") then                    
          if(self.startGem > gemX and self.rndGem == 1) then
              self.rndGem = 2
              self.startGem = 1          
              self.startGemY = self.j       
          elseif (self.startGem > gemX and self.rndGem == 2) then
              self.rndGem = 3
              self.startGem = 1
              self.startGemY = self.j              
          end
                  
          if self.startGem <= gemX  and self.rndGem == 1 then       ---- chk x          
             print(">>>>>> count "..self.startGem ,self.chkFtPosit) -- now  
      
              if (gemsTable[self.startGem][self.j]).isMarkedToDestroy == false  then              
                  if gemsTable[self.startGem][self.j].gemType == gemsTable[self.startGem-1][self.j].gemType  then        
                     -- numberOfMarkedToDestroy = numberOfMarkedToDestroy + 1    
                      gemsTable[self.startGem-1][self.j].isMarkedToDestroy = true   --- main
                      gemsTable[self.startGem][self.j].isMarkedToDestroy = true

                      markPreDestory(self.startGem-1,self.j)
                  end	                   
                  markToDestroy( self )
              end 
          elseif self.startGem <= gemX  and self.rndGem == 2 and self.startGemY > 0 then       ---- chk y up 
              print("like : " ..  self.startGem, self.startGemY)                
              
              local chkUp =  self.startGemY-1             
              local chkDown =  self.startGemY+1
                 
            --  if (chkUp > 0) then      
                  for  i = 1 ,gemX, 1 do
                      for  j = self.startGemY , 1, -1 do    
                          local chkMaxY =j -1
                        
                          if (chkMaxY > 0) then
                              if gemsTable[i][j-1].isMarkedToDestroy == false  then                                    
                                  if gemsTable[i][j].gemType == gemsTable[i][j-1].gemType and gemsTable[i][self.startGemY].gemType == gemsTable[i][j-1].gemType then                                         
                                     
                                      gemsTable[i][j-1].isMarkedToDestroy = true   --- main
                                      gemsTable[i][j].isMarkedToDestroy = true
              
                                      markPreDestory(i,j-1)                                     
                                                                       
                                      markLR(self,i,j)
                                       print("out loop")
 --                                     local chkL = i - 1                         
--                                      while chkL > 0  and chkL <= gemX  and gemsTable[i][j-1].gemType == gemsTable[chkL][j-1].gemType do                                                         
--                                          gemsTable[chkL][j-1].isMarkedToDestroy = true  --- main     
--                                          markPreDestory(chkL,j-1)    
--                                          local chkLJ = j-2
--                                          
--                                          if(chkLJ ~= 0) then
--                                              if (gemsTable[chkL][j-1].gemType == gemsTable[chkL][j-2].gemType) then
--                                                  gemsTable[chkL][j-2].isMarkedToDestroy = true  --- main     
--                                                  markPreDestory(chkL,j-2)       
--                                              end
--                                          end
--                                        
--                                          chkL = chkL - 1                             
--                                      end
                                      
                                     -- local chkR =  i + 1                       
--                                      while chkR > 0  and chkR <= gemX  and gemsTable[i][j-1].gemType == gemsTable[chkR][j-1].gemType do                                                           
--                                          gemsTable[chkR][j-1].isMarkedToDestroy = true  --- main                                        
--                                          markPreDestory(chkR,j-1)    
--                                          local chkRJ = j-2
--                                          
--                                          if(chkRJ ~= 0) then                                           
--                                              if (gemsTable[chkR][j-1].gemType == gemsTable[chkR][j-2].gemType) then
--                                                  gemsTable[chkR][j-2].isMarkedToDestroy = true  --- main     
--                                                  markPreDestory(chkR,j-2)                                           
--                                              end                                          
--                                          end
--                                          
--                                          chkR = chkR + 1                             
--                                      end    
                                  elseif  (j == self.startGemY) then                         
                                      break                                      
                                  end   --chkin                        
                          --        markToDestroy( self )                       
                              end  -- false                           
                          end -- chkMaxY
                      end --j
                  end --i
                  

                  
         --     end  -- end chkUp
              
          end -- end chk y up 
          
          
            
      elseif (self.chkFtPosit == "y") then
          -- bla position Y
      else 
          print(" self.chkFtPosit empry" ..self.gemType)
      end      
end
