-- French (frFR): the guide forever/class/mage/nether-lace-garment (forever/class/mage/nether-lace-garment.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A robe or a tunic for Horde mages in their late 20s."] = "Une robe ou une tunique pour les mages de la Horde vers la fin de la vingtaine de niveaux.",

	-- Step 1: Anastasia Hartwell
	-- {npc:4568} Anastasia Hartwell · {zone:1458} Undercity · {object:36082} Magic Quarter · {spell:3563} Teleport: Undercity · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["{npc:4568} stands in the {zone:1458}'s {object:36082}. Orcs and Trolls use {spell:3563} or take the zeppelin from {zone:1454} to {zone:1420} for her."] = "{npc:4568} se trouve dans le {object:36082} de {zone:1458}. Les orcs et les trolls utilisent {spell:3563} ou prennent le zeppelin d'{zone:1454} à {zone:1420} pour la rejoindre.",

	-- Step 2: Deino
	-- {zone:1454} Orgrimmar · {spell:3567} Teleport: Orgrimmar · {object:173161} Darkbriar Lodge (no name in this language: may be words) · {npc:5885} Deino · {object:172961} Valley of Spirits · {item:7269} Deino's Flask
	["Take the zeppelin to {zone:1454} (or use {spell:3567}, which lands you on the upper floor of {object:173161}). {npc:5885} stands with the mage trainers on the lower floor of {object:173161} in the {object:172961}. She hands you {item:7269}."] = "Prenez le zeppelin pour {zone:1454} (ou utilisez {spell:3567}, qui vous dépose à l'étage supérieur du pavillon Darkbriar). {npc:5885} se tient avec les maîtres des mages à l'étage inférieur du pavillon Darkbriar, dans {object:172961}. Elle vous remet {item:7269}.",

	-- Step 3: The Xavian Waterfall
	-- {object:174797} Xavian Waterfall (no name in this language: may be words)
	["The {object:174797}"] = "{object:174797}",
	-- {area:431} Splintertree Post · {area:429} Xavian
	["Fly to {area:431} and swim north up the river past the big lake to its far northern end, where the zone text reads {area:429}; satyrs hold the ruins around it and a few river beasts are in the way. Swim right in under the highest waterfall until you touch the rock wall, then use the flask (you can stay in the water). The waterfalls on the western Falfarren fork do not work."] = "Volez jusqu'à {area:431} et remontez la rivière à la nage vers le nord, au-delà du grand lac, jusqu'à son extrémité nord, là où le nom de la zone affiche {area:429} ; des satyres tiennent les ruines alentour et quelques bêtes de rivière barrent le chemin. Nagez droit sous la plus haute cascade jusqu'à toucher la paroi rocheuse, puis utilisez la fiole (vous pouvez rester dans l'eau). Les cascades de la branche ouest, la Falfarren, ne fonctionnent pas.",
	-- {item:7269} Deino's Flask
	["{item:7269}, under the falls"] = "{item:7269}, sous les chutes",

	-- Step 4: Back to Deino
	-- {npc:5885} Deino
	["Back to {npc:5885}"] = "Retournez voir {npc:5885}",

	-- Step 5: The Laughing Sisters
	-- {quest:1945} Laughing Sisters
	["The {quest:1945}"] = "{quest:1945}",
	-- {quest:1945} Laughing Sisters · {area:426} Raynewood Retreat · {zone:1440} Ashenvale
	["The {quest:1945}, dryads of level 24-25, roam around the {area:426} in central {zone:1440}; every one drops a hair and they come back after 5 minutes. They often resist fire (and some frost and shadow): arcane spells land best. Each runs for help at low health. Keep clear of the guards by the white tower of the retreat, who hit hard."] = "Les {quest:1945}, des dryades de niveau 24-25, errent autour de la {area:426}, au centre d'{zone:1440} ; chacune laisse tomber un cheveu et elles reviennent au bout de 5 minutes. Elles résistent souvent au feu (et certaines au givre et à l'ombre) : les sorts des arcanes passent le mieux. Chacune fuit chercher de l'aide quand sa vie est basse. Tenez-vous loin des gardes près de la tour blanche de la retraite, qui frappent fort.",

	-- Step 6: Kil'hala
	-- {npc:3484} Kil'hala
	["{npc:3484}, a troll tailor, works at the Crossroads. The robe gives intellect, stamina and spirit; the tunic more intellect and stamina but no spirit."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A robe or a tunic for Undead and Troll mages in their late 20s."] = "Une robe ou une tunique pour les mages morts-vivants et trolls, vers la fin des niveaux 20.",
	-- ["Satyrs hold the ruins of {area:429} in eastern {zone:1440}. Fill {item:7269} at the bottom of the highest waterfall."] = "Des satyres occupent les ruines de {area:429}, à l'est d'{zone:1440}. Remplissez {item:7269} au pied de la plus haute cascade.",
	-- ["Satyrs hold the ruins of {area:429} in eastern {zone:1440}. {spell:9052} at the bottom of the highest waterfall."] = "Des satyres occupent les ruines de {area:429} dans l'est d'{zone:1440}. {spell:9052} au pied de la plus haute cascade.",
	-- ["Take the zeppelin to {zone:1454}. {npc:5885} is one of {zone:1454}'s mage trainers."] = "Prenez le zeppelin pour {zone:1454}. {npc:5885} est l'un des maîtres des mages d'{zone:1454}.",
	-- ["The {quest:1945}, dryads, gather near the {area:426} in central {zone:1440}."] = "Les {quest:1945}, des dryades, se rassemblent près de {area:426}, au centre d'{zone:1440}.",
	-- ["{npc:3484}, a troll tailor, works at the {area:380}."] = "{npc:3484}, un tailleur troll, travaille à {area:380}.",
	-- ["{npc:3484}, a troll tailor, works at the {area:380}. The robe gives intellect, stamina and spirit; the tunic more intellect and stamina but no spirit."] = "{npc:3484}, un tailleur troll, travaille à la {area:380}. La robe donne intelligence, endurance et esprit ; la tunique plus d'intelligence et d'endurance mais pas d'esprit.",
	-- ["{npc:4568} stands in the {zone:1458}'s {object:36082}. Trolls take the zeppelin from {zone:1454} to {zone:1420} for her."] = "{npc:4568} se trouve dans le {object:36082} de {zone:1458}. Les trolls prennent le zeppelin d'{zone:1454} à {zone:1420} pour la rejoindre.",
}
