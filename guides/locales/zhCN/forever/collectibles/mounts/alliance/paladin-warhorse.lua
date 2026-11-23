-- Chinese (simplified) (zhCN): the guide forever/collectibles/mounts/alliance/paladin-warhorse (forever/collectibles/mounts/alliance/paladin-warhorse.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Paladin Warhorse"] = "圣骑士战马",
	["Your first mount at 40, summoned at will: a paladin buys no horse."] = "40级获得的第一匹坐骑，可随时召唤：圣骑士无需购买马匹。",

	-- Step 1: The Tome of Nobility (Ironforge)
	-- {npc:6179} Tiza Battleforge · {object:32386} Hall of Mysteries · {npc:6171} Duthorian Rall · {zone:1453} Stormwind · {npc:5149} Brandur Ironhammer · {area:2257} Deeprun Tram
	["At 40 {npc:6179}, upstairs in the {object:32386}, sends you to {npc:6171} in {zone:1453} ({npc:5149} downstairs gives the same errand; take one). Take the {area:2257} to {zone:1453}."] = "40级时，{object:32386} 楼上的 {npc:6179} 会派你去找 {zone:1453} 的 {npc:6171}（楼下的 {npc:5149} 也提供相同差事，接一个即可）。乘坐 {area:2257} 前往 {zone:1453}。",

	-- Step 4: Summon Warhorse
	-- {npc:6171} Duthorian Rall · {quest:1661} The Tome of Nobility · {spell:13819} Summon Warhorse
	["{npc:6171} stands in the Cathedral of Light. At 40 he offers {quest:1661}: accept it and hand it straight back to learn {spell:13819}. Paladins do not buy a horse."] = "{npc:6171} 站在圣光大教堂。40级时，他会提供 {quest:1661}：接受后立即交还，即可学会 {spell:13819}。圣骑士不用花钱买马。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 40 {npc:5149} in the {object:32362} sends you to {npc:6171} in {zone:1453}'s Cathedral of Light. Take the tram from {zone:1455} to {zone:1453}."] = "40级时，{object:32362}的{npc:5149}会让你去找{zone:1453}光明大教堂的{npc:6171}。从{zone:1455}乘地铁前往{zone:1453}。",
	-- ["{npc:6171} stands in the Cathedral of Light. Turning in the {item:6779} teaches {spell:13819}; Paladins do not buy a mount."] = "{npc:6171}站在光明大教堂里。交还{item:6779}即可学会{spell:13819}；圣骑士不需要购买坐骑。",
}
