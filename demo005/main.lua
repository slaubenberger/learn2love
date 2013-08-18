local objects = {}

function love.load()

	for id=0, 40 do
		local object

		if id % 2 == 0 then
			object = createBox()
			object.base.startX = 32 * id
			object.base.x = 32 * id
		else
			object = createCircle()
			object.base.startX = 32 * id
			object.base.x = 32 * id
		end

		objects[id] = object
	end
end

function love.update(dt)
	for i, object in pairs(objects) do
		if object.update then
			object.update(dt)
		end
	end 
end
                 
function love.draw()
	for i, object in pairs(objects) do
		if object.draw then
			object.draw()
		end
	end 
end
 
function love.keypressed(key, unicode)
    if key == "escape" then 
        love.event.quit()
    end 
end

function createBox() 
	local box
	box = {
		base = createBaseObject(),
		
		update = function (dt)
			box.base.update(dt)
		end,

		draw = function ()
			box.base.draw()
		end
	}

	return box
end

function createCircle() 
	local circle
	circle = {
		base = createBaseObject(),
		
		update = function (dt)
			circle.base.update(dt)
		end,

		draw = function ()
			love.graphics.setColor(circle.base.color)
			love.graphics.circle("fill", circle.base.x + circle.base.w * 0.5, circle.base.y + circle.base.h * 0.5, circle.base.w * 0.5, circle.base.h * 0.5)
		end
	}

	return circle
end

function createBaseObject() 
	local baseObject
	baseObject = {
		startX = 0,
		startY = 0,
		directionY = -1,
		x = 0,
		y = 0,
		w = 32,
		h = 32,
		id = nil,
		color = {math.random(1, 255), math.random(1, 255), math.random(1, 255)},
		speed = math.random(1, 32),

		update = function (dt)
			if (baseObject.y + baseObject.h > love.graphics.getHeight() and baseObject.directionY == 1) or (baseObject.y < baseObject.startY and baseObject.directionY == -1) then
				baseObject.directionY = baseObject.directionY * -1
			end

			baseObject.y = baseObject.y + baseObject.h*dt*baseObject.directionY*baseObject.speed
		end,

		draw = function () -- default implementation
			love.graphics.setColor(baseObject.color)
			love.graphics.rectangle("fill", baseObject.x, baseObject.y, baseObject.w, baseObject.h)
		end
	}

	return baseObject
end

print("main.lua")
