-- Chinese (simplified) (zhCN): the guide forever/class/paladin/cloak-of-the-divine-storm (forever/class/paladin/cloak-of-the-divine-storm.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:407778} Divine Storm
	["A rare cloak at 30 from the old {spell:407778} story; for now only Alliance paladins can finish it."] = "来自旧版{spell:407778}故事的30级稀有披风；目前只有联盟圣骑士能完成。",

	-- Step 1: The Strange Orb
	["The Strange Orb"] = "Strange Orb",
	-- {area:444} Tower of Althalaxx · {zone:1439} Darkshore
	["Climb to the top of the {area:444} in northern {zone:1439}. Loot the Strange Orb up there: it gives you the Althalaxx Orb, which starts the quest."] = "爬到{zone:1439}北部{area:444}的顶端。拾取上面的Strange Orb：它会给你奥萨拉克斯宝珠，由此开始任务。",
	-- {area:444} Tower of Althalaxx
	["Strange Orb atop the {area:444}: right-click the Althalaxx Orb it gives"] = "{area:444}顶端的Strange Orb：右键点击它给的奥萨拉克斯宝珠",

	-- Step 2: Delgren the Purifier
	-- {npc:3663} Delgren the Purifier · {area:413} Maestra's Post · {zone:1440} Ashenvale
	["{npc:3663} stands at {area:413} in western {zone:1440}."] = "{npc:3663}站在{zone:1440}西部的{area:413}。",

	-- Step 3: Katherine the Pure
	-- {npc:5492} Katherine the Pure
	["{npc:5492} is in the Cathedral of Light."] = "{npc:5492}在光明大教堂。",

	-- Step 4: Ursula Deline
	-- {object:2101} Mage Quarter · {npc:5495} Ursula Deline
	["Katherine sends you to the warlocks in the {object:2101}; {npc:5495} speaks for them."] = "凯瑟琳让你去找{object:2101}的术士；{npc:5495}代表他们。",

	-- Step 5: Summoner's Salt
	-- {item:209778} Summoner's Salt
	-- plural, as words: Blackrock Summoners = {npc:4463} Blackrock Summoner
	["Blackrock Summoners, Champions and Trackers camp in the north-west of Redridge; they drop the {item:209778}."] = "黑石召唤师、黑石勇士和黑石追踪者驻扎在赤脊山西北部；它们掉落{item:209778}。",

	-- Step 6: Back to Ursula Deline
	-- {npc:5495} Ursula Deline
	["Back to {npc:5495}"] = "回到{npc:5495}处",

	-- Step 7: Motes of Mannoroth
	["Motes of Mannoroth"] = "玛诺洛斯微粒",
	-- {area:435} Demon Fall Canyon · {zone:1440} Ashenvale
	-- plural, as words: Mannoroc Lashers = {npc:11697} Mannoroc Lasher · Searing Infernals = {npc:6073} Searing Infernal · Legion Hounds = {npc:6071} Legion Hound
	["{area:435} is in south-east {zone:1440}. The Mannoroc Lashers, Searing Infernals, Felguards and Legion Hounds in it drop the Motes of Mannoroth."] = "{area:435}位于{zone:1440}东南部。里面的玛诺洛克鞭笞者、灼热的地狱火、恶魔守卫和恶魔指挥官掉落玛诺洛斯微粒。",

	-- Step 8: The Spear of Mannoroth
	-- {object:409311} Spear of Mannoroth (no name in this language: may be words)
	["The {object:409311}"] = "{object:409311}",
	-- {object:409311} Spear of Mannoroth (no name in this language: may be words) · {area:435} Demon Fall Canyon · {object:409315} Shattered Orb (no name in this language: may be words)
	["The {object:409311} stands at the east end of {area:435}. Shatter the orb on it; the {object:409315} appears beside it."] = "{object:409311}矗立在{area:435}东端。在它上面击碎宝珠；{object:409315}会出现在旁边。",
	-- {object:409315} Shattered Orb (no name in this language: may be words)
	["from the {object:409315}"] = "来自{object:409315}",

	-- Step 9: Return to Delgren
	-- {area:413} Maestra's Post
	["Back to {area:413}."] = "回到{area:413}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {object:409311} stands at the east end of {area:435}. {spell:11170} the orb on it; the {object:409315} appears beside it."] = "{object:409311}矗立在{area:435}东端。对上面的宝珠施放{spell:11170}；{object:409315}会出现在旁边。",
	-- ["{npc:5492} is in the 光明大教堂."] = "{npc:5492}在光明大教堂。",
}
