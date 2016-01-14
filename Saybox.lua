Saybox = class("Saybox")
Saybox:include(Stateful)

function Saybox:initialize()
	self.x = 50
	self.y = love.graphics:getHeight() - 250
	self.w = love.graphics:getWidth() - 100
	self.h = 200

	self.bigfont, self.font = nil
	self.colour = {32, 32, 32, 128}

	self.bigfont = love.graphics.newFont("IgniteTheLight.ttf", 32)
	self.font = love.graphics.newFont("IgniteTheLight.ttf", 24)

	self:reset()
end

function Saybox:reset()
	self.speaker = nil
	self.string = ""
	self.revealed_string = ""

	self.char_time = 0.02
	self.char_elapsed_time = 0
end

function Saybox:draw()
	love.graphics.setColor(self.colour)
	love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)

	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle("line", self.x, self.y, self.w, self.h)

	if self.speaker then
		love.graphics.setColor(self.speaker.colour)
		love.graphics.setFont(self.bigfont)
		love.graphics.print(self.speaker.name, self.x + 18, self.y + 12)
	end

	love.graphics.setColor(255, 255, 255, 200)
	love.graphics.setFont(self.font)
	love.graphics.printf(self.revealed_string, 128, self.y + 64, love.graphics:getWidth() - 128*2, "left")
end

function Saybox:update(dt)
	self.char_elapsed_time = self.char_elapsed_time + dt

	if self.char_elapsed_time > self.char_time then
		self.revealed_string = string.sub(self.string, 1, string.len(self.revealed_string) + 1)
		self.char_elapsed_time = 0
	end
end