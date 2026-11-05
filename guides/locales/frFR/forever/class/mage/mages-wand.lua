-- French (frFR): the guide forever/class/mage/mages-wand (forever/class/mage/mages-wand.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A wand of your school for the 30s: frost, arcane or fire."] = "Une baguette de votre école pour les niveaux 30 : givre, arcanes ou feu.",

	-- Step 1: Journey to the Marsh (Stormwind)
	-- {npc:5497} Jennea Cannon · {zone:1453} Stormwind · {object:2101} Mage Quarter · {npc:6546} Tabetha · {zone:1455} Ironforge
	["{npc:5497} at the top of the Wizard's Sanctum, {zone:1453}'s {object:2101}, sends you to {npc:6546}; Bink in {zone:1455} gives the same quest."] = "{npc:5497}, au sommet du Sanctuaire des sorciers, dans le {object:2101} de {zone:1453}, vous envoie voir {npc:6546} ; Bink, à {zone:1455}, donne la même quête.",

	-- Step 2: Journey to the Marsh (Orgrimmar)
	-- {npc:5885} Deino · {zone:1454} Orgrimmar · {object:173161} Darkbriar Lodge (no name in this language: may be words) · {npc:6546} Tabetha · {npc:4568} Anastasia Hartwell · {zone:1458} Undercity · {npc:3048} Ursyn Ghull · {zone:1456} Thunder Bluff
	["{npc:5885}, one of {zone:1454}'s mage trainers in {object:173161}, sends you to {npc:6546}; {npc:4568} in the {zone:1458} and {npc:3048} in {zone:1456} give the same quest."] = "{npc:5885}, l'un des maîtres des mages d'{zone:1454}, dans le pavillon Darkbriar, vous envoie voir {npc:6546} ; {npc:4568} à {zone:1458} et {npc:3048} aux {zone:1456} donnent la même quête.",

	-- Step 3: Tabetha
	-- {npc:6546} Tabetha · {area:508} Stonemaul Ruins · {zone:1413} Barrens
	["{npc:6546}, a hermit, lives in a cottage deep in the marsh west of Theramore, just north of the {area:508}. Level 38-41 elites roam the east side of her farm, and swimming in passes level 42 Muckshells: come in from the west along the road from the {zone:1413}. Her cottage is no refuge: mobs follow you inside. Take both her quests."] = "{npc:6546}, une ermite, vit dans une chaumière au fond du marais à l'ouest de Theramore, juste au nord des {area:508}. Des élites de niveau 38-41 rôdent du côté est de sa ferme, et les Muckshells de niveau 42 barrent la route à la nage : arrivez par l'ouest, par la route venant des {zone:1413}. Sa chaumière n'est pas un refuge : les monstres vous suivent à l'intérieur. Acceptez ses deux quêtes.",

	-- Step 4: Magus Tirth
	-- {npc:6548} Magus Tirth · {area:439} Shimmering Flats · {zone:1441} Thousand Needles
	["{npc:6548} spends his days at the race track in the {area:439}, south-east {zone:1441}."] = "{npc:6548} passe ses journées sur la piste de course de {area:439}, au sud-est de {zone:1441}.",

	-- Step 5: "Plucky" Johnson
	["\"Plucky\" Johnson"] = "Johnson « le Brave »",
	["Tirth's apprentice is \"Plucky\" Johnson, a small grey chicken pecking around the foot of the race track's lookout tower; at night type /target plucky. Target him and type /beckon (not /chicken or /wave): he turns human for a moment. Talk to him and ask for the phrase. Do not attack him. If he is gone, he is back within 5 minutes."] = "L'apprenti de Tirth est Johnson « le Brave », un petit poulet gris qui picore au pied de la tour de guet de la piste de course ; la nuit, tapez /target Johnson. Ciblez-le et tapez /beckon (pas /chicken ni /wave) : il redevient humain un instant. Parlez-lui et demandez-lui la phrase. Ne l'attaquez pas. S'il a disparu, il revient dans les 5 minutes.",

	-- Step 6: Witherbark trolls and the Bolt Charged Bramble
	-- {item:7272} Bolt Charged Bramble
	["Witherbark trolls and the {item:7272}"] = "Trolls fanécorce et {item:7272}",
	-- {area:321} Hammerfall · {item:7273} Witherbark Totem Stick · {area:336} Circle of Outer Binding · {item:7272} Bolt Charged Bramble
	["The Witherbark trolls (level 30-36) hold the villages in south-eastern Arathi and south of {area:321}; every kind of them drops a {item:7273} about two times in five: you need ten. Then go to the {area:336} (the outer one, not the Inner circle). Three elementals (level 33-39) stand around its middle stone: pull them one at a time and clear them first. Stand at the middle stone and use a totem stick; about ten seconds later the {item:7272} forms on the stone: click it. If you die before you pick it up, the bramble and the sticks are lost and you need ten more."] = "Les trolls Fanécorce (niveau 30-36) tiennent les villages du sud-est d'Arathi et du sud de {area:321} ; toutes leurs variétés laissent tomber un {item:7273} environ deux fois sur cinq : il vous en faut dix. Allez ensuite au {area:336} (le cercle extérieur, pas l'intérieur). Trois élémentaires (niveau 33-39) se tiennent autour de sa pierre centrale : attirez-les un par un et éliminez-les d'abord. Placez-vous à la pierre centrale et utilisez un bâton totem ; une dizaine de secondes plus tard, le {item:7272} se forme sur la pierre : cliquez dessus. Si vous mourez avant de le ramasser, le roncier et les bâtons sont perdus et il vous en faut dix autres.",
	-- {area:336} Circle of Outer Binding
	["at the middle stone of the {area:336}"] = "à la pierre centrale du {area:336}",

	-- Step 7: Jade
	-- {npc:6546} Tabetha · {item:1529} Jade · {area:271} Southshore
	-- plural, as words: Torn Fin Coastrunners = {npc:2375} Torn Fin Coastrunner
	["{npc:6546} also wants one {item:1529}, a green gem. Miners sometimes find one in ore veins; the Auction House sells it; the Torn Fin Coastrunners on the coast south-west of {area:271} drop one about every fifth kill. Do not sell it to a vendor by mistake."] = "{npc:6546} veut aussi une {item:1529}, une gemme verte. Les mineurs en trouvent parfois dans les filons ; l'hôtel des ventes en vend ; les Cours-la-côte Aileron déchiré sur la côte au sud-ouest d'{area:271} en laissent tomber une environ toutes les cinq victimes. Ne la vendez pas à un marchand par erreur.",

	-- Step 8: Rituals of Power
	-- {area:796} Scarlet Monastery · {zone:1420} Tirisfal Glades · {npc:6487} Arcanist Doan · {item:5535} Compendium of the Fallen
	["Tirth sold the book to the Scarlet Crusade. The {area:796} stands in north-eastern {zone:1420}; take the Library wing with a group of five. The book is in the last long hallway, the one that ends in {npc:6487}'s round room: on the left-hand shelf as you face his room, next to the {item:5535}. Take the thick, highlighted blue book sticking out of the shelf; a magnifying-glass cursor means a book you can only read."] = "Tirth a vendu le livre à la Croisade écarlate. Le {area:796} se dresse au nord-est de {zone:1420} ; faites l'aile de la Bibliothèque avec un groupe de cinq. Le livre se trouve dans le dernier long couloir, celui qui mène à la salle ronde d'{npc:6487} : sur l'étagère de gauche quand vous faites face à sa salle, à côté du {item:5535}. Prenez le gros livre bleu en surbrillance qui dépasse de l'étagère ; un curseur en forme de loupe indique un livre que vous pouvez seulement lire.",
	-- {quest:1951} Rituals of Power
	["{quest:1951}: Scarlet Monastery Library"] = "{quest:1951} : bibliothèque du Monastère écarlate",

	-- Step 9: Tabetha's ritual
	-- {npc:6546} Tabetha
	["{npc:6546}'s ritual"] = "Le rituel de {npc:6546}",
	-- {npc:6546} Tabetha
	["Back to {npc:6546}. With both quests handed in she starts the ritual: wait a few seconds, then talk to her again and pick your wand: Icefury (frost), Nether Force (arcane) or Ragefire (fire)."] = "Retournez voir {npc:6546}. Une fois les deux quêtes rendues, elle commence le rituel : attendez quelques secondes, puis reparlez-lui et choisissez votre baguette : Icefury (givre), Nether Force (arcanes) ou Ragefire (feu).",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:6546}"] = "Retournez voir {npc:6546}",
	-- ["The Witherbark trolls hold south-eastern {zone:1417}; every one of them can drop a {item:7273}. Then take the ten sticks north-west to the binding circle where they become the {item:7272}. {npc:6546} also wants a {item:1529}: buy one at an Auction House on the way; miners sometimes find one in Tin Veins."] = "Les Trolls fanécorce occupent le sud-est des {zone:1417} ; chacun peut laisser tomber un {item:7273}. Portez ensuite les dix bâtons au nord-ouest jusqu'au cercle de lien, où ils deviennent la {item:7272}. {npc:6546} veut aussi une {item:1529} : achetez-en une dans un hôtel des ventes en chemin ; les mineurs en trouvent parfois dans les Filons d'étain.",
	-- ["Tirth sold the book to the Scarlet Brotherhood. The {area:796} stands in north-eastern {zone:1420}; take the Library wing. The book juts out of the wall on the left as you enter the Athenaeum, before {npc:6487}."] = "Tirth a vendu le livre à la Croisade écarlate. Le {area:796} se dresse au nord-est de {zone:1420} ; prenez l'aile de la Bibliothèque. Le livre dépasse du mur à gauche en entrant dans l'Athenaeum, avant {npc:6487}.",
	-- ["Tirth's apprentice is \"Plucky\" Johnson, a small grey chicken by the race track. Target him and type /beckon: he turns human for a moment, long enough to talk to him."] = "L'apprenti de Tirth est Johnson « le Brave », un petit poulet gris près de la piste de course. Ciblez-le et tapez /beckon : il redevient humain un instant, le temps de lui parler.",
	-- ["Witherbark trolls"] = "Trolls fanécorce",
	-- ["{npc:5497} in the Wizard's Sanctum, {zone:1453}'s {object:2101}, sends you to {npc:6546}; Bink in {zone:1455} gives the same quest."] = "{npc:5497}, dans la tour du {object:2101} de {zone:1453}, vous envoie voir {npc:6546} ; Bink, à {zone:1455}, donne la même quête.",
	-- ["{npc:5885}, one of {zone:1454}'s mage trainers, sends you to {npc:6546}; {npc:4568} in the {zone:1458} and {npc:3048} in {zone:1456} give the same quest."] = "{npc:5885}, l'un des maîtres des mages d'{zone:1454}, vous envoie voir {npc:6546} ; {npc:4568} à {zone:1458} et {npc:3048} aux {zone:1456} donnent la même quête.",
	-- ["{npc:6546}, a hermit, lives in a cottage deep in the marsh west of Theramore, just north of the {area:508}."] = "{npc:6546}, une ermite, vit dans une chaumière au fond du marais à l'ouest de Theramore, juste au nord des {area:508}.",
}
