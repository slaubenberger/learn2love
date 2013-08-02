local level = {}

level.name = "001"

function level:load()
	print("Level 001 loaded")

	brick = {
        act_x = 0,
        act_y = 0,
        speed = 16,
        step = 0,
        distance_x = 0
    }
end

function level:play()
	print("Level 001 played")

end

function level:update(dt)
    if brick.act_x + 32 > configTable.screen.width then
    	brick.act_x = 0
    	brick.act_y = brick.act_y + 32
    end

    if brick.act_y + 32 > configTable.screen.height then
    	brick.act_x = 0
    	brick.act_y = 0
    end

    local newPosition_x = brick.act_x + (32 * brick.speed * dt)
    brick.distance_x = brick.distance_x + (newPosition_x - brick.act_x)

    if brick.distance_x > 32 then
       brick.step = brick.step + 1
       brick.distance_x = brick.distance_x - 32 
    end

    --brick.act_y = brick.act_y + (32 * brick.speed * dt)
    brick.act_x = newPosition_x
end

function level:draw()
	love.graphics.setColor(255, 0, 0)
	love.graphics.print("Level 001", 256, 24)
    love.graphics.print("Steps: "..brick.step, 256, 48)
    love.graphics.print("FPS: "..love.timer.getFPS(), 256, 128)

	-- love.graphics.setColor(math.random(0, 255), math.random(0, 255), math.random(0, 255))
    love.graphics.setColor(255, 255, 0)
    love.graphics.rectangle("fill", brick.act_x, brick.act_y, 28, 28)
    -- love.graphics.rectangle("line", brick.act_x, brick.act_y, 32, 32)
end

-- Add all neccessary callback functions from löve
-- function love.keypressed(key)
-- end

return level