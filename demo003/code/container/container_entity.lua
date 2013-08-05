container_entity = {}
--container_entity.objects = {}
container_entity.objpath = "code/entity/"

local register = {}
-- local id = 0

register["box"] = love.filesystem.load(container_entity.objpath .. "entity_box.lua")
register["circle"] = love.filesystem.load(container_entity.objpath .. "entity_circle.lua")

function container_entity.get(name)
	if register[name] then
		return register[name]
	else
		print("ERROR: Entity " .. name .. " does not exist!")
		return false
	end
end

function container_entity.create(name, x, y)
	print("container_entity.create")
	if not x then
		x = 0
	end
	
	if not y then
		y = 0
	end
	
	if register[name] then
		-- id = id + 1
		local entity = register[name]()
		entity:load(x, y)
		-- entity.type = name
		-- entity.id = id
		return entity
		-- container_entity.objects[id] = entity
		-- return container_entity.objects[id]
	else
		print("Error: Entity " .. name .. " does not exist!")
		return false;
	end
end

-- function container_entity.update(dt)
-- 	for i, entity in pairs(container_entity.objects) do
-- 		if entity.update then
-- 			entity:update(dt)
-- 		end
-- 	end
-- end

-- function container_entity.draw()
-- 	for i, entity in pairs(container_entity.objects) do
-- 		if entity.draw then
-- 			entity:draw()
-- 		end
-- 	end
-- end

-- function container_entity.derive(name)
-- 	return love.filesystem.load( container_entity.objpath .. name .. ".lua")()
-- end

-- function container_entity.destroy(id)
-- 	if container_entity.objects[id] then
-- 		if container_entity.objects[id].die then
-- 			container_entity.objects[id]:die()
-- 		end
-- 		container_entity.objects[id] = nil
-- 	end
-- end

-- function container_entity.shoot(x, y)
-- 	for i, entity in pairs(container_entity.objects) do
-- 		if entity.die then
-- 			if entity.type == "box" then
-- 				local hit = insideBox( x, y, entity.x, entity.y, 512*(entity.size/20), 128*(entity.size/20))
-- 				if hit then
-- 					entity:Damage(2)
-- 				end
-- 			end
-- 		end
-- 	end
-- end

print("container_entity.lua")
