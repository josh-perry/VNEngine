Game = class("Game")
Game:include(Stateful)

local InGame = Game:addState("InGame")

saybox = Saybox:new()

function JumpToLocation(toLoc)
	Game.mod.save_file.current_location = "Beach"
	print(toLoc)
end

function JumpToPage(toPage)
	Game.mod.save_file.current_page = toPage
	Game.wait = false
end

function JumpToChapter(toChapter)
	Game.mod.save_file.current_chapter = toChapter
	Game.mod.save_file.current_page = 1
	Game.wait = false
end

function AddMenu(toMenu)
	Game.menus = {}
	table.insert(Game.menus, toMenu)
end

function InGame:load()
	locations = {}

	math.randomseed(os.time())

	-- oh god why
	for i, v in pairs(self.mod.characters) do
		f = loadstring(v.name.." = Game.mod.characters[\""..i.."\"]:new()")
		f()
	end

	for i, v in pairs(self.mod.locations) do
		locations[i] = v:new()
	end

	self.wait = false
	self.menus = {}
end

function InGame:draw()
	locations[self.mod.save_file.current_location]:draw()

	if saybox.speaker then
		saybox.speaker:draw()
	end

	saybox:draw()

	for i, v in pairs(self.menus) do
		v:draw()
	end

	love.window.setTitle(self.mod.name.." - "..self.mod.save_file.current_location.." - current chapter: "..self.mod.save_file.current_chapter..", current page: "..self.mod.save_file.current_page)
end

function InGame:update(dt)
	if not self.wait then
		f = loadstring(self.mod.script.chapters[self.mod.save_file.current_chapter][self.mod.save_file.current_page])
		f()
	end

	for i, v in pairs(self.menus) do
		v:update(dt)
	end

	saybox:update(dt)
end

function InGame:keypressed(key, unicode)
end

function InGame:keyreleased(key, unicode)
	if key == "escape" then
		love.event.quit()
	end
end

function InGame:mousepressed(x, y, button)
	if button == 1 then
		if table.getn(self.menus) < 1 then
			self.mod.save_file.current_page = self.mod.save_file.current_page + 1
			self.wait = false
			saybox:reset()

			if not self.mod.script.chapters[self.mod.save_file.current_chapter][self.mod.save_file.current_page] then
				--error("Chapter/page does not exist.")
				print("Chapter/page does not exist.")
				love.event.quit()
			end
		else
			for i, v in pairs(self.menus) do
				if v:check_click(x, y) then
					self.wait = false
					Game.menus = {}
					return
				end
			end
		end
	end
end

function InGame:mousereleased(x, y, button)
end
