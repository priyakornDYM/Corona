
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
local picture = {"img/element/red.png",
                        "img/element/green.png",
                        "img/element/blue.png",
                        "img/element/purple.png",
                        "img/element/pink.png",
                        "img/element/yellow.png"}

local onGemTouch
local sizeGem = 96
local widthGem = 106
local gemX, gemY = 6, 5
local stTableX, enTableX = 3, 636





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

--    newGem.ismarkRoworcolum = false    --##--
--    newGem.isMarkedToDestroy = false
    
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

   -- groupGameLayer:insert( newGem )


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
   -- print("pasteGem")
--      1. remember position and color
--      2. remove all gems
--      3. create for remember 
  print("i".. gemsTable[self.i][self.j].i.."j" ..gemsTable[self.i][self.j].j )
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
        
        maxX = gemX
        color2 = {}
        markY = gemsTable[self.i][self.j].markY    
        markJ = gemsTable[self.i][self.j].j 
        
        if(positEn > 533 ) then                  
            for posX = gemX, 1, -1 do                     
                color2[posX] = gemsTable[posX][self.j].colorR              
                markI = gemsTable[posX][self.j].i 
                
                gemsTable[posX][self.j]:removeSelf()

                if( positSt > 0) then
                    color = gemsTable[positSt][self.j].colorR                                
                    positSt = positSt - 1    
                else                               
                    color =color2[maxX]                                    
                    maxX = maxX - 1 
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
                gemsTable[posX][self.j].i = markI
                gemsTable[posX][self.j].j = markJ
                                             
                gemsTable[posX][self.j].touch = onGemTouch
                gemsTable[posX][self.j]:addEventListener( "touch", gemsTable[posX][self.j] )                   
          end              
          
        elseif (positEn > 427 and positEn < 533) then                                 
                for posX = gemX, 1, -1 do                     
                color2[posX] = gemsTable[posX][self.j].colorR              
                markI = gemsTable[posX][self.j].i 
                
                gemsTable[posX][self.j]:removeSelf()

                if( positSt > 0) then
                    color = gemsTable[positSt][self.j].colorR                                
                    positSt = positSt - 1    
                else                               
                    color =color2[maxX]                                    
                    maxX = maxX - 1 
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
                print("poas "..positSt)
               if(posX-1 <= 0)then
                    gemsTable[posX][self.j].x = channelX[6]   ---- chk
                    gemsTable[posX][self.j].i = 6 
                else    
                    gemsTable[posX][self.j].x = channelX[posX-1]   ---- chk
                    gemsTable[posX][self.j].i = posX -1                  
                end
                
                gemsTable[posX][self.j].color = color                  
                gemsTable[posX][self.j].y = markY                 
                gemsTable[posX][self.j].j = markJ                 
                                             
                gemsTable[posX][self.j].touch = onGemTouch
                gemsTable[posX][self.j]:addEventListener( "touch", gemsTable[posX][self.j] )   
                end         
            --
              
        elseif (positEn > 319 and positEn < 427) then   
        elseif (positEn > 216 and positEn < 319) then    
        elseif (positEn > 111 and positEn < 216) then         
        end    

      --print("slideEvent "..slideEvent," last position "..positEn)
       
    elseif (self.chkFtPosit == "y") then
--          channelY ={
--                    479,  --1
--                    585,  --2
--                    691,  --3
--                    797,  --4
--                    903,  --5                  
--                 }
        --- bla bla y
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
    checkMemory()
end

function jumpGem(posit,RLUD)
    print("jump " ..posit,RLUD)
    
--jumpGem:addEventListener( "cancelled", myListener ) 
-- 

--local event = { name="cancelled"} 
--jumpGem:dispatchEvent( event )
    
end

function slideGem(self,event)    
    if(self.chkFtPosit == "x") then ------- -- -- slide X              
        self.slideEvent = (event.x - event.xStart)        
       -- gemsTable[][].j :: gemsTable[][].i == point self // gemsTable[self.i][self.j] == data self VIP                         
        if(gemsTable[self.i][self.j].x <= 20 or gemsTable[self.i][self.j].x >= 620) then     --  jump end dont move          
            if(gemsTable[self.i][self.j].x <= 20) then
                posEnd ="st"                 
            elseif (gemsTable[self.i][self.j].x >= 620) then
                posEnd ="en"               
            else
                print ("Error slideGem gemsTable[self.i][self.j].x <= 0 or gemsTable[self.i][self.j].x >= 640")
            end 
            
            jumpGem(gemsTable[self.i][self.j].i,posEnd) 
            --print("dd "..gemsTable[self.i][self.j].x)
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
           if(gemsTable[self.i][self.j].y <= 455) then
                self.posEnd ="st"                 
           elseif (gemsTable[self.i][self.j].y >= 940) then
                self.posEnd ="en"              
           else
                print ("Error slideGem gemsTable[self.i][self.j].x <= 0 or gemsTable[self.i][self.j].x >= 640")
           end 
       
        ---   pasteGem(self,event) 
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

function lockGem(self,event)
      -- lock gem
end

function onTouchCancel(self,event)
  --event.phase = "cancelled"
  print("cancel")
  
end
function onGemTouch( self, event )	-- was pre-declared   
   if event.phase == "began" then
       for  i = 1 ,gemX, 1 do
           for  j = 1 , gemY, 1 do
               gemsTable[i][j].colorR = gemsTable[i][j].color   --- - -- - copy gem
               gemsTable[i][j].markX = gemsTable[i][j].x
               gemsTable[i][j].markY = gemsTable[i][j].y   
              --print("test ".. gemsTable[i][j].gemType )
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
       
--       state = display.newImageRect( "img/state_mission/water_spring.jpg", 640, 425)
--       state:setReferencePoint( display.TopLeftReferencePoint )
--       state.x, state.y = 0, 0
             
       self.chkFtPosit =""  
       
       print("began :"..self.x, self.y)
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
          -- print("end")   
           pasteGem(self,event)
           self.chkFtPosit =""  
      
           display.getCurrentStage():setFocus( nil )
           self.isFocus = false
           
           self:setFillColor(255)
           
--           if lineY ~= nil then
--                lineY:removeSelf()
--            end
           lineY:removeSelf()
           lineX:removeSelf()
       end
    end
    return true
end

function scene:createScene( event )     
    print("--------------main puzzle----------------")
    checkMemory()
    local group = self.view
    
    local background = display.newImageRect( "img/background/bg_puzzle_test.tga", _W, _H )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0        
    group:insert(background)      
    
    local state = display.newImageRect( "img/state_mission/water_spring.jpg", 640, 425)
    state:setReferencePoint( display.TopLeftReferencePoint )
    state.x, state.y = 0, 0
    group:insert(state) 
 
    
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



