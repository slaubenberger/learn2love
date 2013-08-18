local entity = {}

entity.startX = 0
entity.startY = 0
entity.directionY = 1
entity.x = 0
entity.y = 0
entity.id = nil
entity.speed = math.random(1, 64)

-- entity.health = 1

function entity:setPos(x, y)
	print("entity:setPos - circle: " .. tostring(x) .. "/" .. tostring(y))

	entity.x = x
	entity.y = y
end

function entity:getPos()
	-- print("entity:getPos - circle")

	return entity.x, entity.y;
end

function entity:load(x, y)
	print("entity:load - circle: " .. tostring(x) .. "/" .. tostring(y))

	entity.startX = x
	entity.startY = y

	entity:setPos(x, y)
	entity.w = 16
	entity.h = 16
end

function entity:setSize(w, h)
	print("entity:setSize - circle: " .. tostring(w) .. "/" .. tostring(h))

	entity.w = w
	entity.h = h
end

function entity:getSize()
	-- print("entity:getSize - circle")

	return entity.w, entity.h;
end

function entity:update(dt)
	-- print("entity:update - circle: " .. dt)

	if (entity.y < 0 and entity.directionY == 1) or (entity.y + entity.h > entity.startY and entity.directionY == -1) then
		entity.directionY = entity.directionY * -1
	end
		
	entity.y = entity.y - entity.h*dt*entity.directionY*entity.speed
end

function entity:draw()
	-- print("entity:draw - circle")

	local x, y = entity:getPos()
	local w, h = entity:getSize()

	love.graphics.setColor(127, 127, 63)
	love.graphics.circle("fill", x + w * 0.5, y + h * 0.5, w * 0.5, h * 0.5)
end

print("entity_circle.lua")

return entity;