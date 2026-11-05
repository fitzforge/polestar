local _, ns = ...

-- Synthetic: written for Polestar's golden tests, not the addon's data.
ns.Overrides = {
    [25] = false,
    [5587] = { quality = 3, stats = { sta = 2, spi = 1 } },
    [900002] = { name = "Golden Test Ring", quality = 2, slot = 11, class = 4, subclass = 0, itemLevel = 15, reqLevel = 10, stats = { int = 3 }, sources = { { type = "quest", id = 4402, name = "Galgar's Cactus Apple Surprise", zoneId = 14, level = 3, reqLevel = 1, side = 2 } } },
}
