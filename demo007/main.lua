local objects = {}
local score = 0
local lifes = 3
local misses = 25
local hasHit = false
local ballonsCreated = 0
local ballonsShot = 0
timer = 0

function love.load()
	cursor = love.graphics.newImage("crosshair.png")
	love.mouse.setVisible(false)
	love.mouse.setGrab(true)

	sfxShot = love.audio.newSource("shot.ogg", "static")
	sfxMiss = love.audio.newSource("miss.ogg", "static")
	sfxGameover = love.audio.newSource("gameover.ogg", "static")
	music = love.audio.newSource("music.ogg", "stream")

	sfxMiss:setVolume(0.5)
	sfxShot:setVolume(0.5)

	-- music:setVolume(0.8)
	music:setLooping(true)
    love.audio.play(music)

	local numberOfBallons = 11

	for id=0, numberOfBallons do
		local object

		object = createBallon()
		object.x = love.graphics.getWidth() / numberOfBallons * id
		object.y = love.graphics.getHeight() + object.radius
		object.id = id
		objects[id] = object
	end
end

function love.update(dt)
	if lifes > 0  and misses > 0 then
		for i, object in pairs(objects) do
			if object.update then
				object.update(dt)
			end
		end 

		timer = timer + dt
	end
end
                 
function love.draw()
	if lifes > 0 and misses > 0 then
		for i, object in pairs(objects) do
			if object.draw then
				object.draw()
			end
		end 
	else
		love.graphics.print("GAME OVER", love.graphics.getWidth() * 0.5, love.graphics.getHeight() * 0.5)
	end


	love.graphics.setColor(255, 0, 0)
	love.graphics.draw(cursor, love.mouse.getX() - cursor:getWidth() / 2, love.mouse.getY() - cursor:getHeight() / 2)

	love.graphics.setColor(127, 255, 127)
	
	love.graphics.print("Score: " .. score, 0, 0)
	love.graphics.print("Ballons shot: " .. ballonsShot, 0, 24)

	love.graphics.print("Ballons created: " .. ballonsCreated, 0, love.graphics.getHeight() - 24)
    
    local time = "Time: "..(math.floor(timer * 10 + .1)/10)
    if string.find(time, "%.") == nil then
        time = time..".0"
    end
    love.graphics.print(time, love.graphics.getWidth() - 96, love.graphics.getHeight() - 24)

	love.graphics.setColor(255, 127, 127)
	
	love.graphics.print("Lifes: " .. lifes, love.graphics.getWidth() - 96, 0)
	love.graphics.print("Misses: " .. misses, love.graphics.getWidth() - 96, 24)

end
 
function love.keypressed(key, unicode)
    if key == "escape" then 
        love.event.quit()
    end 
end

function love.mousepressed(x, y, button)
	if lifes > 0 and misses > 0 then
		for i, object in pairs(objects) do
			if object.isHit then
				object.isHit(x, y)
			end
		end 

		love.audio.play(sfxShot)
		
		if hasHit then
			hasHit = false
			ballonsShot = ballonsShot + 1
		else
			lifes = lifes - 1
			if lifes > 0 then
				love.audio.play(sfxMiss)
			else
				love.audio.play(sfxGameover)
			end
		end
	end
end

function createBallon() 
	local ballon
	ballon = {
		directionY = 1,
		x = 0,
		y = love.graphics.getHeight(),
		radius = math.random(8, 96),
		id = nil,
		color = {math.random(1, 255), math.random(1, 255), math.random(1, 255)},
		speed = math.random(1.0, 2.5),
		points = 0,

		update = function (dt)
			ballon.y = ballon.y - ballon.radius*dt*ballon.directionY*ballon.speed

			if ballon.y + ballon.radius + 64 < 0 then -- out of screen
				local object

				object = createBallon()
				object.x = ballon.x
				object.y = love.graphics.getHeight() + object.radius
				object.id = ballon.id
				objects[ballon.id] = object
			
				misses = misses - 1

				if misses == 0 then
					love.audio.play(sfxGameover)
				end
			end
		end,

		draw = function ()
			love.graphics.setColor(ballon.color)
			love.graphics.circle("fill", ballon.x, ballon.y, ballon.radius)
			love.graphics.rectangle("fill", ballon.x - 1, ballon.y + ballon.radius, 2, 64)
		end,

		isHit = function (x, y)
			if (x - ballon.x)^2 + (y - ballon.y)^2 < ballon.radius^2 then
				hasHit = true
				score = score + ballon.points

				local object

				object = createBallon()
				object.x = ballon.x
				object.y = love.graphics.getHeight() + object.radius
				object.id = ballon.id
				objects[ballon.id] = object
			end
		end
	}

	ballon.points = (128 - ballon.radius) * ballon.speed
	
	ballonsCreated = ballonsCreated + 1

	return ballon
end

print("main.lua")
