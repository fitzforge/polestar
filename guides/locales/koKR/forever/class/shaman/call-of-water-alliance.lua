-- Korean (koKR): the guide forever/class/shaman/call-of-water-alliance (forever/class/shaman/call-of-water-alliance.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:94494} Call of Water
	["{quest:94494} (Alliance)"] = "{quest:94494}(얼라이언스)",
	-- {item:5177} Water Totem · {spell:5394} Healing Stream Totem
	["The {item:5177} that lets you place water totems, and {spell:5394} with it."] = "물 토템을 놓을 수 있게 해 주는 {item:5177}, 그리고 함께 받는 {spell:5394}.",

	-- Step 1: Eldrun Stormbreaker
	-- {npc:258098} Eldrun Stormbreaker · {zone:1455} Ironforge · {npc:258043} Norric Lochthane · {zone:1432} Loch Modan
	["At 20 {npc:258098}, the shaman trainer in {zone:1455}, sends you to {npc:258043} in {zone:1432}."] = "20레벨에 {zone:1455}의 주술사 상급자 {npc:258098}이(가) {zone:1432}의 {npc:258043}에게 보냅니다.",

	-- Step 2: Norric Lochthane
	-- {npc:258043} Norric Lochthane · {area:146} Stonewrought Dam
	["{npc:258043}'s burrow hut stands on the north-western edge of the loch, south of {area:146}."] = "{npc:258043}의 굴 오두막은 호수 북서쪽 가장자리, {area:146} 남쪽에 있습니다.",

	-- Step 3: Hervdana Saegrund
	-- {npc:258203} Hervdana Saegrund · {zone:1437} Wetlands
	["{npc:258203}'s family lives in a cave beneath the southern falls of the {zone:1437}."] = "{npc:258203}의 가족은 {zone:1437} 남쪽 폭포 아래 동굴에 삽니다.",

	-- Step 4: The brown waterskin
	["The brown waterskin"] = "갈색 물주머니",
	-- {item:265732} Unfilled Brown Waterskin · {npc:258203} Hervdana Saegrund
	["Fill the {item:265732} at the bottom of the waterfalls below {npc:258203}'s cave, where the fresh water meets the brackish."] = "{npc:258203}의 동굴 아래 폭포 밑, 민물과 바닷물이 만나는 곳에서 {item:265732}을(를) 채우십시오.",

	-- Step 6: The red waterskin
	["The red waterskin"] = "붉은 물주머니",
	-- {area:71} Stonewatch Falls · {area:68} Lake Everstill · {item:265747} Unfilled Red Waterskin
	-- plural, as words: Murloc Nightcrawlers = {npc:544} Murloc Nightcrawler
	["{area:71} pour out of {area:68} at the east end of Redridge. Fill the {item:265747} at their foot, where the Murloc Nightcrawlers gather."] = "{area:71}은(는) 붉은마루 동쪽 끝의 {area:68}에서 쏟아져 내립니다. {npc:544}이(가) 모여 있는 폭포 아래에서 {item:265747}을(를) 채우세요.",

	-- Step 8: The blue waterskin
	["The blue waterskin"] = "파란 물주머니",
	-- {npc:258203} Hervdana Saegrund · {area:150} Menethil Harbor · {area:442} Auberdine · {area:271} Southshore · {area:415} Astranaar · {item:265772} Unfilled Blue Waterskin
	["{npc:258203}: take the boat from {area:150} to {area:442} (it stops in {area:271} on the way), then go south to {area:415}. Fill the {item:265772} in the lake around the town."] = "{npc:258203}: {area:150}에서 배를 타고 {area:442}(으)로 간 뒤(도중에 {area:271}에 들릅니다), 남쪽의 {area:415}(으)로 가십시오. 마을을 둘러싼 호수에서 {item:265772}을(를) 채우십시오.",

	-- Step 9: Hervdana Saegrund
	-- {item:7810} Vial of Purest Water · {npc:258043} Norric Lochthane
	["the {item:7810}, for {npc:258043}"] = "{item:7810}, {npc:258043}에게 줄 것",

	-- Step 10: Norric Lochthane
	-- {npc:258043} Norric Lochthane · {item:6637} Water Sapta
	["{npc:258043}: your {item:6637}"] = "{npc:258043}: {item:6637}",

	-- Step 11: Stendel's Pond
	-- {area:919} Stendel's Pond · {area:20} Moonbrook · {item:6637} Water Sapta · {npc:5894} Corrupt Minor Manifestation of Water · {item:7811} Remaining Drops of Purest Water · {object:619896} Forgotten Shrine · {npc:5895} Minor Manifestation of Water · {item:7813} Shard of Water
	["{area:919} lies outside {area:20}. Drink the {item:6637} there and defeat the {npc:5894} for its bracers, then place them and the {item:7811} on the {object:619896}. The {npc:5895} it calls forth gives you the {item:7813}."] = "{area:919}은(는) {area:20} 외곽에 있습니다. 그곳에서 {item:6637}을(를) 마시고 {npc:5894}을(를) 처치해 손목보호구를 얻은 뒤, 그것과 {item:7811}을(를) {object:619896}에 놓으십시오. 나타난 {npc:5895}이(가) {item:7813}을(를) 줍니다.",
	-- {npc:5895} Minor Manifestation of Water
	["{npc:5895}, at the shrine"] = "{npc:5895}, 제단에서",

	-- Step 12: Norric Lochthane
	-- {npc:258043} Norric Lochthane · {spell:5394} Healing Stream Totem · {item:5177} Water Totem
	["{npc:258043}: {spell:5394} and your {item:5177}"] = "{npc:258043}: {spell:5394}과(와) {item:5177}",
}
