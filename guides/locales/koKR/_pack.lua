-- Korean (koKR): the pack's own texts (its title and notes, its guides' folders).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Pack
	["Polestar Guides"] = "Polestar 가이드",
	["Leveling, profession, reputation and collectible guides for Polestar."] = "Polestar용 레벨업, 전문 기술, 평판, 수집품 가이드.",

	-- Folders
	["Companion pets · Drops"] = "애완동물 · 획득",
	["Companion pets · Legacy"] = "애완동물 · 유산",
	["Companion pets · Quests"] = "애완동물 · 퀘스트",
	["Companion pets · Vendors"] = "애완동물 · 상인",
	["Mounts · Drops"] = "탈것 · 획득",
	["Mounts · Legacy"] = "탈것 · 유산",
	["Mounts · Level 40"] = "탈것 · 레벨 40",
	["Mounts · Level 60"] = "탈것 · 레벨 60",
	["Mounts · PvP"] = "탈것 · PvP",
	["Mounts · Reputation"] = "탈것 · 평판",
}
