local level = {}

level.name = "002"

function level:load()
	print("Level 002 loaded")

	circle = {
        act_x = 0,
        act_y = 0,
        speed = 16,
        step = 0
    }
end

function level:play()
	print("Level 002 played")

end

function level:update(dt)
    if circle.act_x + 32 > configTable.screen.width then
    	circle.act_x = 0
    	circle.act_y = brick.act_y + 32
    end

    if circle.act_y + 32 > configTable.screen.height then
    	circle.act_x = 0
    	circle.act_y = 0
    end

    circle.act_x = circle.act_x + (32 * circle.speed * dt)
end

function level:draw()
	love.graphics.setColor(0, 0, 255)
	love.graphics.print("Level 002", 256, 24)

    love.graphics.print("FPS: "..love.timer.getFPS(), 256, 48)

	-- love.graphics.setColor(math.random(0, 255), math.random(0, 255), math.random(0, 255))
    love.graphics.setColor(0, 255, 255)
    love.graphics.circle("fill", circle.act_x, circle.act_y + 16, 16, 16)
end

-- Add all neccessary callback functions from löve
-- function love.keypressed(key)
-- end

return level