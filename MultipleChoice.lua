MultipleChoice = class("MultipleChoice", Menu)
MultipleChoice:include(Stateful)

function MultipleChoice:initialize()
	self.items = {}
end

function MultipleChoice:draw()
	for i, v in pairs(self.items) do
		v:draw(love.graphics:getWidth() / 2 - 256, (64 * i) + (#self.items / 64), 512, 64)
	end
end

function MultipleChoice:update(dt)
	for i, v in pairs(self.items) do
		v:update(dt)
	end
end

function MultipleChoice:add_item(toItem)
	table.insert(self.items, toItem)
end

function MultipleChoice:check_click(toX, toY)
	for i, v in pairs(self.items) do
		if v:check_click(toX, toY) then
			print("b")
			return true
		end
	end
end

--

MultipleChoiceItem = class("MultipleChoiceItem")

function MultipleChoiceItem:initialize(toString, toFunc)
	self.colour = {128, 128, 128, 200}
	self.w = 256
	self.h = 128

	self.x = 0
	self.y = 0

	self.string = toString or "No string"
	self.func = toFunc or nil
end

function MultipleChoiceItem:draw(toX, toY, toW, toH)
	-- okay whatever
	self.x = toX
	self.y = toY
	self.w = toW
	self.h = toH

	if CheckCollision(love.mouse:getX(), love.mouse:getY(), 1, 1, self.x, self.y, self.w, self.h) then
		love.graphics.setColor({self.colour[1] / 2, self.colour[2] / 2, self.colour[3] / 2, 255})
	else
		love.graphics.setColor(self.colour)
	end	

	love.graphics.rectangle("fill", toX, toY, toW, toH)

	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle("line", toX, toY, toW, toH)

	love.graphics.print(self.string, toX + 16, toY + (toH / 4))
end

function MultipleChoiceItem:update(dt)
end

function MultipleChoiceItem:check_click(toX, toY)
	if CheckCollision(toX, toY, 1, 1, self.x, self.y, self.w, self.h) then
		self.func()
		return true
	end
end

function CheckCollision(ax1,ay1,aw,ah, bx1,by1,bw,bh)
	local ax2,ay2,bx2,by2 = ax1 + aw, ay1 + ah, bx1 + bw, by1 + bh
 	return ax1 < bx2 and ax2 > bx1 and ay1 < by2 and ay2 > by1
end