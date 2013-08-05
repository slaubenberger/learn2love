manager_interface = {}
manager_interface.current = "mainmenu"

require("code/container/container_interface")

function manager_interface.use(name)
	print("manager_theme.use: " .. name)

	manager_interface.current = name
end

function manager_interface.draw()
	-- print("manager_interface.draw")

	container_interface.get(manager_interface.current).draw()

	if mcp.isPaused or not mcp.hasFocus then
		container_interface.get("pause").draw()
	end	

	if mcp.isDebug then
		container_interface.get("debug").draw()
	end
end

function manager_interface.keypressed(key)
	print("manager_interface.keypressed: " .. key)

	container_interface.get(manager_interface.current).keypressed(key)

	if mcp.isDebug then
		container_interface.get("debug").keypressed(key)
	end
end

function manager_interface.mousepressed(x, y, button)
	print("manager_interface.mousepressed: " .. x .. "/" .. y .. "/" .. button)

	container_interface.get(manager_interface.current).mousepressed(x, y, button)

	if mcp.isDebug then
		container_interface.get("debug").mousepressed(x, y, button)
	end

end

print("Manager_interface.lua")
