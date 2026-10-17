local ADDON = ...

Polestar.RegisterPack({ addon = ADDON, id = "acceptance-future", format = 4, title = "Acceptance Future", author = "Bo", version = "3.0.0", license = "MIT" })
Polestar.RegisterGuide({
	id = "acceptance-future/a",
	pack = "acceptance-future",
	title = "From the Future",
	steps = { { goals = { { t = "level", level = 10 } } } },
})
