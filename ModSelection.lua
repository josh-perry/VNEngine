local ModSelection = Game:addState("ModSelection")
local g = love.graphics

function ModSelection:load()
	self.mods = {}
	self.selection = 1

	local filesTable = love.filesystem.getDirectoryItems("mods")

	for i, v in ipairs(filesTable) do
		if love.filesystem.isDirectory("mods/"..v) then
			table.insert(self.mods, "mods/"..v)
		end
	end
end

function ModSelection:update(dt)
end

function ModSelection:draw()
	local count = 1
	g.setColor(255, 255, 255)
	for i, v in pairs(self.mods) do
		local toPrint = ""
		local init_file_exists = false

		if love.filesystem.exists(v.."/mod_init.lua") then
			love.graphics.setColor(100, 255, 100)
			init_file_exists = true
		else
			love.graphics.setColor(255, 100, 100)
			init_file_exists = false
		end

		if self.selection == i then
			toPrint = "> "..v

			if not init_file_exists then
				toPrint = toPrint.." - mod_init.lua file not found!"
			end
		else
			toPrint = "  "..v

			if not init_file_exists then
				toPrint = toPrint.." {!}"
			end
		end

		g.print(toPrint, 32, 32 + (26 * count))
		count = count + 1

		love.graphics.setColor(255, 255, 255)
	end

	if count == 1 then
		g.print("No mods found!", 32, 32)
	else
		g.print("Found mods:", 32, 32)
	end
end

function ModSelection:keypressed(key, unicode)
	if key == "up" then
		self.selection = self.selection - 1
	elseif key == "down" then
		self.selection = self.selection + 1
	elseif key == "z" then
		if love.filesystem.exists(self.mods[self.selection].."/mod_init.lua") then
			file = love.filesystem.load(self.mods[self.selection].."/mod_init.lua")
			local mod = file()

			if mod then
				self.mod = mod
				self:gotoState("InGame")
				love.window.setTitle(mod.name)
				self:load()
				print(mod.name.." loaded without error.")
			else
				print("Error loading mod!")
			end
		else
			print("Error: mod_init file not found!")
		end
	end

	if self.selection < 1 then
		self.selection = 1
	elseif self.selection > #self.mods then
		self.selection = #self.mods
	end
end

function ModSelection:keyreleased(key, unicode)
end

function ModSelection:mousepressed(x, y, button)
end

function ModSelection:mousereleased(x, y, button)
end
