-- French (frFR): the guide forever/class/paladin/verigans-fist (forever/class/paladin/verigans-fist.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:5502} Sense Undead
	["The Alliance paladin's rare two-handed mace for the 20s, with a shield and {spell:5502} on the way."] = "La rare masse à deux mains des paladins de l'Alliance pour les niveaux 20+, avec un bouclier et {spell:5502} en chemin.",

	-- Step 1: The Tome of Valor (Ironforge)
	-- {npc:6179} Tiza Battleforge · {object:32386} Hall of Mysteries (no name in this language: may be words) · {object:32362} Mystic Ward · {item:6776} Tome of Valor · {npc:6171} Duthorian Rall · {zone:1453} Stormwind · {area:2257} Deeprun Tram · {zone:1455} Ironforge
	["At 20 {npc:6179}, upstairs in the {object:32386} in the {object:32362}, gives you the {item:6776}. Right-click it: it sends you to {npc:6171} in {zone:1453}'s Cathedral of Light. Take the {area:2257} from {zone:1455} to {zone:1453}."] = "Au niveau 20, {npc:6179}, à l'étage de la salle des Mystères, dans {object:32362}, vous remet le {item:6776}. Faites un clic droit dessus : il vous envoie voir {npc:6171} dans la cathédrale de la Lumière de {zone:1453}. Prenez le {area:2257} de {zone:1455} à {zone:1453}.",

	-- Step 2: The Tome of Valor
	-- {npc:6171} Duthorian Rall · {item:6776} Tome of Valor
	["{npc:6171} stands in the Cathedral of Light. Humans get the {item:6776} from him. Right-click the book to start its quest and hand it straight back to him."] = "{npc:6171} se tient dans la cathédrale de la Lumière. Les humains reçoivent le {item:6776} de lui. Faites un clic droit sur le livre pour lancer sa quête et rendez-la-lui aussitôt.",
	-- {item:6776} Tome of Valor
	["Right-click the {item:6776}"] = "Clic droit sur le {item:6776}",

	-- Step 3: Daphne Stilwell
	-- {npc:6182} Daphne Stilwell · {zone:1436} Westfall · {area:20} Moonbrook · {area:1581} Deadmines
	-- plural, as words: Defias Raiders = {npc:6180} Defias Raider
	["{npc:6182}'s farmhouse stands on the south-west coast of {zone:1436}, south of {area:20}: take the path that runs south beside the {area:1581}' back exit. When you take her quest, she walks from her orchard to the house and three waves of Defias Raiders (level 17-18) attack: three, then four, then five. Fight close to her so they do not swarm her, and heal her when she drops. You get time to eat and drink between waves, and she heals to full. If you or {npc:6182} die, the quest fails: abandon it and take it again from her (she is back five minutes after dying). Players find it hard alone before about 24."] = "La ferme de {npc:6182} se trouve sur la côte sud-ouest de la {zone:1436}, au sud de {area:20} : prenez le chemin qui descend vers le sud le long de la sortie arrière des {area:1581}. Quand vous acceptez sa quête, elle marche de son verger jusqu'à la maison et trois vagues d'Écumeurs défias (niveau 17-18) attaquent : trois, puis quatre, puis cinq. Combattez près d'elle pour qu'ils ne l'encerclent pas, et soignez-la quand sa vie baisse. Vous avez le temps de manger et boire entre les vagues, et elle récupère toute sa vie. Si vous ou {npc:6182} mourez, la quête échoue : abandonnez-la et reprenez-la auprès d'elle (elle revient cinq minutes après sa mort). Les joueurs la trouvent difficile en solo avant le niveau 24 environ.",
	-- {npc:6182} Daphne Stilwell
	["Protect {npc:6182}: three waves"] = "Protégez {npc:6182} : trois vagues",

	-- Step 4: Duthorian Rall
	-- {npc:6171} Duthorian Rall · {item:9607} Bastion of Stormwind · {spell:5502} Sense Undead
	["Back to the Cathedral of Light: {npc:6171} gives you the {item:9607} shield and teaches you {spell:5502}."] = "Retour à la cathédrale de la Lumière : {npc:6171} vous donne le bouclier {item:9607} et vous apprend {spell:5502}.",

	-- Step 5: Jordan Stilwell
	-- {npc:6181} Jordan Stilwell · {zone:1455} Ironforge · {item:6996} Jordan's Weapon Notes
	["{npc:6181} works outside the gates of {zone:1455}, not inside. He gives you {item:6996}: four parts, in any order. Keep the notes."] = "{npc:6181} travaille devant les portes de {zone:1455}, pas à l'intérieur. Il vous remet les {item:6996} : quatre pièces, dans n'importe quel ordre. Gardez les notes.",

	-- Step 6: Bailor Stonehand
	-- {npc:6241} Bailor Stonehand · {area:144} Thelsamar
	["{npc:6241} is downstairs in the house of {area:144} that has a tailoring merchant outside. His quest only opens once you hold Jordan's."] = "{npc:6241} est au rez-de-chaussée de la maison de {area:144} devant laquelle se tient un marchand de fournitures de couture. Sa quête ne s'ouvre qu'une fois celle de Jordan en votre possession.",

	-- Step 7: Bailor's Ore
	-- {zone:1432} Loch Modan
	["The crate of ore sits outdoors in the middle of the Mo'grosh ogre camp in north-east {zone:1432}, beside a big tree and a broken wagon, between the caves. The camp holds about fifteen Mo'grosh ogres, elite (level 18-19), who knock you down and come back after five minutes: grouping up is encouraged; at 20-22 it needs a group of about three. The crate is back two seconds after each loot, so every paladin in the group gets one."] = "La caisse de minerai est posée en plein air au milieu du camp des ogres Mo'grosh, dans le nord-est du {zone:1432}, à côté d'un grand arbre et d'un chariot cassé, entre les grottes. Le camp abrite une quinzaine d'ogres Mo'grosh élites (niveau 18-19), qui vous renversent et reviennent au bout de cinq minutes : il est conseillé de grouper ; aux niveaux 20-22, il faut un groupe d'environ trois. La caisse revient deux secondes après chaque fouille : chaque paladin du groupe en obtient donc une.",
	-- {object:92420} Bailor's Ore
	["{object:92420} crate"] = "Caisse : {object:92420}",

	-- Step 8: Back to Bailor Stonehand
	-- {npc:6241} Bailor Stonehand
	["Back to {npc:6241}"] = "Retour à {npc:6241}",
	-- {npc:6241} Bailor Stonehand · {item:6993} Jordan's Refined Ore Shipment
	["{npc:6241} turns the ore into {item:6993}, the part Jordan wants."] = "{npc:6241} transforme le minerai en {item:6993}, la pièce que veut Jordan.",

	-- Step 9: Whitestone Oak Lumber
	-- {area:1581} Deadmines · {area:20} Moonbrook
	-- plural, as words: Goblin Woodcarvers = {npc:641} Goblin Woodcarver
	["{area:1581} is a group of five under {area:20}; the instance portal is at the bottom of the {area:20} mine. The Goblin Woodcarvers (elite, level 18-19) in the mast room with Sneed drop the lumber every time."] = "{area:1581} est un donjon à cinq sous {area:20} ; le portail de l'instance se trouve au fond de la mine de {area:20}. Les Sculpteurs gobelins (élites, niveau 18-19) de la salle du mât, avec Sneed, laissent tomber le bois à chaque fois.",
	-- {area:1581} Deadmines · {area:20} Moonbrook
	["{area:1581}, in the {area:20} mine"] = "{area:1581}, dans la mine de {area:20}",
	-- plural, as words: Goblin Woodcarvers = {npc:641} Goblin Woodcarver
	["Goblin Woodcarvers, inside"] = "Sculpteurs gobelins, à l'intérieur",

	-- Step 10: Jordan's Smithing Hammer
	-- {area:236} Shadowfang Keep · {zone:1421} Silverpine Forest · {zone:1437} Wetlands · {area:287} Hillsbrad
	["{area:236} is a dungeon for a group of five in the low to mid 20s, in southern {zone:1421}, Horde land: a long trip for the Alliance, through the {zone:1437}, Arathi and {area:287}. The hammer lies on a crate across from the horses in the stables, early in the dungeon, at the far end of the courtyard before the ramp up; it is back five minutes after someone takes it."] = "{area:236} est un donjon pour un groupe de cinq au début ou au milieu de la vingtaine de niveaux, dans le sud de la {zone:1421}, en territoire de la Horde : un long trajet pour l'Alliance, à travers les {zone:1437}, Arathi et {area:287}. Le marteau est posé sur une caisse en face des chevaux dans les écuries, au début du donjon, au fond de la cour avant la rampe ; il revient cinq minutes après que quelqu'un l'a pris.",
	-- {object:91138} Jordan's Hammer
	["{object:91138}, inside"] = "{object:91138}, à l'intérieur",

	-- Step 11: Thundris Windweaver
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["{npc:3649} is in {area:442}. Take his quest before you hunt naga: the Kor Gem never drops without it."] = "{npc:3649} est à {area:442}. Acceptez sa quête avant de chasser les nagas : la gemme kor ne tombe jamais sans elle.",

	-- Step 12: The Corrupted Kor Gem
	-- {item:6995} Corrupted Kor Gem
	["The {item:6995}"] = "La {item:6995}",
	-- {area:2797} Blackfathom Deeps · {zone:1440} Ashenvale · {item:6995} Corrupted Kor Gem · {spell:122} Frost Nova
	["The Blackfathom naga in the flooded passages around the {area:2797} entrance, on {zone:1440}'s north-west coast, drop the {item:6995}: Tide Priestesses (level 20-21), Oracles (21-22) and Sea Witches (23-24), one in two. You do not need to enter the instance. All are elite: grouping up is encouraged; players solo them one at a time, with difficulty. They heal themselves, run for help at low health, satyrs stand near some, and the Sea Witches cast {spell:122} up close. Some players report no drop while in a raid group."] = "Les nagas de Brassenoire dans les passages inondés autour de l'entrée de {area:2797}, sur la côte nord-ouest d'{zone:1440}, laissent tomber la {item:6995} : Prêtresses des marées (niveau 20-21), Oracles (21-22) et Sorcières des mers (23-24), une fois sur deux. Vous n'avez pas besoin d'entrer dans l'instance. Toutes sont élites : il est conseillé de grouper ; des joueurs les tuent en solo une par une, difficilement. Elles se soignent, fuient chercher de l'aide quand leur vie est basse, des satyres se tiennent près de certaines, et les Sorcières des mers lancent {spell:122} au corps à corps. Certains joueurs signalent n'avoir rien obtenu en groupe de raid.",

	-- Step 13: The Purified Kor Gem
	-- {item:7083} Purified Kor Gem
	["The {item:7083}"] = "La {item:7083}",
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["Back to {npc:3649} in {area:442}: he purifies the gem."] = "Retournez voir {npc:3649} à {area:442} : il purifie la gemme.",

	-- Step 14: Verigan's Fist
	-- {npc:6181} Jordan Stilwell · {zone:1455} Ironforge
	["Bring the four parts to {npc:6181} outside {zone:1455}. Accept his last quest and wait by him while he forges the mace at his anvil."] = "Apportez les quatre pièces à {npc:6181}, devant {zone:1455}. Acceptez sa dernière quête et attendez près de lui pendant qu'il forge la masse sur son enclume.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 20 {npc:6179} in the {object:32362} gives you the {item:6776}; it sends you to {npc:6171} in {zone:1453}'s Cathedral of Light. Take the tram from {zone:1455} to {zone:1453}."] = "Au niveau 20, {npc:6179}, dans {object:32362}, vous remet le {item:6776} ; il vous envoie voir {npc:6171} dans la Cathedral of Light de {zone:1453}. Prenez le tram de {zone:1455} à {zone:1453}.",
	-- ["Bring the four parts to {npc:6181} outside {zone:1455}."] = "Apportez les quatre pièces à {npc:6181}, devant {zone:1455}.",
	-- ["Protect {npc:6182}"] = "Protégez {npc:6182}",
	-- ["The Alliance paladin's rare two-handed mace for the 20s, with a shield on the way."] = "La rare masse à deux mains des paladins de l'Alliance pour les niveaux 20+, avec un bouclier en chemin.",
	-- ["The Blackfathom naga by the entrance of {area:2797} on {zone:1440}'s north-west coast drop the {item:6995}. They are elite: grouping up is advised."] = "Les nagas de Brassenoire près de l'entrée de {area:2797}, sur la côte nord-ouest d'{zone:1440}, laissent tomber la {item:6995}. Ils sont élites : un groupe est conseillé.",
	-- ["The ore crate lies by the trees in the middle of the Mo'grosh ogre camp in north-east {zone:1432}. The Mo'grosh ogres are elite: grouping up is advised."] = "La caisse de minerai se trouve près des arbres, au milieu du camp des ogres Mo'grosh, au nord-est du {zone:1432}. Les ogres Mo'grosh sont élites : un groupe est conseillé.",
	-- ["from the {item:6776}"] = "via le {item:6776}",
	-- ["{area:1581} is a group of five under {area:20}; the instance portal is inside the {area:20} mine. The Goblin Woodcarvers in the Mast Room, with Sneed, drop the lumber."] = "{area:1581} est un donjon à cinq sous {area:20} ; le portail se trouve dans la mine de {area:20}. Les Sculpteurs gobelins de la salle du mât, avec Sneed, laissent tomber le bois.",
	-- ["{area:236} is a level 20-30 dungeon in southern {zone:1421}. The hammer lies on a box inside the stables, at the far end of the courtyard before the ramp up."] = "{area:236} est un donjon de niveau 20-30 au sud de {zone:1421}. Le marteau repose sur une caisse dans les écuries, au fond de la cour, avant la rampe.",
	-- ["{npc:3649} is in {area:442}."] = "{npc:3649} est à {area:442}.",
	-- ["{npc:6171} stands in the Cathedral of Light. Right-click the {item:6776} to start its quest."] = "{npc:6171} se tient dans la Cathedral of Light. Faites un clic droit sur le {item:6776} pour commencer sa quête.",
	-- ["{npc:6181} stands outside the gates of {zone:1455}. He gives you {item:6996}, which list the four parts."] = "{npc:6181} se tient devant les portes de {zone:1455}. Il vous remet les {item:6996}, qui listent les quatre pièces.",
	-- ["{npc:6182}'s farmhouse stands on the south-west coast of {zone:1436}. Waves of Defias attack it during her quest: keep her alive, and heal her if she needs it."] = "La ferme de {npc:6182} se trouve sur la côte sud-ouest de {zone:1436}. Des vagues de Défias l'attaquent pendant sa quête : gardez-la en vie et soignez-la si besoin.",
	-- ["{npc:6241} is in {area:144}."] = "{npc:6241} est à {area:144}.",
	-- ["{npc:6241} turns the ore into {item:6993}."] = "{npc:6241} transforme le minerai en {item:6993}.",
}
