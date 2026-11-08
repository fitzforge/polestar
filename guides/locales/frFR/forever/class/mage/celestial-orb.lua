-- French (frFR): the guide forever/class/mage/celestial-orb (forever/class/mage/celestial-orb.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:7515} Celestial Orb
	["{item:7515} and Stave"] = "{item:7515} et Bâton céleste",
	["An off-hand orb or a staff for the late 30s, your pick."] = "Un orbe de main gauche ou un bâton pour la fin des 30, au choix.",

	-- Step 1: Return to the Marsh (Stormwind)
	-- {npc:5497} Jennea Cannon · {zone:1453} Stormwind · {object:2101} Mage Quarter · {npc:6546} Tabetha · {zone:1455} Ironforge
	["{npc:5497} at the top of the Wizard's Sanctum, {zone:1453}'s {object:2101}, sends you back to {npc:6546}; Bink in {zone:1455} gives the same quest."] = "{npc:5497}, au sommet du Sanctuaire des sorciers, dans le {object:2101} de {zone:1453}, vous renvoie voir {npc:6546} ; Bink, à {zone:1455}, donne la même quête.",

	-- Step 2: Return to the Marsh (Orgrimmar)
	-- {npc:5885} Deino · {zone:1454} Orgrimmar · {object:173161} Darkbriar Lodge (no name in this language: may be words) · {npc:6546} Tabetha · {npc:4568} Anastasia Hartwell · {zone:1458} Undercity · {npc:3048} Ursyn Ghull · {zone:1456} Thunder Bluff
	["{npc:5885}, one of {zone:1454}'s mage trainers in {object:173161}, sends you back to {npc:6546}; {npc:4568} in the {zone:1458} and {npc:3048} in {zone:1456} give the same quest."] = "{npc:5885}, l'un des maîtres des mages d'{zone:1454}, dans le pavillon Darkbriar, vous renvoie voir {npc:6546} ; {npc:4568} à {zone:1458} et {npc:3048} aux {zone:1456} donnent la même quête.",

	-- Step 3: Tabetha
	-- {npc:6546} Tabetha · {area:508} Stonemaul Ruins
	["{npc:6546}'s cottage is deep in the marsh west of Theramore, just north of the {area:508}; come in from the west road, the elites roam its east side."] = "La chaumière de {npc:6546} est au fond du marais à l'ouest de Theramore, juste au nord des {area:508} ; arrivez par la route de l'ouest, les élites rôdent du côté est.",

	-- Step 4: The Infernal Orb
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace · {area:2408} Shadowprey Village · {item:7291} Infernal Orb · {spell:686} Shadow Bolt · {zone:1412} Mulgore · {zone:1456} Thunder Bluff
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner · Nether Maidens = {npc:4679} Nether Maiden
	["The Burning Blade Summoners (level 38-39, not elite) work the {area:602} in southern {zone:1443}, east of {area:2408}, and every one carries an {item:7291}. They cast {spell:686} from 40 yards, keep an imp at their side and run for help at low health; Nether Maidens patrol the pillared ruin beside them, so pull with care. Horde mages: one more summoner stands alone in western {zone:1412}, south-west of {zone:1456}."] = "Les Invocateurs de la Lame ardente (niveau 38-39, non élites) officient à {area:602}, dans le sud de {zone:1443}, à l'est de {area:2408}, et chacun porte un {item:7291}. Ils lancent {spell:686} à 40 mètres, gardent un diablotin à leurs côtés et fuient chercher de l'aide quand leur vie est basse ; des Vierges du néant patrouillent dans la ruine à piliers voisine, attirez-les donc avec prudence. Mages de la Horde : un autre invocateur se tient seul dans l'ouest de {zone:1412}, au sud-ouest des {zone:1456}.",

	-- Step 5: The Exorcism
	-- {npc:6546} Tabetha · {quest:1955} The Exorcism · {npc:6549} Demon of the Orb
	["Back at {npc:6546}'s. Kill the critters around the cottage first: they join the fight. Accepting {quest:1955} starts a 3 minute timer, and {npc:6546} calls the {npc:6549} out in her garden: a level 40 elite that resists many spells, roots and slows. Grouping up is encouraged: a mage of 40 may need help or potions, at about 45 it is soloable. You can pull it from range from the dock. The timer keeps running after it dies, so hand the quest in straight away. If time runs out, abandon the quest and take it again; she calls the demon again."] = "De retour chez {npc:6546}. Tuez d'abord les bestioles autour de la chaumière : elles se joignent au combat. Accepter {quest:1955} lance un compte à rebours de 3 minutes, et {npc:6546} fait sortir le {npc:6549} dans son jardin : un élite de niveau 40 qui résiste à beaucoup de sorts, immobilise et ralentit. Il est conseillé de grouper : un mage de niveau 40 peut avoir besoin d'aide ou de potions, vers 45 il se fait en solo. Vous pouvez l'attirer à distance depuis le ponton. Le compte à rebours continue après sa mort : rendez donc la quête tout de suite. Si le temps est écoulé, abandonnez la quête et reprenez-la ; elle rappelle le démon.",
	-- {npc:6549} Demon of the Orb
	["{npc:6549} (elite, 40)"] = "{npc:6549} (élite, 40)",

	-- Step 6: Power in Uldaman
	-- {area:1517} Uldaman · {zone:1418} Badlands · {area:1898} Dustwind Gulch · {npc:7023} Obsidian Sentinel · {npc:7209} Obsidian Shard
	["{area:1517} is a dungeon in the northern {zone:1418}: a group of five. Go in by the rear entrance, a cave in {area:1898} south-east of the main entrance (elite dragons fly nearby): the {npc:7023} (level 42 elite) stands just past the first door. At 80, 60, 40 and 20 percent it breaks off an {npc:7209}, an elite too; while a shard lives, both reflect targeted spells, so use area spells and your wand on them. A solo trick: step out through the nearby zone line each time a shard appears; the Sentinel heals but keeps shrinking. It always drops the power source, and takes 2 hours to come back."] = "{area:1517} est un donjon au nord de {zone:1418} : un groupe de cinq. Entrez par l'entrée arrière, une grotte dans le {area:1898} au sud-est de l'entrée principale (des dragons élites volent tout près) : la {npc:7023} (élite de niveau 42) se tient juste après la première porte. À 80, 60, 40 et 20 %, elle détache un {npc:7209}, élite lui aussi ; tant qu'un éclat est en vie, tous deux renvoient les sorts ciblés : utilisez donc des sorts de zone et votre baguette sur eux. Une astuce en solo : sortez par la limite de zone toute proche chaque fois qu'un éclat apparaît ; la Sentinelle se soigne mais continue de rapetisser. Elle laisse toujours tomber la source d'énergie, et met 2 heures à revenir.",

	-- Step 7: Mana Surges
	-- {npc:6546} Tabetha · {quest:1957} Mana Surges · {spell:403} Lightning Bolt
	["Back to {npc:6546}. Accepting {quest:1957} opens a rift beside her cottage and starts a 10 minute timer: twelve {quest:1957} (level 40, Shock and {spell:403}) come out about four at a time. Attacking one does not pull the rest. Standing at the edge of the field draws them all; the tree south-west of it is out of their reach but in your spell range. Kill twelve and hand in before the timer runs out."] = "Retournez voir {npc:6546}. Accepter {quest:1957} ouvre une faille à côté de sa chaumière et lance un compte à rebours de 10 minutes : douze {quest:1957} (niveau 40, Horion et {spell:403}) en sortent environ quatre par quatre. En attaquer un n'attire pas les autres. Se tenir au bord du champ les attire tous ; l'arbre au sud-ouest est hors de leur portée mais à portée de vos sorts. Tuez-en douze et rendez la quête avant la fin du compte à rebours.",
	-- {quest:1958} Celestial Power · {item:7515} Celestial Orb · {item:9517} Celestial Stave
	["{quest:1958}: the {item:7515} (off-hand) or the {item:9517}"] = "{quest:1958} : l'{item:7515} (main gauche) ou le {item:9517}",

	-- Step 8: Tabetha's Task (optional)
	-- {quest:2861} Tabetha's Task
	["{quest:2861} (optional)"] = "{quest:2861} (facultatif)",
	-- {npc:6546} Tabetha · {npc:5497} Jennea Cannon · {npc:4568} Anastasia Hartwell · {npc:5885} Deino · {quest:2861} Tabetha's Task · {quest:2846} Tiara of the Deep · {npc:7795} Hydromancer Velratha · {area:978} Zul'Farrak · {zone:1446} Tanaris · {item:9527} Spellshifter Rod · {item:9531} Gemshale Pauldrons
	["At 40 the mage trainers who send you to {npc:6546} ({npc:5497}, Bink, {npc:4568}, {npc:5885}) also have {quest:2861}, a quest any class can do. {npc:6546} then wants the {quest:2846} from {npc:7795}, a level 46 elite naga in {area:978}, the troll dungeon in north-western {zone:1446}: a group of five, level 44-54. She is one of the bosses by the sacred pool, and the tiara always drops. The reward window shows the {item:9527} and the {item:9531}."] = "Au niveau 40, les maîtres des mages qui vous envoient voir {npc:6546} ({npc:5497}, Bink, {npc:4568}, {npc:5885}) proposent aussi {quest:2861}, une quête que toutes les classes peuvent faire. {npc:6546} veut ensuite la {quest:2846} d'{npc:7795}, une naga élite de niveau 46 à {area:978}, le donjon troll au nord-ouest de {zone:1446} : un groupe de cinq, niveau 44-54. C'est l'un des boss près du bassin sacré, et le diadème tombe toujours. La fenêtre des récompenses montre le {item:9527} et les {item:9531}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:6546}. She opens a mana rift beside her cottage: kill twelve {quest:1957} within ten minutes."] = "Retournez voir {npc:6546}. Elle ouvre une faille de mana à côté de sa chaumière : tuez douze {quest:1957} en dix minutes.",
	-- ["The Burning Blade Summoners work the {area:602} in southern {zone:1443}; any of them carries an {item:7291}."] = "Les Invocateurs de la Lame ardente officient à {area:602}, dans le sud de {zone:1443} ; chacun d'eux porte {item:7291}.",
	-- ["{area:1517} is a dungeon in the northern {zone:1418}, by the {object:178824}: a group of five. Defeat the {npc:7023} inside for its power source."] = "{area:1517} est un donjon au nord de {zone:1418}, près de {object:178824} : un groupe de cinq. Vainquez {npc:7023} à l'intérieur pour sa source d'énergie.",
	-- ["{npc:5497} in the Wizard's Sanctum, {zone:1453}'s {object:2101}, sends you back to {npc:6546}; Bink in {zone:1455} gives the same quest."] = "{npc:5497}, au Sanctuaire des sorciers dans {object:2101} de {zone:1453}, vous renvoie voir {npc:6546} ; Bink, à {zone:1455}, donne la même quête.",
	-- ["{npc:5885}, one of {zone:1454}'s mage trainers, sends you back to {npc:6546}; {npc:4568} in the {zone:1458} and {npc:3048} in {zone:1456} give the same quest."] = "{npc:5885}, l'un des maîtres des mages d'{zone:1454}, vous renvoie voir {npc:6546} ; {npc:4568} à {zone:1458} et {npc:3048} à {zone:1456} donnent la même quête.",
	-- ["{npc:6546} draws the demon out of the orb beside her cottage. The {npc:6549} is elite: grouping up is advised. You have three minutes before it slips back into the orb."] = "{npc:6546} fait sortir le démon de l'orbe à côté de sa chaumière. {npc:6549} est élite : il est conseillé de grouper. Vous avez trois minutes avant qu'il ne retourne dans l'orbe.",
	-- ["{npc:6546}'s cottage is deep in the marsh west of Theramore, just north of the {area:508}."] = "La chaumière de {npc:6546} est au fond du marais à l'ouest de Theramore, juste au nord de {area:508}.",
}
