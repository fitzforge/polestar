-- Korean (koKR): the guide forever/class/shaman/call-of-water-horde (forever/class/shaman/call-of-water-horde.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:63} Call of Water
	["{quest:63} (Horde)"] = "{quest:63} (호드)",
	-- {item:5177} Water Totem · {spell:5394} Healing Stream Totem
	["The {item:5177} that lets you place water totems, and {spell:5394} with it."] = "물의 토템을 놓게 해 주는 {item:5177}와(과), 함께 얻는 {spell:5394}입니다.",

	-- Step 1: Searn Firewarder
	-- {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom · {npc:5901} Islen Waterseer · {zone:1413} Barrens
	["At 20 {npc:5892} in the {object:172957} sends you to {npc:5901} in the {zone:1413}."] = "20레벨에 {object:172957}의 {npc:5892}이(가) {zone:1413}의 {npc:5901}에게 보냅니다.",

	-- Step 2: Xanis Flameweaver
	-- {npc:5906} Xanis Flameweaver · {zone:1456} Thunder Bluff · {npc:5901} Islen Waterseer · {zone:1413} Barrens
	["At 20 {npc:5906}, a shaman trainer in {zone:1456}, sends you to {npc:5901} in the {zone:1413}."] = "20레벨에 {zone:1456}의 주술사 상급자 {npc:5906}이(가) {zone:1413}의 {npc:5901}에게 보냅니다.",

	-- Step 3: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["{npc:5901} waits on the hill south of {area:392}."] = "{npc:5901}은(는) {area:392} 남쪽 언덕에서 기다립니다.",

	-- Step 4: Brine
	-- {npc:5899} Brine · {area:378} Camp Taurajo
	["{npc:5899}'s hut stands on the ridge above the quilboar watering hole, south of {area:378}."] = "{npc:5899}의 오두막은 {area:378} 남쪽, 가시멧돼지 물웅덩이 위 능선에 있습니다.",
	-- {item:7766} Empty Brown Waterskin
	["Fill the {item:7766} at the quilboar watering hole"] = "가시멧돼지 물웅덩이에서 {item:7766} 채우기",

	-- Step 5: The Spring Well
	-- {object:107045} Spring Well
	["The {object:107045}"] = "{object:107045}",
	-- {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {area:272} Tarren Mill · {object:107045} Spring Well
	["Take the zeppelin from {zone:1454} to {zone:1420} and travel south to {area:272}. The {object:107045} stands beside the inn."] = "{zone:1454}에서 비행선을 타고 {zone:1420}(으)로 간 뒤 남쪽 {area:272}(으)로 가십시오. {object:107045}은(는) 여관 옆에 있습니다.",
	-- {item:7768} Empty Red Waterskin · {object:107045} Spring Well
	["Fill the {item:7768} at the {object:107045}"] = "{object:107045}에서 {item:7768} 채우기",

	-- Step 7: The Ruins of Stardust
	-- {area:418} The Ruins of Stardust · {zone:1440} Ashenvale
	["The fountain stands in the middle of the {area:418}, in south-western {zone:1440}."] = "샘은 {zone:1440} 남서쪽 {area:418} 한가운데에 있습니다.",
	-- {item:7767} Empty Blue Waterskin
	["Fill the {item:7767} at the fountain"] = "샘에서 {item:7767} 채우기",

	-- Step 8: Brine
	-- {item:7810} Vial of Purest Water · {npc:5901} Islen Waterseer
	["the {item:7810}, for {npc:5901}"] = "{item:7810}, {npc:5901}에게 줄 것",

	-- Step 9: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {item:6637} Water Sapta
	["{npc:5901}: your {item:6637}"] = "{npc:5901}: {item:6637}",

	-- Step 10: The Brazier of Everfount
	-- {object:113791} Brazier of Everfount
	["The {object:113791}"] = "{object:113791}",
	-- {area:228} Sepulcher · {object:113791} Brazier of Everfount · {item:6637} Water Sapta · {npc:5894} Corrupt Minor Manifestation of Water · {npc:5895} Minor Manifestation of Water · {item:7813} Shard of Water · {npc:5901} Islen Waterseer
	["Fly to the {area:228}: the {object:113791} stands on the hill just south-west of it. Drink the {item:6637} there, beat the {npc:5894} for its bracers and place them in the brazier, then speak to the {npc:5895} and keep the {item:7813} for {npc:5901}."] = "{area:228}(으)로 비행하십시오. {object:113791}은(는) 그 바로 남서쪽 언덕에 있습니다. 그곳에서 {item:6637}을(를) 마시고, {npc:5894}을(를) 쓰러뜨려 손목보호구를 얻어 화로에 넣은 뒤, {npc:5895}와(과) 대화하고 {item:7813}은(는) {npc:5901}에게 가져가십시오.",

	-- Step 11: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {spell:5394} Healing Stream Totem · {item:5177} Water Totem
	["{npc:5901}: {spell:5394} and your {item:5177}"] = "{npc:5901}: {spell:5394} 및 {item:5177}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The fountain stands in the middle of the {area:418}, in south-western {zone:1440}."] = "샘은 {zone:1440} 남서쪽 {area:418} 한가운데에 있습니다.",
}
