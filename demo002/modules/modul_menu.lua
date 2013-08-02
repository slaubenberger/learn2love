 menu = {}

 function menu.draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("fill", 32, 32, 32, 32)

    love.graphics.circle("fill", 96, 48, 16, 16)

    love.graphics.print("demo002", 256, 24)
    love.graphics.print("Press '1' or '2' to start a 'game'", 256, 64)
    love.graphics.print("Hit 'escape' to return to the main menu or exit", 256, 96)
end

function menu.keypressed(key)
    if key == "1" or key == "2" then
        local levelId = "00"..key 
        
        if not playedLevels[levelId] then
            currentLevel = levels.use(levelId)
            playedLevels[levelId] = currentLevel
        else
            currentLevel = playedLevels[levelId]
        end   
    end 

    if isMainMenu and key == "escape" then 
        love.event.quit()
    end
end

