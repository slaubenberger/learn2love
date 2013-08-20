function love.load()
	require("luafft")
	
	isPaused = false

	love.mouse.setVisible(false)

	sound = love.sound.newSoundData("sound/playme.ogg") -- from http://www.uniquetracks.com/Free-Music-Loops.html "Summer Night"
	-- sound = love.sound.newSoundData("sound/500Hz.mp3") -- from http://www.audiocheck.net/
	-- sound = love.sound.newSoundData("sound/leftchannel.mp3") -- from http://www.audiocheck.net/

	rate = sound:getSampleRate()
    channels = sound:getChannels()
	print("Rate: " .. rate)
	print("Channels: " .. channels)
	print("Bits per Sample: " .. sound:getBits())

	music = love.audio.newSource(sound)
	music:setLooping(true)
	music:play()
	
	spectrum = {}
	-- spectrum2 = {}

	frequencyStart = 1 -- 43Hz
	frequencyEnd = 160 -- 6880Hz

	love.graphics.setLine(1,'smooth')
end

function love.update(dt)
	local curSample = music:tell('samples')
	local wave = {}
	-- local wave2 = {}
	local size = next_possible_size(2048)
    
    if channels == 2 then
        
    	-- average of both channels
         for ii = curSample, (curSample + (size - 1) * 0.5) do
            local sample = (sound:getSample(ii * 2) + sound:getSample(ii * 2 + 1)) * 0.5
            table.insert(wave, complex.new(sample, 0))
        end

           -- real stereo
  --       for ii = curSample, (curSample + (size - 1) * 0.25) do
  --           local sample = sound:getSample(ii * 2)
  --           local sample2 = sound:getSample(ii * 2 + 1)
  --           table.insert(wave, complex.new(sample, 0))
  --           table.insert(wave2, complex.new(sample2, 0))
	 --    end
		
		-- local spec2 = fft(wave2, false)
		-- divide(spec2, size * 0.5)
		-- spectrum2 = spec2
    else
        for ii = curSample, (curSample + (size - 1) * 0.5) do
            table.insert(wave, complex.new(sound:getSample(ii), 0))
        end
    end
    
	local spec = fft(wave, false)

	
	divide(spec, size * 0.5)
	
	spectrum = spec
end

function love.draw()
		if love.keyboard.isDown("up") then
		frequencyStart = frequencyStart + 1

		if frequencyStart >= #spectrum * 0.5 then
			frequencyStart = 1
		end
	end
	if love.keyboard.isDown("down") then
		frequencyStart = frequencyStart - 1

		if frequencyStart < 1 then
			frequencyStart = #spectrum * 0.5
		end
	end

	if love.keyboard.isDown("right") then
		frequencyEnd = frequencyEnd + 1

		if frequencyEnd >= #spectrum * 0.5 then
			frequencyEnd = 1
		end
	end
	if love.keyboard.isDown("left") then
		frequencyEnd = frequencyEnd - 1

		if frequencyEnd < 1 then
			frequencyEnd = #spectrum - 1 * 0.5
		end
	end

	local height = love.graphics.getHeight()
	local width = love.graphics.getWidth()

	if channels == 2 then -- stereo
		local dist = width / (frequencyEnd - frequencyStart + 1) / 2

		-- Channel 1
		for ii = frequencyStart, frequencyEnd do
			local v = spectrum[ii]
			local n = height * 2 * v:abs(),0

			-- counter = counter + 1
			n = n * 1.25 -- extra gain

			-- Rainbow colors
			if ii > 0 and ii <= (frequencyEnd - frequencyStart) / 7 then 
				love.graphics.setColor(255, 0, 0)
			elseif ii > (frequencyEnd - frequencyStart) / 7 and ii <= (frequencyEnd - frequencyStart) / 7 * 2 then
				love.graphics.setColor(255, 128, 0)
			elseif ii > (frequencyEnd - frequencyStart) / 7 * 2 and ii <= (frequencyEnd - frequencyStart) / 7 * 3 then
				love.graphics.setColor(255, 255, 0)
			elseif ii > (frequencyEnd - frequencyStart) / 7 * 3 and ii <= (frequencyEnd - frequencyStart) / 7 * 4 then
				love.graphics.setColor(0, 128, 0)
			elseif ii > (frequencyEnd - frequencyStart) / 7 * 4 and ii <= (frequencyEnd - frequencyStart) / 7 * 5 then
				love.graphics.setColor(0, 0, 255)
			elseif ii > (frequencyEnd - frequencyStart) / 7 * 5 and ii <= (frequencyEnd - frequencyStart) / 7 * 6 then
				love.graphics.setColor(75, 0, 130)
			else
				love.graphics.setColor(148, 0, 211)
			end

			love.graphics.rectangle(
				"fill",
				(frequencyEnd - frequencyStart - (frequencyEnd - ii))*dist, 
				height/2 - n/2,
				dist, n)
		end

		-- Channel 2
		for ii = #spectrum - frequencyStart + 1, #spectrum - frequencyEnd + 1, -1 do
			local v = spectrum[ii]
			local n = height * 2 * v:abs(),0

			n = n * 1.25 -- extra gain

			-- Rainbow colors
			if ii <= (#spectrum - frequencyStart + 1) and ii >= #spectrum - ((frequencyEnd - frequencyStart) / 7) then 
				love.graphics.setColor(255, 0, 0) -- red
			elseif ii < #spectrum - ((frequencyEnd - frequencyStart) / 7) and ii >= #spectrum - ((frequencyEnd - frequencyStart) / 7 * 2) then
				love.graphics.setColor(255, 128, 0) -- orange
			elseif ii < #spectrum - ((frequencyEnd - frequencyStart) / 7 * 2) and ii >= #spectrum - ((frequencyEnd - frequencyStart) / 7 * 3) then
				love.graphics.setColor(255, 255, 0) -- yellow
			elseif ii < #spectrum - ((frequencyEnd - frequencyStart) / 7 * 3) and ii >= #spectrum - ((frequencyEnd - frequencyStart) / 7 * 4) then
			 	love.graphics.setColor(0, 128, 0) -- green
			elseif ii < #spectrum - ((frequencyEnd - frequencyStart) / 7 * 4) and ii >= #spectrum - ((frequencyEnd - frequencyStart) / 7 * 5) then
			 	love.graphics.setColor(0, 0, 255) -- blue
			elseif ii < #spectrum - ((frequencyEnd - frequencyStart) / 7 * 5) and ii >= #spectrum - ((frequencyEnd - frequencyStart) / 7 * 6) then
				love.graphics.setColor(75, 0, 130) -- indigo
			else
				love.graphics.setColor(148, 0, 211) -- violet
			end

			love.graphics.rectangle(
				"fill",
				(frequencyEnd - frequencyStart - (#spectrum - ii) + frequencyEnd)*dist, 
				height/2 - n/2,
				dist, n)
		end
		
		-- for ii = #spectrum - frequencyStart + 1, #spectrum - frequencyEnd + 1, -1 do
		-- 	local v = spectrum[ii]
		-- 	local n = height * 2 * v:abs(),0

		-- 	n = n * 1.25 -- extra gain

		-- 	-- Rainbow colors
		-- 	if ii <= (#spectrum - frequencyStart + 1) and ii >= #spectrum - ((frequencyEnd - frequencyStart) / 7) then 
		-- 		love.graphics.setColor(255, 0, 0) -- red
		-- 	elseif ii < #spectrum - ((frequencyEnd - frequencyStart) / 7) and ii >= #spectrum - ((frequencyEnd - frequencyStart) / 7 * 2) then
		-- 		love.graphics.setColor(255, 128, 0) -- orange
		-- 	elseif ii < #spectrum - ((frequencyEnd - frequencyStart) / 7 * 2) and ii >= #spectrum - ((frequencyEnd - frequencyStart) / 7 * 3) then
		-- 		love.graphics.setColor(255, 255, 0) -- yellow
		-- 	elseif ii < #spectrum - ((frequencyEnd - frequencyStart) / 7 * 3) and ii >= #spectrum - ((frequencyEnd - frequencyStart) / 7 * 4) then
		-- 	 	love.graphics.setColor(0, 128, 0) -- green
		-- 	elseif ii < #spectrum - ((frequencyEnd - frequencyStart) / 7 * 4) and ii >= #spectrum - ((frequencyEnd - frequencyStart) / 7 * 5) then
		-- 	 	love.graphics.setColor(0, 0, 255) -- blue
		-- 	elseif ii < #spectrum - ((frequencyEnd - frequencyStart) / 7 * 5) and ii >= #spectrum - ((frequencyEnd - frequencyStart) / 7 * 6) then
		-- 		love.graphics.setColor(75, 0, 130) -- indigo
		-- 	else
		-- 		love.graphics.setColor(148, 0, 211) -- violet
		-- 	end

		-- 	love.graphics.rectangle(
		-- 		"fill",
		-- 		(frequencyEnd - frequencyStart - (#spectrum - ii) + frequencyEnd)*dist, 
		-- 		height/2 - n/2,
		-- 		dist, n)
		-- end

		love.graphics.setColor(255, 255, 255)
		love.graphics.rectangle("fill",	width / 2, 0, 1, height)

		-- love.graphics.print("up/down - Frequency start: " .. frequencyStart * 43 .. "Hz", 0, 0)
		-- love.graphics.print("left/right - Frequency end: " .. frequencyEnd * 43 .. "Hz", 0, 24)
	else -- mono 
		local dist = width / (frequencyEnd - frequencyStart + 1)

		for ii = frequencyStart, frequencyEnd do
			local v = spectrum[ii]
			local n = height * 2 * v:abs(),0

			n = n * 1.25 -- extra gain

			-- Rainbow colors
			if ii > 0 and ii <= (frequencyEnd - frequencyStart) / 7 then 
				love.graphics.setColor(255, 0, 0)
			elseif ii > (frequencyEnd - frequencyStart) / 7 and ii <= (frequencyEnd - frequencyStart) / 7 * 2 then
				love.graphics.setColor(255, 128, 0)
			elseif ii > (frequencyEnd - frequencyStart) / 7 * 2 and ii <= (frequencyEnd - frequencyStart) / 7 * 3 then
				love.graphics.setColor(255, 255, 0)
			elseif ii > (frequencyEnd - frequencyStart) / 7 * 3 and ii <= (frequencyEnd - frequencyStart) / 7 * 4 then
				love.graphics.setColor(0, 128, 0)
			elseif ii > (frequencyEnd - frequencyStart) / 7 * 4 and ii <= (frequencyEnd - frequencyStart) / 7 * 5 then
				love.graphics.setColor(0, 0, 255)
			elseif ii > (frequencyEnd - frequencyStart) / 7 * 5 and ii <= (frequencyEnd - frequencyStart) / 7 * 6 then
				love.graphics.setColor(75, 0, 130)
			else
				love.graphics.setColor(148, 0, 211)
			end

			love.graphics.rectangle(
				"fill",
				(frequencyEnd - frequencyStart - (frequencyEnd - ii))*dist, 
				height/2 - n/2,
				dist, n)
		end

		-- love.graphics.print("Frequency start: " .. frequencyStart * 21 .. "Hz", 0, 0)
		-- love.graphics.print("Frequency end: " .. frequencyEnd * 21 .. "Hz", 0, 24)
	end

	love.graphics.print("up/down - Frequency start: " .. frequencyStart * 43 .. "Hz", 0, 0)
	love.graphics.print("left/right - Frequency end: " .. frequencyEnd * 43 .. "Hz", 0, 24)
	love.graphics.print("FPS: " .. love.timer.getFPS(), 0, 48)
end
 
function love.keypressed(key, unicode)
    if key == " " then 
    	isPaused = not isPaused

    	if isPaused then
	        love.audio.pause(music)
    	else
			love.audio.resume(music)
    	end
    end 

    if key == "escape" then 
        love.event.quit()
    end 
end

function divide(list, factor)
	for ii, v in ipairs(list) do
		list[ii] = list[ii] / factor
	end
end
