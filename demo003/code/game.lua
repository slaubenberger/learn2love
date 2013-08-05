game = {}
game.currentLevel = nil

require("code/container/container_entity")
require("code/container/container_level")

function game.run()
	print("mcp.mainmenu")
	
	if game.currentLevel == nil then
		game.playLevel("001")
	else
		game.playLevel(game.currentLevel)
	end
end    

function game.playLevel(name)
	print("mcp.mainmenu")

	if game.currentLevel == nil or game.currentLevel ~= name then
		game.currentLevel = name
		container_level.use(name)
	end

	container_level.get(game.currentLevel).play()
end

function game.draw()
	-- print("game.draw") 

	container_level.get(game.currentLevel).draw()
end

function game.update(dt)
	-- print("game.update: " .. dt)

	container_level.get(game.currentLevel).update(dt)
end

function game.keypressed(key)
	print("game.keypressed: " .. key)

	container_level.get(game.currentLevel).keypressed(key)
end

print("game.lua")
