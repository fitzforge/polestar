-- Korean (koKR): the guide forever/reputation/hydraxian-waterlords (forever/reputation/hydraxian-waterlords.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Hydraxian Waterlords Reputation"] = "히드락시안 물의 군주 평판",

	-- Step 1: Duke Hydraxis
	-- {npc:13278} Duke Hydraxis · {zone:1447} Azshara · {faction:749} Hydraxian Waterlords
	["{npc:13278} stands on a small island off the eastern coast of {zone:1447}; swim or walk the shallows out to him. The {faction:749} start out Neutral. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:13278}은(는) {zone:1447} 동쪽 해안 앞 작은 섬에 서 있습니다. 헤엄치거나 얕은 물을 걸어 가세요. {faction:749}은(는) 중립에서 시작합니다. Forever의 외교관 유산 특전은 평판 획득량을 늘려 줍니다.",

	-- Step 2: Dust Stormers and Desert Rumblers
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler
	["Dust Stormers and Desert Rumblers"] = "{npc:11744}와(과) {npc:11746}",
	-- {zone:1451} Silithus
	["Both elementals roam north-western {zone:1451}; the Rumblers cluster a little further north."] = "두 정령 모두 {zone:1451} 북서부를 돌아다닙니다. 우레의 모래정령은 조금 더 북쪽에 모여 있습니다.",

	-- Step 3: Poisoned Water
	-- {item:17310} Aspect of Neptulon · {zone:1423} Eastern Plaguelands · {item:17309} Discordant Bracers
	["Use the {item:17310} on the poisoned water elementals of {zone:1423}, then loot their {item:17309} (12)."] = "{zone:1423}의 오염된 물의 정령에게 {item:17310}을(를) 사용한 뒤 {item:17309}(12)을(를) 획득하세요.",

	-- Step 4: Back to Duke Hydraxis
	-- {npc:13278} Duke Hydraxis
	["Back to {npc:13278}"] = "{npc:13278}에게 돌아가기",

	-- Step 5: Eye of the Emberseer
	-- {npc:9816} Pyroguard Emberseer · {quest:6821} Eye of the Emberseer
	["{npc:9816} in Upper Blackrock Spire drops the {quest:6821}. This needs a raid group."] = "검은바위 첨탑 상층의 {npc:9816}이(가) {quest:6821}을(를) 떨어뜨립니다. 공격대가 필요합니다.",

	-- Step 6: The Molten Core
	-- {npc:11668} Firelord · {npc:11658} Molten Giant · {npc:11673} Ancient Core Hound · {npc:12101} Lava Surger · {area:2717} Molten Core
	["Kill a {npc:11668}, a {npc:11658}, an {npc:11673} and a {npc:12101} in the {area:2717}. Every {area:2717} elemental and boss also counts toward the Waterlords."] = "{area:2717}에서 {npc:11668}, {npc:11658}, {npc:11673}, {npc:12101}을(를) 하나씩 처치하세요. {area:2717}의 모든 정령과 우두머리도 물의 군주 평판에 반영됩니다.",

	-- Step 7: Agent of Hydraxis
	-- {quest:6823} Agent of Hydraxis · {npc:13278} Duke Hydraxis · {item:17333} Aqual Quintessence · {area:2717} Molten Core · {npc:12018} Majordomo Executus · {item:22754} Eternal Quintessence
	["{quest:6823} needs Honored. At Honored, {npc:13278} hands out {item:17333}, used to douse the runes in the {area:2717} that summon {npc:12018}; at Revered, the reusable {item:22754}."] = "{quest:6823}에는 우호적이 필요합니다. 우호적이 되면 {npc:13278}이(가) {area:2717}에서 {npc:12018}을(를) 소환하는 룬을 끄는 데 쓰는 {item:17333}을(를) 주고, 매우 우호적이 되면 재사용 가능한 {item:22754}을(를) 줍니다.",

	-- Step 8: Hands of the Enemy
	-- {area:2717} Molten Core
	["Bring the Hands of Lucifron, Gehennas, Shazzrah and Sulfuron from the {area:2717}."] = "{area:2717}에서 루시프론의 손, 게헨나스의 손, 샤즈라의 손, 설퍼론의 손을 가져오세요.",

	-- Step 9: Hydraxian Waterlords to Revered
	-- {faction:749} Hydraxian Waterlords
	["{faction:749} to Revered"] = "{faction:749}: 매우 우호적까지",
	-- {area:2717} Molten Core
	["{area:2717} clears carry the rest. Bosses always count; in Classic, trash kills stop giving Waterlords reputation partway up, so late on the bosses do the work."] = "나머지는 {area:2717} 공략으로 채웁니다. 우두머리는 항상 반영되지만, 클래식에서는 일반 몹 처치가 중간부터 물의 군주 평판을 주지 않으므로 후반에는 우두머리가 평판을 책임집니다.",

	-- Step 10: Hydraxian Waterlords to Exalted
	-- {faction:749} Hydraxian Waterlords
	["{faction:749} to Exalted"] = "{faction:749}: 확고한 동맹까지",
	-- {area:2717} Molten Core
	["Keep clearing the {area:2717} until Exalted."] = "확고한 동맹이 될 때까지 {area:2717}을(를) 계속 공략하세요.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Use the {item:17310} on the poisoned water elementals of {zone:1423}, then loot their {item:17309} (12). Our data has no spawn points for those elementals."] = "{zone:1423}의 오염된 물의 정령에게 {item:17310}을(를) 사용한 뒤 {item:17309}(12)을(를) 획득하세요. 그 정령들의 생성 위치는 데이터에 없습니다.",
}
