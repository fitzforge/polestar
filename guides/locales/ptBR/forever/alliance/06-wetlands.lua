-- Portuguese (Brazil) (ptBR): the guide forever/alliance/06-wetlands (forever/alliance/06-wetlands.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Moonglade
	-- {spell:18960} Teleport: Moonglade
	["Cast {spell:18960}"] = "",

	-- Step 2: Aquatic Form
	-- {zone:1453} Stormwind City · {item:15885} Pendant of the Sea Lion · {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {npc:11800} Silva Fil'naveth · {area:702} Rut'theran Village
	["In {zone:1453}, join the two half pendants into the {item:15885} and cast {spell:18960}: {npc:11802} is in {area:2361}. Then {npc:11800} in {area:2361} flies Druids straight to {area:702}. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {item:15885} Pendant of the Sea Lion
	["{item:15885}: join the two halves"] = "{item:15885}: junte as duas metades",

	-- Step 4: Mathrengyl Bearwalker
	-- {area:1658} Cenarion Enclave · {area:442} Auberdine · {area:150} Menethil Harbor
	["Take the portal up to the {area:1658}, then fly back to {area:442} for the boat to {area:150}."] = "",

	-- Step 6: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "",

	-- Step 7: Into Darnassus
	-- {zone:1457} Darnassus
	["Into {zone:1457}"] = "",

	-- Step 10: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Navio para {area:150}",
	-- {area:442} Auberdine · {area:150} Menethil Harbor
	["Take the boat from {area:442}'s dock to {area:150}."] = "",

	-- Step 11: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "",
	-- {zone:1453} Stormwind City
	["{zone:1453} flight master"] = "",

	-- Step 12: Menethil Harbor
	-- {npc:1239} First Mate Fitzsimmons
	["{npc:1239}, in the inn"] = "{npc:1239}, na estalagem",
	-- {npc:1464} Innkeeper Helbrek
	["Flagon of Mead, from {npc:1464}"] = "",
	-- {npc:2104} Captain Stoutfist
	["{npc:2104}, by the keep; on the top floor"] = "",
	-- {npc:2104} Captain Stoutfist · {quest:98221} From the Ashes · {area:1036} Angerfang Encampment
	["{npc:2104}: {quest:98221}, the Attack Plans in the {area:1036}"] = "",
	-- {npc:1242} Karl Boran
	["{npc:1242}, on the pier north of the inn"] = "{npc:1242}, no píer ao norte da estalagem",
	-- {npc:2094} James Halloran
	["{npc:2094}, by the docks"] = "",
	-- {npc:2097} Harlo Barnaby · {npc:1071} Longbraid the Grim · {area:205} Dun Modr
	["{npc:2097}, by the north gate: {npc:1071} takes it on 30-40/01-hillsbrad-foothills' {area:205} stop"] = "",

	-- Step 13: The Bluegill hovels
	["The Bluegill hovels"] = "As choças Guelrazul",
	-- {area:1022} Bluegill Marsh · {object:261} Damaged Crate · {object:142151} Sealed Barrel · {object:259} Half-buried Barrel
	["Follow the coast north out of Menethil into {area:1022}. Three containers in the murloc hovels, south to north: the {object:261}, then the {object:142151}, then the {object:259} at the north end."] = "",

	-- Step 14: The Lost Fleet: kill these as you meet them
	-- {area:1039} The Lost Fleet
	["{area:1039}: kill these as you meet them"] = "",
	-- {npc:1159} First Mate Snellig
	-- plural, as words: Cursed Sailors = {npc:1157} Cursed Sailor · Cursed Marines = {npc:1158} Cursed Marine · Giant Wetlands Crocolisks = {npc:2089} Giant Wetlands Crocolisk · Fen Creepers = {npc:1040} Fen Creeper
	["Follow the coast north to the wrecked ship. Cursed Sailors walk the beach, Cursed Marines the deck; {npc:1159} stands on the beach by the bow. Giant Wetlands Crocolisks lurk on the coast just north of it.\nCareful: Fen Creepers hide in stealth where the river splits close to the ghost ship, and they can join a fight."] = "",

	-- Step 15: Menethil Harbor
	-- {npc:2094} James Halloran · {npc:1242} Karl Boran · {npc:2104} Captain Stoutfist · {npc:1239} First Mate Fitzsimmons
	["In from the north: {npc:2094} by the docks, {npc:1242} on the pier, {npc:2104} in the keep, then {npc:1239} in the inn."] = "",
	-- {npc:1242} Karl Boran · {npc:2104} Captain Stoutfist
	["{npc:1242}: for {npc:2104} in the keep"] = "{npc:1242}: para {npc:2104} na fortaleza",
	-- {npc:2104} Captain Stoutfist
	["{npc:2104}, on the top floor"] = "",
	-- {object:2117} Stormwind Keep
	["For Bolvar Fordragon in {object:2117}: keep it"] = "Para Bolvar Fordragon na {object:2117}: guarde-o",

	-- Step 16: Captain Halyndor
	["The captain walks the deck of the wrecked ship; his strongbox sits in the hold."] = "O capitão anda pelo convés do navio naufragado; a caixa-forte dele fica no porão.",

	-- Step 17: Glorin Steelbrow
	["Inside"] = "",
	-- {npc:1284} Archbishop Benedictus · {zone:1453} Stormwind City
	["For {npc:1284} in {zone:1453}, at the end of this guide"] = "",

	-- Step 18: Raptor valley
	["Raptor valley"] = "Vale dos raptores",
	-- {quest:295} Ormer's Revenge
	["Follow the road east: the bigger raptors for {quest:295} hunt in the valley just west of the excavation site."] = "",

	-- Step 19: Whelgar's Excavation Site
	-- {npc:1078} Ormer Ironbraid · {npc:1077} Prospector Whelgar
	["The excavation site sits on the hill south of the road: {npc:1078} at the top, {npc:1077} below ground."] = "",

	-- Step 20: Whelgar's Excavation Site: kill these as you meet them
	-- {area:118} Whelgar's Excavation Site
	["{area:118}: kill these as you meet them"] = "",
	-- {npc:1353} Sarltooth
	["The relics lie in the dig itself. {npc:1353}, a big Razormaw, prowls the raptor valley just west of it."] = "As relíquias ficam na própria escavação. {npc:1353}, um Rasgaqueixo grande, ronda o vale dos raptores logo a oeste.",
	-- {item:2661} Neru Fragment · {object:331} Loose Soil
	["{item:2661}: the {object:331}"] = "{item:2661}: {object:331}",

	-- Step 21: Ormer Ironbraid and Whelgar
	-- {npc:1078} Ormer Ironbraid
	["{npc:1078} and Whelgar"] = "{npc:1078} e Whelgar",
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
	["Below ground"] = "",

	-- Step 24: Prospector Whelgar
	-- {item:279996} Goaz Stone · {zone:1437} Wetlands · {area:205} Dun Modr
	["A new {item:279996}, for the four titan watchers around the {zone:1437}; below ground. Their hearts drop from level 32 elites on the {area:205} visit"] = "",

	-- Step 25: Angerfang Encampment
	-- {zone:1455} Ironforge · {npc:2091} Chieftain Nek'rosh · {quest:98221} From the Ashes
	["North from the dig into the Dragonmaw camp: click the four sets of Attack Plans. The {zone:1455} plan lies at the camp's west end, the other three further east. {npc:2091}, an elite, stands apart to the south-east: {quest:98221} doesn't need him."] = "",
	-- {item:3337} Dragonmaw War Banner
	["{item:3337}: the camp's Raiders and Swamprunners"] = "",

	-- Step 26: Rethiel the Greenwarden
	-- {area:1025} Green Belt · {npc:1244} Rethiel the Greenwarden · {quest:277} Fire Taboo · {zone:1437} Wetlands
	["Follow the road east to the {area:1025}; {npc:1244} stands by the river. {quest:277}'s flint came with you from your last {zone:1437} visit."] = "",

	-- Step 27: Howin Kindfeather
	-- {npc:270637} Howin Kindfeather · {npc:1244} Rethiel the Greenwarden
	["{npc:270637} camps among the Fenrunners, just west of {npc:1244}."] = "",
	-- {area:1038} Dragonmaw Gates · {zone:1437} Wetlands
	-- plural, as words: Razormaw Incisors = {item:280103} Razormaw Incisor
	["Razormaw Incisors: from the raptors by the {area:1038}, on the {zone:1437} loop of 30-40/01-hillsbrad-foothills"] = "",

	-- Step 28: Einar Stonegrip
	-- {npc:270637} Howin Kindfeather · {npc:2093} Einar Stonegrip
	["East from {npc:270637}: {npc:2093} stands beside the road."] = "",
	-- {npc:2093} Einar Stonegrip · {npc:2094} James Halloran
	["{npc:2093}: for {npc:2094} in Menethil"] = "",

	-- Step 29: Green Belt: kill these as you meet them
	-- {area:1025} Green Belt
	["{area:1025}: kill these as you meet them"] = "",
	-- {area:1025} Green Belt · {item:279996} Goaz Stone
	-- plural, as words: Maddened Rotclaws = {npc:271334} Maddened Rotclaw · Fen Creepers = {npc:1040} Fen Creeper
	["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; Neru stands in the north-east (use the {item:279996}).\nFen Creepers hide in the marsh pools north-west of the {area:1025}.\nCareful: When out of combat, Fen Creepers cast Sneak from time to time, so they are stealthed and hard to see."] = "",

	-- Step 30: Rethiel the Greenwarden
	-- {quest:98283} Carnage · {zone:1437} Wetlands
	["{quest:98283}, an elite raptor, on the {zone:1437} loop of 30-40/01-hillsbrad-foothills"] = "",

	-- Step 31: Captain Stoutfist
	-- {area:150} Menethil Harbor · {npc:2104} Captain Stoutfist · {area:2103} Menethil Keep
	["Back west along the road to {area:150}: {npc:2104} stands on the top floor of {area:2103}."] = "",
	["On the top floor"] = "",
	-- {zone:1437} Wetlands
	["For the Dragonmaw catapult, on the {zone:1437} loop of 30-40/01-hillsbrad-foothills"] = "",
	-- {npc:2094} James Halloran
	["{npc:2094}, by the docks, on the way to the boat"] = "",

	-- Step 32: Boat to Auberdine
	-- {area:442} Auberdine
	["The boat to {area:442} leaves from the far end of Menethil's western pier."] = "",

	-- Step 33: Auberdine
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine · {npc:3693} Terenthis · {npc:3694} Sentinel Selarin
	["{npc:3649} stands at the north end of {area:442}, {npc:3693} and {npc:3694} by the flight master."] = "",
	-- {npc:3649} Thundris Windweaver · {zone:1453} Stormwind City
	["{npc:3649}: Alexston's reply, if you took it in {zone:1453}"] = "",
	-- {npc:3693} Terenthis · {zone:1439} Darkshore
	["{npc:3693}: Volcor's escort from the end of {zone:1439}"] = "",
	-- {npc:3694} Sentinel Selarin · {npc:3691} Raene Wolfrunner · {area:415} Astranaar
	["{npc:3694}: for {npc:3691} in {area:415}"] = "",

	-- Step 34: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "",

	-- Step 35: Shindrell Swiftfire
	-- {npc:3845} Shindrell Swiftfire · {area:415} Astranaar
	["{npc:3845} stands by {area:415}'s flight master."] = "",
	-- {quest:4581} Kayneth Stillwind · {area:2358} Forest Song
	["For {quest:4581} at {area:2358}"] = "",

	-- Step 36: Astranaar
	-- {npc:3691} Raene Wolfrunner
	["{npc:3691}, in the inn"] = "{npc:3691}, na estalagem",
	-- {npc:3894} Pelturas Whitemoon
	["{npc:3894}, inside"] = "",

	-- Step 37: Melyria and Illiyana
	-- {npc:3901} Illiyana
	["Melyria and {npc:3901}"] = "Melyria e {npc:3901}",
	-- {area:415} Astranaar
	["The two stand together at the western end of the road, south-west of {area:415}."] = "",

	-- Step 38: Shael'dryn
	-- {area:419} Howling Vale · {npc:3916} Shael'dryn
	["Follow the road east to the {area:419}; {npc:3916} stands by the moonwell."] = "Siga a estrada para leste até o {area:419}; {npc:3916} fica junto ao poço lunar.",

	-- Step 39: Dartol's Rod
	["Dartol's Rod"] = "Bastão de Transformação de Dartol",
	-- {item:5475} Wooden Key
	-- plural, as words: Withered Ancients = {npc:3919} Withered Ancient
	["The Crazed and Withered Ancients north of the moonwell carry the {item:5475}; the worn chest it opens stands among them."] = "Os Ancientes Enlouquecidos e Ancientes Fenescidos ao norte do poço lunar carregam a {item:5475}; o baú gasto que ela abre fica entre eles.",

	-- Step 40: The Howling Vale
	-- {area:419} Howling Vale
	["Take the tunnel into the {area:419}; the tome lies in the ruins at its west end."] = "Pegue o túnel para {area:419}; o tomo está nas ruínas no extremo oeste.",

	-- Step 42: Anilia
	-- {area:429} Xavian · {npc:3920} Anilia
	["Follow the road east to the satyr camps of {area:429}; {npc:3920} hides at their edge."] = "Siga a estrada para leste até os acampamentos de sátiros de {area:429}; {npc:3920} se esconde na borda deles.",

	-- Step 43: Geltharis
	-- {npc:4619} Geltharis · {area:429} Xavian
	["{npc:4619} leads the {area:429} satyrs; he carries the branch."] = "{npc:4619} lidera os sátiros de {area:429}; ele carrega o galho.",

	-- Step 44: Forest Song
	-- {area:2358} Forest Song · {npc:3848} Kayneth Stillwind
	["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} stands there."] = "{area:2358}, o posto avançado dos elfos noturnos no extremo leste da estrada: {npc:3848} fica lá.",

	-- Step 45: The Dor'Danil Barrow Den: kill these as you meet them
	-- {area:432} The Dor'Danil Barrow Den
	["{area:432}: kill these as you meet them"] = "",
	-- {area:2358} Forest Song
	["The Forsaken's camp lies in the woods south of {area:2358}.\nRusty chests lie around the Shadethicket furbolg camps west of the Forsaken; open them until one holds the pommel.\nCareful: Non-elite Forsaken of about level 28-30 guard the camp. Some of them are stealthed, and the ones around the table often aggro together."] = "",

	-- Step 46: Fallen Sky Lake
	-- {npc:3931} Shadethicket Oracle · {quest:1035} Fallen Sky Lake · {object:669176} Gleaming Crescent Pendant
	["The {npc:3931} walks the shore of {quest:1035}, south-west of the chests; the {object:669176} lies north of the lake, on the way.\nCareful: Other mobs, some of them underwater, sit near the island. Clear them first so they don't join the fight when you pull the Oracle."] = "",
	-- {object:669176} Gleaming Crescent Pendant · {npc:3961} Maliynn · {area:415} Astranaar
	["{object:669176}: for {npc:3961} in {area:415}"] = "{object:669176}: para {npc:3961} em {area:415}",

	-- Step 48: Insane druids
	["Insane druids"] = "Druidas insanos",
	-- {area:2358} Forest Song
	["The three druids stand together at the Forsaken camp south of {area:2358}.\nCareful: The den has many mobs that respawn quickly, including stealthed undead and patrols, so extra mobs often join a fight."] = "",
	-- {npc:3940} Taneel Darkwood · {area:432} The Dor'Danil Barrow Den
	["{npc:3940}, inside {area:432}"] = "",
	-- {npc:3941} Uthil Mooncall · {area:432} The Dor'Danil Barrow Den
	["{npc:3941}, inside {area:432}"] = "",
	-- {npc:3942} Mavoris Cloudsbreak · {area:432} The Dor'Danil Barrow Den
	["{npc:3942}, inside {area:432}"] = "",

	-- Step 49: Satyrnaar
	-- {object:19901} Circle of Imprisonment · {area:430} Satyrnaar · {area:428} Night Run
	-- plural, as words: Felmusk Rogues = {npc:3759} Felmusk Rogue
	["The {object:19901} stands in the satyr camp of {area:430}, further east along the road.\nCareful: The Felmusk Rogues in {area:428} often go stealthed, and {area:430} has satyr casters."] = "",

	-- Step 51: Night Run
	-- {object:19901} Circle of Imprisonment · {area:428} Night Run
	["The second {object:19901} lies in the valley of {area:428}, on the way west."] = "O segundo {object:19901} fica no vale de {area:428}, no caminho para oeste.",

	-- Step 53: Hidden Shrine
	["The shrine sits on the hill just south-east of the moonwell; follow the winding path up."] = "O santuário fica na colina logo a sudeste do poço lunar; suba pela trilha sinuosa.",

	-- Step 56: Krolg
	-- {npc:3897} Krolg · {area:421} Mystral Lake
	["{npc:3897}, a furbolg untouched by the corruption, sits south of the road below {area:421}."] = "{npc:3897}, um furbolg intocado pela corrupção, fica ao sul da estrada abaixo de {area:421}.",

	-- Step 57: Ran Bloodtooth
	-- {npc:3696} Ran Bloodtooth · {npc:3897} Krolg
	["{npc:3696} and his guards camp just east of {npc:3897}.\nCareful: Wolves and spiders roam near the camp and can join a fight. Some of the wolves come in pairs."] = "",

	-- Step 59: Melyria and Illiyana
	-- {npc:3897} Krolg · {area:416} Shrine of Aessina · {npc:3901} Illiyana
	["West from {npc:3897} along the southern hills to the {area:416}: Melyria and {npc:3901} stand together by it."] = "",

	-- Step 60: Delgren the Purifier
	-- {area:413} Maestra's Post
	["North to {area:413}."] = "",

	-- Step 61: Astranaar
	-- {area:415} Astranaar · {npc:3691} Raene Wolfrunner · {npc:3961} Maliynn · {npc:3894} Pelturas Whitemoon
	["South-east along the road to {area:415}: {npc:3691} in the inn, {npc:3961} and {npc:3894} inside, the flight master at the west end."] = "",

	-- Step 62: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "",
	-- {area:415} Astranaar
	["{area:415} flight master"] = "",

	-- Step 64: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "",
	-- {npc:1571} Shellei Brondir
	["{npc:1571} is the flight master by Menethil's inn."] = "",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "",

	-- Step 66: Ironforge priests
	-- {zone:1455} Ironforge
	["{zone:1455} priests"] = "Sacerdotes de {zone:1455}",
	-- {npc:11406} High Priest Rohan · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries (no name in this language: may be words) · {object:32362} Mystic Ward (no name in this language: may be words)
	["{npc:11406} and {npc:258785} are in the {object:32386}, in the {object:32362}."] = "{npc:11406} e {npc:258785} estão no {object:32386}, na {object:32362}.",

	-- Step 67: Tram to Stormwind City
	-- {zone:1453} Stormwind City
	["Tram to {zone:1453}"] = "",

	-- Step 68: Cathedral of Light
	["Cathedral of Light"] = "Catedral da Luz",
	-- {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind City · {object:28027} Dwarven District · {object:2098} Cathedral Square
	["Take the {area:2257} from {object:171524} to {zone:1453}'s {object:28027}, then walk to the {object:2098}."] = "Pegue o {area:2257} em {object:171524} até o {object:28027} de {zone:1453}, depois ande até a {object:2098}.",
	-- {npc:4982} Thomas
	["{npc:4982}, in the Cathedral of Light"] = "{npc:4982}, na Catedral da Luz",

	-- Step 69: Stormwind Keep
	-- {quest:337} An Old History Book · {zone:1431} Duskwood
	["Only if you looted {quest:337} in {zone:1431}"] = "Só se você saqueou {quest:337} em {zone:1431}",

	-- Step 70: Lord Grayson Shadowbreaker
	-- {npc:928} Lord Grayson Shadowbreaker
	["Back to the Cathedral of Light: {npc:928} stands inside."] = "De volta à Catedral da Luz: {npc:928} fica lá dentro.",
	-- {npc:2228} Lieutenant Farren Orinelle · {area:271} Southshore
	["For {npc:2228} in {area:271}: keep it"] = "Para {npc:2228} em {area:271}: guarde-o",

	-- Step 71: Jorgen and Elling Trias
	-- {npc:4959} Jorgen · {npc:482} Elling Trias
	["{npc:4959} and {npc:482}"] = "{npc:4959} e {npc:482}",
	-- {npc:482} Elling Trias · {object:2096} Trade District
	["{npc:482}, the cheese shop in the {object:2096}"] = "{npc:482}, a loja de queijos no {object:2096}",

	-- Step 72: Trade District
	-- {area:42} Darkshire
	["Next: fly to {area:42}."] = "Próximo: voe até {area:42}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{item:2594}, from {npc:1464}"] = "{item:2594}, de {npc:1464}",
}
