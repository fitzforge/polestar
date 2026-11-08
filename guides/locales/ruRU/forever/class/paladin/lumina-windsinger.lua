-- Russian (ruRU): the guide forever/class/paladin/lumina-windsinger (forever/class/paladin/lumina-windsinger.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:268484} Moonsilver Blade · {item:267369} Wolfsbane
	["{item:268484} and {item:267369} (Forsaken)"] = "{item:268484} и {item:267369} (Отрекшиеся)",
	-- {quest:91862} Lumina Windsinger · {quest:95140} Old Fire-Eye
	["The Forsaken paladin's two-handed sword: rescue {quest:91862}, gather three parts, slay {quest:95140}."] = "Двуручный меч паладина Отрекшихся: спасите {quest:91862}, соберите три части, убейте {quest:95140}.",

	-- Step 1: Danitha Morr
	-- {npc:246378} Danitha Morr · {zone:1421} Silverpine Forest
	["At 18 {npc:246378}, inside Bandarion Keep on the bluffs north-west of the Solliden Farmstead, sends you south to the Sepulcher in {zone:1421}."] = "",

	-- Step 2: The Sepulcher
	-- {npc:248840} Trevan Rol · {npc:259611} Deathguard Baldren
	["{npc:248840} stands in the lower part of the Sepulcher, below the surface; {npc:259611} keeps watch near the town's entrance."] = "",

	-- Step 3: The pyre on Fenris Isle
	["The pyre on Fenris Isle"] = "",
	-- {object:566037} Charred Remains
	["Fenris Isle lies in the lake north-east of the Sepulcher. The gnolls' pyre, with the {object:566037}, is on its shore: click the remains to hand in, and click them again for the next quest. The body is a tauren's, not the elf's."] = "",
	-- {object:566037} Charred Remains
	["from the {object:566037}"] = "Объект: {object:566037}",

	-- Step 4: Fenris Keep
	["Fenris Keep"] = "",
	-- {quest:91862} Lumina Windsinger · {item:267412} Fenris Isle Key · {npc:1944} Rot Hide Bruiser
	["{quest:91862} is caged in the basement of Fenris Keep, at the north end of the isle. The Rot Hide gnolls (level 18-19) fill the keep: they pull in big groups across floors and players report very fast respawns, so clear a path and keep moving. Any of them can carry the {item:267412} (often the first kill); the rare {npc:1944} (22) and Snarlmane (23) can too. If her cage is empty, another player is escorting her: wait for her to come back."] = "",
	-- {item:267412} Fenris Isle Key
	["{item:267412}, from the Rot Hide gnolls"] = "{item:267412} – с гноллов из стаи Гнилошкуров",

	-- Step 5: Free Lumina Windsinger
	-- {npc:248755} Lumina Windsinger
	["Free {npc:248755}"] = "Освободите {npc:248755}",
	-- {npc:248755} Lumina Windsinger
	["Hand in the key first: starting the escort before that gives the key quest no credit. Then open the cage: {npc:248755} walks out through the keep and its courtyard while the gnolls attack, then runs for the dock and makes her own way back to the Sepulcher. Stay close and keep her alive; if she dies, take the quest again when she is back in her cage."] = "",

	-- Step 6: Back to the Sepulcher
	["Back to the Sepulcher"] = "",
	-- {npc:259620} Lumina Windsinger · {npc:248840} Trevan Rol · {quest:95034} The Debt
	["{npc:259620} waits beside {npc:248840} in the Sepulcher (a different {npc:259620} from the one you escorted). For {quest:95034}, click through every line of her story."] = "",
	-- {npc:259620} Lumina Windsinger
	["{npc:259620}, the Sepulcher"] = "",

	-- Step 7: A Moon-Kissed Blade
	-- {npc:259620} Lumina Windsinger · {quest:95140} Old Fire-Eye · {npc:248840} Trevan Rol
	["At 20 {npc:259620} asks for a blade that can kill {quest:95140}. Talk to {npc:248840} beside her for his Weapon Notes, which list the parts, and keep them: he wants them back with the parts. Three parts, in any order: two from dungeons (a group of five each) and a gem from elite naga outside a third."] = "",
	-- {item:267454} Trevan's Weapon Notes · {npc:248840} Trevan Rol
	["{item:267454}: talk to {npc:248840}"] = "",

	-- Step 8: The Enchanted Silver Ingot
	-- {item:267361} Enchanted Silver Ingot
	["The {item:267361}"] = "",
	-- {object:1680} Shadowfang Keep (no name in this language: may be words) · {npc:4275} Archmage Arugal
	["{object:1680} is the dungeon in south Silverpine, for a group of five in the low to mid 20s. The ingot sits on the table next to {npc:4275} at the very end. A friend's cleared instance works: walk in and run to the table."] = "",
	-- {item:267361} Enchanted Silver Ingot
	["{item:267361}, on Arugal's table"] = "",

	-- Step 9: Whitestone Oak Lumber
	-- {zone:1436} Westfall
	-- plural, as words: Goblin Woodcarvers = {npc:641} Goblin Woodcarver
	["The Deadmines lies under Moonbrook in {zone:1436}, Alliance land: a group of five at about 17-24. The way in is the Moonbrook mine. The Goblin Woodcarvers (elite, level 18-19) in Sneed's mast room drop the lumber every time."] = "",
	["The Deadmines, in the Moonbrook mine"] = "",
	-- plural, as words: Goblin Woodcarvers = {npc:641} Goblin Woodcarver
	["Goblin Woodcarvers, inside"] = "Гоблины-древорубы, внутри",

	-- Step 10: Ulric Frostveil
	-- {npc:259649} Ulric Frostveil · {zone:1440} Ashenvale · {zone:1458} Undercity · {zone:1454} Orgrimmar · {zone:1413} Barrens
	["{npc:259649} waits at Zoram'gar Outpost on {zone:1440}'s west coast: from the {zone:1458} take the zeppelin to {zone:1454}, then go north through the {zone:1413} into {zone:1440} and west along the road. Andruk, the outpost's wind rider master, saves you the walk next time. Take {npc:259649}'s quest before you hunt the naga: the Kor Gem only drops while you have it."] = "",
	-- {npc:259649} Ulric Frostveil
	["{npc:259649}, Zoram'gar Outpost"] = "",

	-- Step 11: The Corrupted Kor Gem
	-- {item:6995} Corrupted Kor Gem
	["The {item:6995}"] = "{item:6995}",
	-- {item:6995} Corrupted Kor Gem
	["The naga stand in the flooded ruins and passages around the Blackfathom Deeps entrance, just north of Zoram'gar: you do not need to enter the instance (its first naga drop the gem too). Tide Priestesses (level 20-21), Oracles (21-22) and Sea Witches (23-24) drop the {item:6995}, one in two. All are elite: grouping up is encouraged. Players solo them one at a time, with difficulty; a group of three makes it easy. They heal themselves, run for help at low health, and the Sea Witches cast Frost Nova up close. Some players report no drop while in a raid group."] = "",

	-- Step 12: The Purified Kor Gem
	-- {item:272448} Purified Kor Gem
	["The {item:272448}"] = "",
	-- {npc:259649} Ulric Frostveil · {item:272448} Purified Kor Gem · {npc:248840} Trevan Rol
	["Back to {npc:259649} at Zoram'gar: he cleanses the gem. Keep the {item:272448} for {npc:248840}."] = "",

	-- Step 13: Trevan Rol
	-- {npc:248840} Trevan Rol · {item:268192} Bundle of Blacksmithing Materials · {object:1772} Tarren Mill (no name in this language: may be words)
	["Bring the lumber, the ingot and the gem to {npc:248840} in the Sepulcher. He gives you a {item:268192} for a smith in {object:1772}: keep it in your bags."] = "",

	-- Step 14: Ott
	-- {npc:3539} Ott · {object:1772} Tarren Mill (no name in this language: may be words) · {zone:1424} Hillsbrad Foothills · {quest:95125} Ott's Masterwork
	["{npc:3539}, the weaponsmith, stands just south of {object:1772} in {zone:1424}. Accepting {quest:95125} starts the forging: step back and wait near him until he is done."] = "",
	-- {npc:3539} Ott · {quest:95125} Ott's Masterwork
	["{npc:3539} gives you {quest:95125}"] = "",

	-- Step 15: The Moonsilver Blade
	-- {npc:248840} Trevan Rol · {item:268484} Moonsilver Blade
	["Back to {npc:248840} in the Sepulcher's lower part: he hands you the {item:268484}, a two-handed sword."] = "",

	-- Step 16: Two-Handed Swords
	["Two-Handed Swords"] = "",
	-- {npc:11870} Archibald · {zone:1458} Undercity · {object:36070} War Quarter
	["The blade is a two-handed sword, and you need the skill to hit a level 25 elite with it. {npc:11870}, the weapon master in the {zone:1458}'s {object:36070}, teaches Two-Handed Swords for a small fee; then swing it on easy mobs until the skill is near its cap (five points per level)."] = "",
	-- {npc:11870} Archibald · {object:36070} War Quarter
	["{npc:11870}, {object:36070}: Two-Handed Swords"] = "",

	-- Step 17: Old Fire-Eye
	-- {item:268484} Moonsilver Blade · {quest:95140} Old Fire-Eye
	["Equip the {item:268484}. {quest:95140}, the great worgen, roams the woods south of the Sepulcher toward the gates of Gilneas. He is elite (level 25): grouping up is encouraged; one player needed a second, another soloed him at 25. A purple shield guards him until your first swing with the blade lands: a message tells you it broke."] = "",
	-- {quest:95140} Old Fire-Eye · {item:268484} Moonsilver Blade
	["{quest:95140}, with the {item:268484} equipped"] = "",

	-- Step 18: Wolfsbane
	-- {npc:259620} Lumina Windsinger · {item:268484} Moonsilver Blade · {item:267369} Wolfsbane
	["Back to {npc:259620} in the Sepulcher with the {item:268484} (the quest asks for it): she takes it and blesses it with the magic of her people into {item:267369}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the {area:228}"] = "Вернитесь в {area:228}",
	-- ["Free her with the key, then stay close while she fights her way out of the keep."] = "Освободите ее ключом и держитесь рядом, пока она пробивается из крепости.",
	-- ["No item yet: a Forsaken paladin rescue story; its sequel, the {item:268484}, cannot be finished yet."] = "Предмета пока нет: история о спасении для паладина Отрекшихся; ее продолжение, {item:268484}, пока нельзя завершить.",
	-- ["Once she is clear of {area:235}, Lumina waits for you in the {area:228}. Speak with her again to hear what really happened on the road."] = "Когда она выберется из места {area:235}, Люмина ждет вас здесь: {area:228}. Поговорите с ней снова, чтобы узнать, что на самом деле случилось в дороге.",
	-- ["Once she is clear of {area:235}, {npc:259620} waits for you in the {area:228}. Speak with her again to hear what really happened on the road."] = "Когда она выберется из места {area:235}, {npc:259620} ждет вас в месте {area:228}. Поговорите с ней снова, чтобы узнать, что на самом деле случилось в дороге.",
	-- ["Rescuing {quest:91862}"] = "Спасение: {quest:91862}",
	-- ["Ride south through {zone:1421} to the {area:228}. {npc:248840} stands in the town; {npc:259611} keeps watch near its entrance."] = "Езжайте на юг через {zone:1421} к {area:228}. {npc:248840} стоит в поселении; {npc:259611} стоит на страже у входа.",
	-- ["The pyre on {area:172}"] = "Погребальный костер: {area:172}",
	-- ["{area:172} lies in the lake east of the {area:228}. The charred remains are on its shore."] = "{area:172} — остров в озере к востоку от {area:228}. Обугленные останки лежат на его берегу.",
	-- ["{npc:246378} leads the Paladins of Tyr's Watch from inside {area:16602}, on the bluffs north-west of the {area:156}."] = "{npc:246378} руководит паладинами Tyr's Watch изнутри места {area:16602}, на утесах к северо-западу от места {area:156}.",
	-- ["{npc:259620}, the {area:228}"] = "{npc:259620}, {area:228}",
	-- ["{quest:91862} is caged inside {area:235}, at the north end of the isle. The Rot Hide gnolls around her carry the key."] = "{quest:91862} заперта в клетке здесь: {area:235}, северный край острова. Ключ у гноллов из стаи Гнилошкуров вокруг нее.",
	-- ["{zone:1458} and Earthen Ring reputation"] = "Репутация: {zone:1458} и Служители Земли",
}
