-- Chinese (traditional) (zhTW): the guide forever/class/rogue/blade-of-cunning-horde (forever/class/rogue/blade-of-cunning-horde.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:7298} Blade of Cunning
	["{item:7298} (Horde)"] = "{item:7298}（部落）",
	["A dagger at 10 from your home town's rogue quests."] = "10級時從家鄉盜賊任務獲得的匕首。",

	-- Step 1: Therzok
	-- {npc:3170} Kaplak · {area:362} Razor Hill · {quest:1859} Therzok · {zone:1454} Orgrimmar
	["At 10 {npc:3170}, the rogue trainer in {area:362}, sends you to {quest:1859} in {zone:1454}."] = "10級時，{area:362}的盜賊訓練師{npc:3170}會派你去找{zone:1454}的{quest:1859}。",

	-- Step 2: The Shattered Hand
	-- {quest:1859} Therzok · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {quest:1963} The Shattered Hand
	["{quest:1859} stands in the {object:172960}, the canyon under the {object:172982}. Trolls: take {quest:1963} from him at 10."] = "{quest:1859}站在{object:172960}，就是{object:172982}下方的峽谷。食人妖：10級時向他接受{quest:1963}。",

	-- Step 3: Tazan
	-- {npc:6494} Tazan · {zone:1413} Barrens · {area:392} Ratchet
	["{npc:6494} stands on the {zone:1413} coast south of {area:392}. Kill him for his satchel."] = "{npc:6494}站在{area:392}南邊的{zone:1413}海岸上。擊殺他取得他的背包。",

	-- Step 4: Back to Therzok
	-- {npc:6446} Therzok
	["Back to {npc:6446}"] = "回到{npc:6446}那裡",

	-- Step 5: Tazan's Key
	-- {npc:6466} Gamon · {object:172982} Valley of Strength · {item:7208} Tazan's Key · {item:7209} Tazan's Satchel
	["{npc:6466} drinks in the inn in the {object:172982}. Pick his pocket for {item:7208}, then open {item:7209}."] = "{npc:6466}在{object:172982}的旅店裡喝酒。對他偷竊取得{item:7208}，然後打開{item:7209}。",
	-- {item:7209} Tazan's Satchel
	["{item:7209}, once you have the key"] = "{item:7209}，拿到鑰匙後",
	-- {item:7295} Tazan's Logbook
	["{item:7295}, from the satchel"] = "{item:7295}，來自背包",

	-- Step 6: Therzok's reward
	-- {npc:6446} Therzok
	["{npc:6446}'s reward"] = "{npc:6446}的獎勵",

	-- Step 7: Mennet Carkad
	-- {npc:2130} Marion Call · {area:2119} Gallows' End Tavern · {area:159} Brill · {quest:1885} Mennet Carkad · {zone:1458} Undercity
	["At 10 {npc:2130}, the rogue trainer in the {area:2119} in {area:159}, sends you to {quest:1885} in the {zone:1458}."] = "10級時，{area:159}{area:2119}的盜賊訓練師{npc:2130}會派你去找{zone:1458}的{quest:1885}。",

	-- Step 8: The Rogues' Quarter
	-- {object:36073} Rogues' Quarter
	["The {object:36073}"] = "{object:36073}",
	-- {quest:1885} Mennet Carkad · {object:36073} Rogues' Quarter
	["{quest:1885} stands in the {object:36073}."] = "{quest:1885}站在{object:36073}。",

	-- Step 9: Astor Hadren
	-- {npc:6497} Astor Hadren · {area:228} Sepulcher
	["{npc:6497} stands north-east of the {area:228}. Take his Letter of Introduction from him."] = "{npc:6497}站在{area:228}東北方。向他取得阿斯托的介紹信。",

	-- Step 10: Back to Mennet Carkad
	-- {npc:6467} Mennet Carkad
	["Back to {npc:6467}"] = "回到{npc:6467}那裡",

	-- Step 11: Andron Gant
	-- {npc:6522} Andron Gant
	["{npc:6522}'s ledger sits on the bookshelf beside him."] = "{npc:6522}的帳本放在他旁邊的書架上。",

	-- Step 12: Mennet Carkad and Varimathras
	-- {npc:6467} Mennet Carkad · {npc:2425} Varimathras
	["{npc:6467} and {npc:2425}"] = "{npc:6467}與{npc:2425}",
	-- {npc:6467} Mennet Carkad · {npc:2425} Varimathras · {object:36126} Royal Quarter
	["{npc:6467} sends the ledger on to {npc:2425} in the Hall of the Dark Lady, the {object:36126}."] = "{npc:6467}會把帳本轉交給黑暗女王大廳{object:36126}的{npc:2425}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Tazan"] = "塔贊",
	-- ["{item:7208}: Gamon"] = "{item:7208}：加摩爾",
	-- ["{item:7209}: Tazan"] = "{item:7209}：塔贊",
}
