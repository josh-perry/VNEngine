Location = class("Location")

function Location:initialize()
	self.name = nil
	self.colour = {}
	self.pose_graphics = {}
	self.pose = "static"

	if self.load then
		self:load()
		self.path = Game.mod.paths.locations.."/"..self.name
		--print("Loading "..self.name.." with path: "..self.path)
	else
		self.broken = true
	end
end

function Location:load_assets()
	if not self.pose_graphics[self.pose] then
		self.pose_graphics[self.pose] = love.graphics.newImage(self.path.."/graphics/"..self.pose..".png")
	end
end

function Location:draw(toX, toY)
	self:load_assets()
	love.graphics.draw(self.pose_graphics[self.pose], toX, toY)
end

function Location:update(dt)
end