-- Chinese (traditional) (zhTW): the guide forever/class/warlock/incubus-horde (forever/class/warlock/incubus-horde.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Succubus and Incubus (Horde)"] = "",
	["At 20: the succubus and Forever's incubus, its male twin, each with a soul pouch for your shards."] = "",

	-- Step 1: Devourer of Souls (Orgrimmar)
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {npc:5909} Cazul · {npc:5675} Carendin Halgar · {zone:1458} Undercity · {quest:1472} Devourer of Souls · {zone:1454} Orgrimmar
	["At 20 {npc:5875}, in the {object:172960} under the {object:172982}, sends you to {npc:5909} a few steps away. Two trainers start these demons, {npc:5875} here and {npc:5675} in the {zone:1458}, and you can take only one; this guide follows whichever {quest:1472} you took. {npc:5909} offers both of {zone:1454}'s branches: take both."] = "",
	["the succubus"] = "",
	["the incubus"] = "",

	-- Step 2: Zankaja
	-- {npc:5910} Zankaja · {object:172982} Valley of Strength
	["{npc:5910} lives in a hut up on the cliffs on the west side of the city, above the {object:172982}: climb the wind rider tower, cross the bridge at its top to the west and turn right off it. She sends you to the Crossroads."] = "",

	-- Step 3: Magar
	-- {npc:3363} Magar · {object:173018} Magar's Cloth Goods · {object:172960} Cleft of Shadow · {zone:1440} Ashenvale
	["{npc:3363} keeps {object:173018} on the main street east of the {object:172960}. He asks you to look for his mate Krilge in {zone:1440}."] = "",

	-- Step 4: Gazrog
	-- {npc:3464} Gazrog · {npc:4197} Ken'zigla · {area:2539} Malaka'jin · {zone:1442} Stonetalon Mountains
	["{npc:3464} waits in front of the inn at the Crossroads. He sends you on to {npc:4197} at {area:2539}, in {zone:1442}."] = "",

	-- Step 5: Ken'zigla
	-- {zone:1442} Stonetalon Mountains · {area:2539} Malaka'jin · {npc:4197} Ken'zigla · {npc:5911} Grunt Logmar
	["Take the road west from the Crossroads into {zone:1442} and, just past the border, the faint trail up to the left (south): {area:2539} cannot be reached from the main road. {npc:4197} hands you her draught for {npc:5911}."] = "",

	-- Step 6: Grunt Dogran
	-- {npc:5911} Grunt Logmar · {area:378} Camp Taurajo · {npc:5875} Gan'rul Bloodeye
	["{npc:5911} stands at {area:378}, south down the road from the Crossroads. He sends you north to the quilboar camp where Dogran is held: the camp with two huts side by side, north-west of a decoy camp whose huts stand apart. A rare level 22 elite quilboar sometimes guards the huts: send your voidwalker in, sacrifice it if you must, and talk to Dogran. He gives you a pendant for {npc:5875}. Keep it."] = "",

	-- Step 7: The Binding: succubus (Orgrimmar)
	-- {quest:1513} The Binding · {zone:1454} Orgrimmar
	["{quest:1513}: succubus ({zone:1454})"] = "",
	-- {npc:5875} Gan'rul Bloodeye · {item:6626} Dogran's Pendant · {object:172960} Cleft of Shadow · {npc:3216} Neeru Fireblade
	["Back to {npc:5875} with the pendant. He hands you {item:6626}: take it across the {object:172960} to {npc:3216}'s tent, stand on the purple circle and use it. Summon your voidwalker first and let it tank: the succubus (level 20, not elite) charms and lashes; keep your damage over time on her. If she wins, use the pendant again. Keep the pendant: {npc:5875} takes it back."] = "",
	-- {item:6626} Dogran's Pendant
	["{item:6626}, on the circle in Neeru's tent"] = "",

	-- Step 8: Fallen Sky Lake
	-- {area:422} Fallen Sky Lake · {zone:1440} Ashenvale · {area:431} Splintertree Post · {item:190232} Withered Scarf · {npc:3931} Shadethicket Oracle
	-- plural, as words: Shadethicket Stone Movers = {npc:3782} Shadethicket Stone Mover
	["{area:422} lies in southern {zone:1440}, south-west of {area:431}. The Shadethicket Stone Movers and Bark Rippers (level 25-26) around the lake drop the {item:190232} about one time in twenty, and the lone {npc:3931} (30) can drop it too: plan on a good number of kills, so come at 25 or later (Forever made this quest level 27); with the succubus already bound you can leave it for your 20s leveling in {zone:1440}. They respawn in five minutes."] = "",

	-- Step 9: The Binding: incubus (Orgrimmar)
	-- {quest:65604} The Binding · {zone:1454} Orgrimmar
	["{quest:65604}: incubus ({zone:1454})"] = "",
	-- {npc:5875} Gan'rul Bloodeye · {item:190232} Withered Scarf
	["Back to {npc:5875} with the scarf, then use the {item:190232} on the same circle in Neeru's tent and defeat the incubus it calls (level 20, not elite) with your voidwalker tanking. Keep the scarf: {npc:5875} takes it back."] = "",
	-- {npc:185335} Summoned Incubus
	["{npc:185335}, at the circle in Neeru's tent"] = "",

	-- Step 10: Devourer of Souls (Undercity)
	-- {object:1661} The Undercity · {npc:5675} Carendin Halgar · {quest:1472} Devourer of Souls · {npc:5875} Gan'rul Bloodeye · {object:36082} Magic Quarter · {npc:5693} Godrick Farsan
	["{object:1661}'s version, for warlocks who took {npc:5675}'s {quest:1472} instead of {npc:5875}'s. At 20 {npc:5675}, in the {object:36082}, sends you to {npc:5693} close by. {npc:5693} shows you an image of each quarry and offers both branches: take both."] = "",

	-- Step 11: Silverpine hearts
	["Silverpine hearts"] = "",
	-- {npc:185333} Avelina Lilly · {area:279} Dalaran · {area:233} Ambermill · {npc:5682} Dalin Forgewright · {area:230} Greymane Wall
	["{npc:185333} (level 22) works as a tailor for the {area:279} wizards at {area:233}, in eastern Silverpine: the wizards around her are hostile. {npc:5682} (level 20, not elite) patrols near the {area:230} in the far south. Both are Alliance-friendly humans: attacking them can flag you for PvP. Each drops her or his heart."] = "",

	-- Step 12: Corma Villard
	-- {npc:5683} Corma Villard · {zone:1437} Wetlands · {area:881} Thandol Span · {zone:1458} Undercity · {area:287} Hillsbrad · {zone:1417} Arathi Highlands
	["{npc:5683} (level 22, not elite; Comar in older records) wanders the north of the {zone:1437} just past the {area:881}, to the right as you come off the bridge. From the {zone:1458} head through {area:287} and {zone:1417}, where the mobs are 30 and up. Attacking her flags you for PvP."] = "",

	-- Step 13: The Binding: succubus (Undercity)
	-- {quest:1474} The Binding · {zone:1458} Undercity
	["{quest:1474}: succubus ({zone:1458})"] = "",
	-- {npc:5675} Carendin Halgar · {npc:5683} Corma Villard · {item:6286} Pure Hearts
	["Back to {npc:5675} with Dalin's and {npc:5683}'s hearts. He hands you the {item:6286}: go down to the summoning circle below him, stand on it and use them. Summon your voidwalker first and keep the fight on the circle, or the guards may kill her and the kill does not count. If she wins, use the hearts again; keep them, {npc:5675} takes them back."] = "",
	-- {item:6286} Pure Hearts · {npc:5675} Carendin Halgar
	["{item:6286}, on the circle below {npc:5675}"] = "",

	-- Step 14: Isaac Pearson
	-- {npc:185334} Isaac Pearson · {area:392} Ratchet · {zone:1413} Barrens · {zone:1411} Durotar · {zone:1454} Orgrimmar
	["{npc:185334} (level 22) works in {area:392}, on the {zone:1413} coast, at one of two spots in town: take the zeppelin to {zone:1411} and head south, or fly from {zone:1454}. He is an Alliance-friendly human: attacking him can flag you for PvP."] = "",

	-- Step 15: The Binding: incubus (Undercity)
	-- {quest:65597} The Binding · {zone:1458} Undercity
	["{quest:65597}: incubus ({zone:1458})"] = "",
	-- {npc:5675} Carendin Halgar · {item:190181} Lovers' Hearts
	["Back to {npc:5675} with the lovers' hearts, then place the {item:190181} on the same circle and defeat the incubus they call (level 20, not elite; it can charm you). Keep the hearts: {npc:5675} takes them back."] = "",
	-- {npc:185335} Summoned Incubus · {npc:5675} Carendin Halgar
	["{npc:185335}, at the circle below {npc:5675}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A second seducer demon, the male sayaad, and a soul shard bag to carry your shards."] = "第二種誘惑型惡魔，也就是男性的魅魔，還有一個用來裝靈魂碎片的靈魂碎片包。",
	-- ["At 20 {npc:5875}, in the {object:172960} under the {object:172982}, sends you to {npc:5909} a few steps away. Two trainers offer the incubus, {npc:5875} here and {npc:5675} in the {zone:1458}, and you can take only one: this guide follows whichever {quest:1472} you took."] = "20級時，{object:172982}下方{object:172960}的{npc:5875}會派你去找幾步之遙的{npc:5909}。有兩位訓練師提供夢魔任務，這裡的{npc:5875}和{zone:1458}的{npc:5675}，你只能接其中一個：本指南依照你接的{quest:1472}。",
	-- ["Back to Carendin in the {object:36082}. Place the hearts at the summoning circle below him and defeat the incubus they call."] = "回到{object:36082}找卡蘭丁。把心臟放在他下方的召喚法陣，擊敗它們召喚出的夢魔。",
	-- ["Back to {npc:5675} in the {object:36082}. Place the hearts at the summoning circle below him and defeat the incubus they call."] = "回到{object:36082}找{npc:5675}。把心臟放在他下方的召喚法陣，擊敗它們召喚出的夢魔。",
	-- ["Back to {npc:5875} in the {object:172960}. Take the scarf to the summoning circle in {npc:3216}'s tent nearby and defeat the incubus it calls."] = "回到{object:172960}找{npc:5875}。把圍巾帶到附近{npc:3216}帳篷裡的召喚法陣，擊敗它召喚出的夢魔。",
	-- ["Incubus (Horde)"] = "夢魔（部落）",
	-- ["{area:422} lies in southern {zone:1440}, south of {area:431}. The Shadethicket bog beasts around the lake drop the {item:190232}, about one in twenty."] = "{area:422}位於{zone:1440}南部、{area:431}南邊。湖周圍的沼澤獸會掉落{item:190232}，大約二十隻一次。",
	-- ["{npc:185333} works as a tailor for the {area:279} wizards at {area:233}, in eastern {zone:1421}. Take her heart."] = "{npc:185333}在{zone:1421}東部的{area:233}為{area:279}的巫師們當裁縫。取走她的心臟。",
	-- ["{npc:185334} works in {area:392}, on the {zone:1413} coast. Take the zeppelin to {zone:1411} and ride or fly on to {area:392}."] = "{npc:185334}在{zone:1413}海岸的{area:392}工作。搭飛艇前往{zone:1411}，再騎或飛往{area:392}。",
	-- ["{npc:3363} keeps {object:173018}, east of the {object:172960} along the main street. He asks you to look for his mate, Krilge."] = "{npc:3363}經營{object:173018}，位於{object:172960}東邊的主街上。他請你去找他的伴侶。",
	-- ["{npc:5675}: he binds the incubus to you"] = "{npc:5675}：他會把夢魔束縛給你",
	-- ["{npc:5875}: he binds the incubus to you"] = "{npc:5875}：他會把夢魔束縛給你",
	-- ["{object:1661}'s version, for warlocks who took {npc:5675}'s {quest:1472} instead of Gan'rul's. At 20 Carendin, in the {object:36082}, sends you to {npc:5693} in the Temple of the Damned, just north of him."] = "{object:1661}的版本，給接了{npc:5675}而非甘盧爾的{quest:1472}的術士。20級時，{object:36082}的卡蘭丁會派你去找就在他北邊神殿裡的{npc:5693}。",
	-- ["{object:1661}'s version, for warlocks who took {npc:5675}'s {quest:1472} instead of {npc:5875}'s. At 20 {npc:5675}, in the {object:36082}, sends you to {npc:5693} in the Temple of the Damned, just north of him."] = "{object:1661}的版本，給接了{npc:5675}而非{npc:5875}的{quest:1472}的術士。20級時，{object:36082}的{npc:5675}會派你去找就在他北邊詛咒者神殿裡的{npc:5693}。",
}
