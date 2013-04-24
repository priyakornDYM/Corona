-----------------------------------------------------------------------------------------
--
-- title_page.lua
--
-- ##ref
-- Action goto game center and chk UDID
-----------------------------------------------------------------------------------------


local storyboard = require( "storyboard" )
local scene = storyboard.newScene()


function scene:createScene( event )    
    print("--------------title----------------")
    local group = self.view
    
--    local background = display.newImageRect( "img/background/bgtest.jpg", display.contentWidth, display.contentHeight )
--    background:setReferencePoint( display.TopLeftReferencePoint )
--    background.x, background.y = 0, 0
    
    local txtNameGame = display.newText( "- game name -", 20, 40, native.systemFont, 36 )
    txtNameGame:setTextColor(255,255,255)

    positX=0
    positY=200

    local startGame = display.newText("Start",positX,positY, nil, 48)
    startGame.id = "btnStart"
    startGame:setReferencePoint(display.BottomLeftReferencePoint)
    startGame:setTextColor(137,161,188)
    
    txtStart=3
    txtStop=1

    startGame.xScale = 3

    local function animeShowTxt( event )
      --print( event.time,"Hello world! rnd" )
      txtStart = txtStart-0.2
      startGame.xScale = txtStart
      startGame:translate(10, 1)  

      --print (txtStart,'chked')

      if txtStart < txtStop then 
        startGame:setTextColor(204,0,0)
        timer.cancel( event.source )
      end
      
    end
    timer.performWithDelay( 50, animeShowTxt, 0 ) -- fede start
      
--    group:insert( background )
    group:insert( txtNameGame)
    group:insert(startGame)
    
    
    local function onStartTouch(event)         
        --print('onStartTouch')
        storyboard.gotoScene( "map", "crossFade", 500 )
        return true
    end
    startGame:addEventListener( "touch", onStartTouch ) -- touch togo mainpage   
    
------------- other scene ---------------
    storyboard.removeScene( "map" )
    storyboard.removeScene( "map_substate" )
    storyboard.removeScene( "team_main" )
    storyboard.removeScene( "shop_main" )
    storyboard.removeScene( "gacha_main" )
    storyboard.removeScene( "commu_main" )
end

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
    



--timer.performWithDelay( 5000, function()
--        storyboard.reloadScene()
--    end, 1 )
















