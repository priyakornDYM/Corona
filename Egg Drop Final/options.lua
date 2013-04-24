-- define a local table to store all references to functions/variables
local options = {}


-- Main function - MUST return a display.newGroup()
options.new = function( params )
	local optionsGroup = display.newGroup()
	
	local ui = require("ui")

	local btnAnim
	
	local btnSound = audio.loadSound( "btnSound.wav" )

	local backgroundImage = display.newImageRect( "optionsBG.png", 570, 380 )
	backgroundImage.x = 240 
	backgroundImage.y = 160
	
	
	local creditsBtn
	
	local onCreditsTouch = function( event )
		if event.phase == "release" and creditsBtn.isActive then
			
			audio.play( btnSound )
			director:changeScene( "creditsScreen", "crossfade")
			
		end
	end
	
	creditsBtn = ui.newButton{
		defaultSrc = "creditsbtn.png",
		defaultX = 100,
		defaultY = 100,
		overSrc = "creditsbtn-over.png",
		overX = 100,
		overY = 100,
		onEvent = onCreditsTouch,
		id = "CreditsButton",
		text = "",
		font = "Helvetica",
		textColor = { 255, 255, 255, 255 },
		size = 16,
		emboss = false
	}
	
	creditsBtn.x = 240 
  	creditsBtn.y = 440
	
	btnAnim = transition.to( creditsBtn, { time=500, y=260, transition=easing.inOutExpo } )	
	
	local closeBtn
	
	local onCloseTouch = function( event )
		if event.phase == "release" then
			audio.play( tapSound )
			director:changeScene( "loadmainmenu", "crossfade" )
		end
	end
	
	closeBtn = ui.newButton{
		defaultSrc = "closebtn.png",
		defaultX = 60,
		defaultY = 60,
		overSrc = "closebtn-over.png",
		overX = 60,
		overY = 60,
		onEvent = onCloseTouch,
		id = "CloseButton",
		text = "",
		font = "Helvetica",
		textColor = { 255, 255, 255, 255 },
		size = 16,
		emboss = false
	}
	
	closeBtn.x = 50 
	closeBtn.y = 280
	
	
		
	local initVars = function()

	  optionsGroup:insert( backgroundImage )
	  optionsGroup:insert( creditsBtn )
	  optionsGroup:insert( closeBtn )	

    end
	
	clean = function()

		if btnAnim then transition.cancel( btnAnim ); end

	end
	
	initVars()
	
	-- MUST return a display.newGroup()
	return optionsGroup
end

return options	
