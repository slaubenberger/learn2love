local theme = {}

function theme.load()
	print("theme.load")
	
    love.graphics.setFont(container_font.get("standard"))
end

print("theme_standard.lua")

return theme