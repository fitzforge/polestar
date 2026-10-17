-- French (frFR): the guide forever/alliance/50-60/02-felwood (forever/alliance/50-60/02-felwood.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Auberdine
	-- {area:702} Rut'theran Village · {area:442} Auberdine · {area:415} Astranaar
	["Take the boat from {area:702} to {area:442} and fly to {area:415}."] = "Prenez le bateau de {area:702} pour {area:442} et un vol pour {area:415}.",

	-- Step 2: Grazle
	-- {area:415} Astranaar · {zone:1448} Felwood · {npc:11554} Grazle · {area:2479} Emerald Sanctuary
	["Ride north out of {area:415} into {zone:1448}. {npc:11554} the furbolg stands by the road just south of the {area:2479}."] = "Chevauchez vers le nord hors de {area:415} jusqu'en {zone:1448}. {npc:11554}, le furbolg, se tient au bord de la route juste au sud du {area:2479}.",

	-- Step 3: Deadwood Village
	-- {npc:11554} Grazle
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	["The Deadwood furbolgs live in the village just south-west of {npc:11554}; keep the Deadwood Headdress Feathers they drop."] = "Les furbolgs Mort-bois vivent dans le village juste au sud-ouest de {npc:11554} ; gardez les Coiffures de plumes mort-bois qu'ils laissent tomber.",

	-- Step 4: Grazle
	-- {npc:15395} Nafien · {zone:1448} Felwood
	["{npc:15395} waits at the north end of {zone:1448}"] = "{npc:15395} attend à l'extrémité nord de {zone:1448}",
	["Five feathers buy a little Timbermaw reputation"] = "Cinq plumes rapportent un peu de réputation Grumegueule",

	-- Step 5: The Emerald Sanctuary
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",
	-- {npc:9528} Arathandris Silversky · {npc:11554} Grazle
	["{npc:9528}, in the ruins just east of {npc:11554}"] = "{npc:9528}, dans les ruines juste à l'est de {npc:11554}",

	-- Step 6: Jadefire Glen
	-- {npc:9454} Xavathras
	["The Jadefire satyrs hold the glen west of the road, with {npc:9454} at its back."] = "Les satyres Jadefeu tiennent le vallon à l'ouest de la route, avec {npc:9454} au fond.",

	-- Step 7: Jaedenar
	-- {area:1763} Jaedenar · {item:13140} Blood Red Key · {npc:11018} Arko'narin · {area:1770} Shadow Hold
	["{area:1763} is the ruined temple north of the glen. Some of its cultists drop a {item:13140}, about one kill in thirty: it opens {npc:11018}'s cell in {area:1770}, the cave at the back. If it drops, clear the way out before you free her; if not, skip her quests."] = "{area:1763} est le temple en ruine au nord du vallon. Certains de ses sectateurs laissent tomber une {item:13140}, environ une fois sur trente : elle ouvre la cellule de {npc:11018} à {area:1770}, la grotte du fond. Si elle tombe, dégagez le chemin de sortie avant de la libérer ; sinon, passez ses quêtes.",
	-- {item:13140} Blood Red Key
	["{item:13140}, a rare drop"] = "{item:13140}, butin rare",
	-- {npc:11016} Captured Arko'narin · {area:1770} Shadow Hold
	["{npc:11016}, in {area:1770}"] = "{npc:11016}, à {area:1770}",
	["Keep her alive until she is out of the cave"] = "Gardez-la en vie jusqu'à sa sortie de la grotte",

	-- Step 9: Jaedenar again
	-- {area:1763} Jaedenar
	["{area:1763} again"] = "De nouveau {area:1763}",
	-- {item:12922} Empty Canteen · {area:1763} Jaedenar · {npc:11018} Arko'narin · {area:1770} Shadow Hold · {npc:9518} Rakaiah
	["Use the {item:12922} at the corrupted moonwell in the middle of {area:1763}. If you freed {npc:11018}, go back into {area:1770} for the succubus {npc:9518}; Trey Lightforge's remains lie beside her."] = "Utilisez la {item:12922} au puits de lune corrompu au milieu de {area:1763}. Si vous avez libéré {npc:11018}, retournez à {area:1770} pour la succube {npc:9518} ; le cadavre de Trey Lightforge se trouve à côté d'elle.",

	-- Step 10: Oozes
	["Oozes"] = "Limons",
	-- {area:1763} Jaedenar · {area:1765} Bloodvenom Falls
	-- plural, as words: Tainted Oozes = {npc:7092} Tainted Ooze
	["The Cursed and Tainted Oozes slide about the streams and fel pools around {area:1763} and {area:1765}: kill them and use Laris's Empty Ooze Jars on their remains."] = "Les Limons maudits et corrompus glissent dans les ruisseaux et les mares gangrenées autour de {area:1763} et de {area:1765} : tuez-les et utilisez les pots vides de Laris sur leurs restes.",

	-- Step 11: Shatter Scar Vale
	-- plural, as words: Entropic Beasts = {npc:9878} Entropic Beast
	["Follow the road north to the cratered vale and walk to each crater, killing the Entropic Beasts and Horrors between them."] = "Suivez la route vers le nord jusqu'au val criblé de cratères et rendez-vous à chaque cratère, en tuant les Bêtes d'entropie et les Horreurs entre eux.",
	["First crater"] = "Premier cratère",
	["Second crater"] = "Deuxième cratère",
	["Third crater"] = "Troisième cratère",

	-- Step 12: Jadefire Run
	-- {area:2618} Jadefire Run · {npc:10648} Xavaric · {quest:939} Flute of Xavaric · {item:11674} Jadefire Felbind
	["{area:2618} is the satyr valley in the north-west, with {npc:10648} at its far end. He drops the {quest:939}; every Jadefire satyr can drop {item:11674}."] = "{area:2618} est la vallée des satyres au nord-ouest, avec {npc:10648} tout au fond. Il laisse tomber la {quest:939} ; tout satyre Jadefeu peut laisser tomber {item:11674}.",

	-- Step 13: Irontree Woods
	-- {area:1767} Irontree Woods · {area:2618} Jadefire Run · {item:11503} Blood Amber
	["The Warpwood treants of {area:1767}, east of {area:2618}, carry the {item:11503}."] = "Les tréants Crochebois de {area:1767}, à l'est de {area:2618}, portent l'{item:11503}.",

	-- Step 14: Talonbranch Glade
	-- {area:1998} Talonbranch Glade
	["Ride east to the night elf camp at {area:1998}."] = "Chevauchez vers l'est jusqu'au camp elfe de la nuit de {area:1998}.",

	-- Step 15: Nafien
	-- {area:1769} Timbermaw Hold · {npc:15395} Nafien
	["Follow the road north to the cave mouth of {area:1769}; {npc:15395} guards it."] = "Suivez la route vers le nord jusqu'à l'entrée de la grotte de {area:1769} ; {npc:15395} la garde.",

	-- Step 16: Felpaw Village
	-- {area:1762} Felpaw Village · {quest:8470} Deadwood Ritual Totem
	["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. The Avengers can drop a {quest:8470}."] = "Les furbolgs Mort-bois de {area:1762} occupent les collines à l'ouest de la grotte. Les Vengeurs peuvent laisser tomber un {quest:8470}.",
	-- {quest:8470} Deadwood Ritual Totem
	["{quest:8470}, a rare drop"] = "{quest:8470}, butin rare",

	-- Step 17: Nafien
	-- {zone:1452} Winterspring
	["Salfa stands at the {zone:1452} end of the tunnel: keep it"] = "Salfa se tient à l'extrémité du tunnel côté {zone:1452} : gardez-la",

	-- Step 18: Timbermaw Hold
	-- {npc:11558} Kernda · {npc:11557} Meilosh
	["Step into the cave: {npc:11558} and {npc:11557} stand just inside."] = "Entrez dans la grotte : {npc:11558} et {npc:11557} se tiennent juste à l'intérieur.",
	-- {npc:11558} Kernda
	["{npc:11558}: the Timbermaw speak to you only from Neutral"] = "{npc:11558} : les Grumegueule ne vous parlent qu'à partir de Neutre",
	-- {npc:11557} Meilosh · {quest:6031} Runecloth
	["{npc:11557}: thirty {quest:6031}, handed in when you pass through again at 57"] = "{npc:11557} : trente {quest:6031}, à rendre quand vous repasserez au niveau 57",

	-- Step 19: The Emerald Sanctuary
	-- {area:1998} Talonbranch Glade
	["Fly from {area:1998} to the Sanctuary's end of the road, or ride south along it."] = "Prenez un vol de {area:1998} jusqu'au bout de la route côté sanctuaire, ou descendez-la vers le sud.",
	-- {zone:1457} Darnassus
	["The vial is filled in {zone:1457}: keep it"] = "La fiole se remplit à {zone:1457} : gardez-la",
	-- {zone:1413} Barrens
	["Ends in the {zone:1413}: keep it"] = "Se termine dans {zone:1413} : gardez-la",

	-- Step 20: Everlook
	-- {area:1769} Timbermaw Hold · {area:1998} Talonbranch Glade · {zone:1452} Winterspring · {area:2255} Everlook
	["Ride north to {area:1769} (or fly back to {area:1998} first) and through the tunnel into {zone:1452}; follow the road east to the goblin town of {area:2255}."] = "Chevauchez vers le nord jusqu'à {area:1769} (ou reprenez d'abord un vol pour {area:1998}) et traversez le tunnel jusqu'au {zone:1452} ; suivez la route vers l'est jusqu'à la ville gobeline de {area:2255}.",
}
