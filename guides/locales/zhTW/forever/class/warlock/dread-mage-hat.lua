-- Chinese (traditional) (zhTW): the guide forever/class/warlock/dread-mage-hat (forever/class/warlock/dread-mage-hat.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A cloth hat in your late 20s: Zardeth's errand for any Alliance player pays warlocks this extra."] = "",

	-- Step 1: Zardeth of the Black Claw
	-- {npc:1435} Zardeth of the Black Claw · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {zone:1431} Duskwood · {zone:1437} Wetlands
	["At 25 {npc:1435}, in the cellar of the {object:2164} in the {object:2101} (beside the warlock trainers), wants two ingredients for a brew. Do it when your leveling takes you to {zone:1431} and the {zone:1437}."] = "25級時，{object:2101}裡{object:2164}的地窖中（術士訓練師旁）的{npc:1435}要兩種材料來配藥。等你練級到{zone:1431}和{zone:1437}時再做。",

	-- Step 2: Tear of Tilloa
	-- {area:1098} Manor Mistmantle · {zone:1431} Duskwood · {area:42} Darkshire · {object:321} Tear of Tilloa · {npc:315} Stalvan Mistmantle
	-- plural, as words: Fetid Corpses = {npc:1270} Fetid Corpse
	["{area:1098} stands in the north-east of {zone:1431}, north of {area:42}. The {object:321} is a small white flower low in the grass of the fenced garden beside Stalvan's house: hard to see, so sweep the garden with your mouse. Fetid Corpses (level 29) wander the grounds and come quickly: at 25, send your voidwalker at the nearest one, grab the flower and leave. {npc:315} (32) is inside the house; leave him alone."] = "{area:1098}在{zone:1431}東北、{area:42}以北。{object:321}是一朵小白花，低低地長在斯塔文房子旁圍欄花園的草叢裡：很難看見，用滑鼠在花園裡掃一遍。腐臭的屍體（29級）在院子裡遊蕩，來得很快：25級時派虛空行者去最近的屍體，採花後離開。{npc:315}（32級）在屋裡；別惹他。",

	-- Step 3: Musquash Root
	-- {area:836} Dun Algaz · {object:147516} Dark Iron · {area:146} Stonewrought Dam
	["The root grows at the water's edge in the pool below the small falls east of {area:836}, beside the {object:147516} cave below the {area:146}: a tall, spiky wooden root, not at the foot of the dam itself."] = "根生長在{area:836}東邊小瀑布下池塘的水邊，在{area:146}下方{object:147516}洞穴旁：一根高大、帶尖刺的木根，不在水壩腳下。",

	-- Step 4: A Noble Brew
	-- {item:2788} Black Claw Stout · {npc:1439} Lord Baurles K. Wishock · {object:2117} Stormwind Keep
	["Back to Zardeth. He brews the {item:2788} and gives it to you for {npc:1439} in the Hall of Petitioners, the first hall on the right inside {object:2117}."] = "回到扎爾迪斯。他釀好{item:2788}交給你，再拿去給{object:2117}內右側第一個大廳——請願者大廳——裡的{npc:1439}。",

	-- Step 5: You Have Served Us Well
	-- {npc:1733} Zggi
	["Back to Zardeth once more: he offers warlocks a reward, which his imp {npc:1733}, standing beside him, hands over."] = "再次回到扎爾迪斯：他給術士一份獎勵，由他身旁的小鬼{npc:1733}交給你。",
}
