local level = {}
level.name = "001"
level.entities = {}
local id = 0

function level.load()
	print("level.load - 001")

	for ii=0.00625, 0.99375, 0.00625 do 
		id = id + 1
		level.entities[id] = container_entity.create("box", love.graphics.getWidth() * ii, 0, true)
	end
	
	for ii=0.00625, 0.99375, 0.00625 do 
		id = id + 1
		level.entities[id] = container_entity.create("circle", love.graphics.getWidth() * ii, love.graphics.getHeight(), true)
	end
end

function level.reload()
	print("level.reload - 001")

	level.entities = {}
	level.load()
end

function level.play()
	print("level.play - 001")
end

-- function level.draw()
-- 	-- print("level.draw - 001")
-- 	container_entity.draw()
-- end

-- function level.update(dt)
-- 	-- print("level.update - 001: " .. dt)
-- 	container_entity.update(dt)
-- end

function level.draw()
	-- print("level.draw - 001")
	for i, entity in pairs(level.entities) do
		if entity.draw then
			entity:draw()
		end
	end
end

function level.update(dt)
	-- print("level.update - 001: " .. dt)
	for i, entity in pairs(level.entities) do
		if entity.update then
			entity:update(dt)
		end
	end
end

function level.keypressed(key)
	print("level.keypressed - 001: " .. key)
end

print("level_001.lua")

return level