container_level = {}
container_level.objpath = "code/level/"
container_level.levels = {}

local register = {}

register["001"] = love.filesystem.load(container_level.objpath .. "level_001.lua")

function container_level.use(name)
	print("container_level.use")
	if register[name] then
		local level = register[name]()
		level.load()
		container_level.levels[name] = level
		return true
	else
		print("ERROR: Level " .. name .. " does not exist!")
		return false
	end
end

function container_level.get(name)
	if container_level.levels[name] then
		return container_level.levels[name]
	else
		print("ERROR: Level " .. name .. " not loaded!")
		return false
	end
end

print("container_level.lua")
