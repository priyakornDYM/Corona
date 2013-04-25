
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
local gemX, gemY = 6, 5
local stTableX, ftTableX = 3, 636




local function checkMemory()
   collectgarbage( "collect" )
   local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
   print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
end
--checkMemory()

local function newGem (i,j)    
    local R = mRandom(1,6)
    local newGem  
    local widthGem = 106
    

--    picture = {"img/element/red.png",
--        "img/element/green.png",
--        "img/element/blue.png",
--        "img/element/purple.png",
--        "img/element/pink.png",
--        "img/element/yellow.png"}

    newGem = display.newImageRect(picture[R],sizeGem,sizeGem)
    
    newGem.x = i * widthGem - 52    
    newGem.y = j * widthGem + 373

    newGem.i = i
    newGem.j = j

--    newGem.ismarkRoworcolum = false    --##--
--    newGem.isMarkedToDestroy = false
    
    newGem.destination_y = newGem.y
    if 	(R == 1 ) then
        newGem.gemType = "RED"
        newGem.color = 1
    elseif (R == 2 ) then
        newGem.gemType = "GREEN"
        newGem.color = 2
    elseif (R == 3 ) then
        newGem.gemType = "BLUE"
        newGem.color = 3
    elseif (R == 4 ) then
        newGem.gemType = "PURPLE"
        newGem.color = 4
    elseif (R == 5 ) then
        newGem.gemType = "PINK"
        newGem.color = 5
    elseif (R == 6 ) then
        newGem.gemType = "YELLOW"
        newGem.color = 6
    end

    --new gem falling animation
    transition.to( newGem, { time=100, y= newGem.destination_y} )

   -- groupGameLayer:insert( newGem )


    newGem.touch = onGemTouch
    newGem:addEventListener( "touch", newGem )

    return newGem
end

------------------ old (its error sensor)--------------------------
--function pasteCopyGem(self,event)    
--   -- print("create "..gemsTable[self.i][self.j].markX,gemsTable[self.i][self.j].x,gemsTable[self.i][self.j].gemType )       
--    --print("pos "..gemsTable[1][self.j].x, gemsTable[6][self.j].x)
--    print("slide "..gemsTable[6][self.j].x)
--    if(gemsTable[self.i][self.j].markX > gemsTable[self.i][self.j].x) then -- -- LEFT   
--       
----        pasteGemMark = 585 + sizeGem + 8
----        R = gemsTable[1][self.j].color                   
----        pasteGem6 = display.newImageRect(picture[R],sizeGem,sizeGem)                
----        pasteGem6.x,pasteGem6.y = pasteGemMark, gemsTable[6][self.j].markY -- 584 is latePos gem                              
--          
--       
----        if(gemsTable[6][self.j].x <= 578 ) then           
------            R = gemsTable[1][self.j].color
------            print("image path "..R,picture[ R ] )
----            pasteGemMark = 585 + sizeGem + 8  
----           
----            if(gemsTable[6][self.j].x >= 577) then                  
----                R = gemsTable[1][self.j].color                   
----                pasteGem6 = display.newImageRect(picture[R],sizeGem,sizeGem)                
----                pasteGem6.x,pasteGem6.y = pasteGemMark, gemsTable[6][self.j].markY -- 584 is latePos gem                              
----            else  
----                print("pasteGemMark")
----                pasteGem6.x = pasteGemMark + self.slideEvent
----            end 
----                 
----            print("gemsTable[6]") --
----        elseif (gemsTable[6][self.j].x <= 472) then          
----            print("gemsTable[5]")
----        elseif (gemsTable[4][self.j].x <= 366) then
----            print("gemsTable[4]")
----        elseif (gemsTable[3][self.j].x <= 260) then  
----            print("gemsTable[3]")
----        elseif (gemsTable[2][self.j].x <= 154) then
----            print("gemsTable[2]")
----        elseif (gemsTable[1][self.j].x <= 48) then  
----            print("gemsTable[1]")
----        else
----            print("type1 "..gemsTable[1][self.j].x)
----            print("type2 "..gemsTable[2][self.j].x)
----            print("type3 "..gemsTable[3][self.j].x)
----            print("type4 "..gemsTable[4][self.j].x)
----            print("type5 "..gemsTable[5][self.j].x)
----            print("type6 "..gemsTable[6][self.j].x)
----        print("slideError "..gemsTable[6][self.j].x)           
----        end 
----       
----        if(copyGem == "RED") then  
----            R = 1
----        elseif (copyGem == "GREEN") then
----            R = 2
----        elseif (copyGem == "BLUE") then
----            R = 3
----        elseif (copyGem == "PURPLE") then
----            R = 4
----        elseif (copyGem == "PINK") then
----            R = 5
----        elseif (copyGem == "YELLOW") then            
----            R = 6
----        end
----       
----        pasteGem = display.newImageRect(picture[R],sizeGem,sizeGem)
----        pasteGam.x,pasteGam.y = 10, 20
--        
--    else    -- -- RIGHT
--       -- gemsTable[gemX][self.j].gemType
--    end    
--end

function copyGem(self,event)
--    print("copyGem(self,event)  ")    
--    print("pointXY :"..gemsTable[self.i][self.j].i,gemsTable[self.i][self.j].j)
   
    copyGemXR, copyGemXL, copyGemYL, copyGemYR = {}, {}, {}, {} 
    intervalGem = sizeGem + 8
    stX = stTableX + intervalGem
    rotateR = gemX+1
    for R = 1, gemX, 1 do        
--        copyGemX[R] = gemsTable[R][self.j].colorR
--        print("color :"..gemsTable[R][self.j].gemType, copyGemX[R])
        copyGemXR[R] = display.newImageRect(picture[gemsTable[R][self.j].colorR],sizeGem,sizeGem)  
        copyGemXR[R].x, copyGemXR[R].y  = ftTableX + (intervalGem * R), gemsTable[6][self.j].markY 
        
        copyGemXL[R] = display.newImageRect(picture[gemsTable[rotateR - R][self.j].colorR],sizeGem,sizeGem)  
        copyGemXL[R].x, copyGemXL[R].y  = stTableX - (intervalGem * R), gemsTable[6][self.j].markY    
    end  
    
    for C = 1, gemY, 1 do
--        copyGemY[C] = gemsTable[self.i][C].colorR
--        print("color :"..gemsTable[self.i][C].gemType, copyGemY[C])
    end
    
end

function pasteGem(self,event) 
    print("pasteGem")
    print("position "..gemsTable[self.j][self.j].i," x "..gemsTable[self.j][self.j].markX)
    
--    1.slide position to real
--    2.replace real gemX
--    3.remove animetion copy gem
    
    if(gemsTable[self.j][self.j].i <= 584 and gemsTable[self.j][self.j].i >= 478) then
        gemsTable[self.j][self.j].x = gemsTable[self.j][self.j].x+20
        print("x "..gemsTable[self.j][self.j].x)
    end
    
    
    for R = 1, gemX, 1 do 
        copyGemXR[R]:removeSelf()
        copyGemXL[R]:removeSelf()
    end
    
end

function slideGem(self,event)
    if(self.chkFtPosit == "x") then ------- -- -- slide X    
        centerGemSt = event.xStart
        self.slideEvent = (event.x - event.xStart)
       -- gemsTable[][].j :: gemsTable[][].i == point self // gemsTable[self.i][self.j] == data self VIP               
               
        if(gemsTable[self.i][self.j].x <= 0 or gemsTable[self.i][self.j].x >= 640) then
            if(gemsTable[self.i][self.j].x <= 0) then
                
            elseif (gemsTable[self.i][self.j].x >= 640) then
                -- slide point Ft
            else
                print ("Error slideGem gemsTable[self.i][self.j].x <= 0 or gemsTable[self.i][self.j].x >= 640")
            end            
--            print("dd "..gemsTable[self.i][self.j].x)
        else  
            intervalGem = sizeGem + 8
            for posX = 1, gemX, 1 do                 
                if gemsTable[posX][self.j].i == self.i then     -- self gem pos               
                    gemsTable[posX][self.j].x = self.markX + self.slideEvent                               
                else
                    gemsTable[posX][self.j].x = gemsTable[posX][self.j].markX + self.slideEvent
                end  
                
                copyGemXR[posX].x =  ftTableX + gemsTable[posX][self.j].markX + self.slideEvent
                copyGemXL[posX].x =  stTableX - gemsTable[posX][self.j].markX + self.slideEvent
            end 
        end
        
        print("------------")
        
        checkMemory()
        
    elseif (self.chkFtPosit == "y") then -- ---- -- slide Y
        ---- wait for move Y bla bla
    else
        print ("Error X Y")
    end   
end

function onGemTouch( self, event )	-- was pre-declared   
   if event.phase == "began" then
       for  i = 1 ,gemX, 1 do
           for  j = 1 , gemY, 1 do
               gemsTable[i][j].colorR = gemsTable[i][j].color   --- - -- - copy gem
               gemsTable[i][j].markX = gemsTable[i][j].x
               gemsTable[i][j].markY = gemsTable[i][j].y          
           end
       end
       
--       self.markX = self.x    -- store x location of object
--       self.markY = self.y    -- store y location of object
        
       display.getCurrentStage():setFocus( self )
       self.isFocus = true
       
       self:setFillColor(100)
       
       local widhtLineY = 525
       local widhtLineX = 620
       
       local sizeLineStY = 695
       local sizeLineStX = 320
       
       lineY = display.newImageRect("img/other/bar_twin_v.png",100,widhtLineY)
       lineY.x, lineY.y = self.markX, sizeLineStY
       lineY:toFront()
       
       lineX = display.newImageRect("img/other/bar_twin_h.png", widhtLineX, 100)       
       lineX.x, lineX.y = sizeLineStX, self.markY
       
       copyGem(self,event)              
      
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
           --            print("end")   
           self.chkFtPosit =""  
           pasteGem(self,event)
      
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
    local group = self.view
    
    local background = display.newImageRect( "img/background/bg_puzzle_test.tga", _W, _H )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0        
    group:insert(background)      
    
    local background = display.newImageRect( "img/state_mission/water1.jpg", 640, 425 )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0
    group:insert(background) 
 
    
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



