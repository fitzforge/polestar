-- Russian (ruRU): the guide forever/professions/fishing (forever/professions/fishing.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Fishing
	-- {skill:356} Fishing
	["Learn {skill:356}"] = "Изучите: {skill:356}",
	-- {skill:356} Fishing · {item:6256} Fishing Pole
	["Any {skill:356} trainer of your faction teaches Apprentice {skill:356} (character level 5); the arrow picks the nearest. Buy a {item:6256} from a trade goods or fishing vendor and equip it."] = "Любой учитель вашей фракции ({skill:356}) обучает навыку {skill:356}, ранг «Ученик» (уровень персонажа 5); стрелка ведет к ближайшему. Купите у торговца товарами или рыболовными принадлежностями: {item:6256} – и наденьте ее.",

	-- Step 2: Fishing: Elwynn Forest (1-50)
	["Fish here until skill 50. Click the bobber when it splashes; every catch can raise the skill."] = "Рыбачьте здесь до навыка 50. Щелкайте по поплавку, когда он плеснет; каждый улов может поднять навык.",

	-- Step 4: Fishing: Darkshore (1-50)
	-- {area:442} Auberdine
	["{area:442} shore"] = "{area:442}: берег",

	-- Step 5: Fishing: Durotar (1-50)
	-- {zone:1411} Durotar
	["{zone:1411} coast"] = "Побережье: {zone:1411}",

	-- Step 6: Fishing: The Barrens (1-50)
	-- {zone:1413} The Barrens
	["{zone:1413} oasis"] = "Оазис в {zone:1413}",

	-- Step 7: Fishing: Tirisfal Glades (1-50)
	["Vile Fin shore"] = "Берег Злобного Плавника",

	-- Step 8: Journeyman Fishing
	-- {skill:356} Fishing
	["Journeyman {skill:356}"] = "{skill:356}: Подмастерье",
	-- {skill:356} Fishing
	["Journeyman {skill:356} raises the cap to 150; it needs skill 50 and character level 10. The arrow picks the nearest {skill:356} trainer of your faction."] = "{skill:356}, ранг «Подмастерье»: предел 150; нужен навык 50 и уровень персонажа 10. Стрелка ведет к ближайшему учителю вашей фракции ({skill:356}).",

	-- Step 9: Fishing: Westfall (50-125)
	["Fish the pools and open water here until skill 125. Pools (floating debris, schools of fish) also drop extra loot."] = "Рыбачьте в косяках и открытой воде здесь до навыка 125. Косяки (плавающий мусор, стаи рыб) дают и дополнительную добычу.",
	-- {zone:1436} Westfall
	["{zone:1436} coast"] = "Побережье: {zone:1436}",

	-- Step 11: Fishing: Darkshore (50-125)
	-- {zone:1439} Darkshore
	["{zone:1439} coast"] = "Побережье: {zone:1439}",

	-- Step 14: Expert Fishing
	-- {skill:356} Fishing
	["Expert {skill:356}"] = "{skill:356}: Умелец",
	-- {skill:356} Fishing · {npc:2626} Old Man Heming · {item:16083} Expert Fishing - The Bass and You · {area:35} Booty Bay · {zone:1434} Stranglethorn Vale
	["Expert {skill:356} (cap 225) is a book, not a trainer rank: {npc:2626} sells {item:16083} in {area:35}, at the south tip of {zone:1434}, to both factions. Buy it and read it; it needs skill 125 and level 20."] = "{skill:356}, ранг «Умелец» (предел 225) – это книга, а не ранг у учителя: {npc:2626} продает ее обеим фракциям ({item:16083}) – {area:35}, южная оконечность зоны {zone:1434}. Купите и прочитайте; нужен навык 125 и уровень 20.",
	-- {item:16083} Expert Fishing - The Bass and You · {skill:356} Fishing
	["Buy and read {item:16083} (Expert {skill:356})"] = "Купите и прочитайте: {item:16083} ({skill:356}, «Умелец»)",

	-- Step 15: Fishing: Wetlands (125-225)
	["Fish the pools here until skill 225. If fish keep getting away, fish easier water until your skill catches up."] = "Рыбачьте в косяках здесь до навыка 225. Если рыба часто срывается, ловите в более простых водах, пока навык не подрастет.",
	-- {zone:1437} Wetlands
	["{zone:1437} coast"] = "Побережье: {zone:1437}",

	-- Step 16: Fishing: Ashenvale (125-225)
	-- {zone:1440} Ashenvale
	["{zone:1440} waters"] = "Воды: {zone:1440}",

	-- Step 18: Fishing: Hillsbrad Foothills (125-225)
	-- {area:287} Hillsbrad
	["{area:287} coast"] = "Побережье: {area:287}",

	-- Step 19: Nat Pagle, Angler Extreme
	-- {skill:356} Fishing · {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh · {zone:1455} Ironforge
	["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1455} sends you to him; the quest needs skill 225 and level 35."] = "{skill:356}, ранг «Искусник» (предел 300): {npc:12919} – {zone:1445}. К нему направляет учитель рыбной ловли (город {zone:1455}); для задания нужен навык 225 и уровень 35.",

	-- Step 20: Nat Pagle, Angler Extreme
	-- {skill:356} Fishing · {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh · {zone:1454} Orgrimmar
	["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1454} sends you to him; the quest needs skill 225 and level 35."] = "{skill:356}, ранг «Искусник» (предел 300): {npc:12919} – {zone:1445}. К нему направляет учитель рыбной ловли (город {zone:1454}); для задания нужен навык 225 и уровень 35.",

	-- Step 21: Nat Pagle
	-- {npc:12919} Nat Pagle
	["{npc:12919} fishes from the shore of a small island off the east coast, south of Theramore."] = "{npc:12919} рыбачит с берега небольшого острова у восточного побережья, к югу от Терамора.",

	-- Step 22: Sar'theris Striker
	-- {area:598} Sar'theris Strand · {zone:1443} Desolace · {item:16968} Sar'theris Striker
	["Fish in {area:598}, the north-west coast of {zone:1443} (Slitherblade naga shore) until you catch a {item:16968}; it only bites there."] = "Рыбачьте здесь: {area:598}, северо-западное побережье зоны {zone:1443} (берег наг из клана Скользящего Плавника), пока не поймаете: {item:16968}; она клюет только там.",

	-- Step 23: Feralas Ahi
	-- {area:2521} Verdantis River · {zone:1444} Feralas · {item:16967} Feralas Ahi
	["Fish in the {area:2521} in {zone:1444} until you catch a {item:16967}; it only bites there."] = "Рыбачьте здесь: {area:2521} ({zone:1444}), пока не поймаете: {item:16967}; она клюет только там.",

	-- Step 24: Savage Coast Blue Sailfin
	-- {area:301} Savage Coast · {zone:1434} Stranglethorn Vale · {item:16969} Savage Coast Blue Sailfin
	["Fish in the {area:301}, the north-west shore of {zone:1434} until you catch a {item:16969}; it only bites there."] = "Рыбачьте здесь: {area:301}, северо-западный берег зоны {zone:1434}, пока не поймаете: {item:16969}; она клюет только там.",

	-- Step 25: Misty Reed Mahi Mahi
	-- {area:300} Misty Reed Strand · {zone:1435} Swamp of Sorrows · {item:16970} Misty Reed Mahi Mahi
	["Fish in the {area:300}, the south-east shore of {zone:1435} until you catch a {item:16970}; it only bites there."] = "Рыбачьте здесь: {area:300}, юго-восточный берег зоны {zone:1435}, пока не поймаете: {item:16970}; она клюет только там.",

	-- Step 26: Nat Pagle
	-- {skill:356} Fishing
	["Artisan {skill:356}"] = "{skill:356}: Искусник",

	-- Step 27: Fishing: Stranglethorn Vale (225-300)
	-- {area:35} Booty Bay · {item:6530} Nightcrawlers
	["Fish the pools along the coast here (eels, snappers, wreckage) until skill 300. {area:35} sells bait and {item:6530} for a small fishing bonus."] = "Рыбачьте в косяках вдоль побережья (угри, луцианы, обломки) до навыка 300. В порту {area:35} продают наживку – {item:6530} – для небольшого бонуса к рыбной ловле.",
	-- {area:35} Booty Bay
	["{area:35} coast"] = "Побережье: {area:35}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{zone:1413} oasis"] = "{zone:1413}: оазис",
}
