-- Chinese (traditional) (zhTW): the guide forever/class/paladin/cloak-of-the-divine-storm (forever/class/paladin/cloak-of-the-divine-storm.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:407778} Divine Storm
	["A rare cloak at 30 from the old {spell:407778} story; for now only Alliance paladins can finish it."] = "源自舊{spell:407778}故事線的30級稀有披風；目前只有聯盟聖騎士能完成。",

	-- Step 1: The Strange Orb
	["The Strange Orb"] = "Strange Orb",
	-- {area:444} Tower of Althalaxx · {zone:1439} Darkshore
	["Climb to the top of the {area:444} in northern {zone:1439}. Loot the Strange Orb up there: it gives you the Althalaxx Orb, which starts the quest."] = "爬上{zone:1439}北部的{area:444}頂端。拾取那裡的Strange Orb：它會給你奧薩拉克斯寶珠，由此開始任務。",
	-- {area:444} Tower of Althalaxx
	["Strange Orb atop the {area:444}: right-click the Althalaxx Orb it gives"] = "{area:444}頂端的Strange Orb：右鍵點擊它給的奧薩拉克斯寶珠",

	-- Step 2: Delgren the Purifier
	-- {npc:3663} Delgren the Purifier · {area:413} Maestra's Post · {zone:1440} Ashenvale
	["{npc:3663} stands at {area:413} in western {zone:1440}."] = "{npc:3663}站在{zone:1440}西部的{area:413}。",

	-- Step 3: Katherine the Pure
	-- {npc:5492} Katherine the Pure
	["{npc:5492} is in the Cathedral of Light."] = "{npc:5492}在光明大教堂內。",

	-- Step 4: Ursula Deline
	-- {object:2101} Mage Quarter · {npc:5495} Ursula Deline
	["Katherine sends you to the warlocks in the {object:2101}; {npc:5495} speaks for them."] = "凱瑟琳派你去找{object:2101}的術士；由{npc:5495}代表他們發言。",

	-- Step 5: Summoner's Salt
	-- {item:209778} Summoner's Salt
	-- plural, as words: Blackrock Summoners = {npc:4463} Blackrock Summoner
	["Blackrock Summoners, Champions and Trackers camp in the north-west of Redridge; they drop the {item:209778}."] = "黑石召喚師、黑石勇士和黑石追蹤者在赤脊山西北部紮營；他們會掉落{item:209778}。",

	-- Step 6: Back to Ursula Deline
	-- {npc:5495} Ursula Deline
	["Back to {npc:5495}"] = "返回烏{npc:5495}",

	-- Step 7: Motes of Mannoroth
	["Motes of Mannoroth"] = "瑪諾洛斯微粒",
	-- {area:435} Demon Fall Canyon · {zone:1440} Ashenvale
	-- plural, as words: Mannoroc Lashers = {npc:11697} Mannoroc Lasher · Searing Infernals = {npc:6073} Searing Infernal · Legion Hounds = {npc:6071} Legion Hound
	["{area:435} is in south-east {zone:1440}. The Mannoroc Lashers, Searing Infernals, Felguards and Legion Hounds in it drop the Motes of Mannoroth."] = "{area:435}在{zone:1440}東南部。那裡的瑪諾洛克鞭笞者、灼熱的地獄火、惡魔守衛和惡魔指揮官會掉落瑪諾洛斯微粒。",

	-- Step 8: The Spear of Mannoroth
	-- {object:409311} Spear of Mannoroth (no name in this language: may be words)
	["The {object:409311}"] = "{object:409311}",
	-- {object:409311} Spear of Mannoroth (no name in this language: may be words) · {area:435} Demon Fall Canyon · {object:409315} Shattered Orb (no name in this language: may be words)
	["The {object:409311} stands at the east end of {area:435}. Shatter the orb on it; the {object:409315} appears beside it."] = "{object:409311}位於{area:435}東端。擊碎上面的寶珠；{object:409315}會出現在旁邊。",
	-- {object:409315} Shattered Orb (no name in this language: may be words)
	["from the {object:409315}"] = "從{object:409315}取得",

	-- Step 9: Return to Delgren
	-- {area:413} Maestra's Post
	["Back to {area:413}."] = "返回{area:413}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {object:409311} stands at the east end of {area:435}. {spell:11170} the orb on it; the {object:409315} appears beside it."] = "{object:409311}位於{area:435}東端。對上面的寶珠施放{spell:11170}；{object:409315}會出現在旁邊。",
}
