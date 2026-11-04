-- French (frFR): the guide forever/class/warrior/haggards-weapons (forever/class/warrior/haggards-weapons.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:71} Defensive Stance
	["{spell:71} and a Weapon (Alliance)"] = "{spell:71} et une arme (Alliance)",
	-- {spell:71} Defensive Stance · {zone:1453} Stormwind · {zone:1455} Ironforge · {zone:1457} Darnassus
	["{spell:71} at 10 and a one-hand weapon of your choice from {zone:1453}, {zone:1455} or {zone:1457}."] = "{spell:71} au niveau 10 et une arme à une main de votre choix, à {zone:1453}, {zone:1455} ou {zone:1457}.",

	-- Step 1: Seena Skybreaker in Valanaar
	-- {npc:252377} Seena Skybreaker · {area:16638} Valanaar
	["{npc:252377} in {area:16638}"] = "{npc:252377} à {area:16638}",
	-- {npc:252377} Seena Skybreaker · {area:16638} Valanaar · {npc:257196} Zaal Stormshield · {area:16629} Shrine of Akir
	["At 10, {npc:252377} stands with the trainers by {area:16638}'s west gate. A cultist, {npc:257196}, holds her family's shield at the {area:16629}."] = "Au niveau 10, {npc:252377} se tient avec les maîtres près de la porte ouest de {area:16638}. Un sectateur, {npc:257196}, détient le bouclier de sa famille au {area:16629}.",

	-- Step 2: Zaal Stormshield
	-- {area:16638} Valanaar · {area:16629} Shrine of Akir · {npc:257196} Zaal Stormshield · {item:263993} Skybreaker Bulwark
	["Head north-west from {area:16638} to the {area:16629}. {npc:257196} stands west of the shrine's approach, among the cult's Guardians, Spiritcallers and Blademasters: pull them one at a time before you take him. He drops the {item:263993}."] = "Allez au nord-ouest de {area:16638} jusqu'au {area:16629}. {npc:257196} se tient à l'ouest de l'accès au sanctuaire, parmi les Gardiens, les Mande-esprits et les Maîtres-lames du culte : attirez-les un par un avant de vous attaquer à lui. Il lâche le {item:263993}.",
	-- {item:263993} Skybreaker Bulwark · {npc:257196} Zaal Stormshield
	["{item:263993}, from {npc:257196}"] = "{item:263993}, sur {npc:257196}",

	-- Step 3: The Skybreaker Bulwark
	-- {npc:252377} Seena Skybreaker · {area:16638} Valanaar · {spell:71} Defensive Stance · {item:275290} Stormforged Protector · {npc:6090} Bartleby · {zone:1453} Stormwind
	["Back to {npc:252377} in {area:16638}. She teaches {spell:71} and gives you the {item:275290}, a shield to use it with. {npc:6090}'s road below still gives a weapon, once you reach {zone:1453}."] = "Retournez voir {npc:252377} à {area:16638}. Elle enseigne {spell:71} et vous donne le {item:275290}, un bouclier à utiliser avec. La voie de {npc:6090}, plus bas, donne encore une arme, une fois à {zone:1453}.",

	-- Step 4: Muren Stormpike
	-- {npc:1229} Granis Swiftaxe · {area:131} Kharanos · {quest:1679} Muren Stormpike · {zone:1455} Ironforge · {zone:1453} Stormwind · {npc:5480} Ilsa Corbin · {quest:1638} A Warrior's Training
	["At 10, {npc:1229}, the warrior trainer in {area:131}, sends you to {quest:1679} in {zone:1455}. Any Alliance warrior may take one of the three roads, never two: in {zone:1453} at 10 anyway? {npc:5480}'s {quest:1638} is the quickest stance (one fight in a tavern), with a Haggard's weapon after it."] = "Au niveau 10, {npc:1229}, le maître des guerriers de {area:131}, vous envoie voir {quest:1679} à {zone:1455}. Tout guerrier de l'Alliance peut prendre l'une des trois voies, jamais deux : vous êtes de toute façon à {zone:1453} au niveau 10 ? La quête {quest:1638} de {npc:5480} est la posture la plus rapide (un seul combat dans une taverne), suivie d'une arme de Haggard.",

	-- Step 5: Muren Stormpike in Ironforge
	-- {quest:1679} Muren Stormpike · {zone:1455} Ironforge
	["{quest:1679} in {zone:1455}"] = "{quest:1679} à {zone:1455}",
	-- {quest:1679} Muren Stormpike · {object:32390} Hall of Arms (no name in this language: may be words) · {object:32359} Military Ward
	["{quest:1679} stands in the {object:32390} in the {object:32359}."] = "{quest:1679} se tient dans la salle d'armes de la {object:32359}.",

	-- Step 6: Vejrek
	-- {quest:1678} Vejrek · {area:135} Frostmane Hold · {spell:71} Defensive Stance · {spell:6343} Thunder Clap
	["{quest:1678} (level 11, a lone troll) waits at his hut on a hill south of {area:135}, near the mountains at the top of a short ramp, with no other trolls around; the hut at the front of {area:135} is the wrong one. He fights in {spell:71} and sunders your armor; {spell:6343} slows him. His head always drops; he returns about 8 minutes after dying."] = "{quest:1678} (niveau 11, un troll solitaire) attend dans sa hutte sur une colline au sud du {area:135}, près des montagnes en haut d'une courte rampe, sans autres trolls autour ; la hutte à l'avant du {area:135} n'est pas la bonne. Il combat en {spell:71} et fracasse votre armure ; {spell:6343} le ralentit. Sa tête tombe toujours ; il revient environ 8 minutes après sa mort.",

	-- Step 7: Tormus Deepforge
	-- {npc:6114} Muren Stormpike · {spell:71} Defensive Stance · {quest:1680} Tormus Deepforge · {object:32372} Great Forge · {zone:1455} Ironforge
	["Back to {npc:6114} for {spell:71}, then to {quest:1680} at the {object:32372} in the middle of {zone:1455}."] = "Retournez voir {npc:6114} pour {spell:71}, puis {quest:1680} à la {object:32372}, au centre de {zone:1455}.",

	-- Step 8: Ironband's Compound
	-- {quest:1681} Ironband's Compound · {zone:1426} Dun Morogh · {area:212} Helm's Bed Lake · {object:85562} Ironband's Strongbox · {npc:6124} Captain Beld
	["{quest:1681} lies in eastern {zone:1426}, below {area:212} on its south side. Dark Iron Spies (level 8-10) stand along the way, far enough apart to pull one at a time. {object:85562} is in the basement of the southernmost house; {npc:6124} (level 11) stands by it and charges on sight. The box always holds the ore and refills 15 minutes after opening."] = "{quest:1681} se trouve dans l'est de {zone:1426}, en contrebas du {area:212}, sur sa rive sud. Des Espions Sombrefer (niveau 8-10) se tiennent le long du chemin, assez espacés pour être attirés un par un. Le {object:85562} est dans la cave de la maison la plus au sud ; le {npc:6124} (niveau 11) se tient à côté et charge à vue. Le coffre contient toujours le minerai et se remplit 15 minutes après avoir été ouvert.",
	-- {item:6800} Umbral Ore · {object:85562} Ironband's Strongbox
	["{item:6800}, from {object:85562}"] = "{item:6800}, dans le {object:85562}",

	-- Step 10: Elanaria
	-- {npc:3598} Kyra Windblade · {area:186} Dolanaar · {npc:2151} Moon Priestess Amara · {quest:1684} Elanaria · {area:1660} Warrior's Terrace · {zone:1457} Darnassus · {zone:1453} Stormwind · {npc:5480} Ilsa Corbin · {quest:1638} A Warrior's Training
	["At 10, {npc:3598}, the warrior trainer in {area:186}, or {npc:2151}, who patrols the road west of {area:186}, sends you to {quest:1684} on the {area:1660} in {zone:1457}. Any Alliance warrior may take one of the three roads, never two: in {zone:1453} at 10 anyway? {npc:5480}'s {quest:1638} teaches the same stance after one fight in a tavern."] = "Au niveau 10, {npc:3598}, la maîtresse des guerriers de {area:186}, ou {npc:2151}, qui patrouille sur la route à l'ouest de {area:186}, vous envoie voir {quest:1684} sur la {area:1660}, à {zone:1457}. Tout guerrier de l'Alliance peut prendre l'une des trois voies, jamais deux : vous êtes de toute façon à {zone:1453} au niveau 10 ? La quête {quest:1638} de {npc:5480} enseigne la même posture après un seul combat dans une taverne.",

	-- Step 11: Elanaria in Darnassus
	-- {quest:1684} Elanaria · {zone:1457} Darnassus
	["{quest:1684} in {zone:1457}"] = "{quest:1684} à {zone:1457}",
	-- {quest:1684} Elanaria · {area:1660} Warrior's Terrace
	["{quest:1684} stands on the {area:1660}."] = "{quest:1684} se tient sur la {area:1660}.",

	-- Step 12: Vorlus Vilehoof
	-- {quest:1683} Vorlus Vilehoof · {area:186} Dolanaar
	["{quest:1683} (level 10, a satyr) stands at a hidden moonwell up a hillside west of {area:186}. The trail is hard to spot: it starts behind a Gnarlpine camp and climbs in switchbacks lined with lamp posts. The furbolgs below can come in groups. His horn always drops; he returns 5 minutes after dying."] = "{quest:1683} (niveau 10, un satyre) se tient près d'un puits de lune caché, en haut d'un flanc de colline à l'ouest de {area:186}. Le sentier est difficile à repérer : il part derrière un camp Pin-tordu et monte en lacets bordés de lampadaires. Les furbolgs en contrebas peuvent arriver en groupe. Sa corne tombe toujours ; il revient 5 minutes après sa mort.",

	-- Step 14: Elunite under Auberdine
	-- {area:442} Auberdine
	["Elunite under {area:442}"] = "Élunite sous {area:442}",
	-- {area:702} Rut'theran Village · {area:442} Auberdine · {npc:6133} Shade of Elura
	["Take the boat from {area:702} to {area:442}. The wreck lies underwater just south of {area:442}'s southern pier, where the Menethil boat docks. Open Crates of Elunite on the sea floor around the wreck, by a huge sunken turtle, toward the beach and under the pier until you have eight; every crate holds ore and comes back in 3-5 minutes. The grey {npc:6133} (level 11) drifts around the middle of the wreck and always drops the medallion: target it when you see it, so you can find it after surfacing for air. Watch your breath; Threshers can join in."] = "Prenez le bateau du {area:702} à {area:442}. L'épave gît sous l'eau juste au sud de la jetée sud d'{area:442}, là où accoste le bateau de Menethil. Ouvrez les caisses d'élunite au fond de la mer autour de l'épave, près d'une énorme tortue engloutie, vers la plage et sous la jetée, jusqu'à en avoir huit ; chaque caisse contient du minerai et revient en 3 à 5 minutes. L'{npc:6133} grise (niveau 11) dérive autour du milieu de l'épave et lâche toujours le médaillon : ciblez-la quand vous la voyez, pour la retrouver après être remonté respirer. Surveillez votre souffle ; des Batteurs peuvent s'en mêler.",
	-- {item:6808} Elunite Ore
	["{item:6808}, from Crates of Elunite"] = "{item:6808}, dans les caisses d'élunite",
	-- {item:6809} Elura's Medallion · {npc:6133} Shade of Elura
	["{item:6809}, from the {npc:6133}"] = "{item:6809}, sur l'{npc:6133}",

	-- Step 15: Smith Mathiel
	-- {area:1660} Warrior's Terrace · {npc:4088} Elanaria · {item:6812} Case of Elunite · {npc:6142} Mathiel
	["Back on the {area:1660}: {npc:4088} hands you the {item:6812}; {npc:6142} works on the far, south side of the same terrace, easy to miss."] = "De retour sur la {area:1660} : {npc:4088} vous remet le {item:6812} ; {npc:6142} travaille de l'autre côté, au sud de la même terrasse, facile à manquer.",

	-- Step 16: A Warrior's Training
	-- {npc:913} Lyria Du Lac · {area:87} Goldshire · {npc:6089} Harry Burlguard · {zone:1453} Stormwind · {npc:5480} Ilsa Corbin · {object:2100} Old Town
	["At 10, {npc:913}, the warrior trainer by the inn in {area:87}, sends you to {npc:6089} in {zone:1453}; {npc:5480}, the warrior trainer in {zone:1453}'s {object:2100}, offers it too."] = "Au niveau 10, {npc:913}, la maîtresse des guerriers près de l'auberge de {area:87}, vous envoie voir {npc:6089} à {zone:1453} ; {npc:5480}, la maîtresse des guerriers de la {object:2100} de {zone:1453}, la propose aussi.",

	-- Step 17: Bartleby
	-- {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2100} Old Town · {quest:1638} A Warrior's Training · {npc:5480} Ilsa Corbin · {zone:1453} Stormwind
	["{npc:6089} and {npc:6090} are in the Pig and Whistle tavern in {object:2100}; {npc:6090} is the drunk at the far end of the bar. {npc:6090} (level 10) hits harder than his level, so start at full health; he gives up at low health instead of dying. If he wins, he disappears for about three minutes: keep the quest and talk to him again when he is back. A Dwarf, Gnome or Night Elf who took {quest:1638} from {npc:5480} instead of their home road is led through {zone:1453} from here."] = "{npc:6089} et {npc:6090} sont dans la taverne du Pig and Whistle, dans la {object:2100} ; {npc:6090} est l'ivrogne au fond du comptoir. {npc:6090} (niveau 10) frappe plus fort que son niveau, commencez donc avec toute votre vie ; il abandonne quand sa vie est basse au lieu de mourir. S'il gagne, il disparaît pendant trois minutes environ : gardez la quête et reparlez-lui quand il revient. Un Nain, un Gnome ou un Elfe de la nuit qui a pris {quest:1638} auprès de {npc:5480} au lieu de la voie de chez lui est guidé à travers {zone:1453} à partir d'ici.",

	-- Step 18: Marshal Haggard
	-- {npc:294} Marshal Haggard · {area:88} Eastvale Logging Camp
	["{npc:294}'s manor stands at the south-east edge of the {area:88} in eastern Elwynn, at the end of a short road that does not join the main one."] = "Le manoir de {npc:294} se dresse à la lisière sud-est du {area:88}, dans l'est de la forêt d'Elwynn, au bout d'une courte route qui ne rejoint pas la route principale.",

	-- Step 19: Dead-tooth Jack
	-- {npc:6093} Dead-Tooth Jack · {item:6783} Dead-tooth's Key · {object:85563} Dead-tooth's Strongbox · {item:6782} Marshal Haggard's Badge
	["{npc:6093} (level 11) camps in the far south-east of Elwynn. A guard stands beside him and Defias and wolves are spread around the camp (now and then a rarer guard too): clear them one at a time, then kill Jack. He always drops {item:6783}; open {object:85563} in the crates by him for {item:6782}. Jack returns 3 minutes after dying, the box 1 minute after opening."] = "{npc:6093} (niveau 11) campe à l'extrême sud-est de la forêt d'Elwynn. Un garde se tient à côté de lui et des Défias et des loups sont répartis autour du camp (parfois aussi un garde plus rare) : éliminez-les un par un, puis tuez Jack. Il lâche toujours la {item:6783} ; ouvrez le {object:85563} dans les caisses près de lui pour l'{item:6782}. Jack revient 3 minutes après sa mort, le coffre 1 minute après avoir été ouvert.",
	-- {npc:6093} Dead-Tooth Jack
	["from {npc:6093}"] = "sur {npc:6093}",
	-- {item:6782} Marshal Haggard's Badge · {object:85563} Dead-tooth's Strongbox
	["{item:6782}, from {object:85563}"] = "{item:6782}, dans le {object:85563}",

	-- Step 20: Back to Marshal Haggard
	-- {npc:294} Marshal Haggard
	["Back to {npc:294}"] = "Retour auprès de {npc:294}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Haggard's Weapons"] = "Les armes de Haggard",
	-- ["{npc:294}'s house is in eastern {zone:1429}, south of the road from {zone:1453} to Redridge."] = "La maison de {npc:294} est dans l'est de {zone:1429}, au sud de la route de {zone:1453} vers les Carmines.",
	-- ["{npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "{npc:5480} entraîne les guerriers dans la {object:2100} ; {npc:6089} et {npc:6090} s'y tiennent ensemble près de la {object:2152}. {npc:6090} vous affronte pour sa chope.",
	-- ["{npc:6093} camps in the far south-east of {zone:1429}, south-east of {npc:294}. He carries the key to the strongbox in his camp."] = "{npc:6093} campe à l'extrême sud-est de {zone:1429}, au sud-est de {npc:294}. Il porte la clé du coffre de son camp.",
	-- ["{npc:6093}: his key opens the strongbox"] = "{npc:6093} : sa clé ouvre le coffre",
	-- ["{spell:71} and a one-hand weapon of your choice at 10."] = "{spell:71} et une arme à une main au choix au niveau 10.",
}
