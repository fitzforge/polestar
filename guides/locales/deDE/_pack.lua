-- German (deDE): the pack's own texts (its title and notes, its guides' folders).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Pack
	["Polestar Guides"] = "Polestar-Guides",
	["Leveling, profession, reputation and collectible guides for Polestar."] = "Guides für Stufenaufstieg, Berufe, Ruf und Sammelobjekte für Polestar.",

	-- Folders
	["Companion pets · Drops"] = "Haustiere · Beute",
	["Companion pets · Legacy"] = "Haustiere · Vermächtnis",
	["Companion pets · Quests"] = "Haustiere · Quests",
	["Companion pets · Vendors"] = "Haustiere · Händler",
	["Mounts · Drops"] = "Reittiere · Beute",
	["Mounts · Legacy"] = "Reittiere · Vermächtnis",
	["Mounts · Level 40"] = "Reittiere · Stufe 40",
	["Mounts · Level 60"] = "Reittiere · Stufe 60",
	["Mounts · PvP"] = "Reittiere · PvP",
	["Mounts · Reputation"] = "Reittiere · Ruf",
}
