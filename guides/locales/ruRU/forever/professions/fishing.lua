-- Russian (ruRU): the guide forever/professions/fishing (forever/professions/fishing.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Fishing
	-- {skill:356} Fishing
	["Learn {skill:356}"] = "Изучите: {skill:356}",
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
	-- was: ["Buy and read {item:16083} (Expert {skill:356})"] = "Купите и прочитайте: {item:16083} ({skill:356}, «Умелец»)"
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
	-- ["Any {skill:356} trainer of your faction teaches Apprentice {skill:356} (character level 5); the arrow picks the nearest. Buy a {item:6256} from a trade goods or fishing vendor and equip it."] = "Любой учитель вашей фракции ({skill:356}) обучает навыку {skill:356}, ранг «Ученик» (уровень персонажа 5); стрелка ведет к ближайшему. Купите у торговца товарами или рыболовными принадлежностями: {item:6256} – и наденьте ее.",
	-- ["Any {skill:356} trainer of your faction teaches Apprentice {skill:356} at any character level (1s); the arrow picks the nearest, and every starting area has one on its lake or shore. Buy a {item:6256} (23c) from a trade goods or fishing vendor and equip it (you can only fish with a pole in your hands), and two or three Shiny Baubles (+25, 50c each): a lure adds its bonus to your skill for ten minutes, so fewer fish get away at the start. If you sat at your starting area's campfire for The Great Outdoors, the camping guide there also offers Camping 101: {skill:356}, handed in to the fishing trainer it names at skill 20 for the {spell:1229745} recipe."] = "Любой учитель навыка {skill:356} вашей фракции обучает рангу «Ученик» ({skill:356}) на любом уровне персонажа (1с); стрелка указывает на ближайшего, и в каждой стартовой зоне такой есть у озера или на берегу. Купите {item:6256} (23м) у торговца хозяйственными товарами или рыболовными принадлежностями и возьмите ее в руки (рыбачить можно только с удочкой в руках), а также две-три блесны (+25, по 50м): приманка на десять минут добавляет свой бонус к навыку, так что поначалу рыба срывается реже. Если вы сидели у костра в своей стартовой зоне ради «Диких просторов», проводник по походной жизни там предложит и «Основы походной жизни: {skill:356}» – его сдают указанному в нем учителю рыбной ловли при навыке 20 за рецепт {spell:1229745}.",
	-- ["Artisan {skill:356}"] = "{skill:356}: Искусник",
	-- ["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1454} sends you to him; the quest needs skill 225 and level 35."] = "{skill:356}, ранг «Искусник» (предел 300): {npc:12919} – {zone:1445}. К нему направляет учитель рыбной ловли (город {zone:1454}); для задания нужен навык 225 и уровень 35.",
	-- ["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1455} sends you to him; the quest needs skill 225 and level 35."] = "{skill:356}, ранг «Искусник» (предел 300): {npc:12919} – {zone:1445}. К нему направляет учитель рыбной ловли (город {zone:1455}); для задания нужен навык 225 и уровень 35.",
	-- ["Buy and read {item:16083} (Expert {skill:356})"] = "Купите и прочитайте: {item:16083} ({skill:356}, «Умелец»)",
	-- ["Expert {skill:356}"] = "{skill:356}: Умелец",
	-- ["Expert {skill:356} (cap 225) is a book, not a trainer rank: {npc:2626} sells {item:16083} (1g) on the lowest dock of {area:35}, at the south tip of {zone:1434}, to both factions. Buy it and read it; it needs skill 125 and level 20. At level 20 the safe way in is the boat from {area:392} in {zone:1413}, not the road through Stranglethorn. He also sells {item:6532} (+75 from skill 100, 2s 50c each), the lure for the rest of the way."] = "{skill:356}, ранг «Умелец» (предел 225) – это книга, а не ранг у учителя: {npc:2626} продает ее обеим фракциям ({item:16083}, 1 з) на нижнем причале – {area:35}, южная оконечность зоны {zone:1434}. Купите и прочитайте; нужен навык 125 и уровень 20. На 20-м уровне безопасный путь туда – корабль из места {area:392} ({zone:1413}), а не дорога через Тернистую долину. Он также продает {item:6532} (+75 с навыка 100, 2 с 50 м за штуку) – приманку на остаток пути.",
	-- ["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. Fish get away here below skill 25; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6325} for the {item:6291} of lakes and rivers ({skill:185} 1, 40c: {npc:3550} ({zone:1420}) or {npc:4574} ({zone:1458})); {item:6326} for the {item:6303} of the coast ({skill:185} 1, 40c: {npc:3550} ({zone:1420}))."] = "Рыбачьте здесь до навыка 50, это около 50 уловов: до 75 каждый улов повышает навык. Применяйте {skill:356} из книги заклинаний и щелкайте по поплавку, когда он плеснет. Сохраняйте рыбу: это ваши первые ингредиенты для навыка {skill:185}. Здесь рыба срывается при навыке ниже 25; приманка на удочке на десять минут повышает навык и закрывает разрыв. Чтобы приготовить улов: {item:6325} для {item:6291} из озер и рек ({skill:185} 1, 40 м: {npc:3550} ({zone:1420}) или {npc:4574} ({zone:1458})); {item:6326} для {item:6303} с побережья ({skill:185} 1, 40 м: {npc:3550} ({zone:1420})).",
	-- ["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. Fish get away here below skill 25; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6325} for the {item:6291} of lakes and rivers ({skill:185} 1, 40c: {npc:5940} ({zone:1412}) or {npc:3029} ({zone:1456})); {item:6326} for the {item:6303} of the coast ({skill:185} 1, 40c: {npc:5942} ({zone:1411}))."] = "Рыбачьте здесь до навыка 50, это около 50 уловов: до 75 каждый улов повышает навык. Применяйте {skill:356} из книги заклинаний и щелкайте по поплавку, когда он плеснет. Сохраняйте рыбу: это ваши первые ингредиенты для навыка {skill:185}. Здесь рыба срывается при навыке ниже 25; приманка на удочке на десять минут повышает навык и закрывает разрыв. Чтобы приготовить улов: {item:6325} для {item:6291} из озер и рек ({skill:185} 1, 40 м: {npc:5940} ({zone:1412}) или {npc:3029} ({zone:1456})); {item:6326} для {item:6303} с побережья ({skill:185} 1, 40 м: {npc:5942} ({zone:1411})).",
	-- ["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. Fish get away here below skill 25; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6325} for the {item:6291} of lakes and rivers ({skill:185} 1, 40c: {npc:66} ({zone:1429}) or {npc:5494} ({zone:1453})); {item:6326} for the {item:6303} of the coast ({skill:185} 1, 40c: {npc:4305} ({zone:1436}) or {npc:5162} ({zone:1455}))."] = "Рыбачьте здесь до навыка 50, это около 50 уловов: до 75 каждый улов повышает навык. Применяйте {skill:356} из книги заклинаний и щелкайте по поплавку, когда он плеснет. Сохраняйте рыбу: это ваши первые ингредиенты для навыка {skill:185}. Здесь рыба срывается при навыке ниже 25; приманка на удочке на десять минут повышает навык и закрывает разрыв. Чтобы приготовить улов: {item:6325} для {item:6291} из озер и рек ({skill:185} 1, 40 м: {npc:66} ({zone:1429}) или {npc:5494} ({zone:1453})); {item:6326} для {item:6303} с побережья ({skill:185} 1, 40 м: {npc:4305} ({zone:1436}) или {npc:5162} ({zone:1455})).",
	-- ["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. Fish get away here below skill 25; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6325} for the {item:6291} of lakes and rivers ({skill:185} 1, 40c: {npc:8508} ({zone:1426}) or {npc:1684} ({zone:1432})); {item:6326} for the {item:6303} of the coast ({skill:185} 1, 40c: {npc:5162} ({zone:1455}) or {npc:4305} ({zone:1436}))."] = "Рыбачьте здесь до навыка 50, это около 50 уловов: до 75 каждый улов повышает навык. Применяйте {skill:356} из книги заклинаний и щелкайте по поплавку, когда он плеснет. Сохраняйте рыбу: это ваши первые ингредиенты для навыка {skill:185}. Здесь рыба срывается при навыке ниже 25; приманка на удочке на десять минут повышает навык и закрывает разрыв. Чтобы приготовить улов: {item:6325} для {item:6291} из озер и рек ({skill:185} 1, 40 м: {npc:8508} ({zone:1426}) или {npc:1684} ({zone:1432})); {item:6326} для {item:6303} с побережья ({skill:185} 1, 40 м: {npc:5162} ({zone:1455}) или {npc:4305} ({zone:1436})).",
	-- ["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. To cook what you catch: {item:6325} for the {item:6291} of lakes and rivers ({skill:185} 1, 40c: {npc:257006} ({zone:2521})); {item:6326} for the {item:6303} of the coast ({skill:185} 1, 40c: {npc:257006} ({zone:2521}))."] = "Рыбачьте здесь до навыка 50, это около 50 уловов: до 75 каждый улов повышает навык. Применяйте {skill:356} из книги заклинаний и щелкайте по поплавку, когда он плеснет. Сохраняйте рыбу: это ваши первые ингредиенты для навыка {skill:185}. Чтобы приготовить улов: {item:6325} для {item:6291} из озер и рек ({skill:185} 1, 40 м: {npc:257006} ({zone:2521})); {item:6326} для {item:6303} с побережья ({skill:185} 1, 40 м: {npc:257006} ({zone:2521})).",
	-- ["Fish here until skill 50. Click the bobber when it splashes; every catch can raise the skill."] = "Рыбачьте здесь до навыка 50. Щелкайте по поплавку, когда он плеснет; каждый улов может поднять навык.",
	-- ["Fish in the {area:2521} in {zone:1444} until you catch a {item:16967}; it only bites there."] = "Рыбачьте здесь: {area:2521} ({zone:1444}), пока не поймаете: {item:16967}; она клюет только там.",
	-- ["Fish in the {area:300}, the south-east shore of {zone:1435} until you catch a {item:16970}; it only bites there."] = "Рыбачьте здесь: {area:300}, юго-восточный берег зоны {zone:1435}, пока не поймаете: {item:16970}; она клюет только там.",
	-- ["Fish in the {area:301}, the north-west shore of {zone:1434} until you catch a {item:16969}; it only bites there."] = "Рыбачьте здесь: {area:301}, северо-западный берег зоны {zone:1434}, пока не поймаете: {item:16969}; она клюет только там.",
	-- ["Fish in {area:598}, the north-west coast of {zone:1443} (Slitherblade naga shore) until you catch a {item:16968}; it only bites there."] = "Рыбачьте здесь: {area:598}, северо-западное побережье зоны {zone:1443} (берег наг из клана Скользящего Плавника), пока не поймаете: {item:16968}; она клюет только там.",
	-- ["Fish the pools along the coast here (eels, snappers, wreckage) until skill 300. {area:35} sells bait and {item:6530} for a small fishing bonus."] = "Рыбачьте в косяках вдоль побережья (угри, луцианы, обломки) до навыка 300. В порту {area:35} продают наживку – {item:6530} – для небольшого бонуса к рыбной ловле.",
	-- ["Fish the pools and open water here until skill 125, about 120 catches: from 75 a catch raises the skill less often (about one in two by 100, one in three by 125). Pools (floating wreckage, schools of fish) also give extra loot. {item:6530} (+50 from skill 50, 1s each) are twice as strong as a {item:6529}. The {item:6365} (+5 from skill 10, 9s 1c) is in limited stock at fishing vendors: buy it when you see it. Fish get away here below skill 75; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6328} for the {item:6289} of lakes and rivers ({skill:185} 50, 4s: Nyoma ({zone:1438})); {item:6368} for the {item:6361} of the coast ({skill:185} 50, 4s: {npc:4307} ({zone:1439}) or {npc:10118} ({zone:1438})). {item:12238} bites only here: eat it as it is. {npc:10216} ({zone:1439}) takes 6 for The Family and the {item:6256}, which gives the {item:12221}. {item:6358} from the schools here is no food: alchemists make {item:6370} from it ({skill:171} 80); keep it to sell or trade."] = "Рыбачьте здесь в косяках и на открытой воде до навыка 125, это около 120 уловов: с 75 улов повышает навык реже (примерно каждый второй к 100, каждый третий к 125). Косяки (плавающие обломки, стаи рыб) также дают дополнительную добычу. {item:6530} (+50 с навыка 50, 1 с за штуку) вдвое сильнее, чем {item:6529}. {item:6365} (+5 с навыка 10, 9 с 1 м) у торговцев рыболовными товарами в ограниченном количестве: покупайте, когда увидите. Здесь рыба срывается при навыке ниже 75; приманка на удочке на десять минут повышает навык и закрывает разрыв. Чтобы приготовить улов: {item:6328} для {item:6289} из озер и рек ({skill:185} 50, 4 с: Ниома ({zone:1438})); {item:6368} для {item:6361} с побережья ({skill:185} 50, 4 с: {npc:4307} ({zone:1439}) или {npc:10118} ({zone:1438})). {item:12238} клюет только здесь: ешьте ее как есть. {npc:10216} ({zone:1439}) берет 6 штук для задания «The Family and the {item:6256}», которое дает {item:12221}. {item:6358} из здешних косяков в пищу не годится: алхимики делают из нее {item:6370} ({skill:171} 80); сохраняйте ее для продажи или обмена.",
	-- ["Fish the pools and open water here until skill 125, about 120 catches: from 75 a catch raises the skill less often (about one in two by 100, one in three by 125). Pools (floating wreckage, schools of fish) also give extra loot. {item:6530} (+50 from skill 50, 1s each) are twice as strong as a {item:6529}. The {item:6365} (+5 from skill 10, 9s 1c) is in limited stock at fishing vendors: buy it when you see it. Fish get away here below skill 75; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6328} for the {item:6289} of lakes and rivers ({skill:185} 50, 4s: {npc:5748} ({zone:1421}) or {npc:4574} ({zone:1458})); {item:6368} for the {item:6361} of the coast ({skill:185} 50, 4s: {npc:4553} ({zone:1458}) or {npc:5748} ({zone:1421})). {item:6358} from the schools here is no food: alchemists make {item:6370} from it ({skill:171} 80); keep it to sell or trade."] = "Рыбачьте здесь в косяках и на открытой воде до навыка 125, это около 120 уловов: с 75 улов повышает навык реже (примерно каждый второй к 100, каждый третий к 125). Косяки (плавающие обломки, стаи рыб) также дают дополнительную добычу. {item:6530} (+50 с навыка 50, 1 с за штуку) вдвое сильнее, чем {item:6529}. {item:6365} (+5 с навыка 10, 9 с 1 м) у торговцев рыболовными товарами в ограниченном количестве: покупайте, когда увидите. Здесь рыба срывается при навыке ниже 75; приманка на удочке на десять минут повышает навык и закрывает разрыв. Чтобы приготовить улов: {item:6328} для {item:6289} из озер и рек ({skill:185} 50, 4 с: {npc:5748} ({zone:1421}) или {npc:4574} ({zone:1458})); {item:6368} для {item:6361} с побережья ({skill:185} 50, 4 с: {npc:4553} ({zone:1458}) или {npc:5748} ({zone:1421})). {item:6358} из здешних косяков в пищу не годится: алхимики делают из нее {item:6370} ({skill:171} 80); сохраняйте ее для продажи или обмена.",
	-- ["Fish the pools and open water here until skill 125, about 120 catches: from 75 a catch raises the skill less often (about one in two by 100, one in three by 125). Pools (floating wreckage, schools of fish) also give extra loot. {item:6530} (+50 from skill 50, 1s each) are twice as strong as a {item:6529}. The {item:6365} (+5 from skill 10, 9s 1c) is in limited stock at fishing vendors: buy it when you see it. Fish get away here below skill 75; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6328} for the {item:6289} of lakes and rivers ({skill:185} 50, 4s: {npc:5940} ({zone:1412}) or {npc:3027} ({zone:1456})); {item:6368} for the {item:6361} of the coast ({skill:185} 50, 4s: {npc:5942} ({zone:1411}) or {npc:3333} ({zone:1454})). {item:6358} from the schools here is no food: alchemists make {item:6370} from it ({skill:171} 80); keep it to sell or trade."] = "Рыбачьте здесь в косяках и на открытой воде до навыка 125, это около 120 уловов: с 75 улов повышает навык реже (примерно каждый второй к 100, каждый третий к 125). Косяки (плавающие обломки, стаи рыб) также дают дополнительную добычу. {item:6530} (+50 с навыка 50, 1 с за штуку) вдвое сильнее, чем {item:6529}. {item:6365} (+5 с навыка 10, 9 с 1 м) у торговцев рыболовными товарами в ограниченном количестве: покупайте, когда увидите. Здесь рыба срывается при навыке ниже 75; приманка на удочке на десять минут повышает навык и закрывает разрыв. Чтобы приготовить улов: {item:6328} для {item:6289} из озер и рек ({skill:185} 50, 4 с: {npc:5940} ({zone:1412}) или {npc:3027} ({zone:1456})); {item:6368} для {item:6361} с побережья ({skill:185} 50, 4 с: {npc:5942} ({zone:1411}) или {npc:3333} ({zone:1454})). {item:6358} из здешних косяков в пищу не годится: алхимики делают из нее {item:6370} ({skill:171} 80); сохраняйте ее для продажи или обмена.",
	-- ["Fish the pools and open water here until skill 125, about 120 catches: from 75 a catch raises the skill less often (about one in two by 100, one in three by 125). Pools (floating wreckage, schools of fish) also give extra loot. {item:6530} (+50 from skill 50, 1s each) are twice as strong as a {item:6529}. The {item:6365} (+5 from skill 10, 9s 1c) is in limited stock at fishing vendors: buy it when you see it. Fish get away here below skill 75; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6328} for the {item:6289} of lakes and rivers ({skill:185} 50, 4s: {npc:66} ({zone:1429}) or {npc:5162} ({zone:1455})); {item:6368} for the {item:6361} of the coast ({skill:185} 50, 4s: {npc:5494} ({zone:1453}) or {npc:4305} ({zone:1436})). {item:6358} from the schools here is no food: alchemists make {item:6370} from it ({skill:171} 80); keep it to sell or trade."] = "Рыбачьте здесь в косяках и на открытой воде до навыка 125, это около 120 уловов: с 75 улов повышает навык реже (примерно каждый второй к 100, каждый третий к 125). Косяки (плавающие обломки, стаи рыб) также дают дополнительную добычу. {item:6530} (+50 с навыка 50, 1 с за штуку) вдвое сильнее, чем {item:6529}. {item:6365} (+5 с навыка 10, 9 с 1 м) у торговцев рыболовными товарами в ограниченном количестве: покупайте, когда увидите. Здесь рыба срывается при навыке ниже 75; приманка на удочке на десять минут повышает навык и закрывает разрыв. Чтобы приготовить улов: {item:6328} для {item:6289} из озер и рек ({skill:185} 50, 4 с: {npc:66} ({zone:1429}) или {npc:5162} ({zone:1455})); {item:6368} для {item:6361} с побережья ({skill:185} 50, 4 с: {npc:5494} ({zone:1453}) или {npc:4305} ({zone:1436})). {item:6358} из здешних косяков в пищу не годится: алхимики делают из нее {item:6370} ({skill:171} 80); сохраняйте ее для продажи или обмена.",
	-- ["Fish the pools and open water here until skill 125. Pools (floating debris, schools of fish) also drop extra loot."] = "Рыбачьте в косяках и открытой воде здесь до навыка 125. Косяки (плавающий мусор, стаи рыб) дают и дополнительную добычу.",
	-- ["Fish the pools here until skill 225, about 500 catches: one in three raises the skill at 125, one in seven by 225, so this is the long stretch. Forever's second camping item, the {item:279965} (from skill 140), is a blueprint that drops from Gelihast in {area:2797}. Fish get away here below skill 150; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6330} for the {item:6308} of lakes and rivers ({skill:185} 100, 12s: {npc:2383} ({zone:1424}) or {npc:5494} ({zone:1453})); {item:6369} for the {item:6362} of the coast ({skill:185} 175, 22s: {npc:3178} ({zone:1437}) or {npc:5162} ({zone:1455})). {item:6358} from the schools here is no food: alchemists make {item:6370} from it ({skill:171} 80); keep it to sell or trade."] = "Рыбачьте здесь в косяках до навыка 225, это около 500 уловов: на 125 навык повышает каждый третий улов, к 225 – каждый седьмой, так что это долгий отрезок. Второй походный предмет Forever, {item:279965} (с навыка 140), – это чертеж, который падает с Гелихаста в подземелье {area:2797}. Здесь рыба срывается при навыке ниже 150; приманка на удочке на десять минут повышает навык и закрывает разрыв. Чтобы приготовить улов: {item:6330} для {item:6308} из озер и рек ({skill:185} 100, 12 с: {npc:2383} ({zone:1424}) или {npc:5494} ({zone:1453})); {item:6369} для {item:6362} с побережья ({skill:185} 175, 22 с: {npc:3178} ({zone:1437}) или {npc:5162} ({zone:1455})). {item:6358} из здешних косяков в пищу не годится: алхимики делают из нее {item:6370} ({skill:171} 80); сохраняйте ее для продажи или обмена.",
	-- ["Fish the pools here until skill 225, about 500 catches: one in three raises the skill at 125, one in seven by 225, so this is the long stretch. Forever's second camping item, the {item:279965} (from skill 140), is a blueprint that drops from Gelihast in {area:2797}. Fish get away here below skill 150; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6330} for the {item:6308} of lakes and rivers ({skill:185} 100, 12s: {npc:2397} ({zone:1424}) or {npc:4553} ({zone:1458})); {item:6369} for the {item:6362} of the coast ({skill:185} 175, 22s: {npc:4574} ({zone:1458})). {item:6358} from the schools here is no food: alchemists make {item:6370} from it ({skill:171} 80); keep it to sell or trade."] = "Рыбачьте здесь в косяках до навыка 225, это около 500 уловов: на 125 навык повышает каждый третий улов, к 225 – каждый седьмой, так что это долгий отрезок. Второй походный предмет Forever, {item:279965} (с навыка 140), – это чертеж, который падает с Гелихаста в подземелье {area:2797}. Здесь рыба срывается при навыке ниже 150; приманка на удочке на десять минут повышает навык и закрывает разрыв. Чтобы приготовить улов: {item:6330} для {item:6308} из озер и рек ({skill:185} 100, 12 с: {npc:2397} ({zone:1424}) или {npc:4553} ({zone:1458})); {item:6369} для {item:6362} с побережья ({skill:185} 175, 22 с: {npc:4574} ({zone:1458})). {item:6358} из здешних косяков в пищу не годится: алхимики делают из нее {item:6370} ({skill:171} 80); сохраняйте ее для продажи или обмена.",
	-- ["Fish the pools here until skill 225, about 500 catches: one in three raises the skill at 125, one in seven by 225, so this is the long stretch. Forever's second camping item, the {item:279965} (from skill 140), is a blueprint that drops from Gelihast in {area:2797}. Fish get away here below skill 150; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6330} for the {item:6308} of lakes and rivers ({skill:185} 100, 12s: {npc:3029} ({zone:1456}) or {npc:3027} ({zone:1456})); {item:6369} for the {item:6362} of the coast ({skill:185} 175, 22s: {npc:12962} ({zone:1440}) or Wulan ({zone:1443}))."] = "Рыбачьте здесь в косяках до навыка 225, это около 500 уловов: на 125 навык повышает каждый третий улов, к 225 – каждый седьмой, так что это долгий отрезок. Второй походный предмет Forever, {item:279965} (с навыка 140), – это чертеж, который падает с Гелихаста в подземелье {area:2797}. Здесь рыба срывается при навыке ниже 150; приманка на удочке на десять минут повышает навык и закрывает разрыв. Чтобы приготовить улов: {item:6330} для {item:6308} из озер и рек ({skill:185} 100, 12 с: {npc:3029} ({zone:1456}) или {npc:3027} ({zone:1456})); {item:6369} для {item:6362} с побережья ({skill:185} 175, 22 с: {npc:12962} ({zone:1440}) или Вулан ({zone:1443})).",
	-- ["Fish the pools here until skill 225. If fish keep getting away, fish easier water until your skill catches up."] = "Рыбачьте в косяках здесь до навыка 225. Если рыба часто срывается, ловите в более простых водах, пока навык не подрастет.",
	-- ["Journeyman {skill:356}"] = "{skill:356}: Подмастерье",
	-- ["Journeyman {skill:356} raises the cap to 150; it needs skill 50 and character level 10. The arrow picks the nearest {skill:356} trainer of your faction."] = "{skill:356}, ранг «Подмастерье»: предел 150; нужен навык 50 и уровень персонажа 10. Стрелка ведет к ближайшему учителю вашей фракции ({skill:356}).",
	-- ["Vile Fin shore"] = "Берег Злобного Плавника",
	-- ["{area:287} coast"] = "Побережье: {area:287}",
	-- ["{area:35} coast"] = "Побережье: {area:35}",
	-- ["{area:442} shore"] = "{area:442}: берег",
	-- ["{npc:12919} fishes from the shore of a small island off the east coast, south of Theramore; swim over from the coast."] = "{npc:12919} рыбачит с берега небольшого острова у восточного побережья, к югу от Терамора; доплывите туда с берега.",
	-- ["{zone:1411} coast"] = "Побережье: {zone:1411}",
	-- ["{zone:1413} oasis"] = "Оазис в {zone:1413}",
	-- ["{zone:1436} coast"] = "Побережье: {zone:1436}",
	-- ["{zone:1437} coast"] = "Побережье: {zone:1437}",
	-- ["{zone:1439} coast"] = "Побережье: {zone:1439}",
	-- ["{zone:1440} waters"] = "Воды: {zone:1440}",
}
