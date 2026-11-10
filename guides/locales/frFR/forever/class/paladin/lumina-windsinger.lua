-- French (frFR): the guide forever/class/paladin/lumina-windsinger (forever/class/paladin/lumina-windsinger.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:268484} Moonsilver Blade · {item:267369} Wolfsbane
	["{item:268484} and {item:267369} (Forsaken)"] = "{item:268484} et {item:267369} (Réprouvés)",
	-- {quest:91862} Lumina Windsinger · {quest:95140} Old Fire-Eye
	["The Forsaken paladin's two-handed sword: rescue {quest:91862}, gather three parts, slay {quest:95140}."] = "L'épée à deux mains du paladin réprouvé : secourez {quest:91862}, réunissez trois pièces, tuez {quest:95140}.",

	-- Step 1: Danitha Morr
	-- {npc:246378} Danitha Morr · {area:16602} Bandarion Keep · {area:156} Solliden Farmstead · {area:228} Sepulcher · {zone:1421} Silverpine Forest
	["At 18 {npc:246378}, inside {area:16602} on the bluffs north-west of the {area:156}, sends you south to the {area:228} in {zone:1421}."] = "Au niveau 18, {npc:246378}, à l'intérieur de {area:16602} sur les hauteurs au nord-ouest de la {area:156}, vous envoie au sud jusqu'au {area:228}, dans la {zone:1421}.",

	-- Step 2: Sepulcher
	-- {npc:248840} Trevan Rol · {area:228} Sepulcher · {npc:259611} Deathguard Baldren
	["{npc:248840} stands in the lower part of the {area:228}, below the surface; {npc:259611} keeps watch near the town's entrance."] = "{npc:248840} se tient dans la partie basse du {area:228}, sous la surface ; {npc:259611} monte la garde près de l'entrée du bourg.",

	-- Step 3: The pyre on Fenris Isle
	-- {area:172} Fenris Isle
	["The pyre on {area:172}"] = "Le bûcher de {area:172}",
	-- {area:172} Fenris Isle · {area:228} Sepulcher · {object:566037} Charred Remains
	["{area:172} lies in the lake north-east of the {area:228}. The gnolls' pyre, with the {object:566037}, is on its shore: click the remains to hand in, and click them again for the next quest. The body is a tauren's, not the elf's."] = "L'{area:172} se trouve dans le lac au nord-est du {area:228}. Le bûcher des gnolls, avec les {object:566037}, est sur sa rive : cliquez sur les restes pour rendre la quête, puis cliquez de nouveau dessus pour la quête suivante. Le corps est celui d'un tauren, pas celui de l'elfe.",
	-- {object:566037} Charred Remains
	["from the {object:566037}"] = "sur {object:566037}",

	-- Step 4: Fenris Keep
	-- {quest:91862} Lumina Windsinger · {area:235} Fenris Keep · {item:267412} Fenris Isle Key · {npc:1944} Rot Hide Bruiser
	["{quest:91862} is caged in the basement of {area:235}, at the north end of the isle. The Rot Hide gnolls (level 18-19) fill the keep: they pull in big groups across floors and players report very fast respawns, so clear a path and keep moving. Any of them can carry the {item:267412} (often the first kill); the rare {npc:1944} (22) and Snarlmane (23) can too. If her cage is empty, another player is escorting her: wait for her to come back."] = "{quest:91862} est enfermée dans une cage au sous-sol du {area:235}, à l'extrémité nord de l'île. Les gnolls Poil-Putride (niveau 18-19) remplissent le donjon : ils viennent en grands groupes d'un étage à l'autre et les joueurs signalent des réapparitions très rapides : dégagez un chemin et ne vous arrêtez pas. N'importe lequel d'entre eux peut porter la {item:267412} (souvent le premier tué) ; le rare {npc:1944} (22) et Snarlmane (23) aussi. Si sa cage est vide, un autre joueur l'escorte : attendez qu'elle revienne.",
	-- {item:267412} Fenris Isle Key
	["{item:267412}, from the Rot Hide gnolls"] = "{item:267412}, sur les gnolls Poil-Putride",

	-- Step 5: Free Lumina Windsinger
	-- {npc:248755} Lumina Windsinger
	["Free {npc:248755}"] = "Libérer {npc:248755}",
	-- {npc:248755} Lumina Windsinger · {area:228} Sepulcher
	["Hand in the key first: starting the escort before that gives the key quest no credit. Then open the cage: {npc:248755} walks out through the keep and its courtyard while the gnolls attack, then runs for the dock and makes her own way back to the {area:228}. Stay close and keep her alive; if she dies, take the quest again when she is back in her cage."] = "Rendez d'abord la clé : lancer l'escorte avant ne valide pas la quête de la clé. Ouvrez ensuite la cage : {npc:248755} traverse le donjon et sa cour pendant que les gnolls attaquent, puis court jusqu'au ponton et regagne seule le {area:228}. Restez près d'elle et gardez-la en vie ; si elle meurt, reprenez la quête quand elle est de retour dans sa cage.",

	-- Step 6: Back to the Sepulcher
	-- {area:228} Sepulcher
	["Back to the {area:228}"] = "Retour au {area:228}",
	-- {npc:259620} Lumina Windsinger · {npc:248840} Trevan Rol · {area:228} Sepulcher · {quest:95034} The Debt
	["{npc:259620} waits beside {npc:248840} in the {area:228} (a different {npc:259620} from the one you escorted). For {quest:95034}, click through every line of her story."] = "{npc:259620} attend à côté de {npc:248840} au {area:228} (une autre {npc:259620} que celle que vous avez escortée). Pour {quest:95034}, faites défiler chaque ligne de son histoire.",
	-- {npc:259620} Lumina Windsinger · {area:228} Sepulcher
	["{npc:259620}, the {area:228}"] = "{npc:259620}, au {area:228}",
	-- {npc:259620} Lumina Windsinger
	["{npc:259620}: hear her story to the end"] = "",

	-- Step 7: A Moon-Kissed Blade
	-- {npc:259620} Lumina Windsinger · {quest:95140} Old Fire-Eye · {npc:248840} Trevan Rol
	["At 20 {npc:259620} asks for a blade that can kill {quest:95140}. Talk to {npc:248840} beside her for his Weapon Notes, which list the parts, and keep them: he wants them back with the parts. Three parts, in any order: two from dungeons (a group of five each) and a gem from elite naga outside a third."] = "Au niveau 20, {npc:259620} demande une lame capable de tuer {quest:95140}. Parlez à {npc:248840}, à côté d'elle, pour obtenir ses notes sur l'arme, qui listent les pièces, et gardez-les : il les veut en retour avec les pièces. Trois pièces, dans n'importe quel ordre : deux dans des donjons (un groupe de cinq pour chacun) et une gemme sur des nagas élites devant un troisième.",
	-- {item:267454} Trevan's Weapon Notes · {npc:248840} Trevan Rol
	["{item:267454}: talk to {npc:248840}"] = "{item:267454} : parlez à {npc:248840}",

	-- Step 8: The Enchanted Silver Ingot
	-- {item:267361} Enchanted Silver Ingot
	["The {item:267361}"] = "Le {item:267361}",
	-- {area:236} Shadowfang Keep · {npc:4275} Archmage Arugal
	["{area:236} is the dungeon in south Silverpine, for a group of five in the low to mid 20s. The ingot sits on the table next to {npc:4275} at the very end. A friend's cleared instance works: walk in and run to the table."] = "{area:236} est le donjon du sud de la forêt des Pins-Argentés, pour un groupe de cinq au début ou au milieu de la vingtaine de niveaux. Le lingot est posé sur la table à côté d'{npc:4275}, tout au fond. L'instance déjà nettoyée d'un ami convient : entrez et courez jusqu'à la table.",
	-- {item:267361} Enchanted Silver Ingot
	["{item:267361}, on Arugal's table"] = "{item:267361}, sur la table d'Arugal",

	-- Step 9: Whitestone Oak Lumber
	-- {area:1581} The Deadmines · {area:20} Moonbrook · {zone:1436} Westfall · {zone:1458} Undercity · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1434} Stranglethorn Vale · {zone:1431} Duskwood
	-- plural, as words: Goblin Woodcarvers = {npc:641} Goblin Woodcarver
	["{area:1581} lies under {area:20} in {zone:1436}, Alliance land: a group of five at about 17-24. From the {zone:1458} take the zeppelin to {object:3202} in {zone:1434} and go north through {zone:1431} into {zone:1436}. The way in is the {area:20} mine. The Goblin Woodcarvers (elite, level 18-19) in Sneed's mast room drop the lumber every time."] = "",
	-- {area:1581} The Deadmines · {area:20} Moonbrook
	["{area:1581}, in the {area:20} mine"] = "{area:1581}, dans la mine de {area:20}",
	-- plural, as words: Goblin Woodcarvers = {npc:641} Goblin Woodcarver
	["Goblin Woodcarvers, inside"] = "Sculpteurs gobelins, à l'intérieur",

	-- Step 10: Ulric Frostveil
	-- {npc:259649} Ulric Frostveil · {area:2897} Zoram'gar Outpost · {zone:1440} Ashenvale · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1458} Undercity · {zone:1454} Orgrimmar · {zone:1413} Barrens
	["{npc:259649} waits at {area:2897} on {zone:1440}'s west coast: take the zeppelin from {object:3202} (or the {zone:1458}) to {zone:1454}, then go north through the {zone:1413} into {zone:1440} and west along the road. Andruk, the outpost's wind rider master, saves you the walk next time. Take {npc:259649}'s quest before you hunt the naga: the Kor Gem only drops while you have it."] = "",

	-- Step 11: The Corrupted Kor Gem
	-- {item:6995} Corrupted Kor Gem
	["The {item:6995}"] = "La {item:6995}",
	-- {area:2797} Blackfathom Deeps · {item:6995} Corrupted Kor Gem · {spell:122} Frost Nova
	["The naga stand in the flooded ruins and passages around the {area:2797} entrance, just north of Zoram'gar: you do not need to enter the instance (its first naga drop the gem too). Tide Priestesses (level 20-21), Oracles (21-22) and Sea Witches (23-24) drop the {item:6995}, one in two. All are elite: grouping up is encouraged. Players solo them one at a time, with difficulty; a group of three makes it easy. They heal themselves, run for help at low health, and the Sea Witches cast {spell:122} up close. Some players report no drop while in a raid group."] = "Les nagas se tiennent dans les ruines inondées et les passages autour de l'entrée de {area:2797}, juste au nord de Zoram'gar : vous n'avez pas besoin d'entrer dans l'instance (ses premiers nagas laissent aussi tomber la gemme). Les Prêtresses des marées (niveau 20-21), Oracles (21-22) et Sorcières des mers (23-24) laissent tomber la {item:6995}, une fois sur deux. Toutes sont élites : il est conseillé de grouper. Des joueurs les tuent en solo une par une, difficilement ; un groupe de trois rend la chose facile. Elles se soignent, fuient chercher de l'aide quand leur vie est basse, et les Sorcières des mers lancent {spell:122} au corps à corps. Certains joueurs signalent n'avoir rien obtenu en groupe de raid.",

	-- Step 12: The Purified Kor Gem
	-- {item:272448} Purified Kor Gem
	["The {item:272448}"] = "La {item:272448}",
	-- {npc:259649} Ulric Frostveil · {item:272448} Purified Kor Gem · {npc:248840} Trevan Rol
	["Back to {npc:259649} at Zoram'gar: he cleanses the gem. Keep the {item:272448} for {npc:248840}."] = "Retournez voir {npc:259649} à Zoram'gar : il purifie la gemme. Gardez la {item:272448} pour {npc:248840}.",

	-- Step 13: Trevan Rol
	-- {npc:248840} Trevan Rol · {area:228} Sepulcher · {item:268192} Bundle of Blacksmithing Materials · {area:272} Tarren Mill
	["Bring the lumber, the ingot and the gem to {npc:248840} in the {area:228}. He gives you a {item:268192} for a smith in {area:272}: keep it in your bags."] = "Apportez le bois, le lingot et la gemme à {npc:248840} au {area:228}. Il vous donne un {item:268192} pour un forgeron d'{area:272} : gardez-le dans vos sacs.",

	-- Step 14: Ott
	-- {npc:3539} Ott · {area:272} Tarren Mill · {zone:1424} Hillsbrad Foothills · {quest:95125} Ott's Masterwork
	["{npc:3539}, the weaponsmith, stands just south of {area:272} in {zone:1424}. Accepting {quest:95125} starts the forging: step back and wait near him until he is done."] = "{npc:3539}, le fabricant d'armes, se tient juste au sud d'{area:272}, dans les {zone:1424}. Accepter {quest:95125} lance la forge : reculez et attendez près de lui qu'il ait fini.",
	-- {npc:3539} Ott
	["Watch {npc:3539} forge the blade"] = "",
	-- {npc:3539} Ott · {quest:95125} Ott's Masterwork
	["{npc:3539} gives you {quest:95125}"] = "{npc:3539} vous donne {quest:95125}",

	-- Step 15: The Moonsilver Blade
	-- {npc:248840} Trevan Rol · {area:228} Sepulcher · {item:268484} Moonsilver Blade
	["Back to {npc:248840} in the {area:228}'s lower part: he hands you the {item:268484}, a two-handed sword."] = "Retournez voir {npc:248840} dans la partie basse du {area:228} : il vous remet la {item:268484}, une épée à deux mains.",

	-- Step 16: Two-Handed Swords
	-- {npc:11870} Archibald · {zone:1458} Undercity · {object:36070} War Quarter · {spell:202} Two-Handed Swords
	["The blade is a two-handed sword, and you need the skill to hit a level 25 elite with it. {npc:11870}, the weapon master in the {zone:1458}'s {object:36070}, teaches {spell:202} for a small fee; then swing it on easy mobs until the skill is near its cap (five points per level)."] = "La lame est une épée à deux mains, et il vous faut la compétence pour toucher avec elle un élite de niveau 25. {npc:11870}, le maître d'armes du {object:36070} de {zone:1458}, enseigne {spell:202} pour une petite somme ; frappez ensuite des monstres faciles avec jusqu'à ce que la compétence approche de son maximum (cinq points par niveau).",

	-- Step 17: Old Fire-Eye
	-- {item:268484} Moonsilver Blade · {quest:95140} Old Fire-Eye · {area:228} Sepulcher · {area:17065} Gilneas
	["Equip the {item:268484}. {quest:95140}, the great worgen, roams the woods south of the {area:228} toward the gates of {area:17065}. He is elite (level 25): grouping up is encouraged; one player needed a second, another soloed him at 25. A purple shield guards him until your first swing with the blade lands: a message tells you it broke."] = "Équipez la {item:268484}. {quest:95140}, le grand worgen, rôde dans les bois au sud du {area:228}, vers les portes de {area:17065}. Il est élite (niveau 25) : il est conseillé de grouper ; un joueur a eu besoin d'un second, un autre l'a tué en solo au niveau 25. Un bouclier violet le protège jusqu'à ce que votre premier coup avec la lame porte : un message vous indique qu'il s'est brisé.",
	-- {quest:95140} Old Fire-Eye · {item:268484} Moonsilver Blade
	["{quest:95140}, with the {item:268484} equipped"] = "{quest:95140}, avec la {item:268484} équipée",

	-- Step 18: Wolfsbane
	-- {npc:259620} Lumina Windsinger · {area:228} Sepulcher · {item:268484} Moonsilver Blade · {item:267369} Wolfsbane
	["Back to {npc:259620} in the {area:228} with the {item:268484} (the quest asks for it): she takes it and blesses it with the magic of her people into {item:267369}."] = "Retournez voir {npc:259620} au {area:228} avec la {item:268484} (la quête la demande) : elle la prend et la bénit de la magie de son peuple pour en faire {item:267369}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Free her with the key, then stay close while she fights her way out of the keep."] = "Libérez-la avec la clé, puis restez près d'elle pendant qu'elle se fraie un chemin hors du donjon.",
	-- ["No item yet: a Forsaken paladin rescue story; its sequel, the {item:268484}, cannot be finished yet."] = "Pas encore d'objet : une histoire de sauvetage pour paladin réprouvé ; sa suite, la {item:268484}, ne peut pas encore être terminée.",
	-- ["Once she is clear of {area:235}, Lumina waits for you in the {area:228}. Speak with her again to hear what really happened on the road."] = "Une fois sortie de {area:235}, Lumina vous attend au {area:228}. Parlez-lui de nouveau pour apprendre ce qui s'est vraiment passé sur la route.",
	-- ["Once she is clear of {area:235}, {npc:259620} waits for you in the {area:228}. Speak with her again to hear what really happened on the road."] = "Une fois sortie de {area:235}, {npc:259620} vous attend au {area:228}. Parlez-lui de nouveau pour apprendre ce qui s'est vraiment passé sur la route.",
	-- ["Rescuing {quest:91862}"] = "Secourir {quest:91862}",
	-- ["Ride south through {zone:1421} to the {area:228}. {npc:248840} stands in the town; {npc:259611} keeps watch near its entrance."] = "Allez vers le sud à travers {zone:1421} jusqu'au {area:228}. {npc:248840} se trouve dans le bourg ; {npc:259611} monte la garde près de l'entrée.",
	-- ["{area:1581} lies under {area:20} in {zone:1436}, Alliance land: a group of five at about 17-24. The way in is the {area:20} mine. The Goblin Woodcarvers (elite, level 18-19) in Sneed's mast room drop the lumber every time."] = "{area:1581} se trouve sous {area:20}, en {zone:1436}, en territoire de l'Alliance : un groupe de cinq vers les niveaux 17-24. L'entrée est la mine de {area:20}. Les Sculpteurs gobelins (élites, niveau 18-19) de la salle du mât de Sneed laissent tomber le bois à chaque fois.",
	-- ["{area:172} lies in the lake east of the {area:228}. The charred remains are on its shore."] = "{area:172} se trouve dans le lac à l'est du {area:228}. Les restes calcinés sont sur sa rive.",
	-- ["{item:267412}, from the {npc:14235} Hide gnolls"] = "{item:267412}, sur les gnolls poil-putride ({npc:14235})",
	-- ["{npc:246378} leads the Paladins of Tyr's Watch from inside {area:16602}, on the bluffs north-west of the {area:156}."] = "{npc:246378} dirige les paladins de Tyr's Watch depuis {area:16602}, sur les hauteurs au nord-ouest de la {area:156}.",
	-- ["{npc:259649} waits at {area:2897} on {zone:1440}'s west coast: from the {zone:1458} take the zeppelin to {zone:1454}, then go north through the {zone:1413} into {zone:1440} and west along the road. Andruk, the outpost's wind rider master, saves you the walk next time. Take {npc:259649}'s quest before you hunt the naga: the Kor Gem only drops while you have it."] = "{npc:259649} attend à l'{area:2897}, sur la côte ouest d'{zone:1440} : depuis {zone:1458}, prenez le zeppelin pour {zone:1454}, puis allez vers le nord à travers les {zone:1413} jusqu'en {zone:1440} et vers l'ouest par la route. Andruk, le maître des coursiers du vent de l'avant-poste, vous épargnera la marche la prochaine fois. Acceptez la quête de {npc:259649} avant de chasser les nagas : la gemme kor ne tombe que si vous l'avez.",
	-- ["{quest:91862} is caged inside {area:235}, at the north end of the isle. The Rot Hide gnolls around her carry the key."] = "{quest:91862} est enfermée dans une cage à l'intérieur de {area:235}, à l'extrémité nord de l'île. Les gnolls Poil-Putride autour d'elle portent la clé.",
	-- ["{quest:91862} is caged inside {area:235}, at the north end of the isle. {npc:14235} Hide gnolls around her carry the key."] = "{quest:91862} est enfermée dans une cage à {area:235}, au nord de l'île. Les gnolls poil-putride ({npc:14235}) qui l'entourent portent la clé.",
	-- ["{zone:1458} and Earthen Ring reputation"] = "Réputation auprès de {zone:1458} et du Cercle terrestre",
}
