-- Chinese (traditional) (zhTW): the guide forever/class/shaman/call-of-air-alliance (forever/class/shaman/call-of-air-alliance.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:94789} Call of Air
	["{quest:94789} and the Tempest's Weapons (Alliance)"] = "{quest:94789}與風暴武器（聯盟）",
	-- {item:5178} Air Totem
	["The {item:5178} that lets you place air totems, then a weapon of your choice at 40."] = "讓你能放置空氣圖騰的{item:5178}，以及40級時任選的一把武器。",

	-- Step 1: Eldrun Stormbreaker
	-- {npc:258098} Eldrun Stormbreaker · {zone:1455} Ironforge · {npc:259023} Veyric Thunderhame · {zone:1417} Arathi Highlands · {item:5178} Air Totem
	["At 30 {npc:258098}, the shaman trainer in {zone:1455}, sends you to {npc:259023} in {zone:1417}. Your level 30 air totems (Grounding, Nature Resistance) need the {item:5178} he gives."] = "",

	-- Step 2: Veyric Thunderhame
	-- {npc:259023} Veyric Thunderhame · {object:2685} Refuge Pointe (no name in this language: may be words)
	["{npc:259023} camps in the hills just west of Hammerfall, the Horde town in the north-east of Arathi: mind its guards. Fly to {object:2685} and head north-east."] = "",
	-- {npc:259023} Veyric Thunderhame · {item:5178} Air Totem
	["{npc:259023}: your {item:5178}"] = "{npc:259023}：你的{item:5178}",

	-- Step 3: Charlga Razorflank
	-- {zone:1413} Barrens · {npc:4421} Charlga Razorflank · {item:274463} Tattered Note
	["Razorfen Kraul is a five-player dungeon at the southern edge of the {zone:1413} (the arrow points at its entrance); {npc:4421} (level 33 elite) is its last boss. She casts Chain Bolt, Renew on her allies and Purity; the {item:274463} drops only from her."] = "",
	-- {item:274463} Tattered Note · {npc:4421} Charlga Razorflank
	["{item:274463}, from {npc:4421}"] = "{item:274463}，來自{npc:4421}",

	-- Step 5: Twisted Fire Totems
	-- plural, as words: Twisted Fire Totems = {item:274044} Twisted Fire Totem
	["Twisted Fire Totems"] = "扭曲火焰圖騰",
	-- {zone:1418} Badlands · {npc:3560} Healing Ward
	-- plural, as words: Twisted Fire Totems = {item:274044} Twisted Fire Totem · Fire Nova Totems = {npc:5879} Fire Nova Totem
	["Five Twisted Fire Totems. The Stonevault troggs (Skullthumpers, Bonesnappers and Shamans, level 37-41) south of Angor Fortress in the {zone:1418} carry them; the Shamans drop Fire Nova Totems and a {npc:3560}, the Bonesnappers run for help when hurt. Respawn about five minutes."] = "",

	-- Step 6: Twisted Earth Totems
	-- plural, as words: Twisted Earth Totems = {item:274045} Twisted Earth Totem
	["Twisted Earth Totems"] = "扭曲大地圖騰",
	-- {zone:1435} Swamp of Sorrows
	-- plural, as words: Twisted Earth Totems = {item:274045} Twisted Earth Totem · The Lost Ones = {npc:256028} The Lost One
	["Five Twisted Earth Totems. The Lost Ones (murlocs, level 34-39) north and north-east of Stonard in the {zone:1435} carry them; most run for help when hurt."] = "",

	-- Step 7: Twisted Water Totems
	-- plural, as words: Twisted Water Totems = {item:274046} Twisted Water Totem
	["Twisted Water Totems"] = "扭曲水之圖騰",
	-- {object:21082} Brackenwall Village (no name in this language: may be words) · {zone:1445} Dustwallow Marsh
	-- plural, as words: Twisted Water Totems = {item:274046} Twisted Water Totem
	["Five Twisted Water Totems. The Mirefin murlocs (level 35-38) north-east of {object:21082} in northern {zone:1445} carry them."] = "",

	-- Step 8: Twisted Air Totems
	-- plural, as words: Twisted Air Totems = {item:274047} Twisted Air Totem
	["Twisted Air Totems"] = "扭曲風之圖騰",
	-- {object:176946} Shadowprey Village (no name in this language: may be words) · {zone:1443} Desolace
	-- plural, as words: Twisted Air Totems = {item:274047} Twisted Air Totem
	["Five Twisted Air Totems. The Maraudine centaurs (level 36-40) north and north-east of {object:176946} in western {zone:1443} carry them; the Scouts drop one nearly every other kill. Wranglers Net and Disarm, Windchasers heal, Stormers throw Jumping Lightning: pull one at a time. Respawn about five minutes."] = "",

	-- Step 10: The steam pools
	["The steam pools"] = "蒸氣池",
	-- {npc:259023} Veyric Thunderhame · {item:268582} Corrupted Totems · {zone:1441} Thousand Needles · {zone:1444} Feralas · {object:19840} Freewind Post (no name in this language: may be words) · {npc:216474} Ravaging Tempest · {item:212792} Eye of the Tempest
	["{npc:259023} hands you the {item:268582}. {zone:1441} is far: the boat to Theramore and the road west, or fly to Thalanaar on the {zone:1444} border and head east into the canyon. Place the {item:268582} at the steam pools north-west of {object:19840} to call the corrupted elementals and then the {npc:216474}; Razormane quilboar join the fight while the ritual runs. A group quest: bring at least one or two friends. The {item:212792} drops about every other kill, and every group member can loot it."] = "",
	-- {item:212792} Eye of the Tempest · {npc:216474} Ravaging Tempest
	["{item:212792}, from the {npc:216474}"] = "{item:212792}，來自{npc:216474}",

	-- Step 12: Bath'rah the Windwatcher
	-- {npc:6176} Bath'rah the Windwatcher · {zone:1416} Alterac Mountains · {object:1772} Tarren Mill (no name in this language: may be words) · {item:280607} Lightning's Grasp · {item:280605} Tidebringer's Claw · {item:280604} Rage of the Storm
	["{npc:6176} camps in the ruins in the east of {zone:1416}: from {object:1772} follow the river east of town north into the hills. Pick your weapon: {item:280607}, {item:280605} or {item:280604}."] = "",
	-- {npc:6176} Bath'rah the Windwatcher · {item:280696} Elementalist's Guard
	["{npc:6176}: the {item:280696} and your weapon"] = "{npc:6176}：{item:280696}和你的武器",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 30 {npc:258098}, the shaman trainer in {zone:1455}, sends you to {npc:259023} in {zone:1417}."] = "30級時，{zone:1455}的薩滿訓練師{npc:258098}會派你去找{zone:1417}的{npc:259023}。",
	-- ["The Lost Ones in the north of the {zone:1435} carry the Twisted Earth Totems."] = "{zone:1435}北部的{npc:256028}帶著扭曲大地圖騰。",
	-- ["The Maraudine centaurs of western {zone:1443} carry the Twisted Air Totems."] = "{zone:1443}西部的瑪洛迪半人馬帶著扭曲風之圖騰。",
	-- ["The Mirefin murlocs of northern {zone:1445} carry the Twisted Water Totems."] = "{zone:1445}北部的黑鰭魚人帶著扭曲水之圖騰。",
	-- ["The Stonevault troggs in the south of the {zone:1418} carry the Twisted Fire Totems."] = "{zone:1418}南部的石窟穴居人帶著扭曲火焰圖騰。",
	-- ["{area:1717} is a dungeon at the southern edge of the {zone:1413} (the arrow points at its entrance); {npc:4421} is its last boss. Bring a group."] = "{area:1717}是{zone:1413}南緣的地城（箭頭指向入口）；{npc:4421}是最後一個首領。請帶小隊。",
	-- ["{npc:259023} camps in the northern hills of {zone:1417}."] = "{npc:259023}在{zone:1417}北部的山丘紮營。",
	-- ["{npc:259023} hands you the {item:268582}: place them at the steam pools of {zone:1441} and defeat the {npc:216474} they call. {quest:96135} is an elite quest: grouping up is advised."] = "{npc:259023}會給你{item:268582}：把它們放在{zone:1441}的蒸氣池，擊敗它們召來的{npc:216474}。{quest:96135}是精英任務：建議組隊。",
	-- ["{npc:6176} camps in the east of {zone:1416}, north-east of {area:272}."] = "{npc:6176}在{zone:1416}東部、{area:272}東北方紮營。",
}
