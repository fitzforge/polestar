-- Chinese (traditional) (zhTW): the guide forever/class/shaman/call-of-air-horde (forever/class/shaman/call-of-air-horde.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:1531} Call of Air
	["{quest:1531} and the Tempest's Weapons (Horde)"] = "{quest:1531}與風暴武器（部落）",
	-- {item:5178} Air Totem
	["The {item:5178} that lets you place air totems, then a weapon of your choice at 40."] = "讓你能放置風之圖騰的{item:5178}，40級時再獲得一把自選武器。",

	-- Step 1: Searn Firewarder
	-- {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom · {npc:5905} Prate Cloudseer · {zone:1441} Thousand Needles
	["At 30 {npc:5892} in the {object:172957} sends you to {npc:5905} in {zone:1441}."] = "30級時，{object:172957}的{npc:5892}會派你去找{zone:1441}的{npc:5905}。",

	-- Step 2: Xanis Flameweaver
	-- {npc:5906} Xanis Flameweaver · {zone:1456} Thunder Bluff · {npc:5905} Prate Cloudseer · {zone:1441} Thousand Needles
	["At 30 {npc:5906}, a shaman trainer in {zone:1456}, sends you to {npc:5905} in {zone:1441}."] = "30級時，{zone:1456}的薩滿訓練師{npc:5906}會派你去找{zone:1441}的{npc:5905}。",

	-- Step 3: Prate Cloudseer
	-- {area:484} Freewind Post · {npc:5905} Prate Cloudseer · {quest:1531} Call of Air
	["Fly to {area:484}. {npc:5905} hides in a small cave in the canyon wall north-east of the post. Skyborne: your own {quest:1531} (96136) ends with her too."] = "飛往{area:484}。{npc:5905}躲在營地東北方峽谷崖壁的小洞穴中。天裔精靈：你自己的{quest:1531}（96136）也在她這裡結束。",
	-- {npc:5905} Prate Cloudseer · {item:5178} Air Totem
	["{npc:5905}: your {item:5178}"] = "{npc:5905}：你的{item:5178}",

	-- Step 4: Charlga Razorflank
	-- {area:1717} Razorfen Kraul · {zone:1413} Barrens · {npc:4421} Charlga Razorflank
	["{area:1717} is a dungeon at the southern edge of the {zone:1413} (the arrow points at its entrance); {npc:4421} is its last boss. Bring a group."] = "{area:1717}是位於{zone:1413}南緣的地城（箭頭指向入口）；{npc:4421}是最後一個首領。找小隊一起去。",
	-- {item:274463} Tattered Note · {npc:4421} Charlga Razorflank
	["{item:274463}, from {npc:4421}"] = "{item:274463}，來自{npc:4421}",

	-- Step 5: Rau Cliffrunner
	-- {npc:4722} Rau Cliffrunner · {area:484} Freewind Post
	["{npc:4722} stands at {area:484}."] = "{npc:4722}站在{area:484}。",

	-- Step 7: Twisted Air Totems
	-- plural, as words: Twisted Air Totems = {item:274047} Twisted Air Totem
	["Twisted Air Totems"] = "扭曲風之圖騰",
	-- {zone:1443} Desolace
	-- plural, as words: Twisted Air Totems = {item:274047} Twisted Air Totem
	["The Maraudine centaurs of western {zone:1443} carry the Twisted Air Totems."] = "{zone:1443}西部的瑪洛迪半人馬身上帶著扭曲風之圖騰。",

	-- Step 8: Twisted Water Totems
	-- plural, as words: Twisted Water Totems = {item:274046} Twisted Water Totem
	["Twisted Water Totems"] = "扭曲水之圖騰",
	-- {zone:1445} Dustwallow Marsh
	-- plural, as words: Twisted Water Totems = {item:274046} Twisted Water Totem
	["The Mirefin murlocs of northern {zone:1445} carry the Twisted Water Totems."] = "{zone:1445}北部的黑鰭魚人身上帶著扭曲水之圖騰。",

	-- Step 9: Twisted Fire Totems
	-- plural, as words: Twisted Fire Totems = {item:274044} Twisted Fire Totem
	["Twisted Fire Totems"] = "扭曲火焰圖騰",
	-- {zone:1418} Badlands
	-- plural, as words: Twisted Fire Totems = {item:274044} Twisted Fire Totem
	["The Stonevault troggs in the south of the {zone:1418} carry the Twisted Fire Totems."] = "{zone:1418}南部的石窟穴居人身上帶著扭曲火焰圖騰。",

	-- Step 10: Twisted Earth Totems
	-- plural, as words: Twisted Earth Totems = {item:274045} Twisted Earth Totem
	["Twisted Earth Totems"] = "扭曲大地圖騰",
	-- {zone:1435} Swamp of Sorrows
	-- plural, as words: The Lost Ones = {npc:256028} The Lost One · Twisted Earth Totems = {item:274045} Twisted Earth Totem
	["The Lost Ones in the north of the {zone:1435} carry the Twisted Earth Totems."] = "{zone:1435}北部的{npc:256028}身上帶著扭曲大地圖騰。",

	-- Step 12: The steam pools
	["The steam pools"] = "蒸氣池",
	-- {npc:5905} Prate Cloudseer · {item:268582} Corrupted Totems · {area:484} Freewind Post · {npc:216474} Ravaging Tempest · {quest:79366} Heed My Call
	["{npc:5905} hands you the {item:268582}: place them at the steam pools west of {area:484} and defeat the {npc:216474} they call. {quest:79366} is an elite quest: grouping up is advised."] = "{npc:5905}會交給你{item:268582}：把它們放在{area:484}西邊的蒸氣池，擊敗它們召喚出的{npc:216474}。{quest:79366}是精英任務：建議組隊。",
	-- {item:212792} Eye of the Tempest · {npc:216474} Ravaging Tempest
	["{item:212792}, from the {npc:216474}"] = "{item:212792}，來自{npc:216474}",

	-- Step 14: Bath'rah the Windwatcher
	-- {npc:6176} Bath'rah the Windwatcher · {zone:1416} Alterac Mountains · {area:272} Tarren Mill
	["{npc:6176} camps in the east of {zone:1416}, north-east of {area:272}."] = "{npc:6176}在{zone:1416}東部、{area:272}東北方紮營。",
	-- {npc:6176} Bath'rah the Windwatcher · {item:213086} Rune of the Storm
	["{npc:6176}: the {item:213086} and your weapon"] = "{npc:6176}：{item:213086}和你的武器",
}
