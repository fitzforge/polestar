-- Chinese (simplified) (zhCN): the guide forever/class/shaman/call-of-water-alliance (forever/class/shaman/call-of-water-alliance.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:94494} Call of Water
	["{quest:94494} (Alliance)"] = "{quest:94494}（联盟）",
	-- {item:5177} Water Totem · {spell:5394} Healing Stream Totem
	["The {item:5177} that lets you place water totems, and {spell:5394} with it."] = "让你能放置水图腾的{item:5177}，以及随之而来的{spell:5394}。",

	-- Step 1: Eldrun Stormbreaker
	-- {npc:258098} Eldrun Stormbreaker · {zone:1455} Ironforge · {npc:258043} Norric Lochthane · {zone:1432} Loch Modan
	["At 20 {npc:258098}, the shaman trainer in {zone:1455}, sends you to {npc:258043} in {zone:1432}."] = "20级时，{zone:1455}的萨满祭司训练师{npc:258098}会让你去{zone:1432}找{npc:258043}。",

	-- Step 2: Norric Lochthane
	-- {npc:258043} Norric Lochthane · {area:146} Stonewrought Dam
	["{npc:258043}'s burrow hut stands on the north-western edge of the loch, south of {area:146}."] = "{npc:258043}的地洞小屋位于湖的西北边缘，{area:146}南边。",

	-- Step 3: Hervdana Saegrund
	-- {npc:258203} Hervdana Saegrund · {zone:1437} Wetlands
	["{npc:258203}'s family lives in a cave beneath the southern falls of the {zone:1437}."] = "{npc:258203}的家人住在{zone:1437}南部瀑布下方的一个洞穴里。",

	-- Step 4: The brown waterskin
	["The brown waterskin"] = "棕色水袋",
	-- {item:265732} Unfilled Brown Waterskin · {npc:258203} Hervdana Saegrund
	["Fill the {item:265732} at the bottom of the waterfalls below {npc:258203}'s cave, where the fresh water meets the brackish."] = "在{npc:258203}的洞穴下方瀑布底部、淡水与咸水交汇处装满{item:265732}。",

	-- Step 6: The red waterskin
	["The red waterskin"] = "红色水袋",
	-- {area:71} Stonewatch Falls · {area:68} Lake Everstill · {item:265747} Unfilled Red Waterskin
	-- plural, as words: Murloc Nightcrawlers = {npc:544} Murloc Nightcrawler
	["{area:71} pour out of {area:68} at the east end of Redridge. Fill the {item:265747} at their foot, where the Murloc Nightcrawlers gather."] = "{area:71}从赤脊山东端的{area:68}倾泻而下。在瀑布脚下{npc:544}聚集的地方装满{item:265747}。",

	-- Step 8: The blue waterskin
	["The blue waterskin"] = "蓝色水袋",
	-- {npc:258203} Hervdana Saegrund · {area:150} Menethil Harbor · {area:442} Auberdine · {area:271} Southshore · {area:415} Astranaar · {item:265772} Unfilled Blue Waterskin
	["{npc:258203}: take the boat from {area:150} to {area:442} (it stops in {area:271} on the way), then go south to {area:415}. Fill the {item:265772} in the lake around the town."] = "{npc:258203}：从{area:150}乘船前往{area:442}（途中停靠{area:271}），然后向南前往{area:415}。在镇子周围的湖里装满{item:265772}。",

	-- Step 9: Hervdana Saegrund
	-- {item:7810} Vial of Purest Water · {npc:258043} Norric Lochthane
	["the {item:7810}, for {npc:258043}"] = "{item:7810}，交给{npc:258043}",

	-- Step 10: Norric Lochthane
	-- {npc:258043} Norric Lochthane · {item:6637} Water Sapta
	["{npc:258043}: your {item:6637}"] = "{npc:258043}：你的{item:6637}",

	-- Step 11: Stendel's Pond
	-- {area:919} Stendel's Pond · {area:20} Moonbrook · {item:6637} Water Sapta · {npc:5894} Corrupt Minor Manifestation of Water · {item:7811} Remaining Drops of Purest Water · {object:619896} Forgotten Shrine · {npc:5895} Minor Manifestation of Water · {item:7813} Shard of Water
	["{area:919} lies outside {area:20}. Drink the {item:6637} there and defeat the {npc:5894} for its bracers, then place them and the {item:7811} on the {object:619896}. The {npc:5895} it calls forth gives you the {item:7813}."] = "{area:919}位于{area:20}外面。在那里喝下{item:6637}，击败{npc:5894}拿到它的护腕，然后把护腕和{item:7811}放在{object:619896}上。被召唤出来的{npc:5895}会给你{item:7813}。",
	-- {npc:5895} Minor Manifestation of Water
	["{npc:5895}, at the shrine"] = "{npc:5895}，在神龛处",

	-- Step 12: Norric Lochthane
	-- {npc:258043} Norric Lochthane · {spell:5394} Healing Stream Totem · {item:5177} Water Totem
	["{npc:258043}: {spell:5394} and your {item:5177}"] = "{npc:258043}：{spell:5394}和你的{item:5177}",
}
