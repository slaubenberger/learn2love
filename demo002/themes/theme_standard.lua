local theme = {}

function theme:load()
    local font = love.graphics.newImageFont("assets/font/imagefont.png", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/():;%&`'*#=[]\"")

    love.graphics.setFont(font)
end

return theme