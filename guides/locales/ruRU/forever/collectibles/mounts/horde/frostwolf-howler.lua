-- Russian (ruRU): the guide forever/collectibles/mounts/horde/frostwolf-howler (forever/collectibles/mounts/horde/frostwolf-howler.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Frostwolf Clan
	-- {area:2839} Alterac Valley · {faction:729} Frostwolf Clan · {npc:13219} Jekyll Flandring · {zone:1416} Alterac Mountains · {npc:13218} Grunnda Wolfheart
	["{area:2839} (level 51+) raises {faction:729}: win, capture towers and graveyards, and hand in the battleground's turn-ins. {npc:13219} waits at the Horde end of {zone:1416} outside the battleground; {npc:13218} inside {area:2839} sells the same mount."] = "{area:2839} (уровень 51+) повышает репутацию: {faction:729}. Побеждайте, захватывайте башни и кладбища и сдавайте задания поля боя. {npc:13219} ждет у ордынского края зоны {zone:1416} снаружи поля боя; {npc:13218} внутри ({area:2839}) продает того же скакуна.",

	-- Step 2: Horn of the Frostwolf Howler
	["The Forever client lists it at 200g and level 60, and asks for no riding rank."] = "Клиент Forever указывает цену 200 з и 60-й уровень и не требует навыка верховой езды.",
	-- {npc:13219} Jekyll Flandring
	["{npc:13219}, 200g"] = "{npc:13219}, 200 з",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Frostwolf Howler"] = "Вой Северного волка",
}
