require "sprite"



function getSpriteSheetData()
 
        local sheet = {
                frames = {
                        { 
                        name = "01.png", 
                        spriteColorRect = { x = 38, y = 38, width = 50, height = 50 }, 
                        textureRect = { x = 2, y = 70, width = 50, height = 50 }, 
                        spriteSourceSize = { width = 128, height = 128 }, 
                        spriteTrimmed = true,
                        textureRotated = false
                        },
 
                        {
                       name = "02.png", 
                        spriteColorRect = { x = 38, y = 36, width = 50, height = 52 },  
                        textureRect = { x = 2, y = 242, width = 50, height = 52 },  
                        spriteSourceSize = { width = 128, height = 128 },  
                        spriteTrimmed = true,
                        textureRotated = false
                        },
                }
        }
        return sheet
end 