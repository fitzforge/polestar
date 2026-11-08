-- French (frFR): the guide forever/class/warrior/brutal-armor (forever/class/warrior/brutal-armor.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Starts now at 20 at your trainer; four armor pieces at 30 (hauberk, helm, gauntlets, legguards), a shield on the way."] = "",

	-- Step 1: Speak with Ruga (Orgrimmar)
	-- {npc:3354} Sorek · {object:172958} Valley of Honor · {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo
	["At 20, {npc:3354} in the {object:172958} sends you to {npc:6394} in {area:378}."] = "Au niveau 20, {npc:3354}, dans la {object:172958}, vous envoie voir {npc:6394} à {area:378}.",

	-- Step 2: Speak with Ruga (Thunder Bluff)
	-- {npc:3041} Torm Ragetotem · {zone:1456} Thunder Bluff · {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo
	["At 20, {npc:3041}, the warrior trainer of {zone:1456}, sends you to {npc:6394} in {area:378}."] = "Au niveau 20, {npc:3041}, maître des guerriers de {zone:1456}, vous envoie voir {npc:6394} à {area:378}.",

	-- Step 3: Speak with Ruga (Undercity)
	-- {npc:4595} Baltus Fowler · {zone:1458} Undercity · {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo
	["At 20, {npc:4595}, a warrior trainer of the {zone:1458}, sends you to {npc:6394} in {area:378}."] = "Au niveau 20, {npc:4595}, maître des guerriers de {zone:1458}, vous envoie voir {npc:6394} à {area:378}.",

	-- Step 4: Ruga Ragetotem
	-- {area:378} Camp Taurajo · {npc:6394} Ruga Ragetotem
	["Fly to {area:378}. {npc:6394} stands in the hut with the leatherworking and tailoring trainers."] = "Volez jusqu'au {area:378}. {npc:6394} se tient dans la hutte des maîtres du travail du cuir et de la couture.",

	-- Step 5: Trial at the Field of Giants
	-- {item:7119} Twitching Antenna · {area:390} Field of Giants · {area:378} Camp Taurajo · {item:7120} Ruga's Bulwark
	-- plural, as words: Silithid Mounds = {object:3685} Silithid Mound
	["You have 30 minutes, and each {item:7119} rots 15 minutes after you loot it, so take the quest only when ready (logging out does not stop the clock). The Silithid Mounds dot the {area:390} south of {area:378}; every silithid drops an antenna. Creepers (level 20-21) and Grubs are the easiest: Swarmers (21-22) call small swarms and Creepers lay eggs that hatch adds. The eastern part of the field has plenty of Creepers. {item:7120}, a shield, is the reward."] = "Vous avez 30 minutes, et chaque {item:7119} pourrit 15 minutes après avoir été ramassée : ne prenez donc la quête que lorsque vous êtes prêt (se déconnecter n'arrête pas le chrono). Les Antres des silithides parsèment le {area:390} au sud du {area:378} ; chaque silithide lâche une antenne. Les Rampants (niveau 20-21) et les Larves sont les plus faciles : les Grouillants (21-22) appellent de petits essaims et les Rampants pondent des œufs d'où sortent des renforts. La partie est du champ compte beaucoup de Rampants. Le {item:7120}, un bouclier, est la récompense.",
	-- {item:7119} Twitching Antenna
	["{item:7119}, from the silithid"] = "{item:7119}, sur les silithides",

	-- Step 6: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:1699} Thorn Hill · {quest:1838} Brutal Armor · {item:7587} Thun'grim's Instructions
	["{npc:5878}'s hut sits on top of {area:1699}, east of the Crossroads: climb the broad ridge on the north or east side. {quest:1838} is a level 30 quest; take it now and gather on the way. {item:7587} list where each material comes from."] = "",

	-- Step 7: Roogug in Razorfen Kraul
	-- {area:1717} Razorfen Kraul
	["Roogug in {area:1717}"] = "Roogug dans {area:1717}",
	-- {area:1717} Razorfen Kraul · {zone:1413} Barrens · {spell:403} Lightning Bolt
	["Roogug is an elite quilboar (level 28) inside {area:1717}, the dungeon at the south end of the {zone:1413}; a five-player dungeon: needs a group of five, his guards come with him. Inside take the left path at the first fork, cross the vine bridge over the pig pens, go past the room with the big cauldron: he waits in the room on the right. He casts {spell:403} and calls Earth Rumblers. The vial always drops."] = "Roogug est un huran élite (niveau 28) dans le {area:1717}, le donjon au sud des {zone:1413} ; un donjon à cinq joueurs : il faut un groupe de cinq, ses gardes viennent avec lui. À l'intérieur, prenez à gauche au premier embranchement, traversez le pont de lianes au-dessus des enclos à cochons, dépassez la salle au grand chaudron : il attend dans la salle de droite. Il lance {spell:403} et appelle des Grondeurs de terre. La fiole tombe toujours.",
	-- {item:6841} Vial of Phlogiston
	["{item:6841}, from Roogug"] = "{item:6841}, sur Roogug",

	-- Step 8: Windshear Mine
	-- {area:2160} Windshear Mine · {area:461} Windshear Crag · {area:460} Sun Rock Retreat · {spell:116} Frostbolt
	-- plural, as words: Smoky Iron Ingots = {item:7126} Smoky Iron Ingot
	["You need 15 Smoky Iron Ingots. The {area:2160} lies at the east end of {area:461}, east of {area:460}; every Windshear kobold (level 19-23) drops an ingot four kills in five. Stonecutters, Geomancers and Overlords run for help when low; Geomancers cast {spell:116}."] = "Il vous faut 15 Lingots de fer cendré. La {area:2160} se trouve à l'extrémité est de la {area:461}, à l'est de la {area:460} ; chaque kobold Cisaille-vent (niveau 19-23) lâche un lingot quatre fois sur cinq. Les Tailleurs de pierre, les Géomanciens et les Seigneurs fuient chercher de l'aide quand leur vie est basse ; les Géomanciens lancent {spell:116}.",
	-- {item:7126} Smoky Iron Ingot
	["{item:7126}, from the Windshear kobolds"] = "{item:7126}, sur les kobolds Cisaille-vent",

	-- Step 9: Hillsbrad Miners
	-- plural, as words: Hillsbrad Miners = {npc:2269} Hillsbrad Miner
	["Hillsbrad Miners"] = "Mineurs d'Hillsbrad ({npc:2269})",
	-- {item:7127} Powdered Azurite · {area:271} Southshore · {spell:71} Defensive Stance · {area:272} Tarren Mill
	-- plural, as words: Hillsbrad Miners = {npc:2269} Hillsbrad Miner
	["You need 10 {item:7127}. The Hillsbrad Miners (level 26-27) work the mine in the hills west of {area:271} and drop the azurite four kills in five; they fight in {spell:71}, sunder your armor and run for help at 30% health. Fly to {area:272} and head south-west."] = "Il vous faut 10 {item:7127}. Les Mineurs d'Hillsbrad (niveau 26-27) travaillent dans la mine des collines à l'ouest d'{area:271} et lâchent l'azurite quatre fois sur cinq ; ils combattent en {spell:71}, fracassent votre armure et fuient chercher de l'aide à 30 % de vie. Volez jusqu'à {area:272} et allez vers le sud-ouest.",
	-- {item:7127} Powdered Azurite
	-- plural, as words: Hillsbrad Miners = {npc:2269} Hillsbrad Miner
	["{item:7127}, from the Hillsbrad Miners"] = "{item:7127}, sur les Mineurs d'Hillsbrad",

	-- Step 10: Iron Bars
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["Iron Bars"] = "Barres de fer",
	-- {item:2772} Iron Ore · {spell:3307} Smelt Iron · {skill:186} Mining · {zone:1454} Orgrimmar
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["You need 10 Iron Bars. Miners smelt them from {item:2772} (one ore a bar, {spell:3307} at {skill:186} 125); everyone else buys them at the auction house in {zone:1454}."] = "Il vous faut 10 Barres de fer. Les mineurs les fondent à partir de {item:2772} (un minerai par barre, {spell:3307} à 125 en {skill:186}) ; tous les autres les achètent à l'hôtel des ventes d'{zone:1454}.",
	-- {npc:8673} Auctioneer Thathung
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["Iron Bars: {npc:8673}"] = "Barres de fer : {npc:8673}",

	-- Step 11: Brutal Hauberk
	-- {npc:5878} Thun'grim Firegaze · {area:1699} Thorn Hill · {quest:1848} Brutal Hauberk
	["Back to {npc:5878} on {area:1699}. {quest:1848} is the first piece; he then sends you to three crafters, one per piece: take all three."] = "Retournez voir {npc:5878} sur la {area:1699}. {quest:1848} est la première pièce ; il vous envoie ensuite voir trois artisans, un par pièce : prenez les trois.",

	-- Step 12: Ula'elek
	-- {npc:6408} Ula'elek · {area:367} Sen'jin Village · {zone:1411} Durotar
	["{npc:6408} is in {area:367} on the {zone:1411} coast. He wants 7 Uncloven Satyr Hooves."] = "{npc:6408} est au {area:367}, sur la côte de {zone:1411}. Il veut 7 sabots de satyre intacts.",

	-- Step 13: Satyr Hooves
	-- {area:430} Satyrnaar · {area:431} Splintertree Post · {area:429} Xavian · {spell:6925} Gift of the Xavian
	-- plural, as words: Fireballs = {spell:133} Fireball
	["The satyrs of {area:430}, north-east of {area:431} ({area:429}, level 28-30), and the Felmusk satyrs north-west of the post (25-27) drop a hoof four kills in five. A {area:429} satyr at 15% health may cast {spell:6925} and heal to full: finish it fast or stun it. Hellcallers throw Fireballs from 40 yards; Felmusk satyrs reek in melee and run for help at 15%."] = "Les satyres de {area:430}, au nord-est du {area:431} ({area:429}, niveau 28-30), et les satyres Gangremusc au nord-ouest du poste (25-27) lâchent un sabot quatre fois sur cinq. Un satyre {area:429} à 15 % de vie peut lancer {spell:6925} et récupérer toute sa vie : achevez-le vite ou étourdissez-le. Les Appelle-l'enfer lancent des Boules de feu à 40 mètres ; les satyres Gangremusc empestent au corps à corps et fuient chercher de l'aide à 15 %.",

	-- Step 15: Orm Stonehoof
	-- {npc:6410} Orm Stonehoof · {zone:1456} Thunder Bluff
	["{npc:6410} works on {zone:1456}'s lowest level, close to the blacksmith."] = "{npc:6410} travaille au niveau le plus bas des {zone:1456}, près du forgeron.",

	-- Step 16: Chimaeric Horn
	-- {npc:6167} Chimaera Matriarch · {area:465} Charred Vale · {zone:1443} Desolace · {item:6840} Galvanized Horn · {spell:3396} Corrosive Poison
	["The {npc:6167} (level 28, not elite, larger than the young ones around her) roams the south edge of the {area:465} in south-west Stonetalon, near the road to {zone:1443}. She is the only one: she returns 5 minutes after dying and drops the {item:6840} four kills in five. She spits {spell:3396} from 30 yards."] = "La {npc:6167} (niveau 28, pas élite, plus grande que les jeunes autour d'elle) parcourt la lisière sud du {area:465}, au sud-ouest des Serres-Rocheuses, près de la route de {zone:1443}. Elle est la seule : elle revient 5 minutes après sa mort et lâche la {item:6840} quatre fois sur cinq. Elle crache {spell:3396} à 30 mètres.",
	-- {item:6840} Galvanized Horn · {npc:6167} Chimaera Matriarch
	["{item:6840}, from the {npc:6167}"] = "{item:6840}, sur la {npc:6167}",

	-- Step 18: Velora Nitely
	-- {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {npc:6411} Velora Nitely · {zone:1458} Undercity · {object:36078} Trade Quarter
	-- plural, as words: Sturdy Dragonmaw Shinbones = {item:7134} Sturdy Dragonmaw Shinbone
	["Take the zeppelin from {zone:1454} to {zone:1420}; {npc:6411} works in the {zone:1458}'s {object:36078}. She wants 8 Sturdy Dragonmaw Shinbones."] = "Prenez le zeppelin d'{zone:1454} vers {zone:1420} ; {npc:6411} travaille dans le {object:36078} de {zone:1458}. Elle veut 8 Solides tibias de Dragonmaw.",

	-- Step 19: Dragonmaw Shinbones
	-- {zone:1437} Wetlands · {area:321} Hammerfall · {area:881} Thandol Span · {area:150} Menethil Harbor · {item:7131} Dragonmaw Shinbone · {spell:686} Shadow Bolt
	["The Dragonmaw orcs (level 26-30) camp in the middle of the {zone:1437}; from {area:321} in Arathi head south over the {area:881} ({area:150} is Alliance). Every Raider, Swamprunner, Centurion, Shadowwarder and Bonewarder drops a {item:7131}: right-click it to test it, and about one in four comes out sturdy, the rest break, so expect 30 or more kills for 8. You can test while moving or fighting. The orcs run for help at 15%; Raiders net you, Centurions shield-bash, Shadowwarders cast {spell:686}, Bonewarders raise skeletons."] = "Les orcs Dragonmaw (niveau 26-30) campent au milieu des {zone:1437} ; depuis {area:321}, en Arathi, allez au sud par le {area:881} ({area:150} est à l'Alliance). Chaque Pillard, Coureur des marais, Centurion, Gardombre et Gardos lâche un {item:7131} : faites un clic droit dessus pour le tester ; environ un sur quatre se révèle solide, les autres se brisent, comptez donc 30 victimes ou plus pour 8. Vous pouvez tester en vous déplaçant ou en combattant. Les orcs fuient chercher de l'aide à 15 % ; les Pillards lancent des filets, les Centurions donnent des coups de bouclier, les Gardombres lancent {spell:686}, les Gardos relèvent des squelettes.",
	["from the Dragonmaw orcs: right-click to test it"] = "sur les orcs Dragonmaw : clic droit pour le tester",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:5878} beside the road east of the {area:380}. {quest:1848} is the first piece; he then sends you to three crafters for the rest."] = "Retournez voir {npc:5878} au bord de la route à l'est de {area:380}. {quest:1848} est la première pièce ; il vous envoie ensuite voir trois artisans pour le reste.",
	-- ["Fly to {area:378}. South of the camp the Silithid Mounds dot the {area:390}: the silithid there carry the Twitching Antennae."] = "Prenez un vol pour {area:378}. Au sud du camp, les Antres des silithides parsèment {area:390} : les silithides qui s'y trouvent portent les Antennes mobiles.",
	-- ["Four armor pieces at 30 (hauberk, helm, gauntlets, legguards) and a shield on the way."] = "Quatre pièces d'armure au niveau 30 (haubert, heaume, gantelets, jambières) et un bouclier en chemin.",
	-- ["Miners smelt Iron Bars from {item:2772} ({skill:186} 125); everyone else buys them at the auction house in {zone:1454}."] = "Les mineurs fondent les Barres de fer à partir de {item:2772} ({skill:186} 125) ; les autres les achètent à l'hôtel des ventes d'{zone:1454}.",
	-- ["Roogug is an elite quilboar inside {area:1717}, the dungeon at the south end of the {zone:1413}; he drops the {item:6841}. {area:1717} is a dungeon: grouping up is advised."] = "Roogug est un huran élite dans {area:1717}, le donjon au sud de {zone:1413} ; il lâche la {item:6841}. {area:1717} est un donjon : mieux vaut former un groupe.",
	-- ["Smoky Iron Ingots from the Windshear kobolds"] = "Lingots de fer cendré sur les kobolds des Cisailles",
	-- ["Sturdy Dragonmaw Shinbones"] = "Solides tibias de Dragonmaw ({item:7134})",
	-- ["Take the zeppelin from {zone:1454} to {zone:1420}; the {zone:1458} lies below the {area:153}."] = "Prenez le zeppelin d'{zone:1454} pour {zone:1420} ; {zone:1458} se trouve sous les {area:153}.",
	-- ["The Dragonmaw orcs camp in the middle of the {zone:1437}, south of the road; Raiders, Swamprunners, Centurions, Shadowwarders and Bonewarders all drop the Sturdy Dragonmaw Shinbones."] = "Les orcs Dragonmaw campent au milieu des {zone:1437}, au sud de la route ; Ecumeurs, Arpenteurs, Centurions, Veilleurs des ombres et Gardiens Dragonmaw lâchent tous les Solides tibias de Dragonmaw ({item:7134}).",
	-- ["The Hillsbrad Miners work the mine in the west of {zone:1424}; they drop the {item:7127}. Take the zeppelin from {zone:1454} to {zone:1420} and ride south through {zone:1421}."] = "Les Mineurs d'Hillsbrad ({npc:2269}) travaillent dans la mine de l'ouest de {zone:1424} ; ils lâchent {item:7127}. Prenez le zeppelin d'{zone:1454} à {zone:1420} et chevauchez vers le sud à travers {zone:1421}.",
	-- ["The {area:2160} lies at the east end of {area:461} in Stonetalon. Its kobolds drop the Smoky Iron Ingots."] = "{area:2160} se trouve à l'extrémité est de {area:461}, dans les Serres-Rocheuses. Ses kobolds lâchent les Lingots de fer cendré.",
	-- ["The {area:287} Miners work the mine in the west of {zone:1424}; they drop the {item:7127}. Take the zeppelin from {zone:1454} to {zone:1420} and ride south through {zone:1421}."] = "Les Mineurs d'{area:287} travaillent dans la mine à l'ouest de {zone:1424} ; ils lâchent l'{item:7127}. Prenez le zeppelin d'{zone:1454} pour {zone:1420} et chevauchez vers le sud à travers {zone:1421}.",
	-- ["The {area:429} satyrs camp in eastern {zone:1440}, with the Felmusk satyrs further west; both drop Uncloven Satyr Hooves."] = "Les satyres de {area:429} campent dans l'est d'{zone:1440}, les satyres Gangremusc plus à l'ouest ; les deux lâchent des Sabots fendus de satyre.",
	-- ["The {npc:6167} roams the south-west of Stonetalon near the Fledgling and Young Chimaeras; she drops the {item:6840}."] = "La {npc:6167} rôde au sud-ouest des Serres-Rocheuses près des Petites chimères et des Jeunes chimères ; elle lâche la {item:6840}.",
	-- ["Twitching Antennae from the silithid"] = "Antennes mobiles sur les silithides",
	-- ["Uncloven {quest:1842}"] = "{quest:1842} fendus",
	-- ["{area:287} Miners"] = "Mineurs d'{area:287}",
	-- ["{item:6840} from the {npc:6167}"] = "{item:6840} sur la {npc:6167}",
	-- ["{item:7127} from the Hillsbrad Miners"] = "{item:7127} sur les Mineurs d'Hillsbrad ({npc:2269})",
	-- ["{item:7127} from the {area:287} Miners"] = "{item:7127} sur les Mineurs d'{area:287}",
	-- ["{npc:5878} camps beside the road east of the {area:380}. {quest:1838} is a level 30 quest; you can take it now and gather for it on the way."] = "{npc:5878} campe au bord de la route à l'est de {area:380}. {quest:1838} est une quête de niveau 30 ; vous pouvez la prendre maintenant et rassembler ce qu'il faut en chemin.",
	-- ["{npc:5878}'s hut sits on top of {area:1699}, east of the {area:380}: climb the broad ridge on the north or east side. {quest:1838} is a level 30 quest; take it now and gather on the way. {item:7587} list where each material comes from."] = "La hutte de {npc:5878} se dresse au sommet de la {area:1699}, à l'est de la {area:380} : montez par la large crête du côté nord ou est. {quest:1838} est une quête de niveau 30 ; prenez-la maintenant et récoltez en chemin. Les {item:7587} indiquent d'où vient chaque matériau.",
	-- ["{npc:6408} is in {area:367} on the {zone:1411} coast."] = "{npc:6408} est à {area:367}, sur la côte de {zone:1411}.",
}
