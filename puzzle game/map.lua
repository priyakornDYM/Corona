
-----------------------------------------------------------------------------------------
--
-- map.lua
--
-- ##ref
--
-- Map
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"


--------- storyboard event -------------
local effect1 =
{    
    effect = "fade",
    time = 1500,
    params = { var1 = "custom", myVar = "another" }
}

--------- icon event -------------
local btnBattle
local btnTeam
local btnGacha
local btnShop
local btnCommu

local btnMapWater
local btnMapMountain
local btnMapForest

local function onBtnRelease(event)--
    if event.target.id == "battle" then
        print( "event: "..event.target.id)          
        storyboard.gotoScene( "map", "fade", 100 )        
    elseif  event.target.id == "team" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "team_main", "fade", 100 )
    elseif  event.target.id == "shop" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "shop_main", "fade", 100 )
    elseif  event.target.id == "gacha" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "gacha_main", "fade", 100 )
    elseif  event.target.id == "commu" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "commu_main", "fade", 100 )
    end
--    storyboard.gotoScene( "title_page", "fade", 100 )	    
    return true	-- indicates successful touch
end


local function checkMemory()
   collectgarbage( "collect" )
   local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
   print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
end
--timer.performWithDelay( 5000, checkMemory, 0 )

--checkMemory()---- chk memory use


function scene:createScene( event)
    print("--------------map----------------")
    local group = self.view
   
    local background = display.newImageRect( "img/background/map_bg.jpg", display.contentWidth, display.contentHeight )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0      
    
    btnMapMountain=display.newImageRect( "img/background/mountain_dark.png",146,95 )
    btnMapMountain.id='mountain'   
    btnMapMountain.x, btnMapMountain.y = 174, 234
    
    btnMapForest=display.newImageRect( "img/background/forest_dark.png",130,130 )
    btnMapForest.id='forest'   
    btnMapForest.x, btnMapForest.y = 183, 328
    
    btnMapWater=display.newImageRect( "img/background/water_dark.png",100,100 )
    btnMapWater.id='water'
    btnMapWater:setReferencePoint( display.TopLeftReferencePoint )
    btnMapWater.x, btnMapWater.y = 65, 250 
    btnMapWater:setStrokeColor(255, 255, 255)
    btnMapWater:setStrokeColor(140, 140, 140) 
    
    btnBattle = widget.newButton{			
            default="img/background/battle_light.png",
            over="img/background/battle_dark.png",
            width=53, height=53,
            onRelease = onBtnRelease	-- event listener function
    }
    btnBattle.id="battle"
    btnBattle:setReferencePoint( display.CenterReferencePoint )
    btnBattle.x, btnBattle.y = 43, 432    

    btnTeam = widget.newButton{			
            default="img/background/team_light.png",
            over="img/background/team_dark.png",
            width=53, height=53,
            onRelease = onBtnRelease	-- event listener function
    }
    btnTeam.id="team"
    btnTeam:setReferencePoint( display.CenterReferencePoint )
    btnTeam.x, btnTeam.y = 100, 432
    
    btnShop = widget.newButton{			
            default="img/background/store_light.png",
            over="img/background/store_dark.png",
            width=53, height=53,
            onRelease = onBtnRelease	-- event listener function
    }
    btnShop.id="shop"
    btnShop:setReferencePoint( display.CenterReferencePoint )
    btnShop.x, btnShop.y = 160, 432
    
    btnGacha = widget.newButton{			
            default="img/background/gacha_light.png",
            over="img/background/gacha_dark.png",
            width=53, height=53,
            onRelease = onBtnRelease	-- event listener function
    }
    btnGacha.id="gacha"
    btnGacha:setReferencePoint( display.CenterReferencePoint )
    btnGacha.x, btnGacha.y = 218, 432
    
    btnCommu = widget.newButton{			
            default="img/background/commu_light.png",
            over="img/background/commu_dark.png",
            width=53, height=53,
            onRelease = onBtnRelease	-- event listener function
    }
    btnCommu.id="commu"
    btnCommu:setReferencePoint( display.CenterReferencePoint )
    btnCommu.x, btnCommu.y = 275, 432
    
    group:insert(background)   
    group:insert(btnMapMountain)  
    group:insert(btnMapForest) 
    group:insert(btnMapWater)  
    
    group:insert(btnBattle)
    group:insert(btnCommu)
    group:insert(btnGacha)
    group:insert(btnShop)
    group:insert(btnTeam)

    local function onStartTouch(event)   
        if event.phase == "began" then
            print( "event began: ".. event.target.id )
            if event.target.id=="water" then               
                btnMapWater=display.newImageRect( "img/background/water_glow.png",110,110 ) 
                btnMapWater.x, btnMapWater.y = 113, 300  
                
                timer.performWithDelay( 300, function() btnMapWater:removeSelf()  end, 1 )
            elseif event.target.id=="mountain" then
                btnMapMountain=display.newImageRect( "img/background/mountain_glow.png",150,95 ) 
                btnMapMountain.x, btnMapMountain.y = 173, 230
                
                timer.performWithDelay( 300, function() btnMapMountain:removeSelf() end, 1 )
            elseif event.target.id=="forest" then
                btnMapForest=display.newImageRect( "img/background/forest_glow.png",130,130 ) 
                btnMapForest.x, btnMapForest.y = 183, 328
                
                timer.performWithDelay( 300, function() btnMapForest:removeSelf() end, 1 )
            end             
        elseif self.isFocus == "ended" then
            -- reset touch focus
          print( "event moded: ".. event.target.id )          
        end    
        timer.performWithDelay( 500, function()
              storyboard.gotoScene( "map_substate", "crossFade", 500 )  --  goto map_substate
        end, 1 )        
    end   --
    
    
    btnMapWater:addEventListener( "touch", onStartTouch ) -- touch togo map kingdoms    
    btnMapMountain:addEventListener( "touch", onStartTouch ) -- touch togo map kingdoms   
    btnMapForest:addEventListener( "touch", onStartTouch ) -- touch togo map kingdoms   
    
------------- other scene ---------------
    storyboard.removeScene( "title_page" )
    storyboard.removeScene( "map_substate" )
    storyboard.removeScene( "team_main" )
    storyboard.removeScene( "shop_main" )
    storyboard.removeScene( "gacha_main" )
    storyboard.removeScene( "commu_main" )
end

function scene:enterScene( event )
    local group = self.view	
    print("scene: enter")
end

function scene:exitScene( event )
    local group = self.view     
     print("scene: exit")
     
--    btnMapWater.isVisible = false
--    btnMapMountain.isVisible = false
--    btnMapForest.isVisible = false
--    
--    if btnTeam then
--		btnTeam:removeSelf()	-- widgets must be manually removed
--		btnTeam = nil
--	end
--    btnBattle.isVisible = false
--   
--    btnGacha.isVisible = false
--    btnShop.isVisible = false
--    btnCommu.isVisible = false

-----------------   
end

function scene:destroyScene( event )
    local group = self.view   
  
    print("scene: destroy")
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene
    




     
--    btnMapWater = widget.newButton{			
--            default="img/background/water_dark.png",
--            over="img/background/water_glow.png",
--            width=100, height=100,
--            onRelease = onPlayBtnRelease	-- event listener function
--    }
--    btnMapWater:setReferencePoint( display.CenterReferencePoint )
--    btnMapWater.x, btnMapWater.y = 118, 300
--	btnMapWater.x = display.contentWidth*0.5
--	btnMapWater.y = display.contentHeight - 125
--    
