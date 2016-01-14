local TrainStation = class("TrainStation", Location)

function TrainStation:load()
	self.name = "TrainStation"
end

return TrainStation