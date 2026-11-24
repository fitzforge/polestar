-- Korean (koKR): the guide forever/class/mage/manaweave-robe (forever/class/mage/manaweave-robe.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	["{npc:328} is the {area:87} mage trainer, upstairs in the Lion's Pride Inn."] = "{npc:328}은(는) {area:87}의 마법사 상급자로, 사자무리 여관 위층에 있습니다.",

	-- Step 2: Dink (Ironforge)
	-- {npc:7312} Dink · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind
	["{npc:7312} teaches mages in {zone:1455}'s {object:32362}. Take the {area:2257} from {object:171524} to {zone:1453} afterwards."] = "{npc:7312}은(는) {zone:1455}의 {object:32362}에서 마법사를 가르칩니다. 이후 {object:171524}에서 {area:2257}을(를) 타고 {zone:1453}(으)로 가십시오.",

	-- Step 3: Jennea Cannon
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter · {item:7247} Chest of Containment Coffers · {item:7308} Cantation of Manifestation
	["{npc:5497} stands at the top of the Wizard's Sanctum, the violet tower of the {object:2101}: climb the spiral ramp and take the portal near the top. The {item:7247} and the {item:7308} lie on the table behind her (both come back 5 minutes after someone takes them). You hand both in at the end, so keep them."] = "{npc:5497}은(는) 마법사 성소, {object:2101}의 보라색 탑 꼭대기에 있습니다. 나선 경사로를 올라 꼭대기 근처 차원문을 타세요. {item:7247}과(와) {item:7308}은(는) 그녀 뒤 탁자에 있습니다(누군가 가져가면 5분 후 다시 나옵니다). 둘 다 마지막에 제출하니 보관하세요.",

	-- Step 4: The Blue Recluse
	-- {object:2169} The Blue Recluse · {object:2101} Mage Quarter · {item:7308} Cantation of Manifestation · {spell:122} Frost Nova · {item:7247} Chest of Containment Coffers · {item:7292} Filled Containment Coffer
	-- plural, as words: Rift Spawns = {npc:6492} Rift Spawn
	["{object:2169} is the tavern in the {object:2101}. Read the {item:7308} inside to make the invisible Rift Spawns (level 16-17) show: in the basement it brings out one, on the balcony or in the kitchen two, in the main room or by the door three, so read it downstairs. They hit hard and break out of {spell:122} fast. Beat one down: it does not die but sits stunned with a spiral over its head; use the {item:7247} on it while it is stunned, then click the {item:7292} it leaves on the floor (clicking before it appears wastes a charge). You need three, and the cantation works only once every 5 minutes (logging out does not reset it), so plan on three rounds."] = "{object:2169}은(는) {object:2101}의 술집입니다. 안에서 {item:7308}을(를) 읽으면 보이지 않는 균열 마귀(16-17레벨)가 드러납니다. 지하에서는 한 마리, 발코니나 부엌에서는 두 마리, 홀이나 문가에서는 세 마리가 나오니 아래에서 읽으세요. 아주 강하고 {spell:122}을(를) 빨리 깨뜨립니다. 하나를 쓰러뜨리면 죽지 않고 머리에 소용돌이가 생긴 채 기절합니다. 기절한 동안 {item:7247}을(를) 사용하고 바닥에 남는 {item:7292}을(를) 클릭하세요(나타나기 전에 클릭하면 충전 횟수만 낭비합니다). 세 개가 필요하고 주문은 5분에 한 번만 통하며 로그아웃해도 초기화되지 않으니 세 번을 계획하세요.",
	-- {npc:6492} Rift Spawn
	["{npc:6492}, down to the stun"] = "{npc:6492}, 기절할 때까지",
	-- {item:7247} Chest of Containment Coffers · {npc:6492} Rift Spawn
	["{item:7247}, on the stunned {npc:6492}"] = "{item:7247}, 기절한 {npc:6492}에게",

	-- Step 5: Back to Jennea Cannon
	-- {npc:5497} Jennea Cannon
	["Back to {npc:5497}"] = "{npc:5497}에게 돌아가기",

	-- Step 6: Linen Cloth
	-- {item:2589} Linen Cloth · {area:149} Silver Stream Mine · {object:2096} Trade District
	["Any humanoid drops {item:2589}, and the Tunnel Rats in the {area:149} drop it while you gather the gems; the Auction House in the {object:2096} sells it. You hand in ten."] = "모든 인간형이 {item:2589}을(를) 떨어뜨리며, 광석을 캘 때 {area:149}의 굴 쥐들이 떨어뜨립니다. {object:2096}의 경매장에서도 팝니다. 열 개를 제출하세요.",
	-- {item:2589} Linen Cloth
	["{item:2589}: humanoids, or the Auction House"] = "{item:2589}: 인간형 몹 또는 경매장",

	-- Step 7: The Silver Stream Mine
	-- {area:149} Silver Stream Mine
	["The {area:149}"] = "{area:149}",
	-- {area:2257} Deeprun Tram · {zone:1455} Ironforge · {zone:1432} Loch Modan · {area:149} Silver Stream Mine · {area:144} Thelsamar · {object:271} Miners' League Crates
	["Take the {area:2257} to {zone:1455}, then the road east through the South Gate tunnel into {zone:1432}. The {area:149} is at the north end of the loch, north of {area:144}; Tunnel Rat kobolds hold it. The gems come only from the tall stacked {object:271} (the cursor shows a cog over them; single boxes hold nothing): every crate gives one, there are fourteen and they come back after 3 to 5 minutes. You may have to go as deep as the end chamber for six. The same crates serve the dwarves' Filthy Paws quest."] = "{area:2257}을(를) 타고 {zone:1455}로 간 뒤 남문 터널을 지나 동쪽 도로로 {zone:1432}에 들어가세요. {area:149}은 호수 북끝, {area:144} 북쪽에 있습니다. 굴 쥐 코볼트가 지킵니다. 보석은 높이 쌓인 {object:271}에서만 나옵니다(커서에 톱니바퀴가 표시됩니다. 작은 상자는 비어 있음). 상자마다 하나씩, 열네 개가 3~5분 후 다시 나옵니다. 여섯 개를 모으려면 끝 방까지 가야 할 수도 있습니다. 같은 상자가 드워프의 더러운 발 퀘스트에도 쓰입니다.",

	-- Step 8: Wynne Larson
	-- {zone:1453} Stormwind · {npc:1309} Wynne Larson · {object:23296} Larson Clothiers · {object:2101} Mage Quarter
	["Back to {zone:1453} by the tram. {npc:1309} works at {object:23296} in the {object:2101}."] = "전차를 타고 {zone:1453}(으)로 돌아가십시오. {npc:1309}은(는) {object:2101}의 {object:23296}에서 일합니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Humanoids drop {item:2589}; the Auction House in the {object:2096} sells it."] = "인간형 몹이 {item:2589}을(를) 떨어뜨립니다. {object:2096}의 경매장에서도 판매합니다.",
	-- ["Take the {area:2257} to {zone:1455}, then the road east through the South Gate tunnel into {zone:1432}. The dwarven miners' league left the crates in the {area:149} at the north end of the loch; Tunnel Rat troggs hold the mine."] = "{area:2257}을(를) 타고 {zone:1455}(으)로 간 뒤, 동쪽 길을 따라 남부 관문 터널을 지나 {zone:1432}(으)로 가십시오. 드워프 광부 연맹이 호수 북쪽 끝 {area:149}에 상자를 두고 갔으며, 광산은 동굴쥐일족 트로그가 차지하고 있습니다.",
	-- ["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}. The {item:7247} and the {item:7308} lie behind her."] = "{npc:5497}은(는) {object:2101}의 탑인 마법사의 성소에 있습니다. {item:7247}와(과) {item:7308}은(는) 그녀 뒤에 있습니다.",
	-- ["{object:2169} is the tavern in the {object:2101}. Use the {item:7308} inside to make the {npc:6492} visible, subdue one with your spells, then use the {item:7247} to throw down a coffer and capture it."] = "{object:2169}은(는) {object:2101}의 선술집입니다. 안에서 {item:7308}을(를) 사용해 {npc:6492}을(를) 보이게 하고, 주문으로 하나를 제압한 뒤 {item:7247}을(를) 사용해 상자를 던져 포획하십시오.",
}
