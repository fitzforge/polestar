-- Korean (koKR): the guide forever/class/mage/manaweave-robe (forever/class/mage/manaweave-robe.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1453} Stormwind · {zone:1432} Loch Modan
	["A robe at 15 for Alliance mages, from {zone:1453} and {zone:1432}."] = "얼라이언스 마법사를 위한 15레벨 로브입니다. {zone:1453}와(과) {zone:1432}에서 진행합니다.",

	-- Step 1: Zaldimar Wefhellt (Goldshire)
	-- {npc:328} Zaldimar Wefhellt · {area:87} Goldshire
	["{npc:328} is the {area:87} mage trainer."] = "{npc:328}은(는) {area:87}의 마법사 상급자입니다.",

	-- Step 2: Dink (Ironforge)
	-- {npc:7312} Dink · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind
	["{npc:7312} teaches mages in {zone:1455}'s {object:32362}. Take the {area:2257} from {object:171524} to {zone:1453} afterwards."] = "{npc:7312}은(는) {zone:1455}의 {object:32362}에서 마법사를 가르칩니다. 이후 {object:171524}에서 {area:2257}을(를) 타고 {zone:1453}(으)로 가십시오.",

	-- Step 3: Jennea Cannon
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter · {item:7247} Chest of Containment Coffers · {item:7308} Cantation of Manifestation
	["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}. The {item:7247} and the {item:7308} lie behind her."] = "{npc:5497}은(는) {object:2101}의 탑인 마법사의 성소에 있습니다. {item:7247}와(과) {item:7308}은(는) 그녀 뒤에 있습니다.",

	-- Step 4: The Blue Recluse
	-- {object:2169} The Blue Recluse · {object:2101} Mage Quarter · {item:7308} Cantation of Manifestation · {npc:6492} Rift Spawn · {item:7247} Chest of Containment Coffers
	["{object:2169} is the tavern in the {object:2101}. Use the {item:7308} inside to make the {npc:6492} visible, subdue one with your spells, then use the {item:7247} to throw down a coffer and capture it."] = "{object:2169}은(는) {object:2101}의 선술집입니다. 안에서 {item:7308}을(를) 사용해 {npc:6492}을(를) 보이게 하고, 주문으로 하나를 제압한 뒤 {item:7247}을(를) 사용해 상자를 던져 포획하십시오.",

	-- Step 5: Back to Jennea Cannon
	-- {npc:5497} Jennea Cannon
	["Back to {npc:5497}"] = "{npc:5497}에게 돌아가기",

	-- Step 6: Linen Cloth
	-- {item:2589} Linen Cloth · {object:2096} Trade District
	["Humanoids drop {item:2589}; the Auction House in the {object:2096} sells it."] = "인간형 몹이 {item:2589}을(를) 떨어뜨립니다. {object:2096}의 경매장에서도 판매합니다.",

	-- Step 7: The Silver Stream Mine
	-- {area:149} Silver Stream Mine
	["The {area:149}"] = "{area:149}",
	-- {area:2257} Deeprun Tram · {zone:1455} Ironforge · {zone:1432} Loch Modan · {area:149} Silver Stream Mine
	["Take the {area:2257} to {zone:1455}, then the road east through the South Gate tunnel into {zone:1432}. The dwarven miners' league left the crates in the {area:149} at the north end of the loch; Tunnel Rat troggs hold the mine."] = "{area:2257}을(를) 타고 {zone:1455}(으)로 간 뒤, 동쪽 길을 따라 남부 관문 터널을 지나 {zone:1432}(으)로 가십시오. 드워프 광부 연맹이 호수 북쪽 끝 {area:149}에 상자를 두고 갔으며, 광산은 동굴쥐일족 트로그가 차지하고 있습니다.",

	-- Step 8: Wynne Larson
	-- {zone:1453} Stormwind · {npc:1309} Wynne Larson · {object:23296} Larson Clothiers · {object:2101} Mage Quarter
	["Back to {zone:1453} by the tram. {npc:1309} works at {object:23296} in the {object:2101}."] = "전차를 타고 {zone:1453}(으)로 돌아가십시오. {npc:1309}은(는) {object:2101}의 {object:23296}에서 일합니다.",
}
