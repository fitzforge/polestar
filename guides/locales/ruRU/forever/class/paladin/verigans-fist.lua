-- Russian (ruRU): the guide forever/class/paladin/verigans-fist (forever/class/paladin/verigans-fist.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["The Alliance paladin's rare two-handed mace for the 20s, with a shield on the way."] = "Редкая двуручная булава паладина Альянса для уровней 20-29, а по пути еще и щит.",

	-- Step 1: The Tome of Valor (Ironforge)
	-- {npc:6179} Tiza Battleforge · {object:32362} Mystic Ward · {item:6776} Tome of Valor · {npc:6171} Duthorian Rall · {zone:1453} Stormwind · {zone:1455} Ironforge
	["At 20 {npc:6179} in the {object:32362} gives you the {item:6776}; it sends you to {npc:6171} in {zone:1453}'s Cathedral of Light. Take the tram from {zone:1455} to {zone:1453}."] = "На 20-м уровне {npc:6179} ({object:32362}) дает вам {item:6776}; он отправляет вас к NPC {npc:6171} в Собор Света ({zone:1453}). Сядьте на подземный поезд из города {zone:1455} в город {zone:1453}.",

	-- Step 2: The Tome of Valor
	-- {npc:6171} Duthorian Rall · {item:6776} Tome of Valor
	["{npc:6171} stands in the Cathedral of Light. Right-click the {item:6776} to start its quest."] = "{npc:6171} стоит в Соборе Света. Щелкните правой кнопкой мыши по предмету {item:6776}, чтобы начать его задание.",
	-- {item:6776} Tome of Valor
	["from the {item:6776}"] = "из предмета {item:6776}",

	-- Step 3: Daphne Stilwell
	-- {npc:6182} Daphne Stilwell · {zone:1436} Westfall
	["{npc:6182}'s farmhouse stands on the south-west coast of {zone:1436}. Waves of Defias attack it during her quest: keep her alive, and heal her if she needs it."] = "Ферма NPC {npc:6182} стоит на юго-западном побережье зоны {zone:1436}. Во время ее задания на ферму нападают волны Братства Справедливости: не дайте ей погибнуть и лечите ее при необходимости.",
	-- {npc:6182} Daphne Stilwell
	["Protect {npc:6182}"] = "Защитите: {npc:6182}",

	-- Step 5: Jordan Stilwell
	-- {npc:6181} Jordan Stilwell · {zone:1455} Ironforge · {item:6996} Jordan's Weapon Notes
	["{npc:6181} stands outside the gates of {zone:1455}. He gives you {item:6996}, which list the four parts."] = "{npc:6181} стоит у ворот города {zone:1455}. Он дает вам {item:6996}, где перечислены четыре части.",

	-- Step 6: Bailor Stonehand
	-- {npc:6241} Bailor Stonehand · {area:144} Thelsamar
	["{npc:6241} is in {area:144}."] = "{npc:6241} находится здесь: {area:144}.",

	-- Step 7: Bailor's Ore
	-- {zone:1432} Loch Modan
	["The ore crate lies by the trees in the middle of the Mo'grosh ogre camp in north-east {zone:1432}. The Mo'grosh ogres are elite: grouping up is advised."] = "Ящик с рудой лежит у деревьев посреди лагеря огров Мо'Грош на северо-востоке зоны {zone:1432}. Огры Мо'Грош — элитные: лучше собрать группу.",
	-- {object:92420} Bailor's Ore
	["{object:92420} crate"] = "Ящик: {object:92420}",

	-- Step 8: Back to Bailor Stonehand
	-- {npc:6241} Bailor Stonehand
	["Back to {npc:6241}"] = "Обратно к NPC {npc:6241}",
	-- {npc:6241} Bailor Stonehand · {item:6993} Jordan's Refined Ore Shipment
	["{npc:6241} turns the ore into {item:6993}."] = "{npc:6241} превращает руду в {item:6993}.",

	-- Step 9: Whitestone Oak Lumber
	-- {area:1581} The Deadmines · {area:20} Moonbrook
	-- plural, as words: Goblin Woodcarvers = {npc:641} Goblin Woodcarver
	["{area:1581} is a group of five under {area:20}; the instance portal is inside the {area:20} mine. The Goblin Woodcarvers in the Mast Room, with Sneed, drop the lumber."] = "{area:1581} — подземелье для группы из пяти игроков под деревней {area:20}; портал подземелья — внутри шахты ({area:20}). Гоблины-древорубы в корабельном зале, где Снид, оставляют древесину.",
	-- {area:1581} The Deadmines · {area:20} Moonbrook
	["{area:1581}, in the {area:20} mine"] = "{area:1581}, в шахте ({area:20})",
	-- plural, as words: Goblin Woodcarvers = {npc:641} Goblin Woodcarver
	["Goblin Woodcarvers, inside"] = "Гоблины-древорубы, внутри",

	-- Step 10: Jordan's Smithing Hammer
	-- {area:236} Shadowfang Keep · {zone:1421} Silverpine Forest
	["{area:236} is a level 20-30 dungeon in southern {zone:1421}. The hammer lies on a box inside the stables, at the far end of the courtyard before the ramp up."] = "{area:236} — подземелье для уровней 20-30 на юге зоны {zone:1421}. Молот лежит на ящике в конюшне, в дальнем конце двора перед подъемом по пандусу.",
	-- {object:91138} Jordan's Hammer
	["{object:91138}, inside"] = "{object:91138}, внутри",

	-- Step 11: Thundris Windweaver
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["{npc:3649} is in {area:442}."] = "{npc:3649} находится здесь: {area:442}.",

	-- Step 12: The Corrupted Kor Gem
	-- {item:6995} Corrupted Kor Gem
	["The {item:6995}"] = "{item:6995}",
	-- {area:2797} Blackfathom Deeps · {zone:1440} Ashenvale · {item:6995} Corrupted Kor Gem
	["The Blackfathom naga by the entrance of {area:2797} on {zone:1440}'s north-west coast drop the {item:6995}. They are elite: grouping up is advised."] = "Наги Непроглядной Пучины у входа в {area:2797} на северо-западном побережье зоны {zone:1440} оставляют {item:6995}. Они элитные: лучше собрать группу.",

	-- Step 13: The Purified Kor Gem
	-- {item:7083} Purified Kor Gem
	["The {item:7083}"] = "{item:7083}",
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["Back to {npc:3649} in {area:442}: he purifies the gem."] = "Вернитесь к {npc:3649} ({area:442}): он очистит самоцвет.",

	-- Step 14: Verigan's Fist
	-- {npc:6181} Jordan Stilwell · {zone:1455} Ironforge
	["Bring the four parts to {npc:6181} outside {zone:1455}."] = "Отнесите четыре части NPC {npc:6181} у ворот города {zone:1455}.",
}
