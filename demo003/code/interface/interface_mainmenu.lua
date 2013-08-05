local interface = {}

function interface.load()
    print("interface.load - mainmenu")
end

function interface.draw()
    -- print("interface.draw - mainmenu")

    love.graphics.setFont(container_font.get("standard"))

	love.graphics.setColor(0, 255, 0)
    love.graphics.rectangle("fill", 32, 32, 32, 32)

    love.graphics.circle("fill", 96, 48, 16, 16)

    love.graphics.print("MAIN MENU VIEW", 144, 24)
    love.graphics.print("- 'F1' or 'right' to start the 'game'", 144, 64)
    love.graphics.print("- 'up' or 'down' to switch between all supported resolutions", 144, 80)
    love.graphics.print("- 'F9' to turn vsync on/off", 144, 96)
    love.graphics.print("- 'F11' to switch between window or fullscreen mode", 144, 112)
    love.graphics.print("- 'F12' to turn the debug panel on/off", 144, 128)
    love.graphics.print("Hit 'escape' to exit", 144, 160)
end

function interface.keypressed(key)
    print("interface.keypressed - mainmenu: " .. key)
    if key == "f1" or key == "right" then
 		mcp.play()	
    end 

    if key == "escape" then 
        love.event.quit()
    end
end

function interface.mousepressed(x, y, button)
    print("interface.mousepressed - mainmenu: " .. x .. "/" .. y .. "/" .. button)

    -- atm nothing
end

function interface.joystickpressed(joystick, button)
    print("interface.joystickpressed - mainmenu: " .. joystick .. "/" .. button)
    
    -- atm nothing
end

print("interface_mainmenu.lua")

return interface