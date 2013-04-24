-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- include Corona's "widget" library
local widget = require "widget"

--------------------------------------------

-- forward declarations and other locals
local playBtn
-- 'onRelease' event listener for playBtn
local function onPlayBtnRelease()
	
	-- go to level1.lua scene
	storyboard.gotoScene( "level1", "fade", 200 )
	
	return true	-- indicates successful touch
end

local optionBtn
-- 'onRelease' event listener for playBtn
local function onoptionBtnRelease()
	
	-- go to level1.lua scene
	storyboard.gotoScene( "option", "slideLeft", 200 )
	
	return true	-- indicates successful touch
end


local dataPage
local function ondataPage()
storyboard.gotoScene( "database", "fade", 300 )
	return true	-- indicates successful touch
end
-----------------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
-- 
-- NOTE: Code outside of listener functions (below) will only be executed once,
--		 unless storyboard.removeScene() is called.
-- 
-----------------------------------------------------------------------------------------

-- Called when the scene's view does not exist:

function scene:createScene( event )
	local group = self.view
	local group2 = self.view

	-- display a background image
	local background = display.newImageRect( "crate.png", display.contentWidth, display.contentHeight )
	background:setReferencePoint( display.TopLeftReferencePoint )
	background.x, background.y = 0, 0
	
	-- create/position logo/title image on upper-half of the screen
	local titleLogo = display.newImageRect( "logo.png", 264, 42 )
	titleLogo:setReferencePoint( display.CenterReferencePoint )
	titleLogo.x = display.contentWidth /2
	titleLogo.y = 100
	--titleLogo.x,titleLogo.y = 160, 100
	
	-- create a widget button (which will loads level1.lua on release)
	playBtn = widget.newButton{
		label="PLAY",
		labelColor = { default={128,255}, over={0} },
		default="button.png",
		--over="button-over.png",
		width=154, height=40,
		onRelease = onPlayBtnRelease	-- event listener function
	}
	playBtn:setReferencePoint( display.CenterReferencePoint )
	playBtn.x = display.contentWidth/2
	playBtn.y = display.contentHeight - 200
	
	-- create a widget button (which will loads optionBtn.lua on release)
	optionBtn = widget.newButton{
		label="Play game",
		labelColor = { default={128,255}, over={0} },
		default="button.png",
		--over="button-over.png",
		width=154, height=40,
		onRelease = onoptionBtnRelease	-- event listener function
	}
	optionBtn:setReferencePoint( display.CenterReferencePoint )
	optionBtn.x = display.contentWidth/2
	optionBtn.y = display.contentHeight - 150
	-- all display objects must be inserted into group
		-- create a widget button (which will loads optionBtn.lua on release)
		
	dataPage = widget.newButton{
		label="database connect",
		labelColor = { default={128,255}, over={0} },
		default="button.png",
		--over="button-over.png",
		width=154, height=40,
		onRelease = ondataPage	-- event listener function
	}
	dataPage:setReferencePoint( display.CenterReferencePoint )
	dataPage.x = display.contentWidth/2
	dataPage.y = display.contentHeight - 100
	
	
	group:insert( background )
	group:insert( titleLogo )
	group2:insert( optionBtn )
	group:insert( playBtn )
	group:insert( dataPage )
	
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	local group2 = self.view
	
	-- INSERT code here (e.g. start timers, load audio, start listeners, etc.)
	
end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	local group2 = self.view
	
	-- INSERT code here (e.g. stop timers, remove listenets, unload sounds, etc.)
	
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
	local group = self.view
	local group2 = self.view
	
	if playBtn then
		playBtn:removeSelf()	-- widgets must be manually removed
		playBtn = nil
	end
	
	if optionBtn then
		optionBtn:removeSelf()	-- widgets must be manually removed
		optionBtn = nil
	end
end

-----------------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
-----------------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched whenever before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

-----------------------------------------------------------------------------------------

return scene