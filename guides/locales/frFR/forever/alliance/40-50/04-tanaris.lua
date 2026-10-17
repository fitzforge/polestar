-- French (frFR): the guide forever/alliance/40-50/04-tanaris (forever/alliance/40-50/04-tanaris.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Mirage Raceway
	-- {area:1108} Forgotten Coast · {area:489} Thalanaar · {zone:1441} Thousand Needles · {area:2240} Mirage Raceway · {area:439} Shimmering Flats · {npc:4454} Fizzle Brassbolts · {npc:4630} Pozzik · {npc:4709} Zamek
	["From the {area:1108} dock, boat to Feathermoon and fly to {area:489}, then ride east through {zone:1441} to the {area:2240} on the {area:439}. {npc:4454} and {npc:4630} are in the camps beside the track; {npc:4709} stands by the goblin camp."] = "Depuis le quai de la {area:1108}, prenez le bateau pour le Bastion de Pennelune et volez jusqu'à {area:489}, puis chevauchez vers l'est à travers {zone:1441} jusqu'au {area:2240} sur les {area:439}. {npc:4454} et {npc:4630} sont dans les camps près de la piste ; {npc:4709} se tient près du camp gobelin.",
	["He runs off to keep Rizzle busy"] = "Il s'éloigne pour occuper Rizzle Brassbolts",

	-- Step 2: Rizzle's plans
	["Rizzle's plans"] = "Les Plans de Rizzle",
	-- {npc:4709} Zamek
	["While {npc:4709} keeps Rizzle talking, his plans lie unguarded in the gnome camp across the track."] = "Pendant que {npc:4709} retient Rizzle Brassbolts, ses plans sont laissés sans surveillance dans le camp gnome de l'autre côté de la piste.",

	-- Step 4: Gadgetzan
	-- {area:439} Shimmering Flats · {zone:1446} Tanaris · {area:976} Gadgetzan
	["Ride south-east off the {area:439} into {zone:1446}. {area:976} is just inside the border."] = "Chevauchez au sud-est hors des {area:439} jusqu'en {zone:1446}. {area:976} est juste après la frontière.",
	-- {quest:2864} Tran'rek
	["{quest:2864}, north side of town"] = "{quest:2864}, au nord de la ville",
	-- {npc:7407} Chief Engineer Bilgewhizzle
	["{npc:7407}, by the water tower"] = "{npc:7407}, près du château d'eau",
	-- {npc:7408} Spigot Operator Luglunket
	["{npc:7408}, next to him"] = "{npc:7408}, à côté de lui",

	-- Step 5: Steamwheedle Port
	["Ride east across the dunes to the goblin harbour on the north-east coast."] = "Chevauchez vers l'est à travers les dunes jusqu'au Port Gentepression sur la côte nord-est.",
	-- {npc:7881} Stoley
	["{npc:7881}, in the port's tavern"] = "{npc:7881}, dans la taverne du port",
	["The Wanted poster beside him"] = "L'affiche Avis de recherche à côté de lui",
	-- {npc:7847} Caliph Scorpidsting · {area:976} Gadgetzan
	["The same poster: {npc:7847} comes much later, after {area:976}"] = "La même affiche : {npc:7847} vient bien plus tard, après {area:976}",

	-- Step 6: Lost Rigger Cove
	-- {npc:7883} Andre Firebeard · {npc:7881} Stoley
	["Follow the coast south to the pirate cove. Southsea pirates crowd the beach and the boats: work along the edge and pull one at a time. {npc:7883} stands on the far side; {npc:7881}'s stolen cargo lies in the camp."] = "Suivez la côte vers le sud jusqu'à la Crique des Gréements. Des Pirates des Mers du sud envahissent la plage et les bateaux : progressez par les bords et attirez-les un par un. {npc:7883} se tient de l'autre côté ; la cargaison volée de {npc:7881} se trouve dans le camp.",

	-- Step 7: Steamwheedle Port
	-- {npc:7881} Stoley · {area:35} Booty Bay
	["{npc:7881}'s next delivery goes back to {area:35}: skip it."] = "La livraison suivante de {npc:7881} retourne à {area:35} : passez-la.",

	-- Step 8: Wastewander bandits
	["Wastewander bandits"] = "Les bandits Bat-le-désert",
	-- {area:976} Gadgetzan
	["Ride back west toward {area:976}. The Wastewander bandits and thieves hold the dunes on the way; any of them can carry a water pouch."] = "Revenez vers l'ouest en direction de {area:976}. Des Bandits Bat-le-désert et des Larrons Bat-le-désert tiennent les dunes en chemin ; chacun d'eux peut porter une Outre de Bat-le-désert.",

	-- Step 10: Waterspring Field
	-- {area:976} Gadgetzan · {npc:7847} Caliph Scorpidsting
	["The tougher Wastewander rogues, shadow mages and assassins camp south-east of {area:976}, south of the bandits. Leave {npc:7847} in the middle of the southern camp for later."] = "Les Voleurs Bat-le-désert, Mages de l'ombre Bat-le-désert et Assassins Bat-le-désert, plus coriaces, campent au sud-est de {area:976}, au sud des bandits. Laissez {npc:7847} au centre du camp sud pour plus tard.",

	-- Step 11: Gadgetzan
	-- {npc:7763} Curgle Cranklehop · {area:702} Rut'theran Village
	["{npc:7763}: his crate goes to {area:702}, later"] = "{npc:7763} : sa caisse va au {area:702}, plus tard",

	-- Step 12: The pool by Sandsorrow Watch
	-- {area:979} Sandsorrow Watch
	["The pool by {area:979}"] = "Le bassin près de {area:979}",
	-- {area:979} Sandsorrow Watch · {item:8584} Untapped Dowsing Widget
	["Ride north-west to the Sandfury troll camp at {area:979}. Use the {item:8584} at the edge of its pool; the trolls stand close, so pull the nearest first."] = "Chevauchez au nord-ouest jusqu'au camp des trolls Sandfury à {area:979}. Utilisez le {item:8584} au bord de son bassin ; les trolls sont proches, attirez d'abord le plus près.",
	-- {item:8585} Tapped Dowsing Widget
	["Gives the {item:8585}"] = "Donne le {item:8585}",
	-- {area:979} Sandsorrow Watch
	["Pool by {area:979}"] = "Bassin près de {area:979}",

	-- Step 14: The Broken Pillar
	-- {area:1938} Broken Pillar
	["The {area:1938}"] = "{area:1938}",
	-- {area:1938} Broken Pillar · {npc:7771} Marvon Rivetseeker · {quest:3161} Gahz'ridian
	["Ride south to the dig camp at the {area:1938}. {npc:7771} hands you a detector helm: wear it to see the {quest:3161} mounds, which lie thick in the sand around the camp and south-west toward the ogres."] = "Chevauchez vers le sud jusqu'au camp de fouilles du {area:1938}. {npc:7771} Rivetseeker vous remet un casque détecteur : portez-le pour voir les monticules de {quest:3161}, nombreux dans le sable autour du camp et au sud-ouest vers les ogres.",

	-- Step 15: Dunemaul Compound
	-- {npc:12046} Gor'marok the Ravager
	["Ride south-west to the ogre compound. Brutes and Enforcers (46-48) fill it; {npc:12046} (49) stands in the middle with guards around him: clear them first."] = "Chevauchez au sud-ouest jusqu'à la Base des Cognedunes. Des Brutes Cognedune et des Massacreurs Cognedune (46-48) la remplissent ; {npc:12046} (49) se tient au centre entouré de gardes : éliminez-les d'abord.",

	-- Step 16: The Noxious Lair
	["Ride north-west to the Centipaar hive in the dunes. Any Centipaar can drop insect parts."] = "Chevauchez au nord-ouest jusqu'au Repaire nuisible, la ruche Centipaar dans les dunes. Tout Centipaar peut laisser tomber des Morceaux d'insecte Centipaar.",

	-- Step 17: Thistleshrub Valley
	-- {quest:3362} Thistleshrub Valley
	-- plural, as words: Gnarled Thistleshrubs = {npc:5490} Gnarled Thistleshrub
	["Ride south into {quest:3362}. The Dew Collectors drop the glands; only some are full, so keep the Laden one. Gnarled Thistleshrubs and Rootshapers share the valley. The Thistleshrubs are 48-50, above you: pull one at a time."] = "Chevauchez vers le sud dans la {quest:3362}. Les Chardonniers collecteurs de rosée laissent tomber les glandes ; seules certaines sont pleines, gardez la Glande de rosée remplie. Les Chardonniers noueux et les Chardonniers taille-racine partagent la vallée. Les Chardonniers noueux sont de niveau 48-50, au-dessus de vous : attirez-les un par un.",

	-- Step 18: Tooga's escort
	-- {npc:5955} Tooga
	["{npc:5955}'s escort"] = "L'escorte de {npc:5955}",
	-- {npc:5955} Tooga · {npc:6015} Torta · {area:977} Steamwheedle Port
	["The little turtle {npc:5955} hides at the north end of the valley. Lead him home to his wife {npc:6015}, by the water just east of {area:977}: he walks slowly and the desert's beasts go for him, so keep him alive."] = "La petite tortue {npc:5955} se cache à l'extrémité nord de la vallée. Ramenez-la chez sa femme {npc:6015}, au bord de l'eau juste à l'est de {area:977} : elle avance lentement et les bêtes du désert l'attaquent, gardez-la en vie.",

	-- Step 19: Gadgetzan
	-- {area:976} Gadgetzan
	["Ride back west to {area:976}."] = "Revenez vers l'ouest jusqu'à {area:976}.",
	-- {npc:11758} Andi Lynn
	["{npc:11758}, on the east side of town"] = "{npc:11758}, à l'est de la ville",
	-- {npc:7583} Sprinkle · {zone:1425} Hinterlands
	["{npc:7583}'s next ingredient grows in the {zone:1425}, and the route never brings it back: skip it."] = "L'ingrédient suivant de {npc:7583} pousse dans les {zone:1425}, et l'itinéraire n'y revient jamais : passez-le.",

	-- Step 20: Caliph Scorpidsting
	-- {area:985} Waterspring Field · {npc:7847} Caliph Scorpidsting
	["Ride south-east to {area:985}. {npc:7847} stands in the middle of the southern Wastewander camp: clear around him first."] = "Chevauchez au sud-est jusqu'au {area:985}. {npc:7847} se tient au centre du camp Bat-le-désert sud : nettoyez autour de lui d'abord.",

	-- Step 21: The Gaping Chasm
	-- {area:1938} Broken Pillar · {area:981} The Gaping Chasm
	["Ride south past the {area:1938} to the {area:981}, the Hazzali tunnels; Scrimshank's gear lies deep inside."] = "Chevauchez vers le sud au-delà du {area:1938} jusqu'au {area:981}, les tunnels Hazzali ; l'équipement d'analyse de Scrimshank se trouve tout au fond.",

	-- Step 22: Gadgetzan
	-- {area:976} Gadgetzan
	["Hearth to {area:976}."] = "Pierre de foyer vers {area:976}.",
	-- {zone:1457} Darnassus
	["for {zone:1457}: the route takes you there at 47"] = "pour {zone:1457} : l'itinéraire vous y mène au niveau 47",

	-- Step 23: Ironforge
	-- {area:976} Gadgetzan · {area:150} Menethil Harbor · {area:1537} Ironforge
	["Fly from {area:976} to Theramore, take the boat to {area:150} and fly to {area:1537}. Train."] = "Volez de {area:976} à Theramore, prenez le bateau pour {area:150} et volez jusqu'à {area:1537}. Entraînez-vous.",

	-- Step 24: Aerie Peak
	-- {area:348} Aerie Peak · {zone:1425} Hinterlands
	["Fly to {area:348}. {zone:1425} guide starts here."] = "Volez jusqu'à {area:348}. Le guide des {zone:1425} commence ici.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly to {area:348}. {zone:1425} guide starts here."] = "Volez jusqu'à {area:348}. Le guide des {zone:1425} commence ici.",
	-- ["Ride south past the {area:1938} to the {area:981}, the Hazzali tunnels; Scrimshank's gear lies deep inside."] = "Chevauchez vers le sud au-delà du {area:1938} jusqu'au {area:981}, les tunnels Hazzali ; l'Equipement d'analyse de Scrimshank se trouve tout au fond.",
	-- ["The Wanted poster by {npc:7882}"] = "L'affiche Avis de recherche près de {npc:7882}",
}
