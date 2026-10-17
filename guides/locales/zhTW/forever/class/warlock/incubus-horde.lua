-- Chinese (traditional) (zhTW): the guide forever/class/warlock/incubus-horde (forever/class/warlock/incubus-horde.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Incubus (Horde)"] = "夢魔（部落）",
	["A second seducer demon, the male sayaad, and a soul shard bag to carry your shards."] = "第二種誘惑型惡魔，也就是男性的魅魔，還有一個用來裝靈魂碎片的靈魂碎片包。",

	-- Step 1: Devourer of Souls (Orgrimmar)
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {npc:5909} Cazul · {npc:5675} Carendin Halgar · {zone:1458} Undercity · {quest:1472} Devourer of Souls
	["At 20 {npc:5875}, in the {object:172960} under the {object:172982}, sends you to {npc:5909} a few steps away. Two trainers offer the incubus, {npc:5875} here and {npc:5675} in the {zone:1458}, and you can take only one: this guide follows whichever {quest:1472} you took."] = "20級時，{object:172982}下方{object:172960}的{npc:5875}會派你去找幾步之遙的{npc:5909}。有兩位訓練師提供夢魔任務，這裡的{npc:5875}和{zone:1458}的{npc:5675}，你只能接其中一個：本指南依照你接的{quest:1472}。",

	-- Step 2: Magar
	-- {npc:3363} Magar · {object:173018} Magar's Cloth Goods · {object:172960} Cleft of Shadow
	["{npc:3363} keeps {object:173018}, east of the {object:172960} along the main street. He asks you to look for his mate, Krilge."] = "{npc:3363}經營{object:173018}，位於{object:172960}東邊的主街上。他請你去找他的伴侶。",

	-- Step 3: Fallen Sky Lake
	-- {area:422} Fallen Sky Lake · {zone:1440} Ashenvale · {area:431} Splintertree Post · {item:190232} Withered Scarf
	["{area:422} lies in southern {zone:1440}, south of {area:431}. The Shadethicket bog beasts around the lake drop the {item:190232}, about one in twenty."] = "{area:422}位於{zone:1440}南部、{area:431}南邊。湖周圍的沼澤獸會掉落{item:190232}，大約二十隻一次。",

	-- Step 4: The Binding (Orgrimmar)
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {npc:3216} Neeru Fireblade
	["Back to {npc:5875} in the {object:172960}. Take the scarf to the summoning circle in {npc:3216}'s tent nearby and defeat the incubus it calls."] = "回到{object:172960}找{npc:5875}。把圍巾帶到附近{npc:3216}帳篷裡的召喚法陣，擊敗它召喚出的夢魔。",
	-- {npc:5875} Gan'rul Bloodeye
	["{npc:5875}: he binds the incubus to you"] = "{npc:5875}：他會把夢魔束縛給你",

	-- Step 5: Devourer of Souls (Undercity)
	-- {object:1661} The Undercity · {npc:5675} Carendin Halgar · {quest:1472} Devourer of Souls · {npc:5875} Gan'rul Bloodeye · {object:36082} Magic Quarter · {npc:5693} Godrick Farsan
	["{object:1661}'s version, for warlocks who took {npc:5675}'s {quest:1472} instead of {npc:5875}'s. At 20 {npc:5675}, in the {object:36082}, sends you to {npc:5693} in the Temple of the Damned, just north of him."] = "{object:1661}的版本，給接了{npc:5675}而非{npc:5875}的{quest:1472}的術士。20級時，{object:36082}的{npc:5675}會派你去找就在他北邊詛咒者神殿裡的{npc:5693}。",

	-- Step 6: Avelina Lilly
	-- {npc:185333} Avelina Lilly · {area:279} Dalaran · {area:233} Ambermill · {zone:1421} Silverpine Forest
	["{npc:185333} works as a tailor for the {area:279} wizards at {area:233}, in eastern {zone:1421}. Take her heart."] = "{npc:185333}在{zone:1421}東部的{area:233}為{area:279}的巫師們當裁縫。取走她的心臟。",

	-- Step 7: Isaac Pearson
	-- {npc:185334} Isaac Pearson · {area:392} Ratchet · {zone:1413} Barrens · {zone:1411} Durotar
	["{npc:185334} works in {area:392}, on the {zone:1413} coast. Take the zeppelin to {zone:1411} and ride or fly on to {area:392}."] = "{npc:185334}在{zone:1413}海岸的{area:392}工作。搭飛艇前往{zone:1411}，再騎或飛往{area:392}。",

	-- Step 8: The Binding (Undercity)
	-- {npc:5675} Carendin Halgar · {object:36082} Magic Quarter
	["Back to {npc:5675} in the {object:36082}. Place the hearts at the summoning circle below him and defeat the incubus they call."] = "回到{object:36082}找{npc:5675}。把心臟放在他下方的召喚法陣，擊敗它們召喚出的夢魔。",
	-- {npc:5675} Carendin Halgar
	["{npc:5675}: he binds the incubus to you"] = "{npc:5675}：他會把夢魔束縛給你",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to Carendin in the {object:36082}. Place the hearts at the summoning circle below him and defeat the incubus they call."] = "回到{object:36082}找卡蘭丁。把心臟放在他下方的召喚法陣，擊敗它們召喚出的夢魔。",
	-- ["{object:1661}'s version, for warlocks who took {npc:5675}'s {quest:1472} instead of Gan'rul's. At 20 Carendin, in the {object:36082}, sends you to {npc:5693} in the Temple of the Damned, just north of him."] = "{object:1661}的版本，給接了{npc:5675}而非甘盧爾的{quest:1472}的術士。20級時，{object:36082}的卡蘭丁會派你去找就在他北邊神殿裡的{npc:5693}。",
}
