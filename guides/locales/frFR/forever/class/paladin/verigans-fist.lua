-- French (frFR): the guide forever/class/paladin/verigans-fist (forever/class/paladin/verigans-fist.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["The Alliance paladin's rare two-handed mace for the 20s, with a shield on the way."] = "La rare masse à deux mains des paladins de l'Alliance pour les niveaux 20+, avec un bouclier en chemin.",

	-- Step 1: The Tome of Valor (Ironforge)
	-- {npc:6179} Tiza Battleforge · {object:32362} Mystic Ward · {item:6776} Tome of Valor · {npc:6171} Duthorian Rall · {zone:1453} Stormwind · {zone:1455} Ironforge
	["At 20 {npc:6179} in the {object:32362} gives you the {item:6776}; it sends you to {npc:6171} in {zone:1453}'s Cathedral of Light. Take the tram from {zone:1455} to {zone:1453}."] = "Au niveau 20, {npc:6179}, dans {object:32362}, vous remet le {item:6776} ; il vous envoie voir {npc:6171} dans la Cathedral of Light de {zone:1453}. Prenez le tram de {zone:1455} à {zone:1453}.",

	-- Step 2: The Tome of Valor
	-- {npc:6171} Duthorian Rall · {item:6776} Tome of Valor
	["{npc:6171} stands in the Cathedral of Light. Right-click the {item:6776} to start its quest."] = "{npc:6171} se tient dans la Cathedral of Light. Faites un clic droit sur le {item:6776} pour commencer sa quête.",
	-- {item:6776} Tome of Valor
	["from the {item:6776}"] = "via le {item:6776}",

	-- Step 3: Daphne Stilwell
	-- {npc:6182} Daphne Stilwell · {zone:1436} Westfall
	["{npc:6182}'s farmhouse stands on the south-west coast of {zone:1436}. Waves of Defias attack it during her quest: keep her alive, and heal her if she needs it."] = "La ferme de {npc:6182} se trouve sur la côte sud-ouest de {zone:1436}. Des vagues de Défias l'attaquent pendant sa quête : gardez-la en vie et soignez-la si besoin.",
	-- {npc:6182} Daphne Stilwell
	["Protect {npc:6182}"] = "Protégez {npc:6182}",

	-- Step 5: Jordan Stilwell
	-- {npc:6181} Jordan Stilwell · {zone:1455} Ironforge · {item:6996} Jordan's Weapon Notes
	["{npc:6181} stands outside the gates of {zone:1455}. He gives you {item:6996}, which list the four parts."] = "{npc:6181} se tient devant les portes de {zone:1455}. Il vous remet les {item:6996}, qui listent les quatre pièces.",

	-- Step 6: Bailor Stonehand
	-- {npc:6241} Bailor Stonehand · {area:144} Thelsamar
	["{npc:6241} is in {area:144}."] = "{npc:6241} est à {area:144}.",

	-- Step 7: Bailor's Ore
	-- {zone:1432} Loch Modan
	["The ore crate lies by the trees in the middle of the Mo'grosh ogre camp in north-east {zone:1432}. The Mo'grosh ogres are elite: grouping up is advised."] = "La caisse de minerai se trouve près des arbres, au milieu du camp des ogres Mo'grosh, au nord-est du {zone:1432}. Les ogres Mo'grosh sont élites : un groupe est conseillé.",
	-- {object:92420} Bailor's Ore
	["{object:92420} crate"] = "Caisse : {object:92420}",

	-- Step 8: Back to Bailor Stonehand
	-- {npc:6241} Bailor Stonehand
	["Back to {npc:6241}"] = "Retour à {npc:6241}",
	-- {npc:6241} Bailor Stonehand · {item:6993} Jordan's Refined Ore Shipment
	["{npc:6241} turns the ore into {item:6993}."] = "{npc:6241} transforme le minerai en {item:6993}.",

	-- Step 9: Whitestone Oak Lumber
	-- {area:1581} The Deadmines · {area:20} Moonbrook
	-- plural, as words: Goblin Woodcarvers = {npc:641} Goblin Woodcarver
	["{area:1581} is a group of five under {area:20}; the instance portal is inside the {area:20} mine. The Goblin Woodcarvers in the Mast Room, with Sneed, drop the lumber."] = "{area:1581} est un donjon à cinq sous {area:20} ; le portail se trouve dans la mine de {area:20}. Les Sculpteurs gobelins de la salle du mât, avec Sneed, laissent tomber le bois.",
	-- {area:1581} The Deadmines · {area:20} Moonbrook
	["{area:1581}, in the {area:20} mine"] = "{area:1581}, dans la mine de {area:20}",
	-- plural, as words: Goblin Woodcarvers = {npc:641} Goblin Woodcarver
	["Goblin Woodcarvers, inside"] = "Sculpteurs gobelins, à l'intérieur",

	-- Step 10: Jordan's Smithing Hammer
	-- {area:236} Shadowfang Keep · {zone:1421} Silverpine Forest
	["{area:236} is a level 20-30 dungeon in southern {zone:1421}. The hammer lies on a box inside the stables, at the far end of the courtyard before the ramp up."] = "{area:236} est un donjon de niveau 20-30 au sud de {zone:1421}. Le marteau repose sur une caisse dans les écuries, au fond de la cour, avant la rampe.",
	-- {object:91138} Jordan's Hammer
	["{object:91138}, inside"] = "{object:91138}, à l'intérieur",

	-- Step 11: Thundris Windweaver
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["{npc:3649} is in {area:442}."] = "{npc:3649} est à {area:442}.",

	-- Step 12: The Corrupted Kor Gem
	-- {item:6995} Corrupted Kor Gem
	["The {item:6995}"] = "La {item:6995}",
	-- {area:2797} Blackfathom Deeps · {zone:1440} Ashenvale · {item:6995} Corrupted Kor Gem
	["The Blackfathom naga by the entrance of {area:2797} on {zone:1440}'s north-west coast drop the {item:6995}. They are elite: grouping up is advised."] = "Les nagas de Brassenoire près de l'entrée de {area:2797}, sur la côte nord-ouest d'{zone:1440}, laissent tomber la {item:6995}. Ils sont élites : un groupe est conseillé.",

	-- Step 13: The Purified Kor Gem
	-- {item:7083} Purified Kor Gem
	["The {item:7083}"] = "La {item:7083}",
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["Back to {npc:3649} in {area:442}: he purifies the gem."] = "Retournez voir {npc:3649} à {area:442} : il purifie la gemme.",

	-- Step 14: Verigan's Fist
	-- {npc:6181} Jordan Stilwell · {zone:1455} Ironforge
	["Bring the four parts to {npc:6181} outside {zone:1455}."] = "Apportez les quatre pièces à {npc:6181}, devant {zone:1455}.",
}
