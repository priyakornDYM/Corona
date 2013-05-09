
-----------------------------------------------------------------------------------------
--
-- test.lua
--
-- ##ref
--
-- test puzzle play
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()


local _W = display.contentWidth     -- 640
local _H = display.contentHeight    -- 960
local mRandom = math.random

local gemsTable = {}
local picture = { "img/element/red.png",
                          "img/element/green.png",
                          "img/element/blue.png",
                          "img/element/purple.png",
                          "img/element/pink.png",
                          "img/element/yellow.png" }
local onGemTouch
local sizeGem = 96
local widthGem = 106
local gemX, gemY = 6, 5
local stTableX, enTableX = 3, 636

local numberOfMarkedToDestroy = 0
local gemToBeDestroyed  	
local isGemTouchEnabled = true 		
local countSlide = 0

local teamPlayer = {
                        "img/character/minitest1001.png"
                    } 



local function checkMemory()
   collectgarbage( "collect" )
   local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
   print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
end
--checkMemory()

local function newGem (i,j)    
    local R = mRandom(1,6)
    local newGem     
    
    newGem = display.newImageRect(picture[R],sizeGem,sizeGem)
    
    newGem.x = i * widthGem - 52    
    newGem.y = j * widthGem + 373

    newGem.i = i
    newGem.j = j

    newGem.ismarkRoworcolum = false    
    newGem.isMarkedToDestroy = false
    
    newGem.destination_y = newGem.y
  
    
    newGem.color = R
    if 	(R == 1 ) then
        newGem.gemType = "RED"       
    elseif (R == 2 ) then
        newGem.gemType = "GREEN"       
    elseif (R == 3 ) then
        newGem.gemType = "BLUE"     
    elseif (R == 4 ) then
        newGem.gemType = "PURPLE"        
    elseif (R == 5 ) then
        newGem.gemType = "PINK"      
    elseif (R == 6 ) then
        newGem.gemType = "YELLOW"    
    end

    --new gem falling animation
    transition.to( newGem, { time=100, y= newGem.destination_y} )
    groupGameLayer:insert( newGem )


    newGem.touch = onGemTouch
    newGem:addEventListener( "touch", newGem )

    return newGem
end

function copyGem(self,event)
--    print("copyGem(self,event)  ")    
--    print("pointXY :"..gemsTable[self.i][self.j].i,gemsTable[self.i][self.j].j)
    copyGemXR, copyGemXL, copyGemYU, copyGemYD = {}, {}, {}, {} 
    intervalGem = sizeGem + 8
   ------ ---  -- - chk event  -Right  -Left  -Up  -Down----
    rotateR = gemX + 1
    for R = 1, gemX, 1 do        
--        copyGemX[R] = gemsTable[R][self.j].colorR
--        print("color :"..gemsTable[R][self.j].gemType, copyGemX[R])      
        copyGemXR[R] = display.newImageRect(picture[gemsTable[R][self.j].colorR],sizeGem,sizeGem)  
        copyGemXR[R].x, copyGemXR[R].y  = enTableX + (intervalGem * R), gemsTable[gemX][self.j].markY 
        
        copyGemXL[R] = display.newImageRect(picture[gemsTable[rotateR - R][self.j].colorR],sizeGem,sizeGem)  
        copyGemXL[R].x, copyGemXL[R].y  = stTableX - (intervalGem * R), gemsTable[gemX][self.j].markY    
    end  
    
    stTableY, enTableY = 400, 903
    rotateC = gemY + 1
    for C = 1, gemY, 1 do    
        copyGemYU[C] = display.newImageRect(picture[gemsTable[self.i][C].colorR],sizeGem,sizeGem)  
        copyGemYU[C].x, copyGemYU[C].y  = gemsTable[self.i][gemY].markX, enTableY + (intervalGem * C)
        
        copyGemYD[C] = display.newImageRect(picture[gemsTable[self.i][rotateC - C].colorR],sizeGem,sizeGem)  
        copyGemYD[C].x, copyGemYD[C].y  = gemsTable[self.i][gemY].markX, stTableY - (intervalGem * C)       
    end
  
end

function pasteGem(self,event)       
    if(self.chkFtPosit == "x") then
        channelX = { 54,    --1
                          160,  --2
                          266,  --3
                          372,  --4
                          478,  --5
                          584   --6
                       }       
        positSt = gemsTable[self.i][self.j].i 
        positEn = gemsTable[self.i][self.j].x
        slideEvent = (event.x - event.xStart)    
             
        colorTmp ={}      
        markY = gemsTable[self.i][self.j].markY    
        markJ = gemsTable[self.i][self.j].j 
        slideL, slideR = 0, 0
   
        if ( slideEvent > 60 or slideEvent < -60) then
            countSlide = countSlide +1
        end
        
        for posX = gemX, 1, -1 do   
            colorTmp[posX] = gemsTable[posX][self.j].colorR           
            gemsTable[posX][self.j]:removeSelf()
        end
                
        if(positEn > 533 ) then                  
            slideL = 0
            slideR = 1
        elseif (positEn > 427 and positEn < 533) then  
            slideL = 5
            slideR = 1         
        elseif (positEn > 319 and positEn < 427) then   
            slideL = 4
            slideR = 2          
        elseif (positEn > 216 and positEn < 319) then   
            slideL = 3
            slideR = 3        
        elseif (positEn > 111 and positEn < 216) then   
            slideL = 2
            slideR = 4        
        else-- R to L only
            slideL = 1
            slideR = 5        
        end        
        -- for chk and loop
      --print("slideEvent "..slideEvent," last position "..positEn)
        for posX = gemX, 1, -1 do   
            if( posX == gemX) then      
                if(positSt > slideL)  then   --- L
                    color = colorTmp[positSt - slideL]     
                    maxXTmp = positSt - slideL                       
                else                        --- R
                    color = colorTmp[positSt + slideR]       
                    maxXTmp = positSt + slideR                      
                end                   
            else                        
                if(maxXTmp == 1 ) then
                    maxXTmp = gemX         
                    color = colorTmp[maxXTmp]    
                else
                    maxXTmp = maxXTmp - 1          
                    color = colorTmp[maxXTmp]    
                end                      
            end      
            
            gemsTable[posX][self.j] = display.newImageRect(picture[color],sizeGem,sizeGem)    
            
            if 	(color == 1 ) then
                gemsTable[posX][self.j].gemType = "RED"                                   
            elseif (color == 2 ) then
                gemsTable[posX][self.j].gemType = "GREEN"                   
            elseif (color == 3 ) then
                gemsTable[posX][self.j].gemType = "BLUE"                    
            elseif (color == 4 ) then
                gemsTable[posX][self.j].gemType = "PURPLE"                  
            elseif (color == 5 ) then
                gemsTable[posX][self.j].gemType = "PINK"                   
            elseif (color == 6 ) then
                gemsTable[posX][self.j].gemType = "YELLOW"                    
            end
                         
            gemsTable[posX][self.j].color = color               
            gemsTable[posX][self.j].x = channelX[posX]   ---- chk
            gemsTable[posX][self.j].y = markY    
            gemsTable[posX][self.j].i = posX
            gemsTable[posX][self.j].j = markJ     
          
            gemsTable[posX][self.j].touch = onGemTouch
            gemsTable[posX][self.j]:addEventListener( "touch", gemsTable[posX][self.j] )   
        end
       
    elseif (self.chkFtPosit == "y") then
        channelY ={
                  479,  --1
                  585,  --2
                  691,  --3
                  797,  --4
                  903,  --5                  
               }
        positSt = gemsTable[self.i][self.j].j 
        positEn = gemsTable[self.i][self.j].y
        slideEvent = (event.y - event.yStart)    
             
        colorTmp = {}      
        markX = gemsTable[self.i][self.j].markX    
        markI = gemsTable[self.i][self.j].i 
        slideU, slideD = 0, 0 
        
--        if ( slideEvent > 60 or slideEvent < -60) then
--            countSlide = countSlide +1
--        end
        
        for posY = gemY, 1, -1 do   
            colorTmp[posY] = gemsTable[self.i][posY].colorR              
            gemsTable[self.i][posY]:removeSelf()
        end
        
        if(positEn > 852 ) then 
            slideU = 0 
            slideD = 1           
        elseif (positEn > 746 and positEn < 852) then  
            slideU = 4 
            slideD = 1                   
        elseif (positEn > 640 and positEn < 746) then
            slideU = 3 
            slideD = 2                  
        elseif (positEn > 534 and positEn < 640) then   
            slideU = 2 
            slideD = 3           
        else-- U to D only
            slideU = 1 
            slideD = 4           
        end     
        --
         for posY = gemY, 1, -1 do   
            if( posY == gemY) then      
                if(positSt > slideU)  then   --- U 
                    color = colorTmp[positSt - slideU]     
                    maxYTmp = positSt - slideU                       
                else                        --- D
                    color = colorTmp[positSt + slideD]       
                    maxYTmp = positSt + slideD                      
                end                   
            else                        
                if(maxYTmp == 1 ) then
                    maxYTmp = gemY         
                    color = colorTmp[maxYTmp]    
                else
                    maxYTmp = maxYTmp - 1          
                    color = colorTmp[maxYTmp]    
                end                      
            end      
            
            gemsTable[self.i][posY] = display.newImageRect(picture[color],sizeGem,sizeGem)    
            
            if 	(color == 1 ) then
                gemsTable[self.i][posY].gemType = "RED"                                   
            elseif (color == 2 ) then
                gemsTable[self.i][posY].gemType = "GREEN"                   
            elseif (color == 3 ) then
                gemsTable[self.i][posY].gemType = "BLUE"                    
            elseif (color == 4 ) then
                gemsTable[self.i][posY].gemType = "PURPLE"                  
            elseif (color == 5 ) then
                gemsTable[self.i][posY].gemType = "PINK"                   
            elseif (color == 6 ) then
                gemsTable[self.i][posY].gemType = "YELLOW"                    
            end
     
            gemsTable[self.i][posY].color = color               
            gemsTable[self.i][posY].x = markX  
            gemsTable[self.i][posY].y = channelY[posY]     
            gemsTable[self.i][posY].i = markI
            gemsTable[self.i][posY].j = posY     

            gemsTable[self.i][posY].touch = onGemTouch
            gemsTable[self.i][posY]:addEventListener( "touch", gemsTable[self.i][posY] )   
        end
    else
        print("just click dont move")
    end 
  
    for R = 1, gemX, 1 do 
        copyGemXR[R]:removeSelf()
        copyGemXL[R]:removeSelf()
    end
    for C = 1, gemY, 1 do 
        copyGemYU[C]:removeSelf()
        copyGemYD[C]:removeSelf()
    end
      lineY:removeSelf()
      lineX:removeSelf()
           
    checkMemory()
    
    lockGem(self,event)    
end

function slideGem(self,event)    
    if(self.chkFtPosit == "x") then ------- -- -- slide X              
        self.slideEvent = (event.x - event.xStart)        
       -- gemsTable[][].j :: gemsTable[][].i == point self // gemsTable[self.i][self.j] == data self VIP                         
        if(gemsTable[self.i][self.j].x <= 20 or gemsTable[self.i][self.j].x >= 620) then     --  jump end dont move                  
            pasteGem(self,event) 
        else  
            intervalGem = sizeGem + 8
            for posX = 1, gemX, 1 do                 
                if gemsTable[posX][self.j].i == self.i then     -- self gem pos               
                    gemsTable[posX][self.j].x = self.markX + self.slideEvent                               
                else
                    gemsTable[posX][self.j].x = gemsTable[posX][self.j].markX + self.slideEvent
                end  
                
                copyGemXR[posX].x = enTableX + gemsTable[posX][self.j].markX + self.slideEvent
                copyGemXL[posX].x = stTableX - gemsTable[posX][self.j].markX + self.slideEvent              
            end 
        end         
    elseif (self.chkFtPosit == "y") then -- ---- -- slide Y      
        self.slideEvent = (event.y - event.yStart)   
       -- print("JUMP ".. gemsTable[self.i][self.j].y)--
         if(gemsTable[self.i][self.j].y <= 455 or gemsTable[self.i][self.j].y >= 940) then        --  jump end dont move         
              pasteGem(self,event) 
         else
            intervalGem = sizeGem + 8
            for posY = 1, gemY, 1 do                 
                if gemsTable[self.i][posY].i == self.y then     -- self gem pos               
                    gemsTable[self.i][posY].y = self.markY + self.slideEvent                               
                else
                    gemsTable[self.i][posY].y = gemsTable[self.i][posY].markY + self.slideEvent
                end              
                
                stTableY, enTableY = 853, 530
                copyGemYU[posY].x = gemsTable[self.i][posY].markX--
                copyGemYU[posY].y = enTableY + gemsTable[self.i][posY].markY + self.slideEvent
                
                copyGemYD[posY].x = gemsTable[self.i][posY].markX 
                copyGemYD[posY].y = stTableY - gemsTable[self.i][posY].markY + self.slideEvent   
            end           
         end
    else
        print ("Error SlideGem Func X Y")
    end       
   
end

local function shiftGems () 
      print ("Shifting Gems")
      -- first roww
      for i = 1, gemX, 1 do
          if gemsTable[i][1].isMarkedToDestroy then           
              gemToBeDestroyed = gemsTable[i][1]              
              
              gemsTable[i][1] = newGem(i,1)
                          
              gemToBeDestroyed:removeSelf()
              gemToBeDestroyed = nil
          end
      end
	-- rest of the rows
      for j = 2, gemY, 1 do  -- j = row number - need to do like this it needs to be checked row by row
          for i = 1, gemX, 1 do            
              if gemsTable[i][j].isMarkedToDestroy then --if you find and empty hole then shift down all gems in column
                  gemToBeDestroyed = gemsTable[i][j]                   
                  for k = j, 2, -1 do -- starting from bottom - finishing at the second row                
                      gemsTable[i][k] = gemsTable[i][k-1]                      
                      gemsTable[i][k].destination_y = gemsTable[i][k].destination_y + 106
                      transition.to( gemsTable[i][k], { time=100, y= gemsTable[i][k].destination_y} )
                                     
                      gemsTable[i][k].j = gemsTable[i][k].j + 1                
                  end
              
                  gemsTable[i][1] = newGem(i,1)

                  gemToBeDestroyed:removeSelf()
                  gemToBeDestroyed = nil
              end 
          end
      end
end --shiftGems()

local function markToDestroy( self )            
      self.isMarkedToDestroy = true
      numberOfMarkedToDestroy = numberOfMarkedToDestroy + 1
            
      print("count ".. countSlide .." i"..gemsTable[self.i][self.j].i.." j"..gemsTable[self.i][self.j].j )
      print("y" .. gemsTable[self.i][self.j].y)
  
--     savePosMark = 0
--      if( self.chkFtPosit == "x" ) then       
--          for i = 1, gemX, 1 do   
--              
--          end           
--      elseif ( self.chkFtPosit == "y" ) then
--         -- chk y bla blas
--      else
--          print("-- not  send chkFtPosit")       
--      end
--      
  --    -- check on the left
      if self.i>1 then
          if (gemsTable[self.i-1][self.j]).isMarkedToDestroy == false then
              if (gemsTable[self.i-1][self.j]).gemType == self.gemType then
                  markToDestroy( gemsTable[self.i-1][self.j] )
                  gemsTable[self.i-1][self.j]:setStrokeColor(140, 140, 140)               
                  gemsTable[self.i-1][self.j].strokeWidth = 5
              end	 
          end
      end

      -- check on the right
      if self.i<gemX then
          if (gemsTable[self.i+1][self.j]).isMarkedToDestroy == false then
              if (gemsTable[self.i+1][self.j]).gemType == self.gemType then
                  markToDestroy( gemsTable[self.i+1][self.j] )
                  gemsTable[self.i+1][self.j]:setStrokeColor(140, 140, 140)               
                  gemsTable[self.i+1][self.j].strokeWidth = 5
              end	 
          end
      end

      -- check above
      if self.j>1 then
          if (gemsTable[self.i][self.j-1]).isMarkedToDestroy == false then
              if (gemsTable[self.i][self.j-1]).gemType == self.gemType then
                  markToDestroy( gemsTable[self.i][self.j-1] )
                  gemsTable[self.i][self.j-1]:setStrokeColor(140, 140, 140)               
                  gemsTable[self.i][self.j-1].strokeWidth = 5
              end	 
          end
      end

      -- check below
      if self.j<gemY then
          if (gemsTable[self.i][self.j+1]).isMarkedToDestroy== false then
              if (gemsTable[self.i][self.j+1]).gemType == self.gemType then
                  markToDestroy( gemsTable[self.i][self.j+1] )
                  gemsTable[self.i][self.j+1]:setStrokeColor(140, 140, 140)               
                  gemsTable[self.i][self.j+1].strokeWidth = 5
              end	 
          end
      end
      
      --print(numberOfMarkedToDestroy.." ".. gemsTable[self.i][self.j].gemType,gemsTable[self.i][self.j].i)--
end

local function enableGemTouch()

	isGemTouchEnabled = true
end


local function destroyGems()
	print ("Destroying Gems. Marked to Destroy = "..numberOfMarkedToDestroy)
  
	for i = 1, gemX, 1 do
      for j = 1, gemY, 1 do        
          if gemsTable[i][j].isMarkedToDestroy then

            isGemTouchEnabled = false
            transition.to( gemsTable[i][j], { time=300, alpha=0.2, xScale=2, yScale = 2, onComplete=enableGemTouch } )			
          end
      end
	end
  
	numberOfMarkedToDestroy = 0 
	timer.performWithDelay( 320, shiftGems )

end


local function cleanUpGems()
	print("Cleaning Up Gems")
		
	numberOfMarkedToDestroy = 0
end
function lockGem(self,event)      
      markToDestroy(self)
     
      if numberOfMarkedToDestroy >= 4 then
          print("destroy : " ..numberOfMarkedToDestroy)
          --destroyGems()        --
      else 
      --    print("     dont lock but count round to attack a monster")      
          cleanUpGems()
          print("not more")
      end           
end

function formulaMission( randomGem, powerChr)
      print("formula")
      
      
      
end

local function networkListener( event )
        if ( event.isError ) then
                print ( "Network error - download failed" )
        else
                event.target.alpha = 0
                transition.to( event.target, { alpha = 1.0 } )
        end

        print ( "RESPONSE: " .. event.response )
end

function onGemTouch( self, event )	-- was pre-declared   
   if event.phase == "began" then
       for  i = 1 ,gemX, 1 do
           for  j = 1 , gemY, 1 do
               gemsTable[i][j].colorR = gemsTable[i][j].color   --- - -- - copy gem
               gemsTable[i][j].markX = gemsTable[i][j].x
               gemsTable[i][j].markY = gemsTable[i][j].y   
            --  print("test i".. gemsTable[i][j].i.." j".. gemsTable[i][j].j.."  "  ..gemsTable[i][j].colorR )--
           end
       end

       display.getCurrentStage():setFocus( self )
       self.isFocus = true
       
       self:setFillColor(100)
       
       widhtLineY, widhtLineX = 525, 620             
       sizeLineStY, sizeLineStX = 695, 320
             
       lineY = display.newImageRect("img/other/bar_twin_v.png",100,widhtLineY)
       lineY.x, lineY.y = self.markX, sizeLineStY      
       
       lineX = display.newImageRect("img/other/bar_twin_h.png", widhtLineX, 100)       
       lineX.x, lineX.y = sizeLineStX, self.markY
            
       copyGem(self, event)      
       
       state = display.newImageRect( "img/state_mission/water_spring03.jpg", 640, 425)
       state:setReferencePoint( display.TopLeftReferencePoint )
       state.x, state.y = 0, 0
       
       
       ------  simple = -=-
       team = display.newImageRect( teamPlayer[1], 100, 100)
       team:setReferencePoint( display.TopLeftReferencePoint )
       team.x, team.y = 10, 300
       team:setStrokeColor(0, 0, 0)   
       team.strokeWidth = 10
             
       self.chkFtPosit =""  
       
       print("began :"..self.x, self.y)
      -- print("i".. gemsTable[self.i][self.j].i.."j" ..gemsTable[self.i][self.j].j )
   elseif self.isFocus then
       
       if event.phase == "moved" then
           local posX = (event.x - event.xStart) + self.markX      
           local posY = (event.y - event.yStart) + self.markY
             
           local pathY = event.y-event.yStart
           local pathX = event.x-event.xStart
                 
              
           if ( posY == self.markY or self.chkFtPosit == "x") then -- move X
               posX = event.x
               posY = self.markY
               self.chkFtPosit ="x"                               
           elseif ( posX == self.markX or self.chkFtPosit == "y") then -- move Y
               posX = self.markX
               posY = event.y
               self.chkFtPosit ="y"                            
           else
               if (pathY < pathX) then-- move X
                   posX = event.x
                   posY = self.markY
                   self.chkFtPosit ="x" 
               else
                   posX = self.markX-- move Y
                   posY = event.y
                   self.chkFtPosit ="y" 
               end           
           end
           
           self.x, self.y = posX, posY  
           --print("x:"..posX.."evX:"..self.x.." y:"..posY.."evY:"..self.y)
           --print("slide "..gemsTable[6][self.j].x)
           slideGem(self,event)  --- old
                      
       elseif event.phase == "ended" or event.phase == "cancelled" then
           print("end "..gemsTable[self.i][self.j].i )   
           pasteGem(self,event)
           self.chkFtPosit =""  
      
           display.getCurrentStage():setFocus( nil )
           self.isFocus = false
           
           self:setFillColor(255)              
           
           lockGem(self,event)
       end
    end
    return true
end

function scene:createScene( event )     
    print("--------------main puzzle----------------")
    checkMemory()
    
    groupGameLayer = display.newGroup()
    
    local group = self.view
    
    local background = display.newImageRect( "img/background/bg_puzzle_test.tga", _W, _H )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0        
    group:insert(background)      
    
    local state = display.newImageRect( "img/state_mission/water_spring03.jpg", 640, 425)
    state:setReferencePoint( display.TopLeftReferencePoint )
    state.x, state.y = 0, 0
    group:insert(state) 
    
    local team = display.newImageRect( teamPlayer[1], 100, 100)
    team:setReferencePoint( display.TopLeftReferencePoint )
    team.x, team.y = 10, 300
    team:setStrokeColor(0, 0, 0)   
    team.strokeWidth = 10
    group:insert(team) 
  
    
   ------------------------- gemsTable -------------------------
    for i = 1, gemX, 1 do --- x
        gemsTable[i] = {}
        for j = 1, gemY, 1 do --- y
            gemsTable[i][j] = newGem(i,j)
        end
    end
    
    
    groupGameLayer = display.newGroup()
  --  groupEndGameLayer = display.newGroup()
    --
    group:insert(groupGameLayer)
    
    
    
end -- end for scene:createScene

function scene:enterScene( event )
    local group = self.view
  
end

function scene:exitScene( event )
    local group = self.view	
end

function scene:destroyScene( event )
    local group = self.view
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene



