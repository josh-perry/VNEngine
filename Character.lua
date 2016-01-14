Character = class("Character")

function Character:initialize()
	self.name = nil
	self.colour = {}
	self.pose_graphics = {}
	self.pose = "static"

	if self.load then
		self:load()
		self.path = Game.mod.paths.characters.."/"..self.name
		--print("Loading "..self.name.." with path: "..self.path)
	else
		self.broken = true
	end
end

function Character:load_assets()
	if not self.pose_graphics[self.pose] then
		self.pose_graphics[self.pose] = love.graphics.newImage(self.path.."/graphics/"..self.pose..".png")
	end
end

function Character:draw(toX, toY)
	self:load_assets()
	love.graphics.draw(self.pose_graphics[self.pose], love.graphics:getWidth() / 2 - self.pose_graphics[self.pose]:getWidth() / 2, love.graphics:getHeight() / 2 - self.pose_graphics[self.pose]:getHeight() / 2)
end

function Character:update(dt)
end

function Character:say(toSay)
	Game.wait = true
	saybox.speaker = self
	saybox.string = toSay
end

function Character:set_pose(toPose)
	self.pose = toPose
end