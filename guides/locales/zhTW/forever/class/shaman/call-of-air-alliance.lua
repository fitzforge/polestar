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
	-- {npc:258098} Eldrun Stormbreaker · {zone:1455} Ironforge · {npc:259023} Veyric Thunderhame · {zone:1417} Arathi Highlands · {spell:10596} Nature Resistance · {item:5178} Air Totem
	["At 30 {npc:258098}, the shaman trainer in {zone:1455}, sends you to {npc:259023} in {zone:1417}. Your level 30 air totems (Grounding, {spell:10596}) need the {item:5178} he gives."] = "30級時，{zone:1455}的薩滿訓練師{npc:258098}會派你去找{zone:1417}的{npc:259023}。你30級的空氣圖騰（根基圖騰、{spell:10596}）需要他給的{item:5178}。",

	-- Step 2: Veyric Thunderhame
	-- {npc:259023} Veyric Thunderhame · {area:321} Hammerfall · {area:320} Refuge Pointe
	["{npc:259023} camps in the hills just west of {area:321}, the Horde town in the north-east of Arathi: mind its guards. Fly to {area:320} and head north-east."] = "{npc:259023}在{area:321}正西的丘陵紮營，那是阿拉希東北的部落城鎮：小心它的衛兵。飛往{area:320}，然後向東北走。",
	-- {npc:259023} Veyric Thunderhame · {item:5178} Air Totem
	["{npc:259023}: your {item:5178}"] = "{npc:259023}：你的{item:5178}",

	-- Step 3: Veyric Thunderhame
	-- {quest:96264} Elemental Aid · {npc:4421} Charlga Razorflank · {area:1717} Razorfen Kraul · {npc:259023} Veyric Thunderhame
	["{quest:96264} sends you to {npc:4421}, a level 33 elite at the end of {area:1717}: {npc:259023}'s next quest waits for 32."] = "",

	-- Step 4: Charlga Razorflank
	-- {area:1717} Razorfen Kraul · {zone:1413} Barrens · {npc:4421} Charlga Razorflank · {spell:8292} Chain Bolt · {spell:139} Renew · {item:274463} Tattered Note
	["{area:1717} is a five-player dungeon at the southern edge of the {zone:1413} (the arrow points at its entrance); {npc:4421} (level 33 elite) is its last boss. She casts {spell:8292}, {spell:139} on her allies and Purity; the {item:274463} drops only from her."] = "{area:1717}是{zone:1413}南緣的五人地城（箭頭指向入口）；{npc:4421}（33級精英）是最後一個首領。她會施放{spell:8292}、對盟友施放{spell:139}以及純淨術；{item:274463}只會從她身上掉落。",
	-- {item:274463} Tattered Note · {npc:4421} Charlga Razorflank
	["{item:274463}, from {npc:4421}"] = "{item:274463}，來自{npc:4421}",

	-- Step 6: Twisted Fire Totems
	-- plural, as words: Twisted Fire Totems = {item:274044} Twisted Fire Totem
	["Twisted Fire Totems"] = "扭曲火焰圖騰",
	-- {area:338} Angor Fortress · {zone:1418} Badlands · {npc:3560} Healing Ward
	-- plural, as words: Twisted Fire Totems = {item:274044} Twisted Fire Totem · Fire Nova Totems = {npc:5879} Fire Nova Totem
	["Five Twisted Fire Totems. The Stonevault troggs (Skullthumpers, Bonesnappers and Shamans, level 37-41) south of {area:338} in the {zone:1418} carry them; the Shamans drop Fire Nova Totems and a {npc:3560}, the Bonesnappers run for help when hurt. Respawn about five minutes."] = "五個畸變火焰圖騰。{zone:1418}中{area:338}以南的石穹穴居怪（碎顱者、碎骨者和薩滿，37-41級）攜帶它們；薩滿會放下火焰新星圖騰和一個{npc:3560}，碎骨者受傷時會逃跑求援。重新出現約五分鐘。",

	-- Step 7: Twisted Earth Totems
	-- plural, as words: Twisted Earth Totems = {item:274045} Twisted Earth Totem
	["Twisted Earth Totems"] = "扭曲大地圖騰",
	-- {area:75} Stonard · {zone:1435} Swamp of Sorrows
	-- plural, as words: Twisted Earth Totems = {item:274045} Twisted Earth Totem · The Lost Ones = {npc:256028} The Lost One
	["Five Twisted Earth Totems. The Lost Ones (murlocs, level 34-39) north and north-east of {area:75} in the {zone:1435} carry them; most run for help when hurt."] = "五個畸變大地圖騰。{zone:1435}中{area:75}以北和東北的失落者（魚人，34-39級）攜帶它們；大多數受傷時會逃跑求援。",

	-- Step 8: Twisted Water Totems
	-- plural, as words: Twisted Water Totems = {item:274046} Twisted Water Totem
	["Twisted Water Totems"] = "扭曲水之圖騰",
	-- {area:496} Brackenwall Village · {zone:1445} Dustwallow Marsh
	-- plural, as words: Twisted Water Totems = {item:274046} Twisted Water Totem
	["Five Twisted Water Totems. The Mirefin murlocs (level 35-38) north-east of {area:496} in northern {zone:1445} carry them."] = "五個畸變水圖騰。{zone:1445}北部{area:496}東北的泥鰭魚人（35-38級）攜帶它們。",

	-- Step 9: Twisted Air Totems
	-- plural, as words: Twisted Air Totems = {item:274047} Twisted Air Totem
	["Twisted Air Totems"] = "扭曲風之圖騰",
	-- {area:2408} Shadowprey Village · {zone:1443} Desolace · {spell:9654} Jumping Lightning
	-- plural, as words: Twisted Air Totems = {item:274047} Twisted Air Totem
	["Five Twisted Air Totems. The Maraudine centaurs (level 36-40) north and north-east of {area:2408} in western {zone:1443} carry them; the Scouts drop one nearly every other kill. Wranglers Net and Disarm, Windchasers heal, Stormers throw {spell:9654}: pull one at a time. Respawn about five minutes."] = "五個畸變空氣圖騰。{zone:1443}西部{area:2408}以北和東北的瑪洛丁半人馬（36-40級）攜帶它們；斥候幾乎每兩次擊殺就掉一個。馴獸者會撒網和繳械，逐風者會治療，風暴者會投擲{spell:9654}：一次拉一個。重新出現約五分鐘。",

	-- Step 11: The steam pools
	["The steam pools"] = "蒸氣池",
	-- {npc:259023} Veyric Thunderhame · {item:268582} Corrupted Totems · {zone:1441} Thousand Needles · {area:489} Thalanaar · {zone:1444} Feralas · {area:484} Freewind Post · {npc:216474} Ravaging Tempest · {item:212792} Eye of the Tempest
	["{npc:259023} hands you the {item:268582}. {zone:1441} is far: the boat to Theramore and the road west, or fly to {area:489} on the {zone:1444} border and head east into the canyon. Place the {item:268582} at the steam pools north-west of {area:484} to call the corrupted elementals and then the {npc:216474}; Razormane quilboar join the fight while the ritual runs. A group quest: bring at least one or two friends. The {item:212792} drops about every other kill, and every group member can loot it."] = "{npc:259023}交給你{item:268582}。{zone:1441}很遠：可以乘船去塞拉摩再走西路，或者飛到{zone:1444}邊界的{area:489}，再向東進入峽谷。把{item:268582}放在{area:484}西北的蒸汽池，召喚被腐蝕的元素，然後是{npc:216474}；儀式進行時鋼鬃野豬人會加入戰鬥。這是一個組隊任務：至少帶一兩個朋友。{item:212792}約每兩次擊殺掉一個，每個隊員都能拾取。",
	-- {item:212792} Eye of the Tempest · {npc:216474} Ravaging Tempest
	["{item:212792}, from the {npc:216474}"] = "{item:212792}，來自{npc:216474}",

	-- Step 13: Bath'rah the Windwatcher
	-- {npc:6176} Bath'rah the Windwatcher · {zone:1416} Alterac Mountains · {area:272} Tarren Mill · {item:280607} Lightning's Grasp · {item:280605} Tidebringer's Claw · {item:280604} Rage of the Storm
	["{npc:6176} camps in the ruins in the east of {zone:1416}: from {area:272} follow the river east of town north into the hills. Pick your weapon: {item:280607}, {item:280605} or {item:280604}."] = "{npc:6176}在{zone:1416}東部的廢墟紮營：從{area:272}沿鎮東的河流向北進入丘陵。選擇你的武器：{item:280607}、{item:280605}或{item:280604}。",
	-- {npc:6176} Bath'rah the Windwatcher · {item:280696} Elementalist's Guard
	["{npc:6176}: the {item:280696} and your weapon"] = "{npc:6176}：{item:280696}和你的武器",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Lost Ones in the north of the {zone:1435} carry the Twisted Earth Totems."] = "{zone:1435}北部的{npc:256028}帶著扭曲大地圖騰。",
	-- ["The Maraudine centaurs of western {zone:1443} carry the Twisted Air Totems."] = "{zone:1443}西部的瑪洛迪半人馬帶著扭曲風之圖騰。",
	-- ["The Mirefin murlocs of northern {zone:1445} carry the Twisted Water Totems."] = "{zone:1445}北部的黑鰭魚人帶著扭曲水之圖騰。",
	-- ["The Stonevault troggs in the south of the {zone:1418} carry the Twisted Fire Totems."] = "{zone:1418}南部的石窟穴居人帶著扭曲火焰圖騰。",
	-- ["{npc:259023} camps in the northern hills of {zone:1417}."] = "{npc:259023}在{zone:1417}北部的山丘紮營。",
	-- ["{npc:259023} hands you the {item:268582}: place them at the steam pools of {zone:1441} and defeat the {npc:216474} they call. {quest:96135} is an elite quest: grouping up is advised."] = "{npc:259023}會給你{item:268582}：把它們放在{zone:1441}的蒸氣池，擊敗它們召來的{npc:216474}。{quest:96135}是精英任務：建議組隊。",
	-- ["{npc:6176} camps in the east of {zone:1416}, north-east of {area:272}."] = "{npc:6176}在{zone:1416}東部、{area:272}東北方紮營。",
}
