-- Russian (ruRU): the pack's own texts (its title and notes, its guides' folders).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Pack
	["Polestar Guides"] = "Гайды Polestar",
	["Leveling, profession, reputation and collectible guides for Polestar."] = "Гайды по прокачке, профессиям, репутации и коллекциям для Polestar.",

	-- Folders
	["Companion pets · Drops"] = "Питомцы · Добыча",
	["Companion pets · Legacy"] = "Питомцы · Наследие",
	["Companion pets · Quests"] = "Питомцы · Задания",
	["Companion pets · Vendors"] = "Питомцы · Торговцы",
	["Mounts · Drops"] = "Транспорт · Добыча",
	["Mounts · Legacy"] = "Транспорт · Наследие",
	["Mounts · Level 40"] = "Транспорт · 40-й уровень",
	["Mounts · Level 60"] = "Транспорт · 60-й уровень",
	["Mounts · PvP"] = "Транспорт · PvP",
	["Mounts · Reputation"] = "Транспорт · Репутация",
}
