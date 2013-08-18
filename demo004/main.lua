function love.load()
	require("libraries.LoveFrames")	

	createInterface()
end

function love.update(dt)
             
    loveframes.update(dt)
 
end
                 
function love.draw()
 
    loveframes.draw()
 
end
 
function love.mousepressed(x, y, button)
 
    loveframes.mousepressed(x, y, button)
 
end
 
function love.mousereleased(x, y, button)
 
    loveframes.mousereleased(x, y, button)
 
end
 
function love.keypressed(key, unicode)
 
    loveframes.keypressed(key, unicode)
 
end
 
function love.keyreleased(key)
 
    loveframes.keyreleased(key)
 
end


function createInterface()
	-- loveframes.config["ACTIVESKIN"] = "Blue"
	-- loveframes.config["ACTIVESKIN"] = "Orange"
	-- loveframes.config["ACTIVESKIN"] = "Gray"
	-- loveframes.config["ACTIVESKIN"] = "Dark"

	createMainmenu()

	-- loveframes.SetState("mainmenu")
end

function createMainmenu()
	local panel = loveframes.Create("panel")
	panel:SetSize(200, 314)
	panel:Center()
	-- panel:SetState("mainmenu")


	local buttonPlay = loveframes.Create("button", panel)
	buttonPlay:SetPos(5, 5)
	buttonPlay:SetSize(190, 48)
	buttonPlay:SetText("Play!")
	buttonPlay.OnClick = function(object)
	    print("The buttonPlay was clicked!")
	end

	local imagePlay = loveframes.Create("image", panel)
	imagePlay:SetPos(13, 13)
	imagePlay:SetImage("assets/images/play.png")
	-- imagePlay:RemoveClickBounds()
	imagePlay.OnMouseEnter = function(object)
    	print("The mouse entered the imagePlay.")
	end
	imagePlay.OnMouseExit = function(object)
	    print("The mouse exited the imagePlay.")
	end


	local buttonOptions = loveframes.Create("button", panel)
	buttonOptions:SetPos(5, 69)
	buttonOptions:SetSize(190, 48)
	buttonOptions:SetText("Options")
	buttonOptions.OnClick = function(object)
	    print("The buttonOptions was clicked!")
	end

	local imageOptions = loveframes.Create("image", panel)
	imageOptions:SetPos(13, 77)
	imageOptions:SetImage("assets/images/options.png")


	local buttonHelp = loveframes.Create("button", panel)
	buttonHelp:SetPos(5, 133)
	buttonHelp:SetSize(190, 48)
	buttonHelp:SetText("Help")
	buttonHelp.OnClick = function(object)
	    print("The buttonHelp was clicked!")
	end

	local imageHelp = loveframes.Create("image", panel)
	imageHelp:SetPos(13, 141)
	imageHelp:SetImage("assets/images/help.png")


	local buttonAbout = loveframes.Create("button", panel)
	buttonAbout:SetPos(5, 197)
	buttonAbout:SetSize(190, 48)
	buttonAbout:SetText("About")
	buttonAbout.OnClick = function(object)
	    print("The buttonAbout was clicked!")
	end

	local imageAbout = loveframes.Create("image", panel)
	imageAbout:SetPos(13, 205)
	imageAbout:SetImage("assets/images/about.png")


	local buttonExit = loveframes.Create("button", panel)
	buttonExit:SetPos(5, 261)
	buttonExit:SetSize(190, 48)
	buttonExit:SetText("Exit")
	buttonExit.OnClick = function(object)
	    print("The buttonExit was clicked!")

	    local frame = loveframes.Create("frame")
		frame:SetSize(230, 98)
		frame:Center()
		frame:SetModal(true)
		frame:SetName("Exit?")
	

		local text = loveframes.Create("text", frame)
		text:SetPos(5, 32)
		text:SetMaxWidth(220)
		if (loveframes.config["ACTIVESKIN"] == "Gray" or loveframes.config["ACTIVESKIN"] == "Dark") then
			text:SetDefaultColor(255, 255, 255)
		end
		text:SetText("Do you really wanna exit?")


		local buttonAbort = loveframes.Create("button", frame)
		buttonAbort:SetPos(10, 64)
		buttonAbort:SetSize(95, 24)
		buttonAbort:SetText("No!")
		buttonAbort.OnClick = function(object)
			frame:Remove()
		end
	
		local imageAbort = loveframes.Create("image", frame)
		imageAbort:SetPos(14, 68)
		imageAbort:SetImage("assets/images/abort.png")


		local buttonOk = loveframes.Create("button", frame)
		buttonOk:SetPos(125, 64)
		buttonOk:SetSize(95, 24)
		buttonOk:SetText("Yes")
		buttonOk.OnClick = function(object)
			love.event.quit()
		end

		local imageOk = loveframes.Create("image", frame)
		imageOk:SetPos(129, 68)
		imageOk:SetImage("assets/images/ok.png")
	end

	local imageExit = loveframes.Create("image", panel)
	imageExit:SetPos(13, 269)
	imageExit:SetImage("assets/images/exit.png")
end


print("main.lua")
