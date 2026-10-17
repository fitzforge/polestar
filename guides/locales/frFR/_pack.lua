-- French (frFR): the pack's own texts (its title and notes, its guides' folders).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Pack
	["Polestar Guides"] = "Guides Polestar",
	["Leveling, profession, reputation and collectible guides for Polestar."] = "Guides de progression, de métiers, de réputation et de collection pour Polestar.",

	-- Folders
	["Companion pets · Drops"] = "Mascottes · Butin",
	["Companion pets · Legacy"] = "Mascottes · Héritage",
	["Companion pets · Quests"] = "Mascottes · Quêtes",
	["Companion pets · Vendors"] = "Mascottes · Marchands",
	["Mounts · Drops"] = "Montures · Butin",
	["Mounts · Legacy"] = "Montures · Héritage",
	["Mounts · Level 40"] = "Montures · Niveau 40",
	["Mounts · Level 60"] = "Montures · Niveau 60",
	["Mounts · PvP"] = "Montures · JcJ",
	["Mounts · Reputation"] = "Montures · Réputation",
}
