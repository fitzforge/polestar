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
	-- {skill:356} Fishing · {item:6256} Fishing Pole · {spell:1229745} Fish Bowl
	-- plural, as words: Shiny Baubles = {item:6529} Shiny Bauble
	["Any {skill:356} trainer of your faction teaches Apprentice {skill:356} (character level 5, 1s); the arrow picks the nearest, and every starting area has one on its lake or shore. Buy a {item:6256} (23c) from a trade goods or fishing vendor and equip it (you can only fish with a pole in your hands), and two or three Shiny Baubles (+25, 50c each): a lure adds its bonus to your skill for ten minutes, so fewer fish get away at the start. If you sat at your starting area's campfire for The Great Outdoors, the camping guide there also offers Camping 101: {skill:356}, handed in to the fishing trainer it names at skill 20 for the {spell:1229745} recipe."] = "",

	-- Step 2: Fishing: Elwynn Forest (1-50)
	-- {skill:356} Fishing · {skill:185} Cooking
	["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. Fish get away here below skill 25; a lure on the pole adds to your skill for ten minutes and closes the gap."] = "",
	["Crystal Lake"] = "",

	-- Step 3: Fishing: Dun Morogh (1-50)
	["Iceflow Lake"] = "",

	-- Step 4: Fishing: Teldrassil (1-50)
	["Rut'theran Village"] = "",

	-- Step 5: Fishing: Zephras Isle (1-50)
	-- {skill:356} Fishing · {skill:185} Cooking
	["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients."] = "",
	["Valanaar shore"] = "",

	-- Step 6: Fishing: Durotar (1-50)
	["Sen'jin coast"] = "",

	-- Step 7: Fishing: Mulgore (1-50)
	["Stonebull Lake"] = "",

	-- Step 8: Fishing: Tirisfal Glades (1-50)
	["Brightwater Lake"] = "",

	-- Step 10: Journeyman Fishing
	-- {skill:356} Fishing
	["Journeyman {skill:356}"] = "{skill:356}: Подмастерье",
	-- {skill:356} Fishing · {spell:1229745} Fish Bowl · {item:6291} Raw Brilliant Smallfish · {item:3371} Empty Vial
	["Journeyman {skill:356} raises the cap to 150; it needs skill 50 and character level 10 (Forever's sniffed trainer lists ask for that level), and costs 5s. The arrow picks the nearest {skill:356} trainer of your faction. {spell:1229745}, Forever's camping item for {skill:356} (from skill 20, 1s or free from Camping 101: {skill:356}), is a {item:6291} in an {item:3371}: it gives no skill, but placed beside a campfire it gives everyone at the camp a buff for an hour."] = "",

	-- Step 11: Fishing: Westfall (50-125)
	-- {item:6530} Nightcrawlers · {item:6529} Shiny Bauble · {item:6365} Strong Fishing Pole
	["Fish the pools and open water here until skill 125, about 120 catches: from 75 a catch raises the skill less often (about one in two by 100, one in three by 125). Pools (floating wreckage, schools of fish) also give extra loot. {item:6530} (+50 from skill 50, 1s each) are twice as strong as a {item:6529}. The {item:6365} (+5 from skill 10, 9s 1c) is in limited stock at fishing vendors: buy it when you see it. Fish get away here below skill 75; a lure on the pole adds to your skill for ten minutes and closes the gap."] = "",
	-- {zone:1436} Westfall
	["{zone:1436} coast"] = "Побережье: {zone:1436}",

	-- Step 12: Fishing: Loch Modan (50-125)
	["The Loch"] = "",

	-- Step 13: Fishing: Darkshore (50-125)
	-- {zone:1439} Darkshore
	["{zone:1439} coast"] = "Побережье: {zone:1439}",

	-- Step 14: Fishing: The Barrens (50-125)
	-- {zone:1413} The Barrens
	["{zone:1413} oasis"] = "Оазис в {zone:1413}",

	-- Step 15: Fishing: Silverpine Forest (50-125)
	["Lordamere Lake"] = "",

	-- Step 16: Expert Fishing
	-- {skill:356} Fishing
	["Expert {skill:356}"] = "{skill:356}: Умелец",
	-- {skill:356} Fishing · {npc:2626} Old Man Heming · {item:16083} Expert Fishing - The Bass and You · {object:3204} Booty Bay (no name in this language: may be words) · {zone:1434} Stranglethorn Vale · {zone:1413} The Barrens · {item:6532} Bright Baubles
	["Expert {skill:356} (cap 225) is a book, not a trainer rank: {npc:2626} sells {item:16083} (1g) on the lowest dock of {object:3204}, at the south tip of {zone:1434}, to both factions. Buy it and read it; it needs skill 125 and level 20. At level 20 the safe way in is the boat from Ratchet in {zone:1413}, not the road through Stranglethorn. He also sells {item:6532} (+75 from skill 100, 2s 50c each), the lure for the rest of the way."] = "",
	-- {item:16083} Expert Fishing - The Bass and You · {skill:356} Fishing
	["Buy and read {item:16083} (Expert {skill:356})"] = "Купите и прочитайте: {item:16083} ({skill:356}, «Умелец»)",

	-- Step 17: Fishing: Wetlands (125-225)
	-- {item:279965} Fishing Rack
	["Fish the pools here until skill 225, about 500 catches: one in three raises the skill at 125, one in seven by 225, so this is the long stretch. Forever's second camping item, the {item:279965} (from skill 140), is a blueprint that drops from Gelihast in Blackfathom Deeps. Fish get away here below skill 150; a lure on the pole adds to your skill for ten minutes and closes the gap."] = "",
	-- {zone:1437} Wetlands
	["{zone:1437} coast"] = "Побережье: {zone:1437}",

	-- Step 18: Fishing: Ashenvale (125-225)
	-- {zone:1440} Ashenvale
	["{zone:1440} waters"] = "Воды: {zone:1440}",

	-- Step 19: Fishing: Stonetalon Mountains (125-225)
	["Mirkfallon Lake"] = "",

	-- Step 20: Fishing: Hillsbrad Foothills (125-225)
	["Hillsbrad coast"] = "",

	-- Step 21: Nat Pagle, Angler Extreme
	-- {skill:356} Fishing · {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh · {zone:1455} Ironforge
	["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1455} sends you to him; the quest needs skill 225 and level 35."] = "{skill:356}, ранг «Искусник» (предел 300): {npc:12919} – {zone:1445}. К нему направляет учитель рыбной ловли (город {zone:1455}); для задания нужен навык 225 и уровень 35.",

	-- Step 22: Nat Pagle, Angler Extreme
	-- {skill:356} Fishing · {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh · {zone:1454} Orgrimmar
	["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1454} sends you to him; the quest needs skill 225 and level 35."] = "{skill:356}, ранг «Искусник» (предел 300): {npc:12919} – {zone:1445}. К нему направляет учитель рыбной ловли (город {zone:1454}); для задания нужен навык 225 и уровень 35.",

	-- Step 23: Nat Pagle
	-- {npc:12919} Nat Pagle
	["{npc:12919} fishes from the shore of a small island off the east coast, south of Theramore; swim over from the coast."] = "",

	-- Step 24: Sar'theris Striker
	-- {zone:1443} Desolace · {object:176946} Shadowprey Village (no name in this language: may be words) · {item:16968} Sar'theris Striker
	["Fish along the coast of {zone:1443} (Sar'theris Strand in the north-west, or the shore west of {object:176946}) until you catch a {item:16968}: about one catch in five there brings it up, and it bites nowhere else. At skill 225 nothing gets away here."] = "",

	-- Step 26: Feralas Ahi
	-- {zone:1444} Feralas · {item:16967} Feralas Ahi · {item:6532} Bright Baubles
	["Fish along the Verdantis River in {zone:1444} (south-east of Dire Maul) until you catch a {item:16967}: about one catch in five there brings it up, and it bites nowhere else. This water loses fish below skill 300: at 225 most get away, so put {item:6532} (+75) on the pole first."] = "",

	-- Step 27: Savage Coast Blue Sailfin
	-- {zone:1434} Stranglethorn Vale · {item:16969} Savage Coast Blue Sailfin
	["Fish along {zone:1434}'s Savage Coast (the west shore) until you catch a {item:16969}: about one catch in five there brings it up, and it bites nowhere else. At skill 225 nothing gets away here."] = "",

	-- Step 29: Misty Reed Mahi Mahi
	-- {zone:1435} Swamp of Sorrows · {item:16970} Misty Reed Mahi Mahi
	["Fish along the Misty Reed Strand (the east shore of {zone:1435}) until you catch a {item:16970}: about one catch in five there brings it up, and it bites nowhere else. At skill 225 nothing gets away here."] = "",

	-- Step 30: Nat Pagle
	-- {skill:356} Fishing
	["Artisan {skill:356}"] = "{skill:356}: Искусник",

	-- Step 31: Fishing: Stranglethorn Vale (225-300)
	-- {item:6533} Aquadynamic Fish Attractor · {item:6532} Bright Baubles
	["Fish the pools along the coast here (eels, snappers, wreckage) until skill 300, about 650 catches (one in seven raises the skill at 225, one in ten by 300). Harder water levels no faster: a catch counts the same anywhere. From skill 225 this water loses no fish, so no lure is needed. The {item:6533} (+100 from skill 100, 2s 50c) and {item:6532} are for harder water and rare fish, not for skill."] = "",
	-- {object:3204} Booty Bay (no name in this language: may be words)
	["{object:3204} coast"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any {skill:356} trainer of your faction teaches Apprentice {skill:356} (character level 5); the arrow picks the nearest. Buy a {item:6256} from a trade goods or fishing vendor and equip it."] = "Любой учитель вашей фракции ({skill:356}) обучает навыку {skill:356}, ранг «Ученик» (уровень персонажа 5); стрелка ведет к ближайшему. Купите у торговца товарами или рыболовными принадлежностями: {item:6256} – и наденьте ее.",
	-- ["Expert {skill:356} (cap 225) is a book, not a trainer rank: {npc:2626} sells {item:16083} in {area:35}, at the south tip of {zone:1434}, to both factions. Buy it and read it; it needs skill 125 and level 20."] = "{skill:356}, ранг «Умелец» (предел 225) – это книга, а не ранг у учителя: {npc:2626} продает ее обеим фракциям ({item:16083}) – {area:35}, южная оконечность зоны {zone:1434}. Купите и прочитайте; нужен навык 125 и уровень 20.",
	-- ["Fish here until skill 50. Click the bobber when it splashes; every catch can raise the skill."] = "Рыбачьте здесь до навыка 50. Щелкайте по поплавку, когда он плеснет; каждый улов может поднять навык.",
	-- ["Fish in the {area:2521} in {zone:1444} until you catch a {item:16967}; it only bites there."] = "Рыбачьте здесь: {area:2521} ({zone:1444}), пока не поймаете: {item:16967}; она клюет только там.",
	-- ["Fish in the {area:300}, the south-east shore of {zone:1435} until you catch a {item:16970}; it only bites there."] = "Рыбачьте здесь: {area:300}, юго-восточный берег зоны {zone:1435}, пока не поймаете: {item:16970}; она клюет только там.",
	-- ["Fish in the {area:301}, the north-west shore of {zone:1434} until you catch a {item:16969}; it only bites there."] = "Рыбачьте здесь: {area:301}, северо-западный берег зоны {zone:1434}, пока не поймаете: {item:16969}; она клюет только там.",
	-- ["Fish in {area:598}, the north-west coast of {zone:1443} (Slitherblade naga shore) until you catch a {item:16968}; it only bites there."] = "Рыбачьте здесь: {area:598}, северо-западное побережье зоны {zone:1443} (берег наг из клана Скользящего Плавника), пока не поймаете: {item:16968}; она клюет только там.",
	-- ["Fish the pools along the coast here (eels, snappers, wreckage) until skill 300. {area:35} sells bait and {item:6530} for a small fishing bonus."] = "Рыбачьте в косяках вдоль побережья (угри, луцианы, обломки) до навыка 300. В порту {area:35} продают наживку – {item:6530} – для небольшого бонуса к рыбной ловле.",
	-- ["Fish the pools and open water here until skill 125. Pools (floating debris, schools of fish) also drop extra loot."] = "Рыбачьте в косяках и открытой воде здесь до навыка 125. Косяки (плавающий мусор, стаи рыб) дают и дополнительную добычу.",
	-- ["Fish the pools here until skill 225. If fish keep getting away, fish easier water until your skill catches up."] = "Рыбачьте в косяках здесь до навыка 225. Если рыба часто срывается, ловите в более простых водах, пока навык не подрастет.",
	-- ["Journeyman {skill:356} raises the cap to 150; it needs skill 50 and character level 10. The arrow picks the nearest {skill:356} trainer of your faction."] = "{skill:356}, ранг «Подмастерье»: предел 150; нужен навык 50 и уровень персонажа 10. Стрелка ведет к ближайшему учителю вашей фракции ({skill:356}).",
	-- ["Vile Fin shore"] = "Берег Злобного Плавника",
	-- ["{area:287} coast"] = "Побережье: {area:287}",
	-- ["{area:35} coast"] = "Побережье: {area:35}",
	-- ["{area:442} shore"] = "{area:442}: берег",
	-- ["{npc:12919} fishes from the shore of a small island off the east coast, south of Theramore."] = "{npc:12919} рыбачит с берега небольшого острова у восточного побережья, к югу от Терамора.",
	-- ["{zone:1411} coast"] = "Побережье: {zone:1411}",
	-- ["{zone:1413} oasis"] = "{zone:1413}: оазис",
}
