-- Spanish (Spain) (esES): the pack's own texts (its title and notes, its guides' folders).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Pack
	["Polestar Guides"] = "Guías de Polestar",
	["Leveling, profession, reputation and collectible guides for Polestar."] = "Guías de subida de nivel, profesiones, reputación y coleccionables para Polestar.",

	-- Folders
	["Companion pets · Drops"] = "Mascotas de compañía · Botín",
	["Companion pets · Legacy"] = "Mascotas de compañía · Legado",
	["Companion pets · Quests"] = "Mascotas de compañía · Misiones",
	["Companion pets · Vendors"] = "Mascotas de compañía · Mercaderes",
	["Mounts · Drops"] = "Monturas · Botín",
	["Mounts · Legacy"] = "Monturas · Legado",
	["Mounts · Level 40"] = "Monturas · Nivel 40",
	["Mounts · Level 60"] = "Monturas · Nivel 60",
	["Mounts · PvP"] = "Monturas · JcJ",
	["Mounts · Reputation"] = "Monturas · Reputación",
}
