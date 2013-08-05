local interface = {}

local pressedKey = ""
local pressedJoystick = ""
local pressedJoystickButton = ""
local pressedMouseButton = ""

function interface.load()
	print("interface.load - debug")
end

function interface.draw()
	-- print("interface.draw - debug")
    
    -- love.graphics.setFont(love.graphics.newFont(10))
    love.graphics.setFont(container_font.get("debug"))

	love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle("fill", 32, 32, 32, 32)

    love.graphics.circle("fill", 96, 48, 16, 16)

    love.graphics.printf("DEBUG VIEW", love.graphics.getWidth() - 256, 8, 256, "center")
    love.graphics.printf("==========", love.graphics.getWidth() - 256, 16, 256, "center")

    interface.drawPanelScreen(love.graphics.getWidth() - 256, 16, 16)
    interface.drawPanelInput(love.graphics.getWidth() - 256, 320, 16)
    interface.drawPanelStats(love.graphics.getWidth() - 256, 432, 16)

    love.graphics.print("Version: " .. _VERSION, love.graphics.getWidth() - 256, love.graphics.getHeight() - 16)
end

function interface.keypressed(key)
	print("interface.keypressed - debug: " .. key)
	pressedKey = key
end

function interface.mousepressed(x, y, button)
    print("interface.mousepressed - debug: " .. x .. "/" .. y .. "/" .. button)

    pressedMouseButton = button
end

function interface.joystickpressed(joystick, button)
    print("interface.joystickpressed - debug: " .. joystick .. "/" .. button)
    
    pressedJoystick = joystick
    pressedJoystickButton = button
end

function interface.drawPanelScreen(x, y, offset)
    local width, height, fullscreen, vsync, fsaa = love.graphics.getMode()

    love.graphics.print("Screen:", x, y + offset * 1)
    love.graphics.print("-------", x, y + offset * 1 + 8)

    love.graphics.print("Resolution:", x, y + offset * 2)
    love.graphics.print(width .. "x" .. height, x + 128, y + offset * 2)
    
    love.graphics.print("Fullscreen:", x, y + offset * 3)
    love.graphics.print(tostring(fullscreen), x + 128, y + offset * 3)

    love.graphics.print("Vsync:", x, y + offset * 4)
    love.graphics.print(tostring(vsync), x + 128, y + offset * 4)
 
    love.graphics.print("FSAA:", x, y + offset * 5)
    love.graphics.print(fsaa, x + 128, y + offset * 5)

    love.graphics.print("Supported resolutions:", x, y + offset * 6)
    for ii, mode in ipairs(util.screenModes) do
        love.graphics.print(mode.width .. "x" .. mode.height, x + 128, y + offset * (5 + ii))
    end
end

function interface.drawPanelInput(x, y, offset)
    love.graphics.print("Input:", x, y + offset * 1)
    love.graphics.print("------", x, y + offset * 1 + 8)

    love.graphics.print("Key pressed:", x, y + offset * 2)
    love.graphics.print(pressedKey, x + 128, y + offset * 2)

    love.graphics.print("Joystick pressed:", x, y + offset * 3)
    love.graphics.print("#=".. pressedJoystick .. " / button=" .. pressedJoystickButton, x + 128, y + offset * 3)
    
    love.graphics.print("Mouse pressed:", x, y + offset * 4)
    love.graphics.print(pressedMouseButton, x + 128, y + offset * 4)
    
    love.graphics.print("Mouse position:", x, y + offset * 5)
    love.graphics.print("x=" .. love.mouse.getX() .. " / y=" .. love.mouse.getY(), x + 128, y + offset * 5)
end

function interface.drawPanelStats(x, y, offset)
    love.graphics.print("Stats:", x, y + offset * 1)
    love.graphics.print("-----", x, y + offset * 1 + 8)

    love.graphics.print("FPS:", x, y + offset * 2)
    love.graphics.print(love.timer.getFPS(), x + 128, y + offset * 2)

    local time = "Time: "..(math.floor(mcp.timer * 10 + .1)/10)
    if string.find(time, "%.") == nil then
        time = time..".0"
    end

    love.graphics.print("Time:", x, y + offset * 3)
    love.graphics.print(time, x + 128, y + offset * 3)
end

print("interface_debug.lua")

return interface