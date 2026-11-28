-- Korean (koKR): the guide forever/professions/fishing (forever/professions/fishing.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Fishing
	-- {skill:356} Fishing
	["Learn {skill:356}"] = "{skill:356} 배우기",
	["No character level needed."] = "",

	-- Step 2: Buy a Fishing Pole
	-- {item:6256} Fishing Pole
	["Buy a {item:6256}"] = "",
	["Equipped like a weapon while you fish."] = "",

	-- Step 3: Buy 2 Shiny Baubles
	-- plural, as words: Shiny Baubles = {item:6529} Shiny Bauble
	["Buy 2 Shiny Baubles"] = "",
	-- {skill:356} Fishing
	["A lure: +25 {skill:356} for ten minutes, so fewer fish get away."] = "",

	-- Step 4: Equip the Fishing Pole
	-- {item:6256} Fishing Pole
	["Equip the {item:6256}"] = "",
	-- {skill:356} Fishing
	["{skill:356} needs the pole in your hands; your weapon goes back on after."] = "",

	-- Step 5: Put a Shiny Bauble on the pole
	-- {item:6529} Shiny Bauble
	["Put a {item:6529} on the pole"] = "",
	["It lasts ten minutes."] = "",

	-- Step 6: Fish near your starting area until 75 · Fishing: Professions tab (K by default)
	-- {skill:356} Fishing
	["Fish near your starting area until 75 · {skill:356}: Professions tab (K by default)"] = "",
	["Every catch gives a point."] = "",
	["Cast, then right-click the bobber when it splashes."] = "",

	-- Step 8: Reach level 10
	["Reach level 10"] = "",
	-- {skill:356} Fishing
	["Journeyman {skill:356} needs level 10."] = "",

	-- Step 9: Train Journeyman Fishing
	-- {skill:356} Fishing
	["Train Journeyman {skill:356}"] = "",
	-- {skill:356} Fishing
	["Needs {skill:356} skill 50 and level 10."] = "",

	-- Step 10: Fish in a capital or a nearby lake until 150 · Fishing: Professions tab (K by default)
	-- {skill:356} Fishing
	["Fish in a capital or a nearby lake until 150 · {skill:356}: Professions tab (K by default)"] = "",
	-- {item:6530} Nightcrawlers
	["{item:6530} on the pole help when fish keep getting away."] = "",

	-- Step 11: Reach level 20
	["Reach level 20"] = "",
	-- {skill:356} Fishing
	["Expert {skill:356} needs level 20."] = "",

	-- Step 12: Buy Expert Fishing - The Bass and You · Old Man Heming, Booty Bay
	-- {item:16083} Expert Fishing - The Bass and You · {npc:2626} Old Man Heming · {area:35} Booty Bay
	["Buy {item:16083} · {npc:2626}, {area:35}"] = "",
	["Sold there only, or at the Auction House."] = "",

	-- Step 13: Read Expert Fishing - The Bass and You
	-- {item:16083} Expert Fishing - The Bass and You
	-- was: ["Buy and read {item:16083} (Expert {skill:356})"] = "{item:16083} 사서 읽기 (숙련 {skill:356})"
	["Read {item:16083}"] = "",
	-- {skill:356} Fishing
	["It teaches Expert {skill:356}: needs {skill:356} skill 125 and level 20."] = "",

	-- Step 14: Buy 11 Bright Baubles
	-- {item:6532} Bright Baubles
	["Buy 11 {item:6532}"] = "",
	["For the water that loses fish below 225: ten minutes each, about 11 to 225."] = "",

	-- Step 15: Fish in the mid-level waters until 225 · Fishing: Professions tab (K by default)
	-- {skill:356} Fishing
	["Fish in the mid-level waters until 225 · {skill:356}: Professions tab (K by default)"] = "",
	-- {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh
	["{npc:12919}, who teaches Artisan, fishes in {zone:1445}."] = "",

	-- Step 16: Reach level 35
	["Reach level 35"] = "",
	-- {npc:12919} Nat Pagle
	["{npc:12919}'s quests need level 35."] = "",

	-- Step 17: Accept I Got Nothin' Left! · Grimnur Stonebrand, Ironforge
	-- {quest:6609} I Got Nothin' Left! · {npc:5161} Grimnur Stonebrand · {zone:1455} Ironforge
	["Accept {quest:6609} · {npc:5161}, {zone:1455}"] = "",
	-- {npc:12919} Nat Pagle
	["The fishing trainer sends you to {npc:12919}, who teaches Artisan."] = "",

	-- Step 18: Accept You Too Good. · Lumak, Orgrimmar
	-- {quest:6608} You Too Good. · {npc:3332} Lumak · {zone:1454} Orgrimmar
	["Accept {quest:6608} · {npc:3332}, {zone:1454}"] = "",

	-- Step 19: Hand in I Got Nothin' Left! · Nat Pagle, island off Dustwallow Marsh
	-- {quest:6609} I Got Nothin' Left! · {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh
	["Hand in {quest:6609} · {npc:12919}, island off {zone:1445}"] = "",
	["His island lies off the east coast, south of Theramore."] = "",

	-- Step 20: Hand in You Too Good. · Nat Pagle, island off Dustwallow Marsh
	-- {quest:6608} You Too Good. · {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh
	["Hand in {quest:6608} · {npc:12919}, island off {zone:1445}"] = "",

	-- Step 21: Accept Nat Pagle, Angler Extreme · Nat Pagle
	-- {quest:6607} Nat Pagle, Angler Extreme · {npc:12919} Nat Pagle
	["Accept {quest:6607} · {npc:12919}"] = "",
	["Four fish, each from its own water; about one catch in five brings it up there."] = "",

	-- Step 22: Catch a Sar'theris Striker · Desolace's northern coast, by the tower · Fishing: Professions tab (K by default)
	-- {item:16968} Sar'theris Striker · {zone:1443} Desolace · {skill:356} Fishing
	["Catch a {item:16968} · {zone:1443}'s northern coast, by the tower · {skill:356}: Professions tab (K by default)"] = "",
	["It bites nowhere else."] = "",

	-- Step 23: Catch a Sar'theris Striker · Desolace coast by Shadowprey Village · Fishing: Professions tab (K by default)
	-- {item:16968} Sar'theris Striker · {zone:1443} Desolace · {area:2408} Shadowprey Village · {skill:356} Fishing
	["Catch a {item:16968} · {zone:1443} coast by {area:2408} · {skill:356}: Professions tab (K by default)"] = "",

	-- Step 24: Buy 2 Bright Baubles
	-- {item:6532} Bright Baubles
	["Buy 2 {item:6532}"] = "",
	-- {zone:1444} Feralas
	["Fish get away in {zone:1444} below skill 300; a lure adds 75 for ten minutes."] = "",

	-- Step 25: Catch a Feralas Ahi · Verdantis River, west of the road bridge · Fishing: Professions tab (K by default)
	-- {item:16967} Feralas Ahi · {area:2521} Verdantis River · {skill:356} Fishing
	["Catch a {item:16967} · {area:2521}, west of the road bridge · {skill:356}: Professions tab (K by default)"] = "",

	-- Step 26: Catch a Savage Coast Blue Sailfin · Savage Coast, Stranglethorn Vale · Fishing: Professions tab (K by default)
	-- {item:16969} Savage Coast Blue Sailfin · {area:301} Savage Coast · {zone:1434} Stranglethorn Vale · {skill:356} Fishing
	["Catch a {item:16969} · {area:301}, {zone:1434} · {skill:356}: Professions tab (K by default)"] = "",
	-- {item:8364} Mithril Head Trout
	["Only {item:8364} and Catfish biting means another spot."] = "",

	-- Step 28: Catch a Misty Reed Mahi Mahi · Misty Reed Strand, Swamp of Sorrows · Fishing: Professions tab (K by default)
	-- {item:16970} Misty Reed Mahi Mahi · {area:300} Misty Reed Strand · {zone:1435} Swamp of Sorrows · {skill:356} Fishing
	["Catch a {item:16970} · {area:300}, {zone:1435} · {skill:356}: Professions tab (K by default)"] = "",
	["The small islands keep you clear of the murlocs."] = "",

	-- Step 29: Hand in Nat Pagle, Angler Extreme
	-- {quest:6607} Nat Pagle, Angler Extreme
	["Hand in {quest:6607}"] = "",

	-- Step 30: Train Artisan Fishing
	-- {skill:356} Fishing
	["Train Artisan {skill:356}"] = "",
	-- {npc:12919} Nat Pagle · {skill:356} Fishing
	["{npc:12919} teaches it once his quest is done: needs {skill:356} skill 225 and level 35."] = "",

	-- Step 31: Buy 16 Bright Baubles
	-- {item:6532} Bright Baubles
	["Buy 16 {item:6532}"] = "",
	["For the water that loses fish below 300: ten minutes each, about 16 to 300."] = "",

	-- Step 32: Fish in the high-level waters until 300 · Fishing: Professions tab (K by default)
	-- {skill:356} Fishing
	["Fish in the high-level waters until 300 · {skill:356}: Professions tab (K by default)"] = "",
	["Fish get away here without a lure."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any {skill:356} trainer of your faction teaches Apprentice {skill:356} (character level 5); the arrow picks the nearest. Buy a {item:6256} from a trade goods or fishing vendor and equip it."] = "진영의 {skill:356} 상급자 누구에게서나 초급 {skill:356}을(를) 배울 수 있습니다(캐릭터 레벨 5). 화살표가 가장 가까운 상급자를 가리킵니다. 직업용품 상인이나 낚시 상인에게서 {item:6256}을(를) 사서 장착하세요.",
	-- ["Any {skill:356} trainer of your faction teaches Apprentice {skill:356} at any character level (1s); the arrow picks the nearest, and every starting area has one on its lake or shore. Buy a {item:6256} (23c) from a trade goods or fishing vendor and equip it (you can only fish with a pole in your hands), and two or three Shiny Baubles (+25, 50c each): a lure adds its bonus to your skill for ten minutes, so fewer fish get away at the start. If you sat at your starting area's campfire for The Great Outdoors, the camping guide there also offers Camping 101: {skill:356}, handed in to the fishing trainer it names at skill 20 for the {spell:1229745} recipe."] = "진영의 모든 {skill:356} 상급자가 캐릭터 레벨에 관계없이 초급 {skill:356}을(를) 가르칩니다(1실버). 화살표가 가장 가까운 상급자를 가리키며, 시작 지역마다 호숫가나 해안에 한 명씩 있습니다. 잡화 상인이나 낚시 상인에게서 {item:6256}(23코퍼)을(를) 사서 장착하고(낚싯대를 손에 들어야 낚시할 수 있습니다), 반짝이는 미끼(+25, 개당 50코퍼)도 두세 개 사세요. 미끼는 10분 동안 숙련도에 보너스를 더해 주므로 처음에 놓치는 물고기가 줄어듭니다. '드넓은 야외' 때문에 시작 지역의 모닥불 옆에 앉았다면, 그곳 야영 안내인이 '야영 입문: {skill:356}'도 주며, 숙련도 20에 퀘스트에 적힌 낚시 상급자에게 제출하면 {spell:1229745} 제조법을 받습니다.",
	-- ["Artisan {skill:356}"] = "전문 {skill:356}",
	-- ["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1454} sends you to him; the quest needs skill 225 and level 35."] = "전문 {skill:356}(최대 300)은(는) {zone:1445}의 {npc:12919}에게서 배웁니다. {zone:1454}의 낚시 상급자가 그에게 보내 줍니다. 퀘스트에는 숙련도 225, 레벨 35가 필요합니다.",
	-- ["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1455} sends you to him; the quest needs skill 225 and level 35."] = "전문 {skill:356}(최대 300)은(는) {zone:1445}의 {npc:12919}에게서 배웁니다. {zone:1455}의 낚시 상급자가 그에게 보내 줍니다. 퀘스트에는 숙련도 225, 레벨 35가 필요합니다.",
	-- ["Buy and read {item:16083} (Expert {skill:356})"] = "{item:16083} 사서 읽기 (숙련 {skill:356})",
	-- ["Expert {skill:356}"] = "숙련 {skill:356}",
	-- ["Expert {skill:356} (cap 225) is a book, not a trainer rank: {npc:2626} sells {item:16083} (1g) on the lowest dock of {area:35}, at the south tip of {zone:1434}, to both factions. Buy it and read it; it needs skill 125 and level 20. At level 20 the safe way in is the boat from {area:392} in {zone:1413}, not the road through Stranglethorn. He also sells {item:6532} (+75 from skill 100, 2s 50c each), the lure for the rest of the way."] = "숙련 {skill:356}(최대 225)은(는) 상급자가 아니라 책으로 배웁니다. {zone:1434} 남쪽 끝 {area:35}의 가장 아래 부두에서 {npc:2626}이(가) 양 진영 모두에게 {item:16083}(1골드)을(를) 팝니다. 사서 읽으세요. 숙련도 125, 레벨 20이 필요합니다. 20레벨이라면 가시덤불 골짜기 길보다 {zone:1413} {area:392}에서 배를 타는 것이 안전합니다. 그는 남은 구간에 쓸 미끼인 {item:6532}(숙련도 100부터 +75, 개당 2실버 50코퍼)도 팝니다.",
	-- ["Fish along the coast of {zone:1443} ({area:598} in the north-west, or the shore west of {area:2408}) until you catch a {item:16968}: about one catch in five there brings it up, and it bites nowhere else. At skill 225 nothing gets away here."] = "{zone:1443} 해안을 따라 낚아 {item:16968}을(를) 낚을 때까지 하세요({area:598}는 북서쪽, 또는 {area:2408} 서쪽 해안). 여기서는 다섯 마리 중 한 마리에서 숙련도가 오르고, 다른 곳에서는 물지 않습니다. 숙련도 225에서는 여기서 아무것도 도망가지 않습니다.",
	-- ["Fish along the {area:2521} in {zone:1444} (south-east of {area:2577}) until you catch a {item:16967}: about one catch in five there brings it up, and it bites nowhere else. This water loses fish below skill 300: at 225 most get away, so put {item:6532} (+75) on the pole first."] = "{zone:1444}의 {area:2521}({area:2577} 남동쪽)을 따라 낚아 {item:16967}을(를) 낚을 때까지 하세요. 여기서는 다섯 마리 중 한 마리에서 숙련도가 오르고, 다른 곳에서는 물지 않습니다. 이 물은 숙련도 300 아래에서 물고기를 잃습니다. 225에서는 대부분 도망가니 먼저 {item:6532}(+75)를(을) 낚싯대에 달세요.",
	-- ["Fish along the {area:300} (the east shore of {zone:1435}) until you catch a {item:16970}: about one catch in five there brings it up, and it bites nowhere else. At skill 225 nothing gets away here."] = "{area:300}({zone:1435}의 동쪽 해안)을 따라 낚아 {item:16970}을(를) 낚을 때까지 하세요. 여기서는 다섯 마리 중 한 마리에서 숙련도가 오르고, 다른 곳에서는 물지 않습니다. 숙련도 225에서는 여기서 아무것도 도망가지 않습니다.",
	-- ["Fish along {zone:1434}'s {area:301} (the west shore) until you catch a {item:16969}: about one catch in five there brings it up, and it bites nowhere else. At skill 225 nothing gets away here."] = "{zone:1434}의 {area:301}(서쪽 해안)을 따라 낚아 {item:16969}을(를) 낚을 때까지 하세요. 여기서는 다섯 마리 중 한 마리에서 숙련도가 오르고, 다른 곳에서는 물지 않습니다. 숙련도 225에서는 여기서 아무것도 도망가지 않습니다.",
	-- ["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. Fish get away here below skill 25; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6325} for the {item:6291} of lakes and rivers ({skill:185} 1, 40c: {npc:3550} ({zone:1420}) or {npc:4574} ({zone:1458})); {item:6326} for the {item:6303} of the coast ({skill:185} 1, 40c: {npc:3550} ({zone:1420}))."] = "숙련도 50까지 이곳에서 낚시하십시오. 약 50번 낚으면 됩니다. 75 미만에서는 낚을 때마다 숙련도가 오릅니다. 주문책에서 {skill:356}을(를) 시전하고, 찌가 첨벙거리면 찌를 클릭하십시오. 물고기는 보관하십시오. 첫 {skill:185} 재료가 됩니다. 숙련도 25 미만에서는 이곳 물고기가 도망갑니다. 낚싯대에 미끼를 달면 10분 동안 숙련도가 올라 그 차이를 메워 줍니다. 잡은 물고기 요리법: 호수와 강의 {item:6291}에는 {item:6325}({skill:185} 1, 40코퍼: {zone:1420}의 {npc:3550} 또는 {zone:1458}의 {npc:4574}), 해안의 {item:6303}에는 {item:6326}({skill:185} 1, 40코퍼: {zone:1420}의 {npc:3550}).",
	-- ["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. Fish get away here below skill 25; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6325} for the {item:6291} of lakes and rivers ({skill:185} 1, 40c: {npc:5940} ({zone:1412}) or {npc:3029} ({zone:1456})); {item:6326} for the {item:6303} of the coast ({skill:185} 1, 40c: {npc:5942} ({zone:1411}))."] = "숙련도 50까지 이곳에서 낚시하십시오. 약 50번 낚으면 됩니다. 75 미만에서는 낚을 때마다 숙련도가 오릅니다. 주문책에서 {skill:356}을(를) 시전하고, 찌가 첨벙거리면 찌를 클릭하십시오. 물고기는 보관하십시오. 첫 {skill:185} 재료가 됩니다. 숙련도 25 미만에서는 이곳 물고기가 도망갑니다. 낚싯대에 미끼를 달면 10분 동안 숙련도가 올라 그 차이를 메워 줍니다. 잡은 물고기 요리법: 호수와 강의 {item:6291}에는 {item:6325}({skill:185} 1, 40코퍼: {zone:1412}의 {npc:5940} 또는 {zone:1456}의 {npc:3029}), 해안의 {item:6303}에는 {item:6326}({skill:185} 1, 40코퍼: {zone:1411}의 {npc:5942}).",
	-- ["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. Fish get away here below skill 25; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6325} for the {item:6291} of lakes and rivers ({skill:185} 1, 40c: {npc:66} ({zone:1429}) or {npc:5494} ({zone:1453})); {item:6326} for the {item:6303} of the coast ({skill:185} 1, 40c: {npc:4305} ({zone:1436}) or {npc:5162} ({zone:1455}))."] = "숙련도 50까지 이곳에서 낚시하십시오. 약 50번 낚으면 됩니다. 75 미만에서는 낚을 때마다 숙련도가 오릅니다. 주문책에서 {skill:356}을(를) 시전하고, 찌가 첨벙거리면 찌를 클릭하십시오. 물고기는 보관하십시오. 첫 {skill:185} 재료가 됩니다. 숙련도 25 미만에서는 이곳 물고기가 도망갑니다. 낚싯대에 미끼를 달면 10분 동안 숙련도가 올라 그 차이를 메워 줍니다. 잡은 물고기 요리법: 호수와 강의 {item:6291}에는 {item:6325}({skill:185} 1, 40코퍼: {zone:1429}의 {npc:66} 또는 {zone:1453}의 {npc:5494}), 해안의 {item:6303}에는 {item:6326}({skill:185} 1, 40코퍼: {zone:1436}의 {npc:4305} 또는 {zone:1455}의 {npc:5162}).",
	-- ["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. Fish get away here below skill 25; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6325} for the {item:6291} of lakes and rivers ({skill:185} 1, 40c: {npc:8508} ({zone:1426}) or {npc:1684} ({zone:1432})); {item:6326} for the {item:6303} of the coast ({skill:185} 1, 40c: {npc:5162} ({zone:1455}) or {npc:4305} ({zone:1436}))."] = "숙련도 50까지 이곳에서 낚시하십시오. 약 50번 낚으면 됩니다. 75 미만에서는 낚을 때마다 숙련도가 오릅니다. 주문책에서 {skill:356}을(를) 시전하고, 찌가 첨벙거리면 찌를 클릭하십시오. 물고기는 보관하십시오. 첫 {skill:185} 재료가 됩니다. 숙련도 25 미만에서는 이곳 물고기가 도망갑니다. 낚싯대에 미끼를 달면 10분 동안 숙련도가 올라 그 차이를 메워 줍니다. 잡은 물고기 요리법: 호수와 강의 {item:6291}에는 {item:6325}({skill:185} 1, 40코퍼: {zone:1426}의 {npc:8508} 또는 {zone:1432}의 {npc:1684}), 해안의 {item:6303}에는 {item:6326}({skill:185} 1, 40코퍼: {zone:1455}의 {npc:5162} 또는 {zone:1436}의 {npc:4305}).",
	-- ["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. To cook what you catch: {item:6325} for the {item:6291} of lakes and rivers ({skill:185} 1, 40c: {npc:257006} ({zone:2521})); {item:6326} for the {item:6303} of the coast ({skill:185} 1, 40c: {npc:257006} ({zone:2521}))."] = "숙련도 50까지 이곳에서 낚시하십시오. 약 50번 낚으면 됩니다. 75 미만에서는 낚을 때마다 숙련도가 오릅니다. 주문책에서 {skill:356}을(를) 시전하고, 찌가 첨벙거리면 찌를 클릭하십시오. 물고기는 보관하십시오. 첫 {skill:185} 재료가 됩니다. 잡은 물고기 요리법: 호수와 강의 {item:6291}에는 {item:6325}({skill:185} 1, 40코퍼: {zone:2521}의 {npc:257006}), 해안의 {item:6303}에는 {item:6326}({skill:185} 1, 40코퍼: {zone:2521}의 {npc:257006}).",
	-- ["Fish here until skill 50. Click the bobber when it splashes; every catch can raise the skill."] = "숙련도 50까지 이곳에서 낚시하세요. 찌가 첨벙이면 클릭하세요. 낚을 때마다 숙련도가 오를 수 있습니다.",
	-- ["Fish in the {area:2521} in {zone:1444} until you catch a {item:16967}; it only bites there."] = "{item:16967}을(를) 낚을 때까지 {zone:1444}의 {area:2521}에서 낚시하세요. 그곳에서만 낚입니다.",
	-- ["Fish in the {area:300}, the south-east shore of {zone:1435} until you catch a {item:16970}; it only bites there."] = "{item:16970}을(를) 낚을 때까지 {zone:1435} 남동쪽 물가인 {area:300}에서 낚시하세요. 그곳에서만 낚입니다.",
	-- ["Fish in the {area:301}, the north-west shore of {zone:1434} until you catch a {item:16969}; it only bites there."] = "{item:16969}을(를) 낚을 때까지 {zone:1434} 북서쪽 물가인 {area:301}에서 낚시하세요. 그곳에서만 낚입니다.",
	-- ["Fish in {area:598}, the north-west coast of {zone:1443} (Slitherblade naga shore) until you catch a {item:16968}; it only bites there."] = "{item:16968}을(를) 낚을 때까지 {zone:1443} 북서쪽 해안(뱀갈퀴일족 나가 해안)인 {area:598}에서 낚시하세요. 그곳에서만 낚입니다.",
	-- ["Fish the pools along the coast here (eels, snappers, wreckage) until skill 300, about 650 catches (one in seven raises the skill at 225, one in ten by 300). Harder water levels no faster: a catch counts the same anywhere. From skill 225 this water loses no fish, so no lure is needed. The {item:6533} (+100 from skill 100, 2s 50c) and {item:6532} are for harder water and rare fish, not for skill."] = "여기 해안의 웅덩이에서 낚으세요(장어, 도미, 난파선). 숙련도 300까지 약 650마리입니다(225에서 일곱 마리 중 한 마리, 300에서 열 마리 중 한 마리가 오릅니다). 더 어려운 물이 더 빠르지는 않습니다. 어디서나 한 마리는 같게 칩니다. 숙련도 225부터 이 물은 물고기를 잃지 않으니 미끼가 필요 없습니다. {item:6533}(100부터 +100, 2실버 50코퍼)과(와) {item:6532}은(는) 숙련도가 아니라 더 어려운 물과 희귀 물고기를 위한 것입니다.",
	-- ["Fish the pools along the coast here (eels, snappers, wreckage) until skill 300. {area:35} sells bait and {item:6530} for a small fishing bonus."] = "숙련도 300까지 이곳 해안의 낚시터(장어, 도미, 잔해)에서 낚시하세요. {area:35}에서 미끼와 {item:6530}을(를) 팔며, 낚시 숙련도가 조금 오릅니다.",
	-- ["Fish the pools and open water here until skill 125, about 120 catches: from 75 a catch raises the skill less often (about one in two by 100, one in three by 125). Pools (floating wreckage, schools of fish) also give extra loot. {item:6530} (+50 from skill 50, 1s each) are twice as strong as a {item:6529}. The {item:6365} (+5 from skill 10, 9s 1c) is in limited stock at fishing vendors: buy it when you see it. Fish get away here below skill 75; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6328} for the {item:6289} of lakes and rivers ({skill:185} 50, 4s: Nyoma ({zone:1438})); {item:6368} for the {item:6361} of the coast ({skill:185} 50, 4s: {npc:4307} ({zone:1439}) or {npc:10118} ({zone:1438})). {item:12238} bites only here: eat it as it is. {npc:10216} ({zone:1439}) takes 6 for The Family and the {item:6256}, which gives the {item:12221}. {item:6358} from the schools here is no food: alchemists make {item:6370} from it ({skill:171} 80); keep it to sell or trade."] = "숙련도 125까지 이곳의 낚시 지점과 탁 트인 물에서 낚시하십시오. 약 120번 낚으면 됩니다. 75부터는 숙련도가 덜 자주 오릅니다(100쯤에는 두 번에 한 번, 125쯤에는 세 번에 한 번). 낚시 지점(떠다니는 잔해, 물고기 떼)은 추가 전리품도 줍니다. {item:6530}(숙련도 50부터 +50, 개당 1실버)은(는) {item:6529}보다 두 배 강합니다. {item:6365}(숙련도 10부터 +5, 9실버 1코퍼)은(는) 낚시 상인의 재고가 한정되어 있습니다. 보이면 사십시오. 숙련도 75 미만에서는 이곳 물고기가 도망갑니다. 낚싯대에 미끼를 달면 10분 동안 숙련도가 올라 그 차이를 메워 줍니다. 잡은 물고기 요리법: 호수와 강의 {item:6289}에는 {item:6328}({skill:185} 50, 4실버: {zone:1438}의 니오마), 해안의 {item:6361}에는 {item:6368}({skill:185} 50, 4실버: {zone:1439}의 {npc:4307} 또는 {zone:1438}의 {npc:10118}). {item:12238}은(는) 이곳에서만 낚입니다. 그대로 먹으십시오. {zone:1439}의 {npc:10216}이(가) '가족과 {item:6256}' 퀘스트로 6개를 받으며, 보상으로 {item:12221}을(를) 줍니다. 이곳 물고기 떼에서 낚이는 {item:6358}은(는) 음식이 아닙니다. 연금술사가 이것으로 {item:6370}을(를) 만듭니다({skill:171} 80). 팔거나 거래할 수 있게 보관하십시오.",
	-- ["Fish the pools and open water here until skill 125, about 120 catches: from 75 a catch raises the skill less often (about one in two by 100, one in three by 125). Pools (floating wreckage, schools of fish) also give extra loot. {item:6530} (+50 from skill 50, 1s each) are twice as strong as a {item:6529}. The {item:6365} (+5 from skill 10, 9s 1c) is in limited stock at fishing vendors: buy it when you see it. Fish get away here below skill 75; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6328} for the {item:6289} of lakes and rivers ({skill:185} 50, 4s: {npc:1684} ({zone:1432}) or {npc:5162} ({zone:1455})); {item:6368} for the {item:6361} of the coast ({skill:185} 50, 4s: {npc:3178} ({zone:1437}) or {npc:260487} ({zone:2548}))."] = "여기의 웅덩이와 열린 물에서 숙련도 125까지 낚으세요. 약 120마리입니다. 75부터는 숙련도가 덜 오릅니다(100쯤 두 마리 중 한 마리, 125쯤 세 마리 중 한 마리). 웅덩이(떠다니는 난파선, 물고기 떼)는 추가 전리품도 줍니다. {item:6530}(50부터 +50, 하나에 1실버)은(는) {item:6529}보다 두 배 강합니다. {item:6365}(10부터 +5, 9실버 1코퍼)는 낚시 상인에게 수량 제한으로 있습니다. 보이면 사세요. 여기서는 숙련도 75 아래에서 물고기가 도망가며, 낚싯대에 미끼를 달면 10분 동안 숙련도가 더해져 격차를 줄입니다. 잡은 것을 요리하려면: 호수와 강의 {item:6289}은(는) {item:6328}({skill:185} 50, 4실버: {npc:1684}({zone:1432}) 또는 {npc:5162}({zone:1455})), 해안의 {item:6361}은(는) {item:6368}({skill:185} 50, 4실버: {npc:3178}({zone:1437}) 또는 {npc:260487}({zone:2548})).",
	-- ["Fish the pools and open water here until skill 125, about 120 catches: from 75 a catch raises the skill less often (about one in two by 100, one in three by 125). Pools (floating wreckage, schools of fish) also give extra loot. {item:6530} (+50 from skill 50, 1s each) are twice as strong as a {item:6529}. The {item:6365} (+5 from skill 10, 9s 1c) is in limited stock at fishing vendors: buy it when you see it. Fish get away here below skill 75; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6328} for the {item:6289} of lakes and rivers ({skill:185} 50, 4s: {npc:5748} ({zone:1421}) or {npc:4574} ({zone:1458})); {item:6368} for the {item:6361} of the coast ({skill:185} 50, 4s: {npc:4553} ({zone:1458}) or {npc:5748} ({zone:1421})). {item:6358} from the schools here is no food: alchemists make {item:6370} from it ({skill:171} 80); keep it to sell or trade."] = "숙련도 125까지 이곳의 낚시 지점과 탁 트인 물에서 낚시하십시오. 약 120번 낚으면 됩니다. 75부터는 숙련도가 덜 자주 오릅니다(100쯤에는 두 번에 한 번, 125쯤에는 세 번에 한 번). 낚시 지점(떠다니는 잔해, 물고기 떼)은 추가 전리품도 줍니다. {item:6530}(숙련도 50부터 +50, 개당 1실버)은(는) {item:6529}보다 두 배 강합니다. {item:6365}(숙련도 10부터 +5, 9실버 1코퍼)은(는) 낚시 상인의 재고가 한정되어 있습니다. 보이면 사십시오. 숙련도 75 미만에서는 이곳 물고기가 도망갑니다. 낚싯대에 미끼를 달면 10분 동안 숙련도가 올라 그 차이를 메워 줍니다. 잡은 물고기 요리법: 호수와 강의 {item:6289}에는 {item:6328}({skill:185} 50, 4실버: {zone:1421}의 {npc:5748} 또는 {zone:1458}의 {npc:4574}), 해안의 {item:6361}에는 {item:6368}({skill:185} 50, 4실버: {zone:1458}의 {npc:4553} 또는 {zone:1421}의 {npc:5748}). 이곳 물고기 떼에서 낚이는 {item:6358}은(는) 음식이 아닙니다. 연금술사가 이것으로 {item:6370}을(를) 만듭니다({skill:171} 80). 팔거나 거래할 수 있게 보관하십시오.",
	-- ["Fish the pools and open water here until skill 125, about 120 catches: from 75 a catch raises the skill less often (about one in two by 100, one in three by 125). Pools (floating wreckage, schools of fish) also give extra loot. {item:6530} (+50 from skill 50, 1s each) are twice as strong as a {item:6529}. The {item:6365} (+5 from skill 10, 9s 1c) is in limited stock at fishing vendors: buy it when you see it. Fish get away here below skill 75; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6328} for the {item:6289} of lakes and rivers ({skill:185} 50, 4s: {npc:5940} ({zone:1412}) or {npc:3027} ({zone:1456})); {item:6368} for the {item:6361} of the coast ({skill:185} 50, 4s: {npc:5942} ({zone:1411}) or {npc:3333} ({zone:1454})). {item:6358} from the schools here is no food: alchemists make {item:6370} from it ({skill:171} 80); keep it to sell or trade."] = "숙련도 125까지 이곳의 낚시 지점과 탁 트인 물에서 낚시하십시오. 약 120번 낚으면 됩니다. 75부터는 숙련도가 덜 자주 오릅니다(100쯤에는 두 번에 한 번, 125쯤에는 세 번에 한 번). 낚시 지점(떠다니는 잔해, 물고기 떼)은 추가 전리품도 줍니다. {item:6530}(숙련도 50부터 +50, 개당 1실버)은(는) {item:6529}보다 두 배 강합니다. {item:6365}(숙련도 10부터 +5, 9실버 1코퍼)은(는) 낚시 상인의 재고가 한정되어 있습니다. 보이면 사십시오. 숙련도 75 미만에서는 이곳 물고기가 도망갑니다. 낚싯대에 미끼를 달면 10분 동안 숙련도가 올라 그 차이를 메워 줍니다. 잡은 물고기 요리법: 호수와 강의 {item:6289}에는 {item:6328}({skill:185} 50, 4실버: {zone:1412}의 {npc:5940} 또는 {zone:1456}의 {npc:3027}), 해안의 {item:6361}에는 {item:6368}({skill:185} 50, 4실버: {zone:1411}의 {npc:5942} 또는 {zone:1454}의 {npc:3333}). 이곳 물고기 떼에서 낚이는 {item:6358}은(는) 음식이 아닙니다. 연금술사가 이것으로 {item:6370}을(를) 만듭니다({skill:171} 80). 팔거나 거래할 수 있게 보관하십시오.",
	-- ["Fish the pools and open water here until skill 125, about 120 catches: from 75 a catch raises the skill less often (about one in two by 100, one in three by 125). Pools (floating wreckage, schools of fish) also give extra loot. {item:6530} (+50 from skill 50, 1s each) are twice as strong as a {item:6529}. The {item:6365} (+5 from skill 10, 9s 1c) is in limited stock at fishing vendors: buy it when you see it. Fish get away here below skill 75; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6328} for the {item:6289} of lakes and rivers ({skill:185} 50, 4s: {npc:66} ({zone:1429}) or {npc:5162} ({zone:1455})); {item:6368} for the {item:6361} of the coast ({skill:185} 50, 4s: {npc:5494} ({zone:1453}) or {npc:4305} ({zone:1436})). {item:6358} from the schools here is no food: alchemists make {item:6370} from it ({skill:171} 80); keep it to sell or trade."] = "숙련도 125까지 이곳의 낚시 지점과 탁 트인 물에서 낚시하십시오. 약 120번 낚으면 됩니다. 75부터는 숙련도가 덜 자주 오릅니다(100쯤에는 두 번에 한 번, 125쯤에는 세 번에 한 번). 낚시 지점(떠다니는 잔해, 물고기 떼)은 추가 전리품도 줍니다. {item:6530}(숙련도 50부터 +50, 개당 1실버)은(는) {item:6529}보다 두 배 강합니다. {item:6365}(숙련도 10부터 +5, 9실버 1코퍼)은(는) 낚시 상인의 재고가 한정되어 있습니다. 보이면 사십시오. 숙련도 75 미만에서는 이곳 물고기가 도망갑니다. 낚싯대에 미끼를 달면 10분 동안 숙련도가 올라 그 차이를 메워 줍니다. 잡은 물고기 요리법: 호수와 강의 {item:6289}에는 {item:6328}({skill:185} 50, 4실버: {zone:1429}의 {npc:66} 또는 {zone:1455}의 {npc:5162}), 해안의 {item:6361}에는 {item:6368}({skill:185} 50, 4실버: {zone:1453}의 {npc:5494} 또는 {zone:1436}의 {npc:4305}). 이곳 물고기 떼에서 낚이는 {item:6358}은(는) 음식이 아닙니다. 연금술사가 이것으로 {item:6370}을(를) 만듭니다({skill:171} 80). 팔거나 거래할 수 있게 보관하십시오.",
	-- ["Fish the pools and open water here until skill 125. Pools (floating debris, schools of fish) also drop extra loot."] = "숙련도 125까지 이곳의 낚시터와 탁 트인 물에서 낚시하세요. 낚시터(떠다니는 잔해, 물고기 떼)에서는 추가 전리품도 나옵니다.",
	-- ["Fish the pools here until skill 225, about 500 catches: one in three raises the skill at 125, one in seven by 225, so this is the long stretch. Forever's second camping item, the {item:279965} (from skill 140), is a blueprint that drops from Gelihast in {area:2797}. Fish get away here below skill 150; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6330} for the {item:6308} of lakes and rivers ({skill:185} 100, 12s: {npc:2383} ({zone:1424}) or {npc:5494} ({zone:1453})); {item:6369} for the {item:6362} of the coast ({skill:185} 175, 22s: {npc:3178} ({zone:1437}) or {npc:5162} ({zone:1455})). {item:6358} from the schools here is no food: alchemists make {item:6370} from it ({skill:171} 80); keep it to sell or trade."] = "숙련도 225까지 이곳 낚시 지점에서 낚시하십시오. 약 500번 낚아야 합니다. 125에서는 세 번에 한 번, 225쯤에는 일곱 번에 한 번 숙련도가 오르므로 가장 긴 구간입니다. Forever의 두 번째 야영 아이템인 {item:279965}(숙련도 140부터)은(는) {area:2797}의 겔리하스트가 떨어뜨리는 설계도입니다. 숙련도 150 미만에서는 이곳 물고기가 도망갑니다. 낚싯대에 미끼를 달면 10분 동안 숙련도가 올라 그 차이를 메워 줍니다. 잡은 물고기 요리법: 호수와 강의 {item:6308}에는 {item:6330}({skill:185} 100, 12실버: {zone:1424}의 {npc:2383} 또는 {zone:1453}의 {npc:5494}), 해안의 {item:6362}에는 {item:6369}({skill:185} 175, 22실버: {zone:1437}의 {npc:3178} 또는 {zone:1455}의 {npc:5162}). 이곳 물고기 떼에서 낚이는 {item:6358}은(는) 음식이 아닙니다. 연금술사가 이것으로 {item:6370}을(를) 만듭니다({skill:171} 80). 팔거나 거래할 수 있게 보관하십시오.",
	-- ["Fish the pools here until skill 225, about 500 catches: one in three raises the skill at 125, one in seven by 225, so this is the long stretch. Forever's second camping item, the {item:279965} (from skill 140), is a blueprint that drops from Gelihast in {area:2797}. Fish get away here below skill 150; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6330} for the {item:6308} of lakes and rivers ({skill:185} 100, 12s: {npc:2397} ({zone:1424}) or {npc:4553} ({zone:1458})); {item:6369} for the {item:6362} of the coast ({skill:185} 175, 22s: {npc:4574} ({zone:1458})). {item:6358} from the schools here is no food: alchemists make {item:6370} from it ({skill:171} 80); keep it to sell or trade."] = "숙련도 225까지 이곳 낚시 지점에서 낚시하십시오. 약 500번 낚아야 합니다. 125에서는 세 번에 한 번, 225쯤에는 일곱 번에 한 번 숙련도가 오르므로 가장 긴 구간입니다. Forever의 두 번째 야영 아이템인 {item:279965}(숙련도 140부터)은(는) {area:2797}의 겔리하스트가 떨어뜨리는 설계도입니다. 숙련도 150 미만에서는 이곳 물고기가 도망갑니다. 낚싯대에 미끼를 달면 10분 동안 숙련도가 올라 그 차이를 메워 줍니다. 잡은 물고기 요리법: 호수와 강의 {item:6308}에는 {item:6330}({skill:185} 100, 12실버: {zone:1424}의 {npc:2397} 또는 {zone:1458}의 {npc:4553}), 해안의 {item:6362}에는 {item:6369}({skill:185} 175, 22실버: {zone:1458}의 {npc:4574}). 이곳 물고기 떼에서 낚이는 {item:6358}은(는) 음식이 아닙니다. 연금술사가 이것으로 {item:6370}을(를) 만듭니다({skill:171} 80). 팔거나 거래할 수 있게 보관하십시오.",
	-- ["Fish the pools here until skill 225, about 500 catches: one in three raises the skill at 125, one in seven by 225, so this is the long stretch. Forever's second camping item, the {item:279965} (from skill 140), is a blueprint that drops from Gelihast in {area:2797}. Fish get away here below skill 150; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6330} for the {item:6308} of lakes and rivers ({skill:185} 100, 12s: {npc:3029} ({zone:1456}) or {npc:3027} ({zone:1456})); {item:6369} for the {item:6362} of the coast ({skill:185} 175, 22s: {npc:12962} ({zone:1440}) or Wulan ({zone:1443}))."] = "숙련도 225까지 이곳 낚시 지점에서 낚시하십시오. 약 500번 낚아야 합니다. 125에서는 세 번에 한 번, 225쯤에는 일곱 번에 한 번 숙련도가 오르므로 가장 긴 구간입니다. Forever의 두 번째 야영 아이템인 {item:279965}(숙련도 140부터)은(는) {area:2797}의 겔리하스트가 떨어뜨리는 설계도입니다. 숙련도 150 미만에서는 이곳 물고기가 도망갑니다. 낚싯대에 미끼를 달면 10분 동안 숙련도가 올라 그 차이를 메워 줍니다. 잡은 물고기 요리법: 호수와 강의 {item:6308}에는 {item:6330}({skill:185} 100, 12실버: {zone:1456}의 {npc:3029} 또는 {zone:1456}의 {npc:3027}), 해안의 {item:6362}에는 {item:6369}({skill:185} 175, 22실버: {zone:1440}의 {npc:12962} 또는 {zone:1443}의 울란).",
	-- ["Fish the pools here until skill 225, about 500 catches: one in three raises the skill at 125, one in seven by 225, so this is the long stretch. Forever's second camping item, the {item:279965} (from skill 140), is a blueprint that drops from Gelihast in {area:2797}. Fish get away here below skill 150; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6369} for the {item:6362} of the coast ({skill:185} 175, 22s: {npc:4307} ({zone:1439}))."] = "여기의 웅덩이에서 숙련도 225까지 낚으세요. 약 500마리입니다. 125에서 세 마리 중 한 마리, 225에서 일곱 마리 중 한 마리가 숙련도를 올리니 긴 구간입니다. Forever의 두 번째 야영 아이템 {item:279965}(숙련도 140부터)는 {area:2797}의 겔리하스트가 떨어뜨리는 도면입니다. 여기서는 숙련도 150 아래에서 물고기가 도망가며, 낚싯대에 미끼를 달면 10분 동안 숙련도가 더해져 격차를 줄입니다. 잡은 것을 요리하려면: 해안의 {item:6362}은(는) {item:6369}({skill:185} 175, 22실버: {npc:4307}({zone:1439})).",
	-- ["Fish the pools here until skill 225. If fish keep getting away, fish easier water until your skill catches up."] = "숙련도 225까지 이곳의 낚시터에서 낚시하세요. 물고기가 자꾸 달아나면 숙련도가 오를 때까지 더 쉬운 곳에서 낚시하세요.",
	-- ["Fish until skill 50, about 50 catches: below 75 every catch raises the skill, so any of your faction's starting-area shores will do and the arrow leads to the nearest: Sen'jin coast ({zone:1411}), {area:223} ({zone:1412}) and {area:162} ({zone:1420}), and for Skyborne also {area:16638} shore (Zephras Isle). Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. Fish get away at these shores below skill 25; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6325} for the {item:6291} of lakes and rivers ({skill:185} 1, 40c: {npc:5940} ({zone:1412}), {npc:3550} ({zone:1420}) and {npc:257006} (Zephras Isle)); {item:6326} for the {item:6303} of the coast ({skill:185} 1, 40c: {npc:5942} ({zone:1411}), {npc:3550} ({zone:1420}) and {npc:257006} (Zephras Isle))."] = "숙련도 50까지 낚시하세요. 약 50회입니다. 75 이하에서는 잡을 때마다 숙련도가 오르니 진영별 시작 지역 해안 어디든 괜찮고 화살표가 가장 가까운 곳을 가리킵니다: 센진 해안({zone:1411}), {area:223}({zone:1412}), {area:162}({zone:1420}), 스카이본은 {area:16638} 해안(제프라스 섬)도 가능합니다. 주문책에서 {skill:356}을(를) 시전하고 찌가 튀면 클릭하세요. 물고기는 버리지 마세요. 첫 {skill:185} 재료입니다. 숙련도 25 이하에서는 이 해안에서 물고기가 도망가니 낚싯대에 미끼를 달면 10분간 숙련도가 올라 격차를 메웁니다. 잡은 것을 요리하려면: 호수와 강의 {item:6291}에는 {item:6325}({skill:185} 1, 40코퍼: {npc:5940}({zone:1412}), {npc:3550}({zone:1420}), {npc:257006}(제프라스 섬)); 해안의 {item:6303}에는 {item:6326}({skill:185} 1, 40코퍼: {npc:5942}({zone:1411}), {npc:3550}({zone:1420}), {npc:257006}(제프라스 섬)).",
	-- ["Fish until skill 50, about 50 catches: below 75 every catch raises the skill, so any of your faction's starting-area shores will do and the arrow leads to the nearest: {area:18} ({zone:1429}), {area:211} ({zone:1426}) and {area:702} ({zone:1438}), and for Skyborne also {area:16638} shore (Zephras Isle). Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. Fish get away at these shores below skill 25; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6325} for the {item:6291} of lakes and rivers ({skill:185} 1, 40c: {npc:66} ({zone:1429}), {npc:8508} ({zone:1426}), Nyoma ({zone:1438}) and {npc:257006} (Zephras Isle)); {item:6326} for the {item:6303} of the coast ({skill:185} 1, 40c: {npc:4305} ({zone:1436}), {npc:5162} ({zone:1455}), {npc:10118} ({zone:1438}) and {npc:257006} (Zephras Isle))."] = "숙련도 50까지 낚시하세요. 약 50회입니다. 75 이하에서는 잡을 때마다 숙련도가 오르니 진영별 시작 지역 해안 어디든 괜찮고 화살표가 가장 가까운 곳을 가리킵니다: {area:18}({zone:1429}), {area:211}({zone:1426}), {area:702}({zone:1438}), 스카이본은 {area:16638} 해안(제프라스 섬)도 가능합니다. 주문책에서 {skill:356}을(를) 시전하고 찌가 튀면 클릭하세요. 물고기는 버리지 마세요. 첫 {skill:185} 재료입니다. 숙련도 25 이하에서는 이 해안에서 물고기가 도망가니 낚싯대에 미끼를 달면 10분간 숙련도가 올라 격차를 메웁니다. 잡은 것을 요리하려면: 호수와 강의 {item:6291}에는 {item:6325}({skill:185} 1, 40코퍼: {npc:66}({zone:1429}), {npc:8508}({zone:1426}), 니오마({zone:1438}), {npc:257006}(제프라스 섬)); 해안의 {item:6303}에는 {item:6326}({skill:185} 1, 40코퍼: {npc:4305}({zone:1436}), {npc:5162}({zone:1455}), {npc:10118}({zone:1438}), {npc:257006}(제프라스 섬)).",
	-- ["Journeyman {skill:356}"] = "수습 {skill:356}",
	-- ["Journeyman {skill:356} raises the cap to 150; it needs skill 50 and character level 10 (Forever's sniffed trainer lists ask for that level), and costs 5s. The arrow picks the nearest {skill:356} trainer of your faction. {spell:1229745}, Forever's camping item for {skill:356} (from skill 20, 1s or free from Camping 101: {skill:356}), is a {item:6291} in an {item:3371}: it gives no skill, but placed beside a campfire it gives everyone at the camp a buff for an hour."] = "{skill:356} 수습 단계는 150으로 상한을 올립니다. 숙련도 50과 캐릭터 레벨 10이 필요하고(Forever의 훔쳐본 상급자 목록은 그 레벨을 요구합니다) 5실버입니다. 화살표가 당신 진영의 가장 가까운 {skill:356} 상급자를 가리킵니다. {spell:1229745}, Forever의 {skill:356} 야영 아이템(숙련도 20부터, 1실버 또는 야영 기초 101: {skill:356}에서 무료)은(는) {item:3371}에 든 {item:6291}입니다. 숙련도는 주지 않지만, 모닥불 옆에 설치하면 한 시간 동안 야영지의 모두에게 강화 효과를 줍니다.",
	-- ["Journeyman {skill:356} raises the cap to 150; it needs skill 50 and character level 10. The arrow picks the nearest {skill:356} trainer of your faction."] = "수습 {skill:356}은(는) 최대 숙련도를 150(으)로 올립니다. 숙련도 50, 캐릭터 레벨 10이(가) 필요합니다. 화살표는 진영의 가장 가까운 {skill:356} 상급자를 가리킵니다.",
	-- ["Vile Fin shore"] = "썩은지느러미 물가",
	-- ["{area:287} coast"] = "{area:287} 해안",
	-- ["{area:35} coast"] = "{area:35} 해안",
	-- ["{area:442} shore"] = "{area:442} 물가",
	-- ["{npc:12919} fishes from the shore of a small island off the east coast, south of Theramore; swim over from the coast."] = "{npc:12919}은(는) 테라모어 섬 남쪽, 동쪽 해안 앞바다의 작은 섬 물가에서 낚시하고 있습니다. 해안에서 헤엄쳐 건너가세요.",
	-- ["{zone:1411} coast"] = "{zone:1411} 해안",
	-- ["{zone:1413} oasis"] = "{zone:1413} 오아시스",
	-- ["{zone:1436} coast"] = "{zone:1436} 해안",
	-- ["{zone:1437} coast"] = "{zone:1437} 해안",
	-- ["{zone:1439} coast"] = "{zone:1439} 해안",
	-- ["{zone:1440} waters"] = "{zone:1440} 바다",
}
