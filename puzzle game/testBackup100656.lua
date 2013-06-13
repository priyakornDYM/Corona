
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
local groupGem = { 0, 0, 0, 0, 0, 0}
local gemToBeDestroyed  	
local isGemTouchEnabled = true 		
local countSlide = 0

 local channelX = {   54,    --1
                              160,  --2
                              266,  --3
                              372,  --4
                              478,  --5
                              584   --6
                           }      
 local channelY ={   479,  --1
                              585,  --2
                              691,  --3
                              797,  --4
                              903,  --5                  
                           }

local teamPlayer = {    "img/character/minitest1001.png" } 
local gemPlayer = {    "img/element/green.png"}





timerStash = {}
transitionStash = {}

function cancelAllTimers()
    local k, v

    for k,v in pairs(timerStash) do
        timer.cancel( v )
        v = nil; k = nil
    end

    timerStash = nil
    timerStash = {}
end

function cancelAllTransitions()
    local k, v

    for k,v in pairs(transitionStash) do
        transition.cancel( v )
        v = nil; k = nil
    end

    transitionStash = nil
    transitionStash = {}
end

local function handleLowMemory( event )
    print( "memory warning received!" )
end

Runtime:addEventListener( "memoryWarning", handleLowMemory )

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
    
    newGem.destination_y = j * widthGem + 373 --newGem.y
  
    
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
    transitionStash.newTransition = transition.to( newGem, { time=100, y= newGem.destination_y} )
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

function pasteGem(self, event)       
    if(self.chkFtPosit == "x") then        
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
            gemsTable[posX][self.j].x = channelX[posX]  
            gemsTable[posX][self.j].y = markY    
            gemsTable[posX][self.j].i = posX
            gemsTable[posX][self.j].j = markJ     
         
            gemsTable[posX][self.j].destination_y = markY
            gemsTable[posX][self.j].isMarkedToDestroy = false            
            gemsTable[posX][self.j].touch = onGemTouch
            gemsTable[posX][self.j]:addEventListener( "touch", gemsTable[posX][self.j] )               
        end
       
    elseif (self.chkFtPosit == "y") then       
        positSt = gemsTable[self.i][self.j].j 
        positEn = gemsTable[self.i][self.j].y
        slideEvent = (event.y - event.yStart)    
             
        colorTmp = {}      
        markX = gemsTable[self.i][self.j].markX    
        markI = gemsTable[self.i][self.j].i 
        slideU, slideD = 0, 0 
        
        if ( slideEvent > 60 or slideEvent < -60) then
            countSlide = countSlide +1
        end
        
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
          
            gemsTable[self.i][posY].destination_y = channelY[posY] 
            gemsTable[self.i][posY].isMarkedToDestroy = false            
            gemsTable[self.i][posY].touch = onGemTouch
            gemsTable[self.i][posY]:addEventListener( "touch", gemsTable[self.i][posY] )              
        end
    else
        --print("just click dont move")
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
      
--      for i = 1, gemX, 1 do --- x     
--        for j = 1, gemY, 1 do --- y
--            print("ยยยยi"..i.." j"..j.."    dest"..gemsTable[i][j].destination_y ) 
--        end
--    end
      
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
                      transitionStash.newTransition = transition.to( gemsTable[i][k], { time=100, y= gemsTable[i][k].destination_y} )
                                     
                      gemsTable[i][k].j = gemsTable[i][k].j + 1                
                  end
              
                  gemsTable[i][1] = newGem(i,1)

                  gemToBeDestroyed:removeSelf()
                  gemToBeDestroyed = nil
              end 
          end
      end
end --shiftGems()

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

local function enableGemTouch()
      isGemTouchEnabled = true
end

local function destroyGems(self)
	print ("Destroying Gems. Marked to Destroy = "..numberOfMarkedToDestroy)
  --print("self ".. self.i.. ":".. self.j)
	for i = 1, gemX, 1 do
      for j = 1, gemY, 1 do        
          if gemsTable[i][j].isMarkedToDestroy then      
              gemsTable[i][j]:setStrokeColor(140, 140, 140)               
              gemsTable[i][j].strokeWidth = 7  
              gemsTable[i][j]:setFillColor(150)              
                           
              --isGemTouchEnabled = false
             -- transitionStash.newTransition = transition.to( gemsTable[i][j], { time=300, alpha=0.2, xScale=2, yScale = 2, onComplete=enableGemTouch } )			
          end
      end
	end
  print("chk in"..numberOfMarkedToDestroy)
  
	--numberOfMarkedToDestroy = 0 
	--timer.performWithDelay( 320, shiftGems )
  checkMemory()
end


local function cleanUpGems()
	print("Cleaning Up Gems")

	numberOfMarkedToDestroy = 0
  
  for i = 1, gemX, 1 do
      for j = 1, gemY, 1 do			
        -- show that there is not enough
        if gemsTable[i][j].isMarkedToDestroy then
            transitionStash.newTransition = transition.to( gemsTable[i][j], { time=100, xScale=1.2, yScale = 1.2 } )
            transitionStash.newTransition = transition.to( gemsTable[i][j], { time=100, delay=100, xScale=1.0, yScale = 1.0} )
        end
        
        gemsTable[i][j].isMarkedToDestroy = false
      end
	end
end

function lockGem(self, event)          
      if( self.chkFtPosit ~= "" ) then             
          if( self.chkFtPosit == "x" ) then  
              slideEvent = (event.x - event.xStart) 
          else
              slideEvent = (event.y - event.yStart)   
          end
           
          if ( slideEvent > 60 or slideEvent < -60) then      
              if( self.chkFtPosit == "x" ) then  
                  positEn = slideEvent + gemsTable[self.i][self.j].x
                  
                  if(positEn > 533 ) then                  
                      self.i =  6        
                  elseif (positEn > 427 and positEn < 533) then  
                      self.i =  5                   
                  elseif (positEn > 319 and positEn < 427) then   
                      self.i =  4            
                  elseif (positEn > 216 and positEn < 319) then   
                      self.i =  3            
                  elseif (positEn > 111 and positEn < 216) then   
                      self.i =  2             
                  else
                      self.i =  1          
                  end        
              elseif ( self.chkFtPosit == "y" ) then   
                  positEn = slideEvent + gemsTable[self.i][self.j].y
                  
                  if(positEn > 852 ) then 
                      self.j = 5                          
                  elseif (positEn > 746 and positEn < 852) then  
                      self.j = 4                 
                  elseif (positEn > 640 and positEn < 746) then
                      self.j = 3           
                  elseif (positEn > 534 and positEn < 640) then   
                      self.j = 2     
                  else
                      self.j = 1      
                  end     
              else
                  print("-- not  send chkFtPosit")       
              end  
              
              self.startGem = 1             
              self.rndGem = 1
              markToDestroy(self)


             --print("click i" ..self.i.."j"..self.j)
              --- -- - checking
--              for  i = 1 ,gemX, 1 do
--                 for  j = 1 , gemY, 1 do           
--                     if(gemsTable[i][j].isMarkedToDestroy == false ) then
--                          print("ooooo "..gemsTable[i][j].i, gemsTable[i][j].j)
--                     else
--                          print("xxxxx "..gemsTable[i][j].i, gemsTable[i][j].j)
--                     end                    
--                 end
--             end
             
             --print("destroy "..numberOfMarkedToDestroy)
              if numberOfMarkedToDestroy >= 4 then                      
                  destroyGems(self)       
              else             
                  cleanUpGems()                
              end                
          end  
        
      else 
        --print(" self.chkFtPosit")
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
                transitionStash.newTransition = transition.to( event.target, { alpha = 1.0 } )
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
               if(gemsTable[i][j].isMarkedToDestroy == false ) then
                    print("ooooo "..gemsTable[i][j].i, gemsTable[i][j].j)
               else
                    print("xxxxx "..gemsTable[i][j].i, gemsTable[i][j].j)
               end            
            --  print("test i".. gemsTable[i][j].i.." j".. gemsTable[i][j].j.."  "  ..gemsTable[i][j].colorR )--
           end
       end

       display.getCurrentStage():setFocus( self )
       self.isFocus = true
       
       if(gemsTable[self.i][self.j].isMarkedToDestroy == false ) then
          self:setFillColor(100)       
       end
      
       
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
       gem = display.newImageRect( gemPlayer[1], 30, 30)
       gem:setReferencePoint( display.TopLeftReferencePoint )
       gem.x, gem.y = 12, 300       
       
       team = display.newImageRect( teamPlayer[1], 100, 100)
       team:setReferencePoint( display.TopLeftReferencePoint )
       team.x, team.y = 10, 300       
       
       frame = display.newImageRect( "img/other/frame.png", 100, 100)
       frame:setReferencePoint( display.TopLeftReferencePoint )
       frame.x, frame.y = 10, 300     
       
        
       self.chkFtPosit =""  
       
       print("began :"..self.x, self.y)
       print("i".. gemsTable[self.i][self.j].i.."j" ..gemsTable[self.i][self.j].j )
       print("start".. event.xStart)
       print("mark".. self.markX )
       
     --  local ftCilck = ""
   elseif self.isFocus then       
       if event.phase == "moved" then
           local posX = (event.x - event.xStart) + self.markX      
           local posY = (event.y - event.yStart) + self.markY
             
           local pathY = event.y-event.yStart
           local pathX = event.x-event.xStart                 
    
           if ( posY == self.markY or self.chkFtPosit == "x" ) then -- move X        
              if(self.chkFtPosit == "y" ) then
                  posX = self.markX
                  posY = event.y
                
                  self.chkFtPosit ="y"     
              else
                  posX = event.x
                  posY = self.markY
                
                  self.chkFtPosit ="x"    
              end                      
           elseif ( posX == self.markX or self.chkFtPosit == "y"  ) then -- move Y
              if(self.chkFtPosit == "x" ) then
                  posX = event.x
                  posY = self.markY
              
                  self.chkFtPosit ="x"    
              else
                  posX = self.markX
                  posY = event.y
             
                  self.chkFtPosit ="y"                     
              end

           else
               if (pathY < pathX  and self.chkFtPosit =="") then-- move X
                   posX = event.x
                   posY = self.markY
                   print("|xxxx")
                   self.chkFtPosit ="x" 
               elseif (pathY > pathX  and self.chkFtPosit =="") then
                   posX = self.markX-- move Y
                   posY = event.y
                   print("|yyyy")
                   self.chkFtPosit ="y" 
               end           
           end
           
           self.x, self.y = posX, posY  
           --print("x:"..posX.."evX:"..self.x.." y:"..posY.."evY:"..self.y)
           --print("slide "..gemsTable[6][self.j].x)
             
           slideGem(self,event)  --- old
     
       elseif event.phase == "ended" or event.phase == "cancelled" then
           print("end ".. self.chkFtPosit)   
           
           pasteGem(self,event)
           lockGem(self,event)
           
           self.chkFtPosit =""  
      
           display.getCurrentStage():setFocus( nil )
           self.isFocus = false
           
           if(gemsTable[self.i][self.j].isMarkedToDestroy == false ) then
              self:setFillColor(255)       
           else
              self:setFillColor(150)     
           end                     
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
    
    local gem = display.newImageRect( gemPlayer[1], 30, 30)
    gem:setReferencePoint( display.TopLeftReferencePoint )
    gem.x, gem.y = 12, 300    
       
    local team = display.newImageRect( teamPlayer[1], 100, 100)
    team:setReferencePoint( display.TopLeftReferencePoint )
    team.x, team.y = 10, 300
    group:insert(team) 
    
    local frame = display.newImageRect( "img/other/frame.png", 100, 100)
    frame:setReferencePoint( display.TopLeftReferencePoint )
    frame.x, frame.y = 10, 300     
    group:insert(frame) 
       
       
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