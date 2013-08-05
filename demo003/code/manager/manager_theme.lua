manager_theme = {}
manager_theme.objpath = "code/theme/"
local register = {}

register["standard"] = love.filesystem.load( manager_theme.objpath .. "theme_standard.lua")

function manager_theme.use(name)
	print("manager_theme.use: " .. name)

	if register[name] then
		register[name]().load()
		return true
	else
		print("ERROR: Theme " .. name .. " does not exist!")
		return false
	end
end

print("manager_theme.lua")
