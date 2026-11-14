-- French (frFR): the guide forever/alliance/03-darkshore-return (forever/alliance/03-darkshore-return.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Auberdine
	-- {npc:3649} Thundris Windweaver · {npc:3702} Alanndarian Nightsong · {npc:2913} Archaeologist Hollee · {npc:3693} Terenthis · {npc:3694} Sentinel Selarin
	["From the dock (or the inn, if you used your Hearthstone), up to the north end of the village first ({npc:3649}, {npc:3702} by the moonwell, {npc:2913}), then down the main street: the WANTED poster outside the inn, {npc:3693} at its east end, where the road leaves south. {npc:3694} stands beside {npc:3693} by the flight master; if she isn't there, she has been killed and respawns shortly: wait a moment."] = "Depuis le quai (ou l'auberge, si vous avez utilisé votre pierre de foyer), montez d'abord à l'extrémité nord du village ({npc:3649}, {npc:3702} près du puits de lune, {npc:2913}), puis descendez la rue principale : l'affiche AVIS DE RECHERCHE devant l'auberge, {npc:3693} à son extrémité est, là où la route part vers le sud. {npc:3694} se tient à côté de {npc:3693}, près du maître de vol ; si elle n'y est pas, elle a été tuée et réapparaît bientôt : attendez un instant.",
	-- {npc:3649} Thundris Windweaver · {npc:1646} Baros Alexston
	["{npc:3649}, north end of the village: {npc:1646}'s reply"] = "{npc:3649}, extrémité nord du village : la réponse de {npc:1646}",
	["The WANTED poster"] = "L'affiche AVIS DE RECHERCHE",
	-- {npc:3694} Sentinel Selarin · {npc:3693} Terenthis · {npc:3691} Raene Wolfrunner · {area:415} Astranaar
	["{npc:3694}, beside {npc:3693}: for {npc:3691} in {area:415}, in the next guide"] = "{npc:3694}, à côté de {npc:3693} : pour {npc:3691} à {area:415}, dans le prochain guide",

	-- Step 2: Lunar Fungus and Earthroot
	-- {item:15851} Lunar Fungus · {item:2449} Earthroot
	["{item:15851} and {item:2449}"] = "{item:15851} et {item:2449}",
	-- {area:442} Auberdine · {item:2449} Earthroot · {skill:182} Herbalism · {zone:1439} Darkshore · {zone:1453} Stormwind · {npc:1313} Maria Lumere
	-- plural, as words: Lunar Fungal Blooms = {object:177750} Lunar Fungal Bloom
	["On the way south to the Grove: the Lunar Fungal Blooms grow in the moonkin caves in the hills just east of {area:442}, a short way off the road; the moonkin there are irritable. {item:2449} needs {skill:182}: herbalists pick it all over {zone:1439}, anyone else brings it from {zone:1453} ({npc:1313}) or the Auction House."] = "Sur le chemin du sud vers le Bosquet : les Floraisons fongiques lunaires poussent dans les grottes des séléniens, dans les collines juste à l'est d'{area:442}, non loin de la route ; les Séléniens y sont irritables. La {item:2449} demande la compétence {skill:182} : les herboristes en cueillent partout en {zone:1439}, les autres l'apportent de {zone:1453} ({npc:1313}) ou de l'hôtel des ventes.",

	-- Step 4: Onu
	-- {quest:948} Onu · {npc:270269} Arbal · {npc:11218} Kerlonian Evershade
	["{quest:948} is the ancient at the Grove; {npc:270269} and {npc:11218} sleep beside him."] = "{quest:948} est l'ancien du Bosquet ; {npc:270269} et {npc:11218} dorment à côté de lui.",

	-- Step 5: The Grove of the Ancients
	-- {quest:952} Grove of the Ancients
	["The {quest:952}"] = "{quest:952}",
	-- {quest:1003} Buzzbox 525
	-- plural, as words: Grizzled Thistle Bears = {npc:2165} Grizzled Thistle Bear
	["Grizzled Thistle Bears roam the hills around the Grove; {quest:1003} stands west of it among them."] = "Des Vieux ours des chardons errent dans les collines autour du Bosquet ; {quest:1003} se trouve à l'ouest, parmi eux.",
	-- plural, as words: Grizzled Scalps = {item:5414} Grizzled Scalp
	["Grizzled Scalps"] = "Scalps vieillis",

	-- Step 6: The Master's Glaive
	-- {object:12666} Twilight Tome · {npc:3584} Therylune · {quest:948} Onu · {item:5251} Phial of Scrying · {object:10076} Scrying Bowl
	-- plural, as words: Moonstalker Sires = {npc:2237} Moonstalker Sire
	["Moonstalker Sires prowl the woods around the glaive. The {object:12666} sits at the bottom of the crater; {npc:3584} stands on its north side. For {quest:948}'s quest, use the {item:5251} at the bottom of the crater: it makes the {object:10076}, and you hand the quest in to the bowl."] = "Des Géniteurs traquelunes rôdent dans les bois autour du glaive. Le {object:12666} se trouve au fond du cratère ; {npc:3584} se tient sur son flanc nord. Pour la quête de {quest:948}, utilisez la {item:5251} au fond du cratère : elle fait apparaître le {object:10076}, et vous rendez la quête au bassin.",
	-- plural, as words: Fine Moonstalker Pelts = {item:5386} Fine Moonstalker Pelt
	["Fine Moonstalker Pelts"] = "Belles peaux de traquelune",
	-- {zone:1440} Ashenvale
	["Escort her out of the glaive; Therysil takes the turn-in in {zone:1440}"] = "Escortez-la hors du glaive ; Therysil prend le rendu de quête en {zone:1440}",
	-- {item:5352} Book: The Powers Below
	["Only if a Disciple or Thug dropped {item:5352}: right-click it"] = "Seulement si un Disciple ou un Nervi a laissé tomber {item:5352} : clic droit dessus",
	-- {object:10076} Scrying Bowl
	["The {object:10076}"] = "{object:10076}",
	-- {object:12666} Twilight Tome
	["The {object:12666}"] = "{object:12666}",
	-- {object:12666} Twilight Tome · {quest:949} The Twilight Camp
	["The {object:12666}, once it has {quest:949}"] = "{object:12666}, une fois qu'il contient {quest:949}",
	-- {item:279279} Peerless Eye
	-- plural, as words: Twilight Disciples = {npc:2338} Twilight Disciple
	["{item:279279}: Twilight Disciples and Thugs"] = "{item:279279} : Disciples du crépuscule et Nervis du crépuscule",

	-- Step 7: Prospector Remtravel
	-- {area:450} Remtravel's Excavation · {npc:10323} Murkdeep
	["{area:450} lies on the coast south of {npc:10323}'s beach. Protect the prospector while he searches for the fossil.\nCareful: Ambushers appear as he passes certain spots: a scout comes out from under the board ramp, and more scouts come out when he checks the tent."] = "{area:450} se trouve sur la côte au sud de la plage de {npc:10323}. Protégez le prospecteur pendant qu'il cherche le fossile.\nAttention : des embusqués apparaissent quand il passe à certains endroits : un éclaireur sort de sous la rampe en planches, et d'autres éclaireurs sortent quand il fouille la tente.",

	-- Step 8: Murkdeep's beach
	-- {npc:10323} Murkdeep
	["{npc:10323}'s beach"] = "La plage de {npc:10323}",
	-- {npc:10323} Murkdeep · {area:450} Remtravel's Excavation
	["{npc:10323} camps on the beach west of the glaive: kill the murlocs at the camp fire; he comes in the third wave with his hound. Four beached remains lie on the beaches west and south-west of {area:450}: take them on the way north to his camp."] = "{npc:10323} campe sur la plage à l'ouest du glaive : tuez les murlocs près du feu de camp ; il arrive avec son chien à la troisième vague. Quatre restes échoués gisent sur les plages à l'ouest et au sud-ouest de {area:450} : ramassez-les sur le chemin de son camp, au nord.",

	-- Step 11: The shore west of the Grove
	["The shore west of the Grove"] = "Le rivage à l'ouest du Bosquet",
	-- {area:442} Auberdine · {quest:4728} Beached Sea Creature
	["On the way north to {area:442}, the last {quest:4728} lies on the shore west of the Grove."] = "Sur le chemin d'{area:442}, au nord, la dernière {quest:4728} gît sur le rivage à l'ouest du Bosquet.",

	-- Step 12: Auberdine
	["Follow the road north."] = "Suivez la route vers le nord.",
	-- {quest:87760} Holy Diver · {npc:10219} Gwennyth Bly'Leggonde
	["{quest:87760}: {npc:10219} offers it once all nine beached remains are handed in"] = "{quest:87760} : {npc:10219} la propose une fois les neuf restes échoués rendus",
	-- {item:15826} Curative Animal Salve
	["She gives you the {item:15826}"] = "Elle vous donne le {item:15826}",

	-- Step 13: Gershala Nightwhisper
	-- {area:2797} Blackfathom Deeps · {area:414} Zoram Strand · {npc:8997} Gershala Nightwhisper · {npc:3693} Terenthis
	["For your {area:2797} run, on the {area:414} in the next guide: {npc:8997} stands a short walk west of {npc:3693}."] = "Pour votre expédition dans {area:2797}, sur la {area:414} dans le prochain guide : {npc:8997} se tient à quelques pas à l'ouest de {npc:3693}.",

	-- Step 14: On the way
	["On the way"] = "En chemin",

	-- Step 15: The naga
	["The naga"] = "Les nagas",
	-- {area:443} Ruins of Mathystra · {quest:951} Mathystra Relics · {npc:270294} Baron Marinous
	-- plural, as words: Stormscale Myrmidons = {npc:2181} Stormscale Myrmidon
	["Follow the coast north-east to the {area:443}. {quest:951} lie among the ruins; Stormscale Myrmidons, Sorceresses and Warriors hold them, and Stormscale Beastmistresses walk the shore. Careful: {npc:270294}, an elite naga (21), walks the ruins among them: pull the naga away from him, or fight him at full health."] = "Suivez la côte au nord-est jusqu'aux {area:443}. Les {quest:951} se trouvent parmi les ruines ; des Myrmidons Tempécaille, des Ensorceleuses Tempécaille et des Guerriers Tempécaille les gardent, et des Maîtresses des bêtes tempécaille arpentent la côte. Attention : {npc:270294}, un naga élite (21), arpente les ruines parmi eux : attirez les nagas loin de lui, ou affrontez-le avec toute votre vie.",

	-- Step 16: The Ruins of Mathystra
	-- {area:443} Ruins of Mathystra
	["The {area:443}"] = "{area:443}",
	-- {npc:6667} Gelkak Gyromast
	-- plural, as words: Giant Foreststriders = {npc:2323} Giant Foreststrider · Raging Reef Crawlers = {npc:2236} Raging Reef Crawler
	["{npc:6667} hides on the little island off the ruins. The key pieces drop from Giant Foreststriders (top), Greymist murlocs (middle) and Raging Reef Crawlers (bottom)."] = "{npc:6667} se cache sur le petit îlot au large des ruines. Les morceaux de clé tombent des Trotteurs des forêts géants (haut), des murlocs Grisebrume (milieu) et des Clampants des récifs enragés (bas).",
	["Underwater"] = "Sous l'eau",

	-- Step 17: Strange Lockbox
	-- {item:15883} Half Pendant of Aquatic Agility · {object:177792} Strange Lockbox
	["{item:15883}: the {object:177792} under the water off the north coast, west of the ruins"] = "{item:15883} : l'{object:177792} sous l'eau au large de la côte nord, à l'ouest des ruines",

	-- Step 18: Mist's Edge: kill these as you meet them
	-- {area:452} Mist's Edge
	["{area:452}: kill these as you meet them"] = "{area:452} : tuez-les au passage",

	-- Step 19: Back south
	["Back south"] = "Retour au sud",
	-- {npc:3616} Onu
	["{npc:3616}, at the Grove"] = "{npc:3616}, au Bosquet des Anciens",

	-- Step 20: Volcor
	-- {npc:3692} Volcor · {area:449} Master's Glaive · {npc:3693} Terenthis · {area:442} Auberdine
	["{npc:3692} hides in the hills east of the {area:449}. Help him back to the road; he fights on his way out. {npc:3693} takes the escort in {area:442} on the next visit there."] = "{npc:3692} se cache dans les collines à l'est du {area:449}. Aidez-le à rejoindre la route ; il se bat en chemin. {npc:3693} prend l'escorte à {area:442} lors de votre prochaine visite.",
	-- {npc:3692} Volcor · {area:455} Blackwood Den
	["{npc:3692}, inside {area:455}"] = "{npc:3692}, à l'intérieur de {area:455}",
	["His walk ends at the road, where Grimclaw waits"] = "Sa marche se termine sur la route, où Grimclaw l'attend",
	-- {npc:12298} Sickly Deer · {item:15826} Curative Animal Salve · {zone:1439} Darkshore
	["{npc:12298}: use the {item:15826} on them; they roam all of {zone:1439}"] = "{npc:12298} : utilisez le {item:15826} sur eux ; ils errent dans tout {zone:1439}",
	-- {npc:12298} Sickly Deer
	["Cure {npc:12298}"] = "Soignez : {npc:12298}",

	-- Step 22: Auberdine flight master
	-- {area:442} Auberdine
	["{area:442} flight master"] = "Maître de vol d'{area:442}",

	-- Step 23: The Great Cat Spirit
	-- {area:442} Auberdine · {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["Night Elves fly from {area:442} to {area:702}; Skyborne take the boat from the {area:442} dock and learn the Rut'theran flight path there. Take the portal up to {npc:4217} in the {area:1658}."] = "Les Elfes de la nuit volent d'{area:442} au {area:702} ; les Éolides prennent le bateau au quai d'{area:442} et y apprennent la route aérienne de Rut'theran. Prenez le portail pour monter jusqu'à {npc:4217} dans l'{area:1658}.",

	-- Step 26: Moonglade
	-- {spell:18960} Teleport: Moonglade
	["Cast {spell:18960}"] = "Lancez {spell:18960}",

	-- Step 27: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. {npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart. Learn the flight path there if you do not have it."] = "Lancez {spell:18960}. {npc:11802} se tient à l'étage de son bâtiment à {area:2361} : montez par l'intérieur, la flèche ne distingue pas les étages. Apprenez-y la route aérienne si vous ne l'avez pas.",

	-- Step 28: Dendrite Starblaze
	-- {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["{npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart."] = "{npc:11802} se tient à l'étage de son bâtiment à {area:2361} : montez par l'intérieur, la flèche ne distingue pas les étages.",
	-- {npc:11802} Dendrite Starblaze · {npc:5504} Sheldras Moontree
	["{npc:11802}: the welcome from {npc:5504}"] = "{npc:11802} : le message de bienvenue de {npc:5504}",

	-- Step 30: The relics of the Barrow Dens
	["The relics of the Barrow Dens"] = "Les reliques du Refuge des saisons",
	-- {quest:98394} The Great Cat Spirit · {npc:272054} Avatar of Saeyleenan · {area:493} Moonglade · {area:2363} Stormrage Barrow Dens
	["{quest:98394} (Night Elves) and the {npc:272054} (Skyborne) wait in southern {area:493}. The three relics lie in the {area:2363}, east of them. Reports from the first weeks say a relic gives no loot while another player is looting it: wait a moment and try again."] = "{quest:98394} (Elfes de la nuit) et l'{npc:272054} (Éolides) attendent au sud de {area:493}. Les trois reliques se trouvent dans les {area:2363}, à l'est. D'après les retours des premières semaines, une relique ne donne rien pendant qu'un autre joueur la fouille : attendez un instant et réessayez.",

	-- Step 31: Trial of the Sea Lion
	-- {zone:1436} Westfall · {zone:1439} Darkshore · {area:2362} Shrine of Remulos · {npc:11802} Dendrite Starblaze · {spell:499} Cat Form
	["Both half pendants in your bags (the {zone:1436} half from your last {zone:1436} visit, the {zone:1439} half from the north coast): stand by the {area:2362} on the north-west shore of the lake and use a half to join them, then take the pendant to {npc:11802} with the {spell:499} hand-in. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Les deux moitiés de pendentif dans vos sacs (celle de {zone:1436} rapportée de votre dernier passage dans {zone:1436}, celle de {zone:1439} de la côte nord) : placez-vous près du {area:2362}, sur la rive nord-ouest du lac, et utilisez une moitié pour les réunir, puis apportez le pendentif à {npc:11802} en rendant {spell:499}. {npc:11802} se tient à l'étage de son bâtiment : montez par l'intérieur, la flèche ne distingue pas les étages.",
	-- {item:15885} Pendant of the Sea Lion · {area:2362} Shrine of Remulos
	["{item:15885}: join the halves at the {area:2362}"] = "{item:15885} : réunissez les moitiés au {area:2362}",
	-- {npc:11802} Dendrite Starblaze · {quest:5061} Aquatic Form · {npc:4217} Mathrengyl Bearwalker
	["{npc:11802}: {quest:5061}, for {npc:4217}"] = "{npc:11802} : {quest:5061}, pour {npc:4217}",

	-- Step 32: Back to Dendrite Starblaze
	-- {npc:11802} Dendrite Starblaze
	["Back to {npc:11802}"] = "Retour auprès de {npc:11802}",
	-- {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {npc:11800} Silva Fil'naveth · {area:702} Rut'theran Village
	["Back to {npc:11802} in {area:2361}, then {npc:11800} there flies Druids straight to {area:702}. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Retournez voir {npc:11802} à {area:2361}, puis {npc:11800}, sur place, emmène les Druides directement en vol jusqu'au {area:702}. {npc:11802} se tient à l'étage de son bâtiment : montez par l'intérieur, la flèche ne distingue pas les étages.",

	-- Step 35: To Darnassus
	-- {npc:4217} Mathrengyl Bearwalker · {area:442} Auberdine · {zone:1440} Ashenvale
	["Take the portal up to {npc:4217}, then fly back to {area:442} for the road south to {zone:1440}. {npc:4217} is a Druid trainer: learn your new spells from him."] = "Prenez le portail pour monter jusqu'à {npc:4217}, puis reprenez un vol pour {area:442} et la route du sud vers {zone:1440}. {npc:4217} est un maître des druides : apprenez vos nouveaux sorts auprès de lui.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Moonstalker Sires prowl the woods around the glaive. The {object:10076} and the {object:12666} sit at the bottom of the crater; {npc:3584} stands on its north side."] = "Des Géniteurs traquelunes rôdent dans les bois autour du glaive. Le {object:10076} et le {object:12666} se trouvent au fond du cratère ; {npc:3584} se tient sur son flanc nord.",
	-- ["{npc:4217}: Cat Form"] = "{npc:4217} : Forme de félin",
	-- ["{npc:4217}: Cure Poison"] = "{npc:4217} : Guérison du poison",
}
