
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local mime = require("mime")
local json = require("json")

local userid = "tada1179@hotmail.com"
local password = "1"
local optionBtn

--local URL =  "http://localhost/DYM/index.php?name=tada1179@hotmail.com&pass=1234"
--local URL =  "http://localhost/DYM/index.php?name="..userid.."&id="..password
--local URL =  "http://localhost/DYM/index.php?name=",userid,"&pass=",password
--"http://your-server-name-here.com/json.php?userid="
--        .. mime.b64(userid) .. "&password=" .. mime.b64(password)

-- DEBUG: Show constructed url
-- print ( "Remote URL: " .. URL )
--[[
JSON4Lua example script.
Demonstrates the simple functionality of the json module.
]]--
json = require('json')


-- Object to JSON encode
test = {
    one='first',two='second',three={2,3,5}
}

jsonTest = json.encode(test)

print('JSON encoded test is: ' .. jsonTest)

-- Now JSON decode the json string
result = json.decode(jsonTest)

print ("The decoded table result:")
table.foreach(result,print)
print ("The decoded table result.three")
table.foreach(result.three, print)
local i = 0
local URL
while i < 5 do
    local name = {"one","two","three","four","five"}
    i = i + 1
    URL =  "http://localhost/DYM/image/HEALTH.png"
    network.request( URL, "GET", loginCallback )
end

--local function loginCallback(event)
--
--    -- perform basic error handling
--
--    if ( event.isError ) then
--        print( "Network error!")
--    else
--        -- return a response code
--        print ( "RESPONSE: " .. event.response )
--        local data = json.decode(event.response)
--
--        print("data.result ",data)
--        -- display a result to the user
--        table.foreach(data,print)
--
--       if data.id == 1 then
--            -- player logged in okay, display welcome message
--           print("Welcome back",data.id,"name:",data.name)
--        else
--           -- bad password, or player not found. Prompt user to login again
--           print("Please try again")
--        end
--
--    end
--    return true
--end

-- make JSON call to the remote server
--network.request( URL, "GET", loginCallback )

function scene:createScene( event )
    print("scene")
    local group = self.view

    local crate = display.newImageRect( "image/GREEN.png", 90, 90 )
    crate.x, crate.y = 160, 100
    crate.rotation = 15

    optionBtn = widget.newButton{
        label="Play game",
        labelColor = { default={128,255}, over={0} },
        default="image/GREEN.png",
        --over="button-over.png",
        width=90, height=90,
        --onRelease = onoptionBtnRelease	-- event listener function
    }
    optionBtn:setReferencePoint( display.CenterReferencePoint )
    optionBtn.x = 53
    optionBtn.y = 53
    -- all display objects must be inserted into group
    -- create a widget button (which will loads optionBtn.lua on release)

    group:insert( crate )
    group:insert( optionBtn )
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    local group = self.view


end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
    local group = self.view

end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
    local group = self.view
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