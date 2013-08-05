local interface = {}

function interface.load()
	print("interface.load - game")
end

function interface.draw()
	-- print("interface.draw - game")
    
    love.graphics.setFont(container_font.get("game"))

	love.graphics.setColor(255, 127, 127)
    love.graphics.rectangle("fill", 32, 32, 32, 32)

    love.graphics.circle("fill", 96, 48, 16, 16)

    love.graphics.print("GAME VIEW", 144, 24)
    love.graphics.print("Hit 'escape' or 'left' to return to the main menu", 144, 64)
end

function interface.keypressed(key)
	print("interface.keypressed - game: " .. key)
    if key == "escape" or key == "left" then 
 		mcp.mainmenu()	
    end
end

function interface.mousepressed(x, y, button)
    print("interface.mousepressed - game: " .. x .. "/" .. y .. "/" .. button)

    -- atm nothing
end

function interface.joystickpressed(joystick, button)
    print("interface.joystickpressed - game: " .. joystick .. "/" .. button)
    
    -- atm nothing
end

print("interface_game.lua")

return interface