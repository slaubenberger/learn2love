levels = {}
levels.objpath = "levels/"
local register = {}

function levels.load()
    register["001"] = love.filesystem.load( levels.objpath .. "level_001.lua" )
    register["002"] = love.filesystem.load( levels.objpath .. "level_002.lua" )
end

function levels.use(name)
	if register[name] then
		local level = register[name]()
		level:load()
		level:play()
		return level
	else
		print("ERROR: Level " .. name .. " does not exist!")
		return false
	end
end