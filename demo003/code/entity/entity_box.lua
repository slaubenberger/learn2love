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
	print("entity:setPos - box: " .. tostring(x) .. "/" .. tostring(y))

	entity.x = x
	entity.y = y
end

function entity:getPos()
	-- print("entity:getPos - box")

	return entity.x, entity.y;
end

function entity:load(x, y)
	print("entity:load - box: " .. tostring(x) .. "/" .. tostring(y))

	entity.startX = x
	entity.startY = y

	entity:setPos(x, y)
	entity.w = 16
	entity.h = 16
end

function entity:setSize(w, h)
	print("entity:setSize - box: " .. tostring(w) .. "/" .. tostring(h))

	entity.w = w
	entity.h = h
end

function entity:getSize()
	-- print("entity:getSize - box")

	return entity.w, entity.h;
end

function entity:update(dt)
	-- print("entity:update - box: " .. dt)

	if (entity.y + entity.h > love.graphics.getHeight() and entity.directionY == 1) or (entity.y < entity.startY and entity.directionY == -1) then
		entity.directionY = entity.directionY * -1
	end

	entity.y = entity.y + entity.h*dt*entity.directionY*entity.speed
end

function entity:draw()
	-- print("entity:draw - box")

	local x, y = entity:getPos()
	local w, h = entity:getSize()

	love.graphics.setColor(255, 127, 0)
	love.graphics.rectangle("fill", x, y, w, h)
end

-- function entity:damage(n)
	--if (n <= 0) or (self.falling) then return end
	-- entity:Smoke()
	--self.health = self.health - n
	--addScore(1)
	--if self.health <= 0 then
	--	self.health = 0
		-- entity:Fall()
	--	addScore(3)
	--end
-- end

-- function entity:die()
-- 	container_entity.create( "box", -math.random(128, 256), 128, true )
-- end

print("entity_box.lua")

return entity;