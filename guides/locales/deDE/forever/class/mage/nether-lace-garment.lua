-- German (deDE): the guide forever/class/mage/nether-lace-garment (forever/class/mage/nether-lace-garment.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A robe or a tunic for Horde mages in their late 20s."] = "Eine Robe oder eine Tunika für Horde-Magier in ihren späten Zwanzigern.",

	-- Step 1: Anastasia Hartwell
	-- {npc:4568} Anastasia Hartwell · {zone:1458} Undercity · {object:36082} Magic Quarter · {spell:3563} Teleport: Undercity · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["{npc:4568} stands in the {zone:1458}'s {object:36082}. Orcs and Trolls use {spell:3563} or take the zeppelin from {zone:1454} to {zone:1420} for her."] = "{npc:4568} steht im {object:36082} von {zone:1458}. Orcs und Trolle nutzen {spell:3563} oder nehmen den Zeppelin von {zone:1454} nach {zone:1420} zu ihr.",

	-- Step 2: Deino
	-- {zone:1454} Orgrimmar · {spell:3567} Teleport: Orgrimmar · {object:173161} Darkbriar Lodge (no name in this language: may be words) · {npc:5885} Deino · {object:172961} Valley of Spirits · {item:7269} Deino's Flask
	["Take the zeppelin to {zone:1454} (or use {spell:3567}, which lands you on the upper floor of {object:173161}). {npc:5885} stands with the mage trainers on the lower floor of {object:173161} in the {object:172961}. She hands you {item:7269}."] = "Nimm den Zeppelin nach {zone:1454} (oder nutze {spell:3567}, das dich im oberen Stockwerk von {object:173161} absetzt). {npc:5885} steht bei den Magierlehrern im unteren Stockwerk von {object:173161} im {object:172961}. Sie gibt dir {item:7269}.",

	-- Step 3: The Xavian Waterfall
	-- {object:174797} Xavian Waterfall (no name in this language: may be words)
	["The {object:174797}"] = "Der {object:174797}",
	-- {area:431} Splintertree Post · {area:429} Xavian
	["Fly to {area:431} and swim north up the river past the big lake to its far northern end, where the zone text reads {area:429}; satyrs hold the ruins around it and a few river beasts are in the way. Swim right in under the highest waterfall until you touch the rock wall, then use the flask (you can stay in the water). The waterfalls on the western Falfarren fork do not work."] = "Flieg nach {area:431} und schwimm den Fluss nach Norden hinauf, am großen See vorbei bis zu seinem nördlichen Ende, wo der Gebietstext {area:429} anzeigt; Satyrn halten die Ruinen darum, und ein paar Flusstiere sind im Weg. Schwimm direkt unter den höchsten Wasserfall, bis du die Felswand berührst, und benutze dann die Flasche (du kannst im Wasser bleiben). Die Wasserfälle an der westlichen Falfarren-Gabelung funktionieren nicht.",
	-- {item:7269} Deino's Flask
	["{item:7269}, under the falls"] = "{item:7269}, unter den Fällen",

	-- Step 4: Back to Deino
	-- {npc:5885} Deino
	["Back to {npc:5885}"] = "Zurück zu {npc:5885}",

	-- Step 5: The Laughing Sisters
	-- {quest:1945} Laughing Sisters
	["The {quest:1945}"] = "Die {quest:1945}",
	-- {quest:1945} Laughing Sisters · {area:426} Raynewood Retreat · {zone:1440} Ashenvale
	["The {quest:1945}, dryads of level 24-25, roam around the {area:426} in central {zone:1440}; every one drops a hair and they come back after 5 minutes. They often resist fire (and some frost and shadow): arcane spells land best. Each runs for help at low health. Keep clear of the guards by the white tower of the retreat, who hit hard."] = "Die {quest:1945}, Dryaden der Stufe 24-25, streifen um das {area:426} in der Mitte von {zone:1440}; jede lässt ein Haar fallen, und sie kommen nach 5 Minuten wieder. Sie widerstehen oft Feuer (und manche Frost und Schatten): Arkane Zauber treffen am besten. Jede holt bei niedriger Gesundheit Hilfe. Halte Abstand zu den Wachen am weißen Turm des Rückzugsorts, sie schlagen hart zu.",

	-- Step 6: Kil'hala
	-- {npc:3484} Kil'hala
	["{npc:3484}, a troll tailor, works at the Crossroads. The robe gives intellect, stamina and spirit; the tunic more intellect and stamina but no spirit."] = "{npc:3484}, ein Trollschneider, arbeitet in Crossroads. Die Robe gibt Intelligenz, Ausdauer und Willenskraft; die Tunika mehr Intelligenz und Ausdauer, aber keine Willenskraft.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A robe or a tunic for Undead and Troll mages in their late 20s."] = "Eine Robe oder ein Wams für untote und trollische Magier Ende 20.",
	-- ["Satyrs hold the ruins of {area:429} in eastern {zone:1440}. {spell:9052} at the bottom of the highest waterfall."] = "Satyrn halten die Ruinen von {area:429} im Osten von {zone:1440}. {spell:9052} am Fuß des höchsten Wasserfalls.",
	-- ["Take the zeppelin to {zone:1454}. {npc:5885} is one of {zone:1454}'s mage trainers."] = "Nimm den Zeppelin nach {zone:1454}. {npc:5885} ist einer der Magierlehrer in {zone:1454}.",
	-- ["The {quest:1945}, dryads, gather near the {area:426} in central {zone:1440}."] = "Die {quest:1945}, Dryaden, sammeln sich nahe {area:426} in der Mitte von {zone:1440}.",
	-- ["{npc:3484}, a troll tailor, works at the {area:380}."] = "{npc:3484}, eine Trollschneiderin, arbeitet in {area:380}.",
	-- ["{npc:4568} stands in the {zone:1458}'s {object:36082}. Trolls take the zeppelin from {zone:1454} to {zone:1420} for her."] = "{npc:4568} steht im {object:36082} von {zone:1458}. Trolle nehmen für sie den Zeppelin von {zone:1454} nach {zone:1420}.",
}
