script = {}
chapters = {}

chapters["start"] =
{
	[[	Cirno:say("Lorem ipsum dolor sit amet, consectetur adipiscing elit.")	]],
	[[	Cirno:say("two!")	]],
	[[	Duke:say("threeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee!")	]],
	[[	local menu = MultipleChoice:new()
		menu:add_item(MultipleChoiceItem:new("Abra",
			function()
				JumpToChapter("beach")
			end))
		menu:add_item(MultipleChoiceItem:new("Kedabra",
			function()
				JumpToChapter("beach2")
			end))
		menu:add_item(MultipleChoiceItem:new("Alakazam",
			function()
				JumpToChapter("beach3")
			end))

		AddMenu(menu)
	]]
}

chapters["beach"] =
{
	[[	JumpToLocation("Beach")
		Cirno:set_pose("happy")
		Cirno:say("beach")	]]
}

chapters["beach2"] =
{
	[[	JumpToLocation("Beach")
		Cirno:set_pose("happy")
		Cirno:say("beach2")	]]
}

chapters["beach3"] =
{
	[[	JumpToLocation("Beach")
		Cirno:set_pose("happy")
		Cirno:say("beach3")	]]
}


script.chapters = chapters
return script