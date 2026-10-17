-- Chinese (traditional) (zhTW): the guide forever/class/paladin/lumina-windsinger (forever/class/paladin/lumina-windsinger.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:91862} Lumina Windsinger
	["Rescuing {quest:91862}"] = "營救{quest:91862}",
	-- {item:268484} Moonsilver Blade
	["No item yet: a Forsaken paladin rescue story; its sequel, the {item:268484}, cannot be finished yet."] = "目前沒有物品：一段被遺忘者聖騎士的救援故事；它的續篇{item:268484}目前還無法完成。",
	-- {zone:1458} Undercity
	["{zone:1458} and Earthen Ring reputation"] = "{zone:1458}與陶土議會聲望",

	-- Step 1: Danitha Morr
	-- {npc:246378} Danitha Morr · {area:16602} Bandarion Keep · {area:156} Solliden Farmstead
	["{npc:246378} leads the Paladins of Tyr's Watch from inside {area:16602}, on the bluffs north-west of the {area:156}."] = "{npc:246378}在{area:156}西北方崖頂上的{area:16602}內領導 Tyr's Watch 的聖騎士。",

	-- Step 2: The Sepulcher
	-- {zone:1421} Silverpine Forest · {area:228} The Sepulcher · {npc:248840} Trevan Rol · {npc:259611} Deathguard Baldren
	["Ride south through {zone:1421} to the {area:228}. {npc:248840} stands in the town; {npc:259611} keeps watch near its entrance."] = "向南騎過{zone:1421}前往{area:228}。{npc:248840}站在鎮上；{npc:259611}在入口附近守望。",

	-- Step 3: The pyre on Fenris Isle
	-- {area:172} Fenris Isle
	["The pyre on {area:172}"] = "{area:172}上的火葬堆",
	-- {area:172} Fenris Isle · {area:228} The Sepulcher
	["{area:172} lies in the lake east of the {area:228}. The charred remains are on its shore."] = "{area:172}位於{area:228}東邊的湖中。燒焦的遺骸就在島的岸邊。",
	-- {object:566037} Charred Remains (no name in this language: may be words)
	["from the {object:566037}"] = "來自{object:566037}",

	-- Step 4: Fenris Keep
	-- {quest:91862} Lumina Windsinger · {area:235} Fenris Keep
	["{quest:91862} is caged inside {area:235}, at the north end of the isle. The Rot Hide gnolls around her carry the key."] = "{quest:91862}被關在島北端的{area:235}裡。她周圍的腐皮豺狼人身上帶著鑰匙。",
	-- {item:267412} Fenris Isle Key
	["{item:267412}, from the Rot Hide gnolls"] = "{item:267412}，來自腐皮豺狼人",

	-- Step 5: Free Lumina Windsinger
	-- {npc:248755} Lumina Windsinger
	["Free {npc:248755}"] = "救出{npc:248755}",
	["Free her with the key, then stay close while she fights her way out of the keep."] = "用鑰匙救出她，然後在她殺出要塞時待在她身邊。",

	-- Step 6: Back to the The Sepulcher
	-- {area:228} The Sepulcher
	["Back to the {area:228}"] = "返回{area:228}",
	-- {area:235} Fenris Keep · {npc:259620} Lumina Windsinger · {area:228} The Sepulcher
	["Once she is clear of {area:235}, {npc:259620} waits for you in the {area:228}. Speak with her again to hear what really happened on the road."] = "一旦她離開了{area:235}，{npc:259620}會在{area:228}等你。再次與她交談，聽聽路上到底發生了什麼事。",
	-- {npc:259620} Lumina Windsinger · {area:228} The Sepulcher
	["{npc:259620}, the {area:228}"] = "{npc:259620}，{area:228}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the {area:228}"] = "返回{area:228}",
	-- ["Once she is clear of {area:235}, Lumina waits for you in the {area:228}. Speak with her again to hear what really happened on the road."] = "一旦她離開了{area:235}，露蜜娜會在{area:228}等你。再次與她交談，聽聽路上到底發生了什麼事。",
	-- ["Ride south through {zone:1421} to the {area:228}. {npc:248840} stands in the town; {npc:259611} keeps watch near its entrance."] = "向南騎過{zone:1421}前往{area:228}。{npc:248840}站在鎮上；{npc:259611}在入口附近守望。",
	-- ["{area:172} lies in the lake east of the {area:228}. The charred remains are on its shore."] = "{area:172}位於{area:228}東邊的湖中。燒焦的遺骸就在島的岸邊。",
	-- ["{npc:259620}, the {area:228}"] = "{npc:259620}，{area:228}",
}
