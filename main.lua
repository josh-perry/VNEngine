require("kikito-middleclass")
require("kikito-middleclass-extras")

require("Menu")
require("MultipleChoice")

require("Saybox")
require("Game")
require("ModSelection")
require("Character")
require("Location")
Game = Game:new()

function love.load()
	love.graphics.setBackgroundColor({100, 149, 237})
	math.randomseed(os.time())

	Game:gotoState("ModSelection")
	Game:load()
end

function love.draw()
	Game:draw()
	love.graphics.setColor(255, 255, 255)
end

function love.update(dt)
	Game:update(dt)
end

function love.mousepressed(x, y, button)
	Game:mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
	Game:mousereleased(x, y, button)
end

function love.keypressed(key, unicode)
	Game:keypressed(key, unicode)
end

function love.keyreleased(key, unicode)
	Game:keyreleased(key, unicode)
end
