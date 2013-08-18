local objects = {}

function love.load()
	love.mouse.setVisible(false)

	local numberOfBallons = love.graphics.getWidth() / 4

	for id=0, numberOfBallons do
		local object

		object = createBallon()
		object.base.x = love.graphics.getWidth() / numberOfBallons * id
		object.base.id = id
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

function createBallon() 
	local ballon
	ballon = {
		base = createBaseObject(),

		update = function (dt)
			ballon.base.update(dt)
		end,

		draw = function ()
			love.graphics.setColor(ballon.base.color)
			love.graphics.ellipse("fill", ballon.base.x, ballon.base.y + ballon.base.h * 0.5, ballon.base.w * 0.5, ballon.base.h * 0.5, ballon.base.phi, 30)
			-- love.graphics.rectangle("fill", ballon.base.x + ballon.base.w * 0.5 - 1, ballon.base.y + ballon.base.h * 0.5, 2, ballon.base.h * 0.5 + 32)
		end
	}

	-- local radius = math.random(8, 256)
	ballon.base.w = math.random(16, 256)
	ballon.base.h = math.random(16, 256)
	ballon.base.y = ballon.base.y + (ballon.base.h > ballon.base.w and ballon.base.h or ballon.base.w )* 1.41 -- Wurzel von 2

	return ballon
end

function createBaseObject() 
	local baseObject
	baseObject = {
		directionY = 1,
		x = 0,
		y = love.graphics.getHeight(),
		w = 32,
		h = 32,
		phi = math.random(0, 359),
		id = nil,
		color = {math.random(1, 255), math.random(1, 255), math.random(1, 255)},
		speed = math.random(1.0, 2.1),
		-- speed = 1,

		update = function (dt)
			baseObject.y = baseObject.y - baseObject.h*dt*baseObject.directionY*baseObject.speed

			if baseObject.y + baseObject.h < 0 then -- out of screen
				local object

				object = createBallon()
				object.base.x = baseObject.x
				object.base.id = baseObject.id
				objects[baseObject.id] = object
			end
		end
	}

	return baseObject
end

    -- Ellipse in general parametric form
    -- (See http://en.wikipedia.org/wiki/Ellipse#General_parametric_form)
    -- (Hat tip to IdahoEv: https://love2d.org/forums/viewtopic.php?f=4&t=2687)
    --
    -- The center of the ellipse is (x,y)
    -- a and b are semi-major and semi-minor axes respectively
    -- phi is the angle in radians between the x-axis and the major axis

function love.graphics.ellipse(mode, x, y, a, b, phi, points)
	phi = phi or 0
	points = points or 10
	
	if points <= 0 then points = 1 end

	local two_pi = math.pi*2
	local angle_shift = two_pi/points
	local theta = 0
	local sin_phi = math.sin(phi)
	local cos_phi = math.cos(phi)

	local coords = {}
	for i = 1, points do
		theta = theta + angle_shift
		coords[2*i-1] = x + a * math.cos(theta) * cos_phi - b * math.sin(theta) * sin_phi
		coords[2*i] = y + a * math.cos(theta) * sin_phi + b * math.sin(theta) * cos_phi
	end

	coords[2*points+1] = coords[1]
	coords[2*points+2] = coords[2]

	love.graphics.polygon(mode, coords)
end


print("main.lua")
