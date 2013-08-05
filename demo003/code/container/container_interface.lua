container_interface = {}
container_interface.objpath = "code/interface/"
container_interface.interfaces = {}

local register = {}

register["mainmenu"] = love.filesystem.load(container_interface.objpath .. "interface_mainmenu.lua")
register["game"] = love.filesystem.load(container_interface.objpath .. "interface_game.lua")
register["debug"] = love.filesystem.load(container_interface.objpath .. "interface_debug.lua")
register["pause"] = love.filesystem.load(container_interface.objpath .. "interface_pause.lua")


function container_interface.load(name)
	print("container_interface.load: " .. name)
	if register[name] then
		local interface = register[name]()
		interface.load()
		container_interface.interfaces[name] = interface
		return true
	else
		print("ERROR: Interface " .. name .. " does not exist!")
		return false
	end
end

function container_interface.get(name)
	-- print("container_interface.get: " .. name)
	if not container_interface.interfaces[name] then
		container_interface.load(name)	
	end

	if container_interface.interfaces[name] then
		return container_interface.interfaces[name]
	else
		print("ERROR: Interface " .. name .. " not loaded!")
		return false
	end
end

print("container_interface.lua")