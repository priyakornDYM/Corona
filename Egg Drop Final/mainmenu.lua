-- define a local table to store all references to functions/variables
local mainmenu = {}


-- Main function - MUST return a display.newGroup()
mainmenu.new = function( params )
	local menuGroup = display.newGroup()
	
	local ui = require("ui")

	local btnAnim
	
	local btnSound = audio.loadSound( "btnSound.wav" )

	local backgroundImage = display.newImageRect( "mainMenuBG.png", 570, 380 )
	backgroundImage.x = 240 
	backgroundImage.y = 160
	
	
	local playBtn
	
	local onPlayTouch = function( event )
		if event.phase == "release" and playBtn.isActive then
			
			audio.play( btnSound )
			director:changeScene( "loadgame",  "crossfade" )
			
		end
	end
	
	playBtn = ui.newButton{
		defaultSrc = "playbtn.png",
		defaultX = 100,
		defaultY = 100,
		overSrc = "playbtn-over.png",
		overX = 100,
		overY = 100,
		onEvent = onPlayTouch,
		id = "PlayButton",
		text = "",
		font = "Helvetica",
		textColor = { 255, 255, 255, 255 },
		size = 16,
		emboss = false
	}
	
	playBtn.x = 240 
  	playBtn.y = 440
	
	btnAnim = transition.to( playBtn, { time=500, y=260, transition=easing.inOutExpo } )
	
	
	local optBtn
	
	local onOptionsTouch = function( event )
		if event.phase == "release" and optBtn.isActive then
			
			audio.play( btnSound )
			director:changeScene( "options", "crossfade")
			
		end
	end
	
	optBtn = ui.newButton{
		defaultSrc = "optbtn.png",
		defaultX = 60,
		defaultY = 60,
		overSrc = "optbtn-over.png",
		overX = 60,
		overY = 60,
		onEvent = onOptionsTouch,
		id = "OptionsButton",
		text = "",
		font = "Helvetica",
		textColor = { 255, 255, 255, 255 },
		size = 16,
		emboss = false
	}
	
	optBtn.x = 430 
  	optBtn.y = 440
	
	btnAnim = transition.to( optBtn, { time=500, y=280, transition=easing.inOutExpo } )
		
	
		
	local initVars = function()

	  menuGroup:insert( backgroundImage )
	  menuGroup:insert( playBtn )
	  menuGroup:insert( optBtn )

    end
	
	clean = function()

		if btnAnim then transition.cancel( btnAnim ); end

	end
	
	initVars()
	
	-- MUST return a display.newGroup()
	return menuGroup
end

return mainmenu	
