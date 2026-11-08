-- French (frFR): the guide forever/alliance/06-wetlands (forever/alliance/06-wetlands.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Moonglade
	-- {zone:1450} Moonglade
	["Cast Teleport: {zone:1450}"] = "",

	-- Step 2: Aquatic Form
	-- {zone:1453} Stormwind City · {item:15885} Pendant of the Sea Lion · {zone:1450} Moonglade · {npc:11802} Dendrite Starblaze · {npc:11800} Silva Fil'naveth
	["In {zone:1453}, join the two half pendants into the {item:15885} and cast Teleport: {zone:1450}: {npc:11802} is in Nighthaven. Then {npc:11800} in Nighthaven flies Druids straight to Rut'theran Village. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {item:15885} Pendant of the Sea Lion
	["{item:15885}: join the two halves"] = "{item:15885} : assemblez les deux moitiés",

	-- Step 4: Mathrengyl Bearwalker
	-- {object:1162} Menethil Harbor (no name in this language: may be words)
	["Take the portal up to the Cenarion Enclave, then fly back to Auberdine for the boat to {object:1162}."] = "",

	-- Step 6: Fly to Rut'theran Village
	["Fly to Rut'theran Village"] = "",
	["Auberdine flight master"] = "",

	-- Step 7: Into Darnassus
	-- {zone:1457} Darnassus
	["Into {zone:1457}"] = "Entrez dans {zone:1457}",

	-- Step 10: Boat to Menethil Harbor
	-- {object:1162} Menethil Harbor (no name in this language: may be words)
	["Boat to {object:1162}"] = "",
	-- {object:1162} Menethil Harbor (no name in this language: may be words)
	["Take the boat from Auberdine's dock to {object:1162}."] = "",

	-- Step 11: Fly to Menethil Harbor
	-- {object:1162} Menethil Harbor (no name in this language: may be words)
	["Fly to {object:1162}"] = "",
	-- {zone:1453} Stormwind City
	["{zone:1453} flight master"] = "Maître de vol de {zone:1453}",

	-- Step 12: Menethil Harbor
	-- {npc:1239} First Mate Fitzsimmons
	["{npc:1239}, in the inn"] = "{npc:1239}, à l'auberge",
	-- {item:2594} Flagon of Mead · {npc:1464} Innkeeper Helbrek
	["{item:2594}, from {npc:1464}"] = "{item:2594}, chez {npc:1464}",
	-- {npc:2104} Captain Stoutfist
	["{npc:2104}, by the keep; on the top floor"] = "",
	-- {npc:2104} Captain Stoutfist · {quest:98221} From the Ashes
	["{npc:2104}: {quest:98221}, the Attack Plans in the Angerfang Encampment"] = "",
	-- {npc:2104} Captain Stoutfist · {npc:270637} Howin Kindfeather
	["{npc:2104}: for {npc:270637} in the Green Belt"] = "",
	-- {npc:1242} Karl Boran
	["{npc:1242}, on the pier north of the inn"] = "{npc:1242}, sur la jetée au nord de l'auberge",
	-- {npc:2094} James Halloran
	["{npc:2094}, by the docks"] = "",
	-- {npc:2097} Harlo Barnaby · {npc:1071} Longbraid the Grim · {object:376} Dun Modr (no name in this language: may be words)
	["{npc:2097}, by the north gate: {npc:1071} takes it on 30-40/01-hillsbrad-foothills' {object:376} stop"] = "",

	-- Step 13: The Bluegill hovels
	["The Bluegill hovels"] = "Les huttes des Branchie-bleue",
	-- {object:261} Damaged Crate · {object:142151} Sealed Barrel · {object:259} Half-buried Barrel
	["Follow the coast north out of Menethil into Bluegill Marsh. Three containers in the murloc hovels, south to north: the {object:261}, then the {object:142151}, then the {object:259} at the north end."] = "",

	-- Step 14: The Lost Fleet: kill these as you meet them
	["The Lost Fleet: kill these as you meet them"] = "",
	-- {npc:1159} First Mate Snellig
	-- plural, as words: Cursed Sailors = {npc:1157} Cursed Sailor · Cursed Marines = {npc:1158} Cursed Marine · Giant Wetlands Crocolisks = {npc:2089} Giant Wetlands Crocolisk · Fen Creepers = {npc:1040} Fen Creeper
	["Follow the coast north to the wrecked ship. Cursed Sailors walk the beach, Cursed Marines the deck; {npc:1159} stands on the beach by the bow. Giant Wetlands Crocolisks lurk on the coast just north of it.\nCareful: Fen Creepers hide in stealth where the river splits close to the ghost ship, and they can join a fight."] = "Suivez la côte vers le nord jusqu'à l'épave. Des Marins maudits arpentent la plage, des Soldats de marine maudits le pont ; {npc:1159} se tient sur la plage près de la proue. Des Crocilisques géants des Paluns rôdent sur la côte juste au nord.\nAttention : des Rampants des tourbières se cachent, camouflés, là où la rivière se divise près du navire fantôme, et peuvent se joindre au combat.",

	-- Step 15: Menethil Harbor
	-- {npc:2094} James Halloran · {npc:1242} Karl Boran · {npc:2104} Captain Stoutfist · {npc:1239} First Mate Fitzsimmons
	["In from the north: {npc:2094} by the docks, {npc:1242} on the pier, {npc:2104} in the keep, then {npc:1239} in the inn."] = "",
	-- {npc:1242} Karl Boran · {npc:2104} Captain Stoutfist
	["{npc:1242}: for {npc:2104} in the keep"] = "{npc:1242} : pour {npc:2104}, dans le donjon",
	-- {npc:2104} Captain Stoutfist
	["{npc:2104}, on the top floor"] = "{npc:2104}, au dernier étage",
	-- {object:2117} Stormwind Keep
	["For Bolvar Fordragon in {object:2117}: keep it"] = "Pour Bolvar Fordragon, dans le {object:2117} : gardez-la",

	-- Step 16: Captain Halyndor
	["The captain walks the deck of the wrecked ship; his strongbox sits in the hold."] = "Le capitaine arpente le pont du navire échoué ; son coffre est dans la cale.",

	-- Step 17: Glorin Steelbrow
	["Inside"] = "À l'intérieur",
	-- {npc:1284} Archbishop Benedictus · {zone:1453} Stormwind City
	["For {npc:1284} in {zone:1453}, at the end of this guide"] = "",

	-- Step 18: Raptor valley
	["Raptor valley"] = "La vallée des raptors",
	-- {quest:295} Ormer's Revenge
	["Follow the road east: the bigger raptors for {quest:295} hunt in the valley just west of the excavation site."] = "",

	-- Step 19: Whelgar's Excavation Site
	["Whelgar's Excavation Site"] = "",
	-- {npc:1078} Ormer Ironbraid · {npc:1077} Prospector Whelgar
	["The excavation site sits on the hill south of the road: {npc:1078} at the top, {npc:1077} below ground."] = "",

	-- Step 20: Whelgar's Excavation Site: kill these as you meet them
	["Whelgar's Excavation Site: kill these as you meet them"] = "",
	-- {npc:1353} Sarltooth
	["The relics lie in the dig itself. {npc:1353}, a big Razormaw, prowls the raptor valley just west of it."] = "Les reliques se trouvent dans les fouilles mêmes. {npc:1353}, un grand raptor Razormaw, rôde dans la vallée des raptors juste à l'ouest.",
	-- {item:2661} Neru Fragment · {object:331} Loose Soil
	["{item:2661}: the {object:331}"] = "{item:2661} : le {object:331}",

	-- Step 21: Ormer Ironbraid and Whelgar
	-- {npc:1078} Ormer Ironbraid
	["{npc:1078} and Whelgar"] = "{npc:1078} et Whelgar",
	-- {npc:1077} Prospector Whelgar · {item:279993} Titanic Keystone
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["{npc:1077}, below ground: the {item:279993}, from the elite Goaz Warders"] = "",

	-- Step 22: Goaz Warders
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["Goaz Warders"] = "",
	-- {item:279996} Goaz Stone · {npc:270892} Goaz Warder
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["The Goaz Warders stand just west of Whelgar's camp: use the {item:279996} he gave you beside one.\n{npc:270892} is elite: grouping up is advised."] = "",

	-- Step 23: Prospector Whelgar
	["Below ground"] = "Sous terre",

	-- Step 24: Prospector Whelgar
	-- {item:279996} Goaz Stone · {zone:1437} Wetlands · {object:376} Dun Modr (no name in this language: may be words)
	["A new {item:279996}, for the four titan watchers around the {zone:1437}; below ground. Their hearts drop from level 32 elites on the {object:376} visit"] = "",

	-- Step 25: Angerfang Encampment
	["Angerfang Encampment"] = "",
	-- {npc:2091} Chieftain Nek'rosh
	["South-east from the dig to the Dragonmaw camp. The four sets of Attack Plans lie in the Angerfang Encampment; {npc:2091}, an elite, stands in the camp too."] = "",
	-- {item:3337} Dragonmaw War Banner
	["{item:3337}: the camp's Raiders and Swamprunners"] = "",

	-- Step 26: Rethiel the Greenwarden
	-- {npc:1244} Rethiel the Greenwarden · {quest:277} Fire Taboo · {zone:1437} Wetlands
	["Follow the road east to the Green Belt; {npc:1244} stands by the river. {quest:277}'s flint came with you from your last {zone:1437} visit."] = "",

	-- Step 27: Howin Kindfeather
	-- {npc:270637} Howin Kindfeather · {npc:1244} Rethiel the Greenwarden
	["{npc:270637} camps among the Fenrunners, just west of {npc:1244}."] = "",
	-- {zone:1437} Wetlands
	-- plural, as words: Razormaw Incisors = {item:280103} Razormaw Incisor
	["Razormaw Incisors: from the raptors by the Dragonmaw Gates, on the {zone:1437} loop of 30-40/01-hillsbrad-foothills"] = "",
	-- {zone:1455} Ironforge
	["For King Magni in {zone:1455}, at the end of 30-40/01-hillsbrad-foothills"] = "",

	-- Step 28: Einar Stonegrip
	-- {npc:270637} Howin Kindfeather · {npc:2093} Einar Stonegrip
	["East from {npc:270637}: {npc:2093} stands beside the road."] = "",
	-- {npc:2093} Einar Stonegrip · {npc:2094} James Halloran
	["{npc:2093}: for {npc:2094} in Menethil"] = "",

	-- Step 29: The Green Belt: kill these as you meet them
	["The Green Belt: kill these as you meet them"] = "",
	-- {item:279996} Goaz Stone
	-- plural, as words: Maddened Rotclaws = {npc:271334} Maddened Rotclaw · Fen Creepers = {npc:1040} Fen Creeper
	["Red whelps fill the hills west of the gates, Maddened Rotclaws the Green Belt, Razormaws the northern slopes; Neru stands in the north-east (use the {item:279996}).\nFen Creepers hide in the marsh pools north-west of the Green Belt.\nCareful: When out of combat, Fen Creepers cast Sneak from time to time, so they are stealthed and hard to see."] = "",

	-- Step 30: Rethiel the Greenwarden
	-- {quest:98283} Carnage · {zone:1437} Wetlands
	["{quest:98283}, an elite raptor, on the {zone:1437} loop of 30-40/01-hillsbrad-foothills"] = "",

	-- Step 31: Captain Stoutfist
	-- {object:1162} Menethil Harbor (no name in this language: may be words) · {npc:2104} Captain Stoutfist
	["Back west along the road to {object:1162}: {npc:2104} stands on the top floor of Menethil Keep."] = "",
	["On the top floor"] = "Au dernier étage",
	-- {zone:1437} Wetlands
	["For the Dragonmaw catapult, on the {zone:1437} loop of 30-40/01-hillsbrad-foothills"] = "",
	-- {npc:2094} James Halloran
	["{npc:2094}, by the docks, on the way to the boat"] = "",

	-- Step 32: Boat to Auberdine
	["The boat to Auberdine leaves from the far end of Menethil's western pier."] = "",

	-- Step 33: Auberdine
	["Auberdine"] = "",
	-- {npc:3649} Thundris Windweaver · {npc:3693} Terenthis · {npc:3694} Sentinel Selarin
	["{npc:3649} stands at the north end of Auberdine, {npc:3693} and {npc:3694} by the flight master."] = "",
	-- {npc:3649} Thundris Windweaver · {zone:1453} Stormwind City
	["{npc:3649}: Alexston's reply, if you took it in {zone:1453}"] = "{npc:3649} : la réponse d'Alexston, si vous l'avez prise à {zone:1453}",
	-- {npc:3693} Terenthis · {zone:1439} Darkshore
	["{npc:3693}: Volcor's escort from the end of {zone:1439}"] = "",
	-- {npc:3694} Sentinel Selarin · {npc:3691} Raene Wolfrunner
	["{npc:3694}: for {npc:3691} in Astranaar"] = "",

	-- Step 34: Fly to Astranaar
	["Fly to Astranaar"] = "",

	-- Step 35: Shindrell Swiftfire
	-- {npc:3845} Shindrell Swiftfire
	["{npc:3845} stands by Astranaar's flight master."] = "",
	-- {quest:4581} Kayneth Stillwind
	["For {quest:4581} at Forest Song"] = "",

	-- Step 36: Astranaar
	["Astranaar"] = "",
	-- {npc:3691} Raene Wolfrunner
	["{npc:3691}, in the inn"] = "{npc:3691}, à l'auberge",
	-- {npc:3894} Pelturas Whitemoon
	["{npc:3894}, inside"] = "{npc:3894}, à l'intérieur",

	-- Step 37: Melyria and Illiyana
	-- {npc:3901} Illiyana
	["Melyria and {npc:3901}"] = "Melyria et {npc:3901}",
	["The two stand together at the western end of the road, south-west of Astranaar."] = "",

	-- Step 38: Shael'dryn
	-- {npc:3916} Shael'dryn
	["Follow the road east to the Howling Vale; {npc:3916} stands by the moonwell."] = "",

	-- Step 39: Dartol's Rod
	["Dartol's Rod"] = "Bâtonnet de transformation de Dartol",
	-- {item:5475} Wooden Key
	-- plural, as words: Withered Ancients = {npc:3919} Withered Ancient
	["The Crazed and Withered Ancients north of the moonwell carry the {item:5475}; the worn chest it opens stands among them."] = "Les Anciens fous et les Anciens flétris au nord du puits de lune portent la {item:5475} ; le vieux coffre qu'elle ouvre se trouve parmi eux.",

	-- Step 40: The Howling Vale
	["Take the tunnel into the Howling Vale; the tome lies in the ruins at its west end."] = "",

	-- Step 42: Anilia
	-- {npc:3920} Anilia
	["Follow the road east to the satyr camps of Xavian; {npc:3920} hides at their edge."] = "",

	-- Step 43: Geltharis
	-- {npc:4619} Geltharis
	["{npc:4619} leads the Xavian satyrs; he carries the branch."] = "",

	-- Step 44: Forest Song
	["Forest Song"] = "",
	-- {npc:3848} Kayneth Stillwind
	["Forest Song, the Night Elf outpost at the eastern end of the road: {npc:3848} stands there."] = "",

	-- Step 45: The Dor'Danil Barrow Den: kill these as you meet them
	["The Dor'Danil Barrow Den: kill these as you meet them"] = "",
	["The Forsaken's camp lies in the woods south of Forest Song.\nRusty chests lie around the Shadethicket furbolg camps west of the Forsaken; open them until one holds the pommel.\nCareful: Non-elite Forsaken of about level 28-30 guard the camp. Some of them are stealthed, and the ones around the table often aggro together."] = "",

	-- Step 46: Fallen Sky Lake
	-- {npc:3931} Shadethicket Oracle · {quest:1035} Fallen Sky Lake · {object:669176} Gleaming Crescent Pendant
	["The {npc:3931} walks the shore of {quest:1035}, south-west of the chests; the {object:669176} lies north of the lake, on the way.\nCareful: Other mobs, some of them underwater, sit near the island. Clear them first so they don't join the fight when you pull the Oracle."] = "{npc:3931} arpente les rives de {quest:1035}, au sud-ouest des coffres ; {object:669176} se trouve au nord du lac, en chemin.\nAttention : d'autres monstres, dont certains sous l'eau, se tiennent près de l'île. Éliminez-les d'abord pour qu'ils ne se joignent pas au combat quand vous attirez l'Oracle.",
	-- {object:669176} Gleaming Crescent Pendant · {npc:3961} Maliynn
	["{object:669176}: for {npc:3961} in Astranaar"] = "",

	-- Step 48: Insane druids
	["Insane druids"] = "Druides fous",
	["The three druids stand together at the Forsaken camp south of Forest Song.\nCareful: The den has many mobs that respawn quickly, including stealthed undead and patrols, so extra mobs often join a fight."] = "",
	-- {npc:3940} Taneel Darkwood
	["{npc:3940}, inside The Dor'Danil Barrow Den"] = "",
	-- {npc:3941} Uthil Mooncall
	["{npc:3941}, inside The Dor'Danil Barrow Den"] = "",
	-- {npc:3942} Mavoris Cloudsbreak
	["{npc:3942}, inside The Dor'Danil Barrow Den"] = "",

	-- Step 49: Satyrnaar
	["Satyrnaar"] = "",
	-- {object:19901} Circle of Imprisonment
	-- plural, as words: Felmusk Rogues = {npc:3759} Felmusk Rogue
	["The {object:19901} stands in the satyr camp of Satyrnaar, further east along the road.\nCareful: The Felmusk Rogues in Night Run often go stealthed, and Satyrnaar has satyr casters."] = "",

	-- Step 51: Night Run
	["Night Run"] = "",
	-- {object:19901} Circle of Imprisonment
	["The second {object:19901} lies in the valley of Night Run, on the way west."] = "",

	-- Step 53: Hidden Shrine
	["The shrine sits on the hill just south-east of the moonwell; follow the winding path up."] = "L'Autel caché se trouve sur la colline juste au sud-est du puits de lune ; suivez le sentier sinueux.",

	-- Step 56: Krolg
	-- {npc:3897} Krolg
	["{npc:3897}, a furbolg untouched by the corruption, sits south of the road below Mystral Lake."] = "",

	-- Step 57: Ran Bloodtooth
	-- {npc:3696} Ran Bloodtooth · {npc:3897} Krolg
	["{npc:3696} and his guards camp just east of {npc:3897}.\nCareful: Wolves and spiders roam near the camp and can join a fight. Some of the wolves come in pairs."] = "{npc:3696} et ses gardes campent juste à l'est de {npc:3897}.\nAttention : des loups et des araignées rôdent près du camp et peuvent se joindre au combat. Certains loups vont par deux.",

	-- Step 59: Melyria and Illiyana
	-- {npc:3897} Krolg · {object:13352} Shrine of Aessina (no name in this language: may be words) · {npc:3901} Illiyana
	["West from {npc:3897} along the southern hills to the {object:13352}: Melyria and {npc:3901} stand together by it."] = "",

	-- Step 60: Delgren the Purifier
	-- {object:19863} Maestra's Post (no name in this language: may be words)
	["North to {object:19863}."] = "",

	-- Step 61: Astranaar
	-- {npc:3691} Raene Wolfrunner · {npc:3961} Maliynn · {npc:3894} Pelturas Whitemoon
	["South-east along the road to Astranaar: {npc:3691} in the inn, {npc:3961} and {npc:3894} inside, the flight master at the west end."] = "",

	-- Step 62: Fly to Auberdine
	["Fly to Auberdine"] = "",
	["Astranaar flight master"] = "",

	-- Step 64: Fly to Ironforge
	-- {zone:1455} Ironforge
	["Fly to {zone:1455}"] = "",
	-- {npc:1571} Shellei Brondir
	["{npc:1571} is the flight master by Menethil's inn."] = "",
	-- {object:1162} Menethil Harbor (no name in this language: may be words)
	["{object:1162} flight master"] = "",

	-- Step 66: Ironforge priests
	-- {zone:1455} Ironforge
	["{zone:1455} priests"] = "Prêtres d'{zone:1455}",
	-- {npc:11406} High Priest Rohan · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries (no name in this language: may be words) · {object:32362} Mystic Ward
	["{npc:11406} and {npc:258785} are in the {object:32386}, in the {object:32362}."] = "{npc:11406} et {npc:258785} sont dans le {object:32386}, dans {object:32362}.",

	-- Step 67: Tram to Stormwind City
	-- {zone:1453} Stormwind City
	["Tram to {zone:1453}"] = "Tram pour {zone:1453}",

	-- Step 68: Cathedral of Light
	["Cathedral of Light"] = "Cathédrale de la Lumière",
	-- {object:171524} Tinker Town · {zone:1453} Stormwind City · {object:28027} Dwarven District · {object:2098} Cathedral Square
	["Take the Deeprun Tram from {object:171524} to {zone:1453}'s {object:28027}, then walk to the {object:2098}."] = "",
	-- {npc:4982} Thomas
	["{npc:4982}, in the Cathedral of Light"] = "{npc:4982}, dans la Cathédrale de la Lumière",

	-- Step 69: Stormwind Keep
	-- {quest:337} An Old History Book · {zone:1431} Duskwood
	["Only if you looted {quest:337} in {zone:1431}"] = "Seulement si vous avez ramassé {quest:337} à {zone:1431}",

	-- Step 70: Lord Grayson Shadowbreaker
	-- {npc:928} Lord Grayson Shadowbreaker
	["Back to the Cathedral of Light: {npc:928} stands inside."] = "Retournez à la Cathédrale de la Lumière : {npc:928} se tient à l'intérieur.",
	-- {npc:2228} Lieutenant Farren Orinelle
	["For {npc:2228} in Southshore: keep it"] = "",

	-- Step 71: Jorgen and Elling Trias
	-- {npc:4959} Jorgen · {npc:482} Elling Trias
	["{npc:4959} and {npc:482}"] = "{npc:4959} et {npc:482}",
	-- {npc:482} Elling Trias · {object:2096} Trade District
	["{npc:482}, the cheese shop in the {object:2096}"] = "{npc:482}, la fromagerie du {object:2096}",

	-- Step 72: Trade District
	["Next: fly to Darkshire."] = "",
}
