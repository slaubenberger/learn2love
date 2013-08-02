themes = {}
themes.objpath = "themes/"
local register = {}

function themes.load()
    register["standard"] = love.filesystem.load( themes.objpath .. "theme_standard.lua" )
end

function themes.use(name)
	if register[name] then
		local theme = register[name]()
		theme:load()
		return true
	else
		print("ERROR: Theme " .. name .. " does not exist!")
		return false
	end
end