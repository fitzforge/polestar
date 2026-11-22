-- Korean (koKR): the guide forever/class/mage/spellfire-robes (forever/class/mage/spellfire-robes.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1458} Undercity · {zone:1421} Silverpine Forest
	["A robe at 15 for Horde mages, from the {zone:1458} and {zone:1421}."] = "호드 마법사를 위한 15레벨 로브, {zone:1458}와(과) {zone:1421}에서.",

	-- Step 1: Uthel'nay (Orgrimmar)
	-- {npc:7311} Uthel'nay · {zone:1454} Orgrimmar · {object:173161} Darkbriar Lodge · {object:172961} Valley of Spirits · {zone:1420} Tirisfal Glades
	["{npc:7311} is one of {zone:1454}'s mage trainers, in {object:173161} in the {object:172961}. Then take the zeppelin to {zone:1420} from the tower outside {zone:1454}'s main gate."] = "{npc:7311}은(는) {zone:1454}의 마법사 상급자 중 하나로, {object:172961}의 {object:173161}에 있습니다. 그런 다음 {zone:1454} 정문 밖 탑에서 비행선을 타고 {zone:1420}(으)로 가세요.",

	-- Step 2: Cain Firesong (Brill)
	-- {npc:2128} Cain Firesong · {area:159} Brill · {area:2119} Gallows' End Tavern
	["{npc:2128} is the {area:159} mage trainer, upstairs in the {area:2119}: take the stairs inside, the arrow cannot tell the floors apart."] = "{npc:2128}은(는) {area:159}의 마법사 교관으로 {area:2119} 위층에 있습니다. 안쪽 계단으로 오르세요. 화살표는 층을 구분하지 못합니다.",

	-- Step 3: Anastasia Hartwell
	-- {npc:4568} Anastasia Hartwell · {object:36082} Magic Quarter · {item:7247} Chest of Containment Coffers · {item:7308} Cantation of Manifestation
	["{npc:4568} stands in the {object:36082}. The {item:7247} and the {item:7308} lie on the ledge behind her (both come back 5 minutes after someone takes them). You hand both in at the end, so keep them."] = "{npc:4568}은(는) {object:36082}에 서 있습니다. {item:7247}와(과) {item:7308}은(는) 그녀 뒤 바위턱에 있습니다(누군가 가져가면 둘 다 5분 뒤에 다시 나타납니다). 마지막에 둘 다 제출하므로 보관하세요.",

	-- Step 4: The alchemist shop
	["The alchemist shop"] = "연금술 상점",
	-- {item:7308} Cantation of Manifestation · {item:7247} Chest of Containment Coffers · {item:7292} Filled Containment Coffer
	-- plural, as words: Rift Spawns = {npc:6492} Rift Spawn
	["Algernon's alchemist shop is in the Apothecarium. Stand on the steps or the bridge outside the shop and read the {item:7308}: up to four invisible Rift Spawns (level 16-17) appear and attack at once, and the city guards do not help. Hit one with a single-target spell and back off over the bridge: the others give up and fade, the one you hit follows. Beat it down on the shop's half of the bridge (past halfway the coffer will not work on it) until it stops fighting and sits stunned under a spiral, use the {item:7247} on it, then click the {item:7292} once it appears on the floor (clicking too early wastes a charge). Three are needed."] = "알제넌의 연금술 상점은 연금술사 구역에 있습니다. 상점 밖 계단이나 다리에 서서 {item:7308}을(를) 읽으세요. 보이지 않는 균열 마귀(16-17레벨)가 최대 네 마리 동시에 나타나 공격하며 도시 경비병은 돕지 않습니다. 단일 대상 주문으로 한 마리를 때리고 다리 너머로 물러나면 나머지는 포기하고 사라지고 때린 놈만 따라옵니다. 상점 쪽 다리에서 쓰러뜨리세요(중간을 넘으면 상자가 통하지 않습니다). 싸움을 멈추고 소용돌이 아래 기절할 때까지 {item:7247}을(를) 사용한 뒤 바닥에 나타나는 {item:7292}을(를) 클릭하세요(너무 일찍 클릭하면 충전 횟수를 낭비합니다). 세 마리가 필요합니다.",
	-- {npc:6492} Rift Spawn
	["{npc:6492}, down to the stun"] = "{npc:6492}, 기절할 때까지",
	-- {item:7247} Chest of Containment Coffers · {npc:6492} Rift Spawn
	["{item:7247}, on the stunned {npc:6492}"] = "{item:7247}, 기절한 {npc:6492}에게",

	-- Step 5: Back to Anastasia Hartwell
	-- {npc:4568} Anastasia Hartwell
	["Back to {npc:4568}"] = "{npc:4568}에게 돌아가기",

	-- Step 6: Ambermill
	-- {zone:1458} Undercity · {zone:1421} Silverpine Forest · {area:279} Dalaran · {item:7293} Dalaran Mana Gem · {item:2589} Linen Cloth · {spell:116} Frostbolt · {area:228} Sepulcher · {area:233} Ambermill · {spell:134} Fire Shield · {spell:2120} Flamestrike · {spell:122} Frost Nova
	-- plural, as words: Dalaran Apprentices = {npc:1867} Dalaran Apprentice
	["Leave the {zone:1458} and follow the road south through {zone:1421}. Every {area:279} human drops a {item:7293} four times in five, and {item:2589} too: the easiest are the Dalaran Apprentices (level 13-14, {spell:116}) on the hills south-east of the {area:228}, either side of the road south; deeper in, the walled town of {area:233} in south-east Silverpine has Watchers (18-19, {spell:134} and {spell:2120}) and Wizards (19-20, {spell:122}) that come back every 4 1/2 minutes and run for help at low health, so pull at the edge. Ten {item:2589} also come from any humanoid or the Undercity Auction House."] = "{zone:1458}을(를) 떠나 남쪽 도로로 {zone:1421}을 지나세요. {area:279}의 인간은 다섯 번 중 네 번 {item:7293}을(를), {item:2589}도 떨어뜨립니다. 가장 쉬운 대상은 {area:228} 남동쪽 언덕의 달란 견습생(13-14레벨, {spell:116})으로 남쪽 도로 양쪽에 있습니다. 더 안쪽의 남부 은빛소나무 숲 담장 마을 {area:233}에는 감시자(18-19레벨, {spell:134}, {spell:2120})와 마술사(19-20레벨, {spell:122})가 4분 30초마다 다시 나오고 체력이 낮아지면 도움을 부르니 가장자리에서 끌어오세요. {item:2589} 열 개는 아무 인간형이나 언더시티 경매장에서도 얻을 수 있습니다.",

	-- Step 7: Josef Gregorian
	-- {zone:1458} Undercity · {npc:4576} Josef Gregorian · {npc:11048} Victor Ward · {npc:11049} Rhiannon Davis · {object:36082} Magic Quarter · {quest:1962} Spellfire Robes
	["Back to the {zone:1458}. {npc:4576}, {npc:11048} and {npc:11049} keep the tailor's shop in the {object:36082}. Hand the gems and cloth to {npc:4576} and let the three of them talk for a moment; then {npc:4576} offers {quest:1962}: take it and hand it straight back to him for the robe."] = "{zone:1458}으로 돌아가세요. {npc:4576}, {npc:11048}, {npc:11049}이(가) {object:36082}의 재단사 가게를 맡고 있습니다. 보석과 천을 {npc:4576}에게 주고 세 사람이 잠시 이야기하게 하세요. 그러면 {npc:4576}이(가) {quest:1962}을(를) 주니 받아서 바로 다시 제출하면 로브를 줍니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Algernon's alchemist shop is in the Apothecarium. Use the {item:7308} there to make the {npc:6492} visible, subdue one with your spells, then use the {item:7247} to throw down a coffer and capture it."] = "알게르논의 연금술 상점은 연금술 실험실에 있습니다. 그곳에서 {item:7308}을(를) 사용해 {npc:6492}을(를) 드러내고, 주문으로 약화시킨 뒤 {item:7247}을(를) 사용해 상자를 던져 포획하세요.",
	-- ["Back to the {zone:1458}. {npc:4576}, {npc:11048} and {npc:11049} keep the tailor's shop."] = "{zone:1458}(으)로 돌아가세요. {npc:4576}, {npc:11048}, {npc:11049}이(가) 재봉 상점을 운영합니다.",
	-- ["Humanoids drop {item:2589}; the Undercity Auction House sells it."] = "인간형 몹이 {item:2589}을(를) 떨어뜨립니다. 언더시티 경매장에서도 팝니다.",
	-- ["Leave the {zone:1458} and follow the road south through {zone:1421}. The {area:279} mages hold {area:233}, south-east of the {area:228}; every {npc:1867}, Mage, Protector, Warder, Conjuror, Watcher and Wizard can drop a {item:7293}."] = "{zone:1458}을(를) 나와 길을 따라 남쪽으로 {zone:1421}을(를) 지나가세요. {area:279} 마법사들이 {area:228} 남동쪽의 {area:233}을(를) 차지하고 있습니다. {npc:1867}, 달라란 마법사, 수호병, 보초병, 요술사, 파수꾼, 마술사 모두 {item:7293}을(를) 떨어뜨릴 수 있습니다.",
	-- ["{npc:2128} is the {area:159} mage trainer."] = "{npc:2128}은(는) {area:159}의 마법사 상급자입니다.",
}
