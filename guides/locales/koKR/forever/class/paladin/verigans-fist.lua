-- Korean (koKR): the guide forever/class/paladin/verigans-fist (forever/class/paladin/verigans-fist.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["The Alliance paladin's rare two-handed mace for the 20s, with a shield on the way."] = "20대 얼라이언스 성기사용 희귀 양손 둔기, 도중에 방패도 얻습니다.",

	-- Step 1: The Tome of Valor (Ironforge)
	-- {npc:6179} Tiza Battleforge · {object:32362} Mystic Ward (no name in this language: may be words) · {item:6776} Tome of Valor · {npc:6171} Duthorian Rall · {zone:1453} Stormwind · {zone:1455} Ironforge
	["At 20 {npc:6179} in the {object:32362} gives you the {item:6776}; it sends you to {npc:6171} in {zone:1453}'s Cathedral of Light. Take the tram from {zone:1455} to {zone:1453}."] = "20레벨에 {object:32362}의 {npc:6179}이(가) {item:6776}을(를) 줍니다. 이것은 {zone:1453} 빛의 대성당의 {npc:6171}에게 보냅니다. {zone:1455}에서 지하철을 타고 {zone:1453}(으)로 가세요.",

	-- Step 2: The Tome of Valor
	-- {npc:6171} Duthorian Rall · {item:6776} Tome of Valor
	["{npc:6171} stands in the Cathedral of Light. Right-click the {item:6776} to start its quest."] = "{npc:6171}은(는) 빛의 대성당에 서 있습니다. {item:6776}을(를) 오른쪽 클릭해 퀘스트를 시작하세요.",
	-- {item:6776} Tome of Valor
	["from the {item:6776}"] = "{item:6776}에서",

	-- Step 3: Daphne Stilwell
	-- {npc:6182} Daphne Stilwell · {zone:1436} Westfall
	["{npc:6182}'s farmhouse stands on the south-west coast of {zone:1436}. Waves of Defias attack it during her quest: keep her alive, and heal her if she needs it."] = "{npc:6182}의 농가는 {zone:1436} 남서쪽 해안에 있습니다. 그녀의 퀘스트 동안 데피아즈단이 여러 차례 공격해 옵니다. 그녀를 살려두고 필요하면 치유하세요.",
	-- {npc:6182} Daphne Stilwell
	["Protect {npc:6182}"] = "{npc:6182} 보호",

	-- Step 5: Jordan Stilwell
	-- {npc:6181} Jordan Stilwell · {zone:1455} Ironforge · {item:6996} Jordan's Weapon Notes
	["{npc:6181} stands outside the gates of {zone:1455}. He gives you {item:6996}, which list the four parts."] = "{npc:6181}은(는) {zone:1455} 성문 밖에 서 있습니다. 그가 네 가지 부품이 적힌 {item:6996}을(를) 줍니다.",

	-- Step 6: Bailor Stonehand
	-- {npc:6241} Bailor Stonehand · {area:144} Thelsamar
	["{npc:6241} is in {area:144}."] = "{npc:6241}은(는) {area:144}에 있습니다.",

	-- Step 7: Bailor's Ore
	-- {zone:1432} Loch Modan
	["The ore crate lies by the trees in the middle of the Mo'grosh ogre camp in north-east {zone:1432}. The Mo'grosh ogres are elite: grouping up is advised."] = "광석 상자는 {zone:1432} 북동쪽 모그로쉬 오우거 야영지 한가운데의 나무 옆에 있습니다. 모그로쉬 오우거는 정예이니 파티를 권장합니다.",
	-- {object:92420} Bailor's Ore
	["{object:92420} crate"] = "{object:92420} 상자",

	-- Step 8: Back to Bailor Stonehand
	-- {npc:6241} Bailor Stonehand
	["Back to {npc:6241}"] = "{npc:6241}에게 돌아가기",
	-- {npc:6241} Bailor Stonehand · {item:6993} Jordan's Refined Ore Shipment
	["{npc:6241} turns the ore into {item:6993}."] = "{npc:6241}이(가) 광석을 {item:6993}(으)로 만들어 줍니다.",

	-- Step 9: Whitestone Oak Lumber
	-- {area:1581} The Deadmines · {area:20} Moonbrook
	-- plural, as words: Goblin Woodcarvers = {npc:641} Goblin Woodcarver
	["{area:1581} is a group of five under {area:20}; the instance portal is inside the {area:20} mine. The Goblin Woodcarvers in the Mast Room, with Sneed, drop the lumber."] = "{area:1581}은(는) {area:20} 아래의 5인 던전입니다. 던전 입구는 {area:20} 광산 안에 있습니다. 스니드와 함께 돛대 방에 있는 고블린 목공이 목재를 떨어뜨립니다.",
	-- {area:1581} The Deadmines · {area:20} Moonbrook
	["{area:1581}, in the {area:20} mine"] = "{area:1581}, {area:20} 광산 안",
	-- plural, as words: Goblin Woodcarvers = {npc:641} Goblin Woodcarver
	["Goblin Woodcarvers, inside"] = "고블린 목공, 던전 안",

	-- Step 10: Jordan's Smithing Hammer
	-- {area:236} Shadowfang Keep · {zone:1421} Silverpine Forest
	["{area:236} is a level 20-30 dungeon in southern {zone:1421}. The hammer lies on a box inside the stables, at the far end of the courtyard before the ramp up."] = "{area:236}은(는) {zone:1421} 남부의 20-30레벨 던전입니다. 망치는 안뜰 끝, 오르막길 앞 마구간 안의 상자 위에 있습니다.",
	-- {object:91138} Jordan's Hammer
	["{object:91138}, inside"] = "{object:91138}, 던전 안",

	-- Step 11: Thundris Windweaver
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["{npc:3649} is in {area:442}."] = "{npc:3649}은(는) {area:442}에 있습니다.",

	-- Step 12: The Corrupted Kor Gem
	-- {item:6995} Corrupted Kor Gem
	["The {item:6995}"] = "{item:6995}",
	-- {area:2797} Blackfathom Deeps · {zone:1440} Ashenvale · {item:6995} Corrupted Kor Gem
	["The Blackfathom naga by the entrance of {area:2797} on {zone:1440}'s north-west coast drop the {item:6995}. They are elite: grouping up is advised."] = "{zone:1440} 북서쪽 해안 {area:2797} 입구 옆의 검은심연 나가가 {item:6995}을(를) 떨어뜨립니다. 정예이니 파티를 권장합니다.",

	-- Step 13: The Purified Kor Gem
	-- {item:7083} Purified Kor Gem
	["The {item:7083}"] = "{item:7083}",
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["Back to {npc:3649} in {area:442}: he purifies the gem."] = "{area:442}의 {npc:3649}에게 돌아가세요. 그가 보석을 정화합니다.",

	-- Step 14: Verigan's Fist
	-- {npc:6181} Jordan Stilwell · {zone:1455} Ironforge
	["Bring the four parts to {npc:6181} outside {zone:1455}."] = "네 가지 부품을 {zone:1455} 밖의 {npc:6181}에게 가져가세요.",
}
