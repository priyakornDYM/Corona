-- define a local table to store all references to functions/variables
local loadmainmenu = {}

-- Main function - MUST return a display.newGroup()
loadmainmenu.new = function( params )
	local localGroup = display.newGroup()
	
	local myTimer
	local loadingImage
	
	local loadScreen = function()
		loadingImage = display.newImageRect( "loading.png", 570, 380 )
		loadingImage.x = 240; loadingImage.y = 160
		
		local goToMenu = function()
			director:changeScene( "mainmenu", "crossfade")
		end
		
		myTimer = timer.performWithDelay( 1000, goToMenu, 1 )
	end
	
	loadScreen()
	
	local initVars = function()

	  localGroup:insert(loadingImage)

    end
	
	clean = function()
	
		if myTimer then timer.cancel( myTimer ); end
		
	end
	
	------------------
	-- INITIALIZE variables
	------------------
	initVars()
	
	-- MUST return a display.newGroup()
	return localGroup
end

return loadmainmenu		
		