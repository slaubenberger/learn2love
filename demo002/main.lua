--- Demo002 - main
-- Menu and multi file test
-- @author Stefan Laubenberger
-- @copyright 2013 Stefan Laubenberger

-- Global variables
currentLevel = nil
isMainMenu = true
playedLevels = {}

-- Callback functions
function love.load()
    require("modules/modul_levels")
    require("modules/modul_menu")
    require("modules/modul_themes")

    levels.load()
    --levels.use("001")

    themes.load()
    themes.use("standard")
end

function love.update(dt)
    if gameIsPaused then return end
    
    if (isMainMenu) then
        -- menu.update(dt)
    else
        currentLevel:update(dt)
    end 
end

function love.draw()
    if (isMainMenu) then
        menu.draw()
    else
        currentLevel:draw()
    end    
end

function love.keypressed(key)
    menu.keypressed(key)

    if key == "1" or key == "2" then
        isMainMenu = false
    end 

    if (key == "escape") then 
        isMainMenu = true
    end
end

function love.focus(f) gameIsPaused = not f end

function love.quit()
  print("Thanks for playing! Come back soon!")
end
