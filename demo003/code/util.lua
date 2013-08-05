util = {}
util.screenModes = love.graphics.getModes()
table.sort(util.screenModes, function(a, b) return a.width*a.height < b.width*b.height end)