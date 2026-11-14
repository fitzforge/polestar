-- Russian (ruRU): the guide forever/class/mage/celestial-orb (forever/class/mage/celestial-orb.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:7515} Celestial Orb
	["{item:7515} and Stave"] = "{item:7515} и Небесный посох",
	["An off-hand orb or a staff for the late 30s, your pick."] = "Сфера для левой руки или посох для уровней ближе к 40, на ваш выбор.",

	-- Step 1: Return to the Marsh (Stormwind)
	-- {npc:5497} Jennea Cannon · {zone:1453} Stormwind · {object:2101} Mage Quarter · {npc:6546} Tabetha · {zone:1455} Ironforge
	["{npc:5497} at the top of the Wizard's Sanctum, {zone:1453}'s {object:2101}, sends you back to {npc:6546}; Bink in {zone:1455} gives the same quest."] = "{npc:5497} на вершине Святилища волшебника ({zone:1453}, {object:2101}) отправляет вас обратно к NPC {npc:6546}; Бинк ({zone:1455}) дает то же задание.",

	-- Step 2: Return to the Marsh (Orgrimmar)
	-- {npc:5885} Deino · {zone:1454} Orgrimmar · {object:173161} Darkbriar Lodge (no name in this language: may be words) · {npc:6546} Tabetha · {npc:4568} Anastasia Hartwell · {zone:1458} Undercity · {npc:3048} Ursyn Ghull · {zone:1456} Thunder Bluff
	["{npc:5885}, one of {zone:1454}'s mage trainers in {object:173161}, sends you back to {npc:6546}; {npc:4568} in the {zone:1458} and {npc:3048} in {zone:1456} give the same quest."] = "{npc:5885}, один из учителей магов ({zone:1454}, {object:173161}), отправляет вас обратно к NPC {npc:6546}; {npc:4568} ({zone:1458}) и {npc:3048} ({zone:1456}) дают то же задание.",

	-- Step 3: Tabetha
	-- {npc:6546} Tabetha · {area:508} Stonemaul Ruins
	["{npc:6546}'s cottage is deep in the marsh west of Theramore, just north of the {area:508}; come in from the west road, the elites roam its east side."] = "Хижина NPC {npc:6546} находится глубоко в болотах к западу от острова Терамор, чуть севернее места {area:508}; подходите с западной дороги, элитные противники бродят с восточной стороны.",

	-- Step 4: The Infernal Orb
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace · {area:2408} Shadowprey Village · {item:7291} Infernal Orb · {spell:686} Shadow Bolt · {zone:1412} Mulgore · {zone:1456} Thunder Bluff
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner · Nether Maidens = {npc:4679} Nether Maiden
	["The Burning Blade Summoners (level 38-39, not elite) work the {area:602} in southern {zone:1443}, east of {area:2408}, and every one carries an {item:7291}. They cast {spell:686} from 40 yards, keep an imp at their side and run for help at low health; Nether Maidens patrol the pillared ruin beside them, so pull with care. Horde mages: one more summoner stands alone in western {zone:1412}, south-west of {zone:1456}."] = "",

	-- Step 5: The Exorcism
	-- {npc:6546} Tabetha · {quest:1955} The Exorcism · {npc:6549} Demon of the Orb
	["Back at {npc:6546}'s. Hand in the orb now; {quest:1955} waits for level 38. Kill the critters around the cottage first: they join the fight. Accepting {quest:1955} starts a 3 minute timer, and {npc:6546} calls the {npc:6549} out in her garden: a level 40 elite that resists many spells, roots and slows. Grouping up is encouraged: a mage of 40 may need help or potions, at about 45 it is soloable. You can pull it from range from the dock. The timer keeps running after it dies, so hand the quest in straight away. If time runs out, abandon the quest and take it again; she calls the demon again."] = "Снова у NPC {npc:6546}. Сдайте сферу сейчас; {quest:1955} ждет 38-го уровня. Сначала убейте зверьков вокруг хижины: они вступают в бой. Когда вы берете {quest:1955}, запускается 3-минутный таймер, и {npc:6546} вызывает в своем саду противника {npc:6549}: элитного противника 40-го уровня, устойчивого ко многим заклинаниям, обездвиживанию и замедлению. Лучше собрать группу: магу 40-го уровня может понадобиться помощь или зелья, примерно с 45-го его можно убить в одиночку. Его можно выманить издалека с причала. Таймер продолжает идти после его смерти, поэтому сдайте задание сразу. Если время вышло, откажитесь от задания и возьмите его снова; она снова вызовет демона.",
	-- {npc:6549} Demon of the Orb
	["{npc:6549} (elite, 40)"] = "",

	-- Step 6: Power in Uldaman
	-- {area:1517} Uldaman · {zone:1418} Badlands · {area:1898} Dustwind Gulch · {npc:7023} Obsidian Sentinel · {npc:7209} Obsidian Shard
	["{area:1517} is a dungeon in the northern {zone:1418}: a group of five, from level 40 here. Go in by the rear entrance, a cave in {area:1898} south-east of the main entrance (elite dragons fly nearby): the {npc:7023} (level 42 elite) stands just past the first door. At 80, 60, 40 and 20 percent it breaks off an {npc:7209}, an elite too; while a shard lives, both reflect targeted spells, so use area spells and your wand on them. A solo trick: step out through the nearby zone line each time a shard appears; the Sentinel heals but keeps shrinking. It always drops the power source, and takes 2 hours to come back."] = "{area:1517} – подземелье на севере зоны {zone:1418}: группа из пяти человек, здесь с 40-го уровня. Входите через задний вход – пещеру ({area:1898}) к юго-востоку от главного входа (рядом летают элитные драконы): {npc:7023} (элитный, 42-й уровень) стоит сразу за первой дверью. На 80, 60, 40 и 20 процентах здоровья от него откалывается {npc:7209}, тоже элитный; пока жив осколок, оба отражают направленные заклинания, так что бейте их заклинаниями по области и жезлом. Хитрость для одиночки: каждый раз, когда появляется осколок, выходите за ближайшую границу зоны; часовой лечится, но продолжает уменьшаться. Источник энергии падает всегда, а возрождается часовой через 2 часа.",

	-- Step 7: Mana Surges
	-- {npc:6546} Tabetha · {quest:1957} Mana Surges · {spell:403} Lightning Bolt
	["Back to {npc:6546}. Accepting {quest:1957} opens a rift beside her cottage and starts a 10 minute timer: twelve {quest:1957} (level 40, Shock and {spell:403}) come out about four at a time. Attacking one does not pull the rest. Standing at the edge of the field draws them all; the tree south-west of it is out of their reach but in your spell range. Kill twelve and hand in before the timer runs out."] = "",
	-- {quest:1958} Celestial Power · {item:7515} Celestial Orb · {item:9517} Celestial Stave
	["{quest:1958}: the {item:7515} (off-hand) or the {item:9517}"] = "",

	-- Step 8: Tabetha's Task (optional)
	-- {quest:2861} Tabetha's Task
	["{quest:2861} (optional)"] = "",
	-- {npc:6546} Tabetha · {npc:5497} Jennea Cannon · {npc:4568} Anastasia Hartwell · {npc:5885} Deino · {quest:2861} Tabetha's Task · {quest:2846} Tiara of the Deep · {npc:7795} Hydromancer Velratha · {area:978} Zul'Farrak · {zone:1446} Tanaris · {item:9527} Spellshifter Rod · {item:9531} Gemshale Pauldrons
	["At 40 the mage trainers who send you to {npc:6546} ({npc:5497}, Bink, {npc:4568}, {npc:5885}) also have {quest:2861}, a quest any class can do. {npc:6546} then wants the {quest:2846} from {npc:7795}, a level 46 elite naga in {area:978}, the troll dungeon in north-western {zone:1446}: a group of five, level 44-54. The reward window shows the {item:9527} and the {item:9531}."] = "На 40-м уровне у учителей магов, которые отправляют вас к NPC {npc:6546} ({npc:5497}, Бинк, {npc:4568}, {npc:5885}), есть и задание {quest:2861}, которое может выполнить любой класс. Затем {npc:6546} просит добыть {quest:2846}: ее носит {npc:7795}, элитная нага 46-го уровня в подземелье троллей {area:978} на северо-западе зоны {zone:1446}: группа из пяти человек, 44-54 уровень. В окне награды – {item:9527} и {item:9531}.",

	-- Step 9: Tiara of the Deep in Zul'Farrak
	-- {quest:2846} Tiara of the Deep · {area:978} Zul'Farrak
	["{quest:2846} in {area:978}"] = "{quest:2846} ({area:978})",
	-- {area:978} Zul'Farrak · {zone:1446} Tanaris · {npc:7795} Hydromancer Velratha
	["{area:978}, the troll dungeon in north-western {zone:1446}, needs a group of five; the guide waits for level 44. {npc:7795} is one of the bosses by the sacred pool, and the tiara always drops."] = "{area:978}, подземелье троллей на северо-западе зоны {zone:1446}, требует группы из пяти человек; гайд ждет 44-го уровня. {npc:7795} – один из боссов у священного водоема, и тиара падает всегда.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:6546}. She opens a mana rift beside her cottage: kill twelve {quest:1957} within ten minutes."] = "Вернитесь: {npc:6546}. Она открывает разлом маны рядом со своей хижиной: убейте 12 противников ({quest:1957}) за десять минут.",
	-- ["The Burning Blade Summoners work the {area:602} in southern {zone:1443}; any of them carries an {item:7291}."] = "Призыватели из клана Пылающего Клинка обитают здесь: {area:602}, на юге зоны {zone:1443}; у любого из них есть {item:7291}.",
	-- ["{area:1517} is a dungeon in the northern {zone:1418}, by the {object:178824}: a group of five. Defeat the {npc:7023} inside for its power source."] = "{area:1517} — подземелье на севере зоны {zone:1418}, рядом с объектом {object:178824}: группа из пяти человек. Победите внутри NPC {npc:7023}, чтобы получить его источник силы.",
	-- ["{npc:6546} draws the demon out of the orb beside her cottage. The {npc:6549} is elite: grouping up is advised. You have three minutes before it slips back into the orb."] = "{npc:6546} извлекает демона из сферы рядом со своей хижиной. {npc:6549} — элитный: лучше собрать группу. У вас три минуты, прежде чем он вернется в сферу.",
}
