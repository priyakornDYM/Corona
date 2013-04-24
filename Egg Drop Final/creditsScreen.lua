-- define a local table to store all references to functions/variables
local credits = {}

credits.new = function( params )
	local creditsGroup = display.newGroup()
	
	local backgroundImage = display.newImageRect( "creditsScreen.png", 570, 380 )
	backgroundImage.x = 240 
	backgroundImage.y = 160
	
	local changeToOptions = function( event )
		if event.phase == "began" then
			
			director:changeScene( "options", "crossfade" )
			
		end
	end
	
	backgroundImage:addEventListener( "touch", changeToOptions)
	
		
	local initVars = function()

	 	creditsGroup:insert( backgroundImage )

    end
	
	clean = function()

		backgroundImage:removeEventListener( "touch", changeToOptions)

	end
	
	initVars()
	
	-- MUST return a display.newGroup()
	return creditsGroup
end

return credits
