--- Demo001 - main
-- Extendend grid-lock example with sound.
-- @author Stefan Laubenberger
-- @copyright 2013 Stefan Laubenberger

-- Global variables
textWidth = 192
timer = 0
keyTimer = 0
keyDelay = 0.16
srcMove = love.audio.newSource("audio/effect/move.wav", "static")
srcWall = love.audio.newSource("audio/effect/wall.wav", "static")
srcMusic = love.audio.newSource("audio/music/music.mid", "static")

-- Callback functions
function love.load()
    player = {
        grid_x = 256,
        grid_y = 256,
        act_x = 200,
        act_y = 200,
        speed = 16,
        step = 0
    }

    map = {
        { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        { 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1},
        { 1, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1},
        { 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1},
        { 1, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1},
        { 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
        { 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
        { 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1},
        { 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1},
        { 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1},
        { 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1},
        { 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1},
        { 1, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1},
        { 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1},
        { 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1},
        { 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1},
        { 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1},
        { 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1},
        { 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1},
        { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
    }

    font = love.graphics.newImageFont("font/imagefont.png", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/():;%&`'*#=[]\"")

    love.graphics.setFont(font)

    srcMove:setVolume(0.5)
    srcMusic:setVolume(0.1)
    --srcMusic:setPitch(0.5) -- one octave lower
    
    srcMusic:setLooping(true)
    love.audio.play(srcMusic)
end

function love.update(dt)
    if gameIsPaused then return end

    if (love.keyboard.isDown("up") or love.keyboard.isDown("down") or love.keyboard.isDown("left") or love.keyboard.isDown("right")) and keyTimer > keyDelay then
        if love.keyboard.isDown("up") then
            move("up")
        end
        if love.keyboard.isDown("down") then
            move("down")
        end
        if love.keyboard.isDown("left") then
            move("left")
        end
        if love.keyboard.isDown("right") then
            move("right")
        end

        keyTimer = 0
    end

    player.act_y = player.act_y - ((player.act_y - player.grid_y) * player.speed * dt)
    player.act_x = player.act_x - ((player.act_x - player.grid_x) * player.speed * dt)

    timer = timer + dt
    keyTimer = keyTimer + dt
end

function love.draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("fill", player.act_x, player.act_y, 28, 28)
    love.graphics.rectangle("line", player.act_x, player.act_y, 32, 32)

    step = "Step: "..player.step
    love.graphics.print(step, configTable.screen.width - textWidth, 8)

    time = "Time: "..(math.floor(timer * 10 + .1)/10)
    if string.find(time, "%.") == nil then
        time = time..".0"
    end
    love.graphics.print(time, configTable.screen.width - textWidth, 24)

    love.graphics.setColor(193, 219, 158)
    love.graphics.printf("demo001", 0, 8, configTable.screen.width, 'center')

    love.graphics.setColor(253, 151, 212)
    love.graphics.printf("© 2013 by Stefan Laubenberger", 0, configTable.screen.height - 32, configTable.screen.width, 'center')

    love.graphics.setColor(131, 192, 240)
    for y=1, #map do
        for x=1, #map[y] do
            if map[y][x] == 1 then
                love.graphics.rectangle("fill", x * 32, y * 32, 28, 28)
                love.graphics.rectangle("line", x * 32, y * 32, 32, 32)
            end
        end
    end
end

function love.keypressed(key)
    if (key == "up" or key == "down" or key == "left" or key == "right") then 
        move(key)

        keyTimer = 0
    end
end

function love.focus(f) gameIsPaused = not f end

function love.quit()
  print("Thanks for playing! Come back soon!")
end

--- Checks if the player has moved and triggers the appropriate actions.
-- @param key The current pressed key.
function move(key)
    if (key == "up" or key == "down" or key == "left" or key == "right") then 
        hasMoved = false;
    
        if key == "up" then
            if testMap(0, -1) then
                player.grid_y = player.grid_y - 32
                hasMoved = true;
            end
        end
        if key == "down" then
            if testMap(0, 1) then
                player.grid_y = player.grid_y + 32
                hasMoved = true;
            end
        end
        if key == "left" then
            if testMap(-1, 0) then
                player.grid_x = player.grid_x - 32
                hasMoved = true;
            end
        end
        if key == "right" then
            if testMap(1, 0) then
                player.grid_x = player.grid_x + 32
                hasMoved = true;
            end
        end

        if hasMoved == true then
            player.step = player.step + 1;
            love.audio.play(srcMove)
            love.audio.rewind(srcMove)
        else
            love.audio.play(srcWall)
            love.audio.rewind(srcWall)
        end
    end
end

--- Checks if the player has touched a block.
-- @param x The current x coordinate.
-- @param y The current y coordinate.
-- @return true/false
function testMap(x, y)
    if map[(player.grid_y / 32) + y][(player.grid_x / 32) + x] == 1 then
        return false
    end
    return true
end