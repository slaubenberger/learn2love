mcp = {}
mcp.mode = "mainmenu"
mcp.isDebug = false
mcp.isFullscreen = false
mcp.isVsync = true
mcp.isPaused = false
mcp.hasFocus = true
mcp.timer = 0

local screen_index = 0
local screen_mode = {width = configTable.screen.width, height = configTable.screen.height}

function mcp.run()
	print("mcp.run")

	-- require("code/manager/manager_audio")
	require("code/manager/manager_graphic")
	-- require("code/manager/manager_input")
	require("code/manager/manager_interface")
	-- require("code/manager/manager_io")
	-- require("code/manager/manager_network")
	require("code/manager/manager_theme")
	-- require("code/manager/manager_video")
	require("code/game")
	require("code/util")

	manager_theme.use("standard")

	-- love.graphics.setMode(2560, 1440, true, true, 0);
	-- love.graphics.toggleFullscreen()

	mcp.mainmenu()
end    

function mcp.mainmenu()
	print("mcp.mainmenu")

	mcp.mode = "mainmenu"
	manager_interface.use("mainmenu")
end

function mcp.play()
	print("mcp.play")

	mcp.mode = "game"
	manager_interface.use("game")
    game.run()
end

function mcp:changeResolution()
	mcp.hasFocus = false
	
	love.graphics.setMode(screen_mode.width, screen_mode.height, mcp.isFullscreen, mcp.isVsync, 0);

	if game.currentLevel ~= nil then
		container_level.get(game.currentLevel).reload()
	end
	
	mcp.hasFocus = true
end

function love.draw()
	-- print("love.draw")

	if mcp.mode == "game" then
		game.draw()
	end

	manager_interface.draw()
end

function love.update(dt)
	-- print("love.update: " .. dt)

	if mcp.isPaused or not mcp.hasFocus then return end

	if mcp.mode == "game" then
		game.update(dt)
	end

	-- manager_interface.update(dt)

	mcp.timer = mcp.timer + dt
end

function love.focus(f) mcp.hasFocus = f end

function love.quit()
	print("love.quit")
	
	print("Thanks for playing! Come back soon!")
end

function love.keypressed(key)
	print("love.keypressed: " .. key)

	if key == "f12" then
		mcp.isDebug = not mcp.isDebug
	end
		
	if key == "f11" then
		mcp.isFullscreen = not mcp.isFullscreen

		mcp:changeResolution()
	end
	
	if key == "f9" then
		mcp.isVsync = not mcp.isVsync

		mcp:changeResolution()
	end

	if key == "up" then

		screen_index = screen_index + 1
		
		if screen_index > #util.screenModes then
			screen_index = 1
		end
		
		screen_mode = util.screenModes[screen_index]

		mcp:changeResolution()
	end
	
	if key == "down" then

		screen_index = screen_index - 1
		
		if screen_index < 1 then
			screen_index = #util.screenModes
		end
		
		screen_mode = util.screenModes[screen_index]

		mcp:changeResolution()
	end

	if key == "p" then
		mcp.isPaused = not mcp.isPaused
	end

	if mcp.mode == "game" then
		game.keypressed(key)
	end

	manager_interface.keypressed(key)
end

function love.mousepressed(x, y, button)
	print("love.mousepressed: " .. x .. "/" .. y .. "/" .. button)

	manager_interface.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
	print("love.mousereleased: " .. x .. "/" .. y .. "/" .. button)

	-- atm nothing
end

function love.joystickpressed(joystick, button)
	print("love.joystickpressed: " .. joystick .. "/" .. button)

	manager_interface.joystickpressed(x, y, button)
end

function love.joystickreleased(joystick, button)
	print("love.joystickreleased: " .. joystick .. "/" .. button)

	-- atm nothing
end

-- Add neccessary call back functions from love
-- ...

print("mcp.lua")

