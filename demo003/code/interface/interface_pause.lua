local interface = {}

function interface.load()
	print("interface.load - pause")
end

function interface.draw()
	-- print("interface.draw - pause")
    
    love.graphics.setFont(love.graphics.newFont(48))

	love.graphics.setColor(127, 255, 127)

    love.graphics.printf("Pause", love.graphics.getWidth() * 0.5, love.graphics.getHeight() * 0.5, 0, "center")
end

function interface.keypressed(key)
	print("interface.keypressed - pause: " .. key)
    
    -- atm nothing
end

function interface.mousepressed(x, y, button)
    print("interface.mousepressed - pause: " .. x .. "/" .. y .. "/" .. button)

    -- atm nothing
end

function interface.joystickpressed(joystick, button)
    print("interface.joystickpressed - pause: " .. joystick .. "/" .. button)
    
    -- atm nothing
end

print("interface_pause.lua")

return interface