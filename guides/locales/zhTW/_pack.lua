-- Chinese (traditional) (zhTW): the pack's own texts (its title and notes, its guides' folders).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Pack
	["Polestar Guides"] = "Polestar 指南",
	["Leveling, profession, reputation and collectible guides for Polestar."] = "Polestar 的升級、專業、聲望與收藏品指南。",

	-- Folders
	["Companion pets · Drops"] = "寵物 · 掉落",
	["Companion pets · Legacy"] = "寵物 · 傳承",
	["Companion pets · Quests"] = "寵物 · 任務",
	["Companion pets · Vendors"] = "寵物 · 商人",
	["Mounts · Drops"] = "坐騎 · 掉落",
	["Mounts · Legacy"] = "坐騎 · 傳承",
	["Mounts · Level 40"] = "坐騎 · 40級",
	["Mounts · Level 60"] = "坐騎 · 60級",
	["Mounts · PvP"] = "坐騎 · PvP",
	["Mounts · Reputation"] = "坐騎 · 聲望",
}
