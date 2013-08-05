container_font = {}
container_font.objpath = "assets/font/"
container_font.fonts = {}

local register = {}

register["standard"] = love.graphics.newImageFont(container_font.objpath .. "imagefont.png", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/():;%&`'*#=[]\"")
register["debug"] = love.graphics.newFont(container_font.objpath .. "white_rabbit.ttf", 10)
register["game"] = love.graphics.newFont(container_font.objpath .. "black_tuesday.ttf", 24)

function container_font.load(name)
	print("container_font.load: " .. name)
	if register[name] then
		container_font.fonts[name] = register[name]
		return true
	else
		print("ERROR: Font " .. name .. " does not exist!")
		return false
	end
end

function container_font.get(name)
	-- print("container_font.get: " .. name)
	if not container_font.fonts[name] then
		container_font.load(name)	
	end

	if container_font.fonts[name] then
		return container_font.fonts[name]
	else
		print("ERROR: Font " .. name .. " not loaded!")
		return false
	end
end

print("container_font.lua")