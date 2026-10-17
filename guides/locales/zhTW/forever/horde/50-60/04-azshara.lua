-- Chinese (traditional) (zhTW): the guide forever/horde/50-60/04-azshara (forever/horde/50-60/04-azshara.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Orgrimmar
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow
	["{npc:8659}, the {object:172960}"] = "{npc:8659}，{object:172960}",
	-- {npc:15188} Cenarion Emissary Blackhoof · {object:172957} Valley of Wisdom · {zone:1451} Silithus
	["{npc:15188}, {object:172957}: keep it for {zone:1451}"] = "{npc:15188}，{object:172957}：保留給{zone:1451}",

	-- Step 2: Fly to the Crossroads
	-- {area:380} Crossroads
	["Fly to the {area:380}"] = "飛往{area:380}",

	-- Step 3: Dokimi's crates
	-- {npc:256386} Dokimi
	["{npc:256386}'s crates"] = "{npc:256386}的箱子",
	-- {npc:256386} Dokimi · {area:380} Crossroads
	["{npc:256386} stands in the {area:380}. Open each crate she hands you and bring back what is inside."] = "{npc:256386}站在{area:380}。打開她交給你的每個箱子，把裡面的東西帶回來。",

	-- Step 4: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "飛往{area:392}",

	-- Step 5: Liv Rizzlefix
	-- {area:392} Ratchet · {object:149036} Marvon's Chest
	["Liv's workshop is at the north end of {area:392}'s docks; {object:149036} stands inside it."] = "莉芙的工作室在{area:392}碼頭北端；{object:149036}就在裡面。",

	-- Step 6: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["{npc:5901} camps on the shore just north of {area:392}."] = "{npc:5901}在{area:392}北邊不遠處的岸邊紮營。",
	-- {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Cleansed Water goes to the {area:2479} in {zone:1448}: keep it for later."] = "淨化過的水要送到{zone:1448}的{area:2479}：保留到稍後。",

	-- Step 7: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "飛往{area:1637}",

	-- Step 8: Vehena
	-- {object:172961} Valley of Spirits
	["In the {object:172961}. Have the Wool, Silk and Mageweave in your bags."] = "在{object:172961}。背包裡要有毛料、絲綢和魔紋布。",

	-- Step 9: Rashona Straglash
	-- {object:172958} Valley of Honor
	["In the {object:172958}."] = "在{object:172958}。",
	-- {item:14047} Runecloth
	["Both {item:14047} donations are handed in later in the route: start saving {item:14047}."] = "兩個{item:14047}捐獻都在路線稍後繳交：開始存{item:14047}。",

	-- Step 10: Fly to Valormok
	-- {area:1237} Valormok
	["Fly to {area:1237}"] = "飛往{area:1237}",

	-- Step 12: Ruins of Eldarath
	["Ride east to the ruins on the coast. Fill Cuely's four vials at the tide pools along the shore; Spitelash naga patrol between them."] = "向東騎往海岸上的遺跡。在沿岸的潮池裝滿科雷的四個瓶子；惡鞭納迦在潮池之間巡邏。",

	-- Step 13: Thalassian Base Camp
	-- {area:1227} Bay of Storms
	["The blood elves camp on the cliffs in the north-east, by the {area:1227}."] = "血精靈在東北方{area:1227}旁的懸崖上紮營。",

	-- Step 14: Magus Rimtori's camp
	-- {npc:8578} Magus Rimtori
	["{npc:8578}'s camp"] = "{npc:8578}的營地",
	-- {object:151286} Kaldorei Tome of Summoning (no name in this language: may be words)
	["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there, then kill the Magus."] = "雷姆托里的營地在基地營的東端。閱讀那裡的{object:151286}，然後殺死法師。",

	-- Step 15: Ag'tor Bloodfist
	-- {area:1237} Valormok
	["Ride back west to {area:1237}."] = "向西騎回{area:1237}。",

	-- Step 16: Belgrom Rockmaul
	-- {area:1637} Orgrimmar · {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor
	["Fly to {area:1637}; {npc:4485} is in the {object:172958}."] = "飛往{area:1637}；{npc:4485}在{object:172958}。",

	-- Step 17: Zeppelin to the Undercity
	-- {zone:1458} Undercity
	["Zeppelin to the {zone:1458}"] = "搭飛艇前往{zone:1458}",
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity
	["The zeppelin tower stands just north-east of {zone:1454}'s main gate; take the {zone:1458} zeppelin."] = "飛艇塔就在{zone:1454}正門東北方不遠處；搭乘前往{zone:1458}的飛艇。",
	["Zeppelin tower"] = "飛艇塔",

	-- Step 18: The Apothecarium
	-- {npc:8393} Thersa Windsong
	["{npc:8393}, beside him"] = "{npc:8393}，在他旁邊",

	-- Step 19: Royal Quarter
	-- {npc:8403} Jeremiah Payson
	["{npc:8403}, nearby"] = "{npc:8403}，在附近",
	-- {quest:5050} Good Luck Charm · {npc:10778} Janice Felstone · {zone:1422} Western Plaguelands
	["{quest:5050} goes back to {npc:10778} in the {zone:1422}: keep it."] = "{quest:5050}要交回給{zone:1422}的{npc:10778}：保留此任務。",

	-- Step 21: Prompt Potion Runner
	-- {npc:11044} Doctor Martin Felben
	["{npc:11044}, in the Apothecarium"] = "{npc:11044}，在 Apothecarium",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Open {object:149036} for the {item:10556}"] = "打開{object:149036}取得{item:10556}",
}
