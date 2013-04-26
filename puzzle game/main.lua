
-----------------------------------------------------------------------------------------
--
-- main.lua
--
-- ##ref
-- Scene frist page tosee
-----------------------------------------------------------------------------------------

display.setStatusBar( display.HiddenStatusBar )

-- include the Corona "storyboard" module
local storyboard = require "storyboard"

local options =
{
    effect = "fade",
    time = 100,
    params = { 
        var1 = "custom", 
        myVar = "another" }
}

-- load menu screen
--storyboard.gotoScene( "testmark")
storyboard.gotoScene( "test")





