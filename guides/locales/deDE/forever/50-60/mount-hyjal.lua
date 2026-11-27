-- German (deDE): the guide forever/50-60/mount-hyjal (forever/50-60/mount-hyjal.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1451} Silithus
	["About 100 quests in Forever's new endgame zone, 57 to 59, then on to {zone:1451}."] = "Etwa 100 Quests in Forevers neuer Endgame-Zone, Stufe 57 bis 59, dann weiter nach {zone:1451}.",

	-- Step 1: Into Mount Hyjal
	-- {area:616} Mount Hyjal
	["Into {area:616}"] = "Nach {area:616}",
	-- {area:616} Mount Hyjal · {zone:1452} Winterspring · {area:2255} Everlook · {npc:256222} Ketharas · {area:493} Moonglade · {area:2249} Frostwhisper Gorge · {area:2256} Darkwhisper Gorge · {npc:10201} Lady Hederine
	-- plural, as words: Frostmaul Giants = {npc:7428} Frostmaul Giant · Hederine Slayers = {npc:7463} Hederine Slayer
	["New in Forever: this guide follows what players did on {area:616}. If a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\n{area:616} lies south of {zone:1452}. Fly to {area:2255} (from Theramore on the Alliance route; the Horde route already ends there), bind your Hearthstone at the inn (partway through this guide {npc:256222} sends you to {area:493}, and the way there starts in {area:2255}), then ride south down the road through {area:2249} and on through {area:2256}, which leads up into {area:616}.\nCareful: elites stand along the whole way in. Frostmaul Giants and Preservers (59-60) flank the road through {area:2249}, and Hederine Slayers, Initiates and Manastalkers (57-58) line {area:2256} from its mouth to the zone line, with {npc:10201} (61) on its east side. Follow the arrows' line at full speed, never stop or fight on the way, and don't turn off it."] = "Neu in Forever: Dieser Guide folgt dem, was Spieler in {area:616} getan haben. Wenn ein Schritt falsch ist, sag es uns auf Polestars Discord oder GitHub und nenne den Schritt.\n{area:616} liegt südlich von {zone:1452}. Fliege nach {area:2255} (von Theramore auf der Allianzroute; die Hordenroute endet dort bereits), leg deinen Ruhestein an der Gaststätte an (im Verlauf dieses Guides schickt dich {npc:256222} nach {area:493}, und der Weg dorthin beginnt in {area:2255}), dann reite die Straße nach Süden durch {area:2249} und weiter durch {area:2256}, das hinauf nach {area:616} führt.\nVorsicht: Auf dem ganzen Weg hinein stehen Elitegegner. Frosthagelriese und Frosthagelbewahrer (59-60) säumen die Straße durch {area:2249}, und Töter von Hederine, Initianden von Hederine und Manapirscher von Hederine (57-58) säumen {area:2256} von seiner Mündung bis zur Zonengrenze, mit {npc:10201} (61) an seiner Ostseite. Folge der Linie des Pfeils in vollem Galopp, halt nicht an und kämpfe nicht unterwegs, und weiche ihr nicht von der Seite.",
	-- {area:2249} Frostwhisper Gorge
	["The road through {area:2249}"] = "Die Straße durch {area:2249}",
	-- {area:2256} Darkwhisper Gorge
	["The mouth of {area:2256}"] = "Die Mündung von {area:2256}",
	["Turn west here"] = "Bieg hier nach Westen ab",

	-- Step 2: The road in
	["The road in"] = "Die Straße hinein",
	-- {npc:266803} Quintus Wainworth · {npc:266802} Thark Gorax
	["{npc:266803} (Alliance) and {npc:266802} (Horde) wait together by the road a little inside the zone."] = "{npc:266803} (Allianz) und {npc:266802} (Horde) warten zusammen an der Straße, ein Stück in die Zone hinein.",
	-- {quest:96833} Venom Maws · {npc:256222} Ketharas
	["{quest:96833}: for {npc:256222}, the hermit"] = "{quest:96833}: für {npc:256222}, den Einsiedler",
	-- {quest:96830} Farsight Guided · {npc:244512} Ortak Lomgok · {area:16848} Elderwild
	["{quest:96830}: for {npc:244512} in {area:16848}, later in this guide; keep it"] = "{quest:96830}: für {npc:244512} in {area:16848}, später in diesem Guide; behalte ihn",

	-- Step 3: Loose Cog
	-- {npc:256222} Ketharas
	["The cog lies by the path south-west of the camp, on your way to {npc:256222}."] = "Das Zahnrad liegt am Pfad südwestlich des Lagers, auf dem Weg zu {npc:256222}.",

	-- Step 4: Ketharas
	-- {npc:256222} Ketharas
	["{npc:256222}, the hermit, lives at the Hermit's Abode a little further south-west. He takes the cog too."] = "{npc:256222}, der Einsiedler, lebt in der Einsiedlerhütte ein Stück weiter südwestlich. Er nimmt das Zahnrad auch an.",
	-- {quest:96796} Woods Workshop · {npc:249235} Kaylaena Springwhisper
	["{quest:96796}: for {npc:249235}, on the way"] = "{quest:96796}: für {npc:249235}, unterwegs",

	-- Step 5: Seeds and owl eggs
	["Seeds and owl eggs"] = "Samen und Eiereier",
	-- {npc:266803} Quintus Wainworth · {npc:266802} Thark Gorax
	["The seeds and the owl eggs lie on the slopes between the Hermit's Abode and the road you came in on: search north-east up towards {npc:266803} and {npc:266802}."] = "Die Samen und die Eiereier liegen auf den Hängen zwischen der Einsiedlerhütte und der Straße, durch die du gekommen bist: Suche nach Nordosten hinauf in Richtung {npc:266803} und {npc:266802}.",

	-- Step 7: Kaylaena Springwhisper's workshop
	-- {npc:249235} Kaylaena Springwhisper
	["{npc:249235}'s workshop"] = "Die Werkstatt von {npc:249235}",
	-- {npc:249235} Kaylaena Springwhisper · {quest:91923} Celastrus the Bitter · {npc:248709} Sunderbark
	["North-west over the shrub field to {npc:249235}'s workshop on the slope above it. {quest:91923}, an elite (level 57), patrols the field, and {npc:248709}, an elite ancient (level 56), stands in its middle: give both room. Ghansurok, an elite chimaera (level 61), prowls around the workshop itself: see where he is before you ride up to {npc:249235}."] = "Nach Nordwesten über das Strauchfeld zur Werkstatt von {npc:249235} auf dem Hang darüber. {quest:91923}, ein Elite (Stufe 57), patrouilliert über dem Feld, und {npc:248709}, ein uralter Elite (Stufe 56), steht in seiner Mitte: Lass beiden Raum. Ghansurok, eine Chimäre (Elite, Stufe 61), streift um die Werkstatt selbst herum: Sieh, wo er ist, bevor du zu {npc:249235} hinaufreitest.",
	-- {quest:92008} Premiere Parts · {npc:228216} Nami · {area:2255} Everlook · {area:493} Moonglade
	["{quest:92008}: for {npc:228216} in {area:2255}; you go there from {area:493} at the end of this guide"] = "{quest:92008}: für {npc:228216} in {area:2255}; du kommst am Ende dieses Guides von {area:493} dorthin",

	-- Step 8: The ancients' outpost
	["The ancients' outpost"] = "Der Außenposten der Uralten",
	-- {npc:248395} Tainted Shrubbery · {item:247892} Verdant Leaves · {npc:248367} Hyacinth · {quest:91755} Leaves to Ligatures · {npc:249235} Kaylaena Springwhisper · {npc:260626} Bluebell · {npc:265586} Thylaen · {npc:248366} Fraxinus
	["South down the west side of the shrub field to the ancients' outpost. Leave the {npc:248395} for now: their {item:247892} drop only once {npc:248367}'s {quest:91755} is in your log, and the guide brings you back to the shrub field for the leaves and {npc:249235}'s kills together. {npc:260626}, the flight mistress, waits by the outpost; {npc:248367} and {npc:265586} stand with the ancient {npc:248366}."] = "Nach Süden an der Westseite des Strauchfelds entlang zum Außenposten der Urtume. Lass die {npc:248395} vorerst in Ruhe: Ihre {item:247892} fallen erst, wenn {quest:91755} von {npc:248367} in deinem Questlog ist, und der Guide bringt dich für die Blätter und die Kills für {npc:249235} zusammen zurück zum Strauchfeld. {npc:260626}, die Flugmeisterin, wartet beim Außenposten; {npc:248367} und {npc:265586} stehen beim Urtum {npc:248366}.",

	-- Step 9: Celastrus the Bitter
	-- {quest:91923} Celastrus the Bitter
	["{quest:91923} is elite (level 57) and patrols the shrub field: grouping up is advised."] = "{quest:91923} ist Elite (Stufe 57) und patrouilliert über dem Strauchfeld: Eine Gruppe ist ratsam.",

	-- Step 10: Soil and venison
	["Soil and venison"] = "Erde und Hirschfleisch",
	-- {npc:256222} Ketharas · {npc:248709} Sunderbark
	-- plural, as words: Hyjal Stags = {npc:248041} Hyjal Stag
	["The untainted soil lies in the fields south and east of the outpost; Hyjal Stags graze there too, and their venison is for {npc:256222}'s stew.\nCareful: {npc:248709} (56), an elite treant, walks the fields to the south-east around 60,78: give him room."] = "Der unberührte Boden liegt auf den Feldern südlich und östlich des Außenpostens; Hyjalhirsche weiden dort auch, und ihr Fleisch ist für den Eintopf von {npc:256222}.\nVorsicht: {npc:248709} (56), ein Elite-Treant, läuft über die Felder südöstlich um 60,78: Lass ihm Raum.",

	-- Step 11: The three wrecks
	["The three wrecks"] = "Die drei Wracks",
	-- {npc:256222} Ketharas · {item:269944} Bag of Enchanted Seeds
	["The three wrecks {npc:256222} named lie at the east end of the fields: use the {item:269944} beside each, the catapult and the flying machine first, then the ballista a little north of them."] = "Die drei von {npc:256222} genannten Wracks liegen am östlichen Ende der Felder: Benutze das {item:269944} bei jedem, zuerst beim Katapult und bei der Flugmaschine, dann bei der Ballista etwas nördlich davon.",
	-- {item:269944} Bag of Enchanted Seeds · {npc:266887} Ruined Catapult
	["{item:269944}: the {npc:266887}"] = "{item:269944}: der {npc:266887}",
	-- {item:269944} Bag of Enchanted Seeds · {npc:266886} Ruined Flying Machine
	["{item:269944}: the {npc:266886}"] = "{item:269944}: der {npc:266886}",
	-- {item:269944} Bag of Enchanted Seeds · {npc:262036} Ruined Ballista
	["{item:269944}: the {npc:262036}"] = "{item:269944}: der {npc:262036}",

	-- Step 12: The shrub field
	["The shrub field"] = "Das Strauchfeld",
	-- {npc:248395} Tainted Shrubbery · {quest:91923} Celastrus the Bitter · {npc:248709} Sunderbark
	-- plural, as words: Scarlet Dart Tubers = {item:267289} Scarlet Dart Tuber
	["North into the shrub field: the {npc:248395} drop the leaves, and the Scarlet Dart Tubers grow in the open ground, most of them in the field's western half. Keep clear of {quest:91923} and {npc:248709}, the field's elites."] = "Nach Norden in das Buschfeld: Die {npc:248395} lassen die Blätter fallen, und die Scharlachroten Wurmknollen wachsen im offenen Gelände, die meisten in der westlichen Hälfte des Feldes. Halte dich von {quest:91923} und {npc:248709} fern, den Elites des Feldes.",

	-- Step 13: Celastrus the Bitter
	-- {quest:91923} Celastrus the Bitter
	["{quest:91923} is elite: grouping up is advised. He walks the shrub field."] = "{quest:91923} ist Elite: Eine Gruppe ist ratsam. Er läuft durch das Strauchfeld.",

	-- Step 14: Ketharas
	["South-east back to the Hermit's Abode."] = "Nach Südosten zurück zur Einsiedlerhütte.",

	-- Step 15: Ketharas's shrine
	-- {npc:256222} Ketharas
	["{npc:256222}'s shrine"] = "Der Schrein von {npc:256222}",
	["The shrine is a pair of standing stones west of the Hermit's Abode, on the way back to the outpost: bury the remains there."] = "Der Schrein ist ein Paar aufrechter Steine westlich der Einsiedlerhütte, auf dem Weg zurück zum Außenposten: Begrab die Überreste dort.",

	-- Step 17: The ancients' outpost
	["West to the outpost."] = "Nach Westen zum Außenposten.",
	-- {npc:248366} Fraxinus
	["put the poultice on {npc:248366}"] = "lege den Umschlag auf {npc:248366}",

	-- Step 19: Fine Feathered Friend
	-- {quest:91923} Celastrus the Bitter · {npc:248366} Fraxinus · {quest:95766} Fine Feathered Friend · {npc:257753} Curious Crow · {area:17050} Felblood Scar
	["With {quest:91923} handed in, {npc:248366} offers {quest:95766}: the {npc:257753} at {area:17050} takes it later in this guide."] = "Ist {quest:91923} abgegeben, bietet {npc:248366} {quest:95766} an: den {npc:257753} bei {area:17050} nimmt später in diesem Guide.",

	-- Step 20: The Dying Ancients
	-- {npc:248709} Sunderbark
	["{npc:248709} is an elite corrupted ancient (level 56) in the middle of the shrub field, back east: grouping up is advised."] = "{npc:248709} ist ein verderbter Uralter (Elite, Stufe 56) in der Mitte des Strauchfelds, zurück nach Osten: Eine Gruppe ist ratsam.",

	-- Step 21: Sunderbark
	-- {npc:248709} Sunderbark
	["{npc:248709} is elite: grouping up is advised."] = "{npc:248709} ist Elite: Eine Gruppe ist ratsam.",
	["plant the seed in his remains"] = "pflanze den Samen in seine Überreste",

	-- Step 23: The Curious Crow
	-- {npc:257753} Curious Crow
	["The {npc:257753}"] = "Der {npc:257753}",
	-- {area:17050} Felblood Scar · {npc:257753} Curious Crow
	["West of the outpost to {area:17050}: the {npc:257753} perches at its southern end."] = "Westlich des Außenpostens nach {area:17050}: Der {npc:257753} sitzt an dessen südlichem Ende.",

	-- Step 24: Felflick
	-- {npc:263757} Felflick
	["North to {npc:263757}, a demon caged in the middle of the scar. He stood at the spot marked here every time he was met in the recording, south of where the quest data puts him."] = "Nach Norden zu {npc:263757}, einem Dämon, gefangen in der Mitte der Narbe. Er stand jedes Mal an dem hier markierten Punkt, als er in der Aufzeichnung getroffen wurde, südlich davon, wo die Questdaten ihn verorten.",

	-- Step 25: The Ashen camp
	["The Ashen camp"] = "Das Aschcamp",
	-- plural, as words: Ashen Acolytes = {npc:260422} Ashen Acolyte · Awakened Fel Ash Slimes = {npc:264306} Awakened Fel Ash Slime
	["The Ashen Acolytes hold the camp at the north of the scar. Not every Acolyte carries notes: keep killing them after the twelve kills until you have all twelve notes.\nCareful: Awakened Fel Ash Slimes (58, elite) ooze about the scar: pull the Acolytes away from them."] = "Die Aschenakolythen halten das Camp im Norden der Narbe. Nicht jeder Akolyth trägt Notizen: Töte nach den zwölf Löschungen weiter welche, bis du alle zwölf Notizen hast.\nVorsicht: Erwachte Teufelsaschschleime (58, Elite) schleimen durch die Narbe: Zieh die Akolythten von ihnen weg.",

	-- Step 27: Fel-slime crystals
	["Fel-slime crystals"] = "Teufelsschleimkristalle",
	-- {npc:263757} Felflick · {npc:257753} Curious Crow
	["The crystals grow in the scar west and south of {npc:263757}. The pristine one turned up at the scar's southern end, close to the {npc:257753}, at the spot marked."] = "Die Kristalle wachsen in der Narbe westlich und südlich von {npc:263757}. Der unberührte fand sich am südlichen Ende der Narbe, nahe bei {npc:257753}, an dem markierten Punkt.",

	-- Step 28: The Curious Crow
	["The Crow is just south of the pristine crystal."] = "Der Rabe liegt knapp südlich des unberührten Kristalls.",

	-- Step 29: Slime ooze as you go
	["Slime ooze as you go"] = "Schleimreste auf dem Weg",
	-- plural, as words: Noxious Slimes = {npc:243509} Noxious Slime · Awakened Fel Ash Slimes = {npc:264306} Awakened Fel Ash Slime
	["The Noxious Slimes crawl all over the scar's southern half, and not every one leaves ooze: kill the ones you pass from here on.\nCareful: Awakened Fel Ash Slimes (elites, 58) ooze among the slimes: leave them be."] = "Die Giftigen Schleime kriechen in der ganzen südlichen Hälfte der Narbe, und nicht jeder hinterlässt Reste: Töte von hier an die, an denen du vorbeikommst.\nVorsicht: Erwachte Teufelsaschschleime (Elite, 58) schleimen zwischen den Schleimen: Lass sie in Ruhe.",

	-- Step 31: The warlocks
	["The warlocks"] = "Die Hexenmeister",
	-- {npc:260440} Brashann Grimdark
	-- plural, as words: Awakened Fel Ash Slimes = {npc:264306} Awakened Fel Ash Slime
	["The three warlocks and {npc:260440} are in and around the Ashen camp at the north of the scar.\nCareful: Awakened Fel Ash Slimes (58, elite) ooze about the scar: keep clear of them."] = "Die drei Hexenmeister und {npc:260440} sind in und um das Aschcamp im Norden der Narbe.\nVorsicht: Erwachte Teufelsaschschleime (58, Elite) schleimen durch die Narbe: Halte dich von ihnen fern.",

	-- Step 33: The bone pile
	["The bone pile"] = "Der Knochenhaufen",
	-- {npc:264306} Awakened Fel Ash Slime
	["West to the bone pile by the slime pools: throw the warlocks' bones on it, then hand the quest in at the pile itself. Handing it in wakes the {npc:264306}, an elite (level 58) that hits hard: unless you are grouped for it, hand in and ride clear at once."] = "Nach Westen zum Knochenhaufen bei den Schleimtümpeln: Wirf die Knochen der Hexenmeister darauf, dann gib den Quest am Haufen selbst ab. Beim Abgeben erwacht {npc:264306}, ein Elite (Stufe 58), der hart zuschlägt: Wenn du nicht in einer Gruppe dafür bist, gib ab und reite sofort davon.",

	-- Step 34: Amalgamated Marrow
	-- {npc:264306} Awakened Fel Ash Slime
	["The bone pile wakes the {npc:264306}, an elite (level 58) that hits hard: grouping up is advised."] = "Der Knochenhaufen weckt {npc:264306}, ein Elite (Stufe 58), der hart zuschlägt: Eine Gruppe ist ratsam.",

	-- Step 35: Prickly pinecones
	["Prickly pinecones"] = "Stachelige Tannenzapfen",
	["The pinecones lie under the healthy trees just south of the bone pile, on the scar's south-western rim, and a few east of the Crow."] = "Die Tannenzapfen liegen unter den gesunden Bäumen knapp südlich des Knochenhaufens, am südwestlichen Rand der Narbe, und einige östlich des Raben.",

	-- Step 36: Felflick
	-- {npc:263757} Felflick
	["{npc:263757}: decide his fate"] = "{npc:263757}: Entscheide über sein Schicksal",

	-- Step 37: Finish the slime ooze
	["Finish the slime ooze"] = "Besiege die Schleimreste",
	["The slimes are thickest in the scar's south-western corner."] = "Die Schleime sind im südwestlichen Eck der Narbe am dichtesten.",

	-- Step 40: The Ashen workstations
	["The Ashen workstations"] = "Die Aschwerkstationen",
	["Four workstations stand in the Ashen camp: throw a pinecone at each, from the south up."] = "Vier Werkstationen stehen im Aschcamp: Wirf einen Tannenzapfen auf jede, von Süden aus nach oben.",
	["Slime Workstation"] = "Schleim-Werkstation",
	["Alchemy Workstation"] = "Alchemie-Werkstation",
	["Disease Workstation"] = "Seuchen-Werkstation",
	["Vessel Workstation"] = "Gefäß-Werkstation",

	-- Step 41: The Curious Crow
	-- {quest:91881} The Western Post · {npc:244517} Sefira Everbright · {area:16848} Elderwild
	["{quest:91881}: for {npc:244517} in {area:16848}, later in this guide; keep it"] = "{quest:91881}: für {npc:244517} in {area:16848}, später in diesem Guide; behalte ihn",
	-- {quest:91881} The Western Post · {npc:244511} Zet'gan · {area:16848} Elderwild
	["{quest:91881}: for {npc:244511} in {area:16848}, later in this guide; keep it"] = "{quest:91881}: für {npc:244511} in {area:16848}, später in diesem Guide; behalte ihn",

	-- Step 42: Velician
	-- {npc:278305} Velician
	["West across the slope from the scar: {npc:278305} waits alone."] = "Nach Westen über den Hang von der Narbe: {npc:278305} wartet allein.",

	-- Step 44: Ketharas
	["East across the foothills to the Hermit's Abode."] = "Nach Osten über die Vorgebirge zur Einsiedlerhütte.",

	-- Step 45: Fly to Moonglade
	-- {area:493} Moonglade
	["Fly to {area:493}"] = "Fliege nach {area:493}",
	-- {npc:260626} Bluebell · {area:493} Moonglade · {spell:18960} Teleport: Moonglade · {area:1769} Timbermaw Hold · {zone:1452} Winterspring · {zone:1448} Felwood
	["Back west to {npc:260626} at the ancients' outpost and fly to {area:493}. Druids: {spell:18960} is quicker. (No flight path to {area:493} yet? The road in is {area:1769}'s tunnel, from {zone:1452} or {zone:1448}.)"] = "Zurück nach Westen zu {npc:260626} am Außenposten der Uralten und fliege nach {area:493}. Druiden: {spell:18960} ist schneller. (Noch kein Flugpfad nach {area:493}? Der Weg hinein ist der Tunnel von {area:1769}, aus {zone:1452} oder {zone:1448}.)",
	-- {npc:260626} Bluebell
	["{npc:260626}, the flight mistress"] = "{npc:260626}, die Flugmeisterin",

	-- Step 46: Fly to Moonglade
	-- {area:493} Moonglade · {area:2255} Everlook · {area:1769} Timbermaw Hold · {zone:1452} Winterspring
	["Fly to {area:493} from {area:2255}'s flight master. No flight path to {area:493} yet? The way in is the tunnel through {area:1769}, at the western end of {zone:1452}."] = "Fliege von {area:2255} zu {area:493}. Noch kein Flugpfad nach {area:493}? Der Weg hinein ist der Tunnel durch {area:1769}, am westlichen Ende von {zone:1452}.",

	-- Step 47: Dendrite Starblaze
	-- {area:2361} Nighthaven · {npc:11802} Dendrite Starblaze
	["North into {area:2361}: {npc:11802} stands in the north-east of the village, upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Nach Norden in {area:2361}: {npc:11802} steht im Nordosten des Dorfes, im Obergeschoss seines Gebäudes: Geh im Inneren nach oben, der Pfeil kann die Etagen nicht unterscheiden.",

	-- Step 48: Orokai
	-- {npc:216289} Orokai
	["South-west to {npc:216289}, the ancient. Talk to him again when you are ready and watch what he shows you."] = "Nach Südwesten zu {npc:216289}, dem Uralten. Sprich noch einmal mit ihm, wenn du bereit bist, und sieh zu, was er dir zeigt.",
	-- {npc:216289} Orokai
	["{npc:216289}: ready to watch"] = "{npc:216289}: Bereit zum Zusehen",

	-- Step 49: Dendrite Starblaze
	-- {npc:11802} Dendrite Starblaze
	["{npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:11802} steht im Obergeschoss seines Gebäudes: Geh im Inneren nach oben, der Pfeil kann die Etagen nicht unterscheiden.",
	-- {quest:93773} The Pact · {npc:256222} Ketharas
	["{quest:93773}: for {npc:256222}"] = "{quest:93773}: für {npc:256222}",

	-- Step 50: Rabine Saturna
	-- {quest:1123} Rabine Saturna · {area:2361} Nighthaven · {npc:11802} Dendrite Starblaze · {zone:1457} Darnassus
	["{quest:1123}'s house stands in {area:2361}, a short walk from {npc:11802}: hand her the letter from {zone:1457} on the way to the flight master."] = "Das Haus von {quest:1123} steht in {area:2361}, einen kurzen Spaziergang von {npc:11802} entfernt: Gib ihr den Brief aus {zone:1457} auf dem Weg zum Flugmeister.",
	-- {npc:13220} Layo Starstrike · {zone:1451} Silithus
	["For {npc:13220} in {zone:1451}, on the next guide: keep it"] = "Für {npc:13220} in {zone:1451}, im nächsten Guide: behalte ihn",

	-- Step 51: Rabine Saturna
	-- {zone:1457} Darnassus · {quest:1123} Rabine Saturna · {quest:1124} Wasteland · {area:2361} Nighthaven
	["The letter from {zone:1457} is already with {quest:1123}: take {quest:1124} from her, in her house in {area:2361}."] = "Der Brief aus {zone:1457} ist bereits bei {quest:1123}: nimm {quest:1124} von ihr, in ihrem Haus in {area:2361}.",

	-- Step 52: Fly to Everlook
	-- {area:2255} Everlook
	["Fly to {area:2255}"] = "Flieg nach {area:2255}",
	-- {area:493} Moonglade · {area:2255} Everlook · {npc:249235} Kaylaena Springwhisper
	["South to {area:493}'s flight master (the Alliance's at the southern end of the valley, the Horde's at its south-western end) and fly to {area:2255} for {npc:249235}'s parts order."] = "Nach Süden zum Flugmeister von {area:493} (der der Allianz am südlichen Ende des Tals, der der Horde an dessen südwestlichem Ende) und fliege für den Ersatzteileauftrag von {npc:249235} nach {area:2255}.",

	-- Step 53: Nami
	-- {npc:228216} Nami · {area:2255} Everlook · {area:16853} Tainted Foothills · {npc:249235} Kaylaena Springwhisper
	["{npc:228216} stands between {area:2255}'s two flight masters. Her crate holds fragile cells that fizzle out in time and when knocked about: fly straight back to the {area:16853} and take it to {npc:249235} without detours or fights (about four minutes in the recording). If it fizzles out anyway, {npc:228216} fills it again."] = "{npc:228216} steht zwischen den beiden Flugmeistern von {area:2255}. Ihre Kiste hält zerbrechliche Zellen, die mit der Zeit und bei Stößen verpuffen: Fliege direkt zurück zu {area:16853} und bring sie ohne Umwege und Kämpfe zu {npc:249235} (in der Aufzeichnung etwa vier Minuten). Verpufft sie trotzdem, füllt {npc:228216} sie wieder.",

	-- Step 54: Fly to the Tainted Foothills
	-- {area:16853} Tainted Foothills
	["Fly to the {area:16853}"] = "Fliege zu {area:16853}",

	-- Step 55: Kaylaena Springwhisper's workshop
	-- {npc:260626} Bluebell
	["North from {npc:260626} to the workshop, crate first. Watch for Ghansurok, the elite chimaera (level 61) that prowls around the workshop."] = "Von {npc:260626} nach Norden zur Werkstatt, zuerst die Kiste. Achte auf Ghansurok, die Chimäre (Elite, Stufe 61), die um die Werkstatt streift.",
	["deliver the crate before it fizzles"] = "bring die Kiste, bevor sie verpufft",
	-- {quest:92011} Rubble Rummage · {area:16866} Dae'gun
	["{quest:92011}: in {area:16866}, later in this guide; keep it"] = "{quest:92011}: in {area:16866}, später in diesem Guide; behalte ihn",

	-- Step 56: Ketharas
	["South-east to the Hermit's Abode."] = "Nach Südosten zur Einsiedlerhütte.",
	-- {quest:96930} The Capricious Corvid · {npc:257753} Curious Crow
	["{quest:96930}: for the {npc:257753}, later in this guide"] = "{quest:96930}: für den {npc:257753}, später in diesem Guide",
	-- {quest:92171} Taking to New Heights · {npc:254131} Skylord Omnuron
	["{quest:92171}: for {npc:254131}, later in this guide"] = "{quest:92171}: für {npc:254131}, später in diesem Guide",

	-- Step 57: The Curious Crow
	-- {npc:257753} Curious Crow · {area:17050} Felblood Scar
	["West across the foothills, past the ancients' outpost, to the {npc:257753} at the southern end of {area:17050}."] = "Nach Westen über die Vorgebirge, am Außenposten der Uralten vorbei, zum {npc:257753} am südlichen Ende von {area:17050}.",
	-- {quest:96931} Heading Up the Mountain · {area:17145} Cradle of Tranquility
	["{quest:96931}: for the {area:17145}, later in this guide"] = "{quest:96931}: für den {area:17145}, später in diesem Guide",

	-- Step 58: Malorne's Retreat
	-- {area:17144} Malorne's Retreat · {npc:249549} Fenwick Togglespring
	["West along the southern slopes to {area:17144}: {npc:249549}, a gnome test pilot, hangs tangled up in a tree. A sturdy branch lies just south of him."] = "Nach Westen entlang der südlichen Hänge nach {area:17144}: {npc:249549}, ein gnomischer Testpilot, hängt in einem Baum verstrickt. Ein starker Ast liegt knapp südlich von ihm.",
	-- {npc:254501} Tree Branch
	["{npc:254501}, above Fenwick's head"] = "{npc:254501}, über Fenwicks Kopf",

	-- Step 59: Fenwick's survival pack
	["Fenwick's survival pack"] = "Fenwicks Überlebensrucksack",
	["His pack fell just north of the tree. Open it, then wait half a minute while its safety lock discharges before you open it again."] = "Sein Rucksack fiel knapp nördlich des Baums. Öffne ihn, dann wart eine halbe Minute, während seine Sicherheitssperre sich entlädt, bevor du ihn wieder öffnest.",

	-- Step 60: Brerufa
	-- {npc:256978} Brerufa
	["North-west to Barkskin Burrow, the furbolgs' den in the hillside: {npc:256978} waits just north of its mouth. The Barkskin furbolgs show as hostile until your standing with them improves, but none of them attacked in the recording: the Deadwood furbolgs in the camps around are the ones to fight. {npc:256978} offers more only once this first quest is handed in."] = "Nach Nordwesten zur Barkskin-Höhle, dem Bau der Furbolgs im Berghang: {npc:256978} wartet knapp nördlich ihrer Mündung. Die Barkskin-Furbolgs gelten als feindlich, bis dein Ansehen bei ihnen wächst, aber keiner von ihnen griff in der Aufzeichnung an: Die Deadwood-Furbolgs in den Lagern rundherum sind die, gegen die du kämpfst. {npc:256978} bietet mehr erst an, wenn dieser erste Quest abgegeben ist.",

	-- Step 61: Deadwood Den Guardians
	-- plural, as words: Deadwood Den Guardians = {npc:252063} Deadwood Den Guardian
	["Deadwood Den Guardians"] = "Höhlenwächter der Totenwaldfelle",
	-- {npc:256978} Brerufa
	["The Deadwood furbolgs camp on the slopes north and east of {npc:256978}: kill their Den Guardians."] = "Die Deadwood-Furbolgs lagern auf den Hängen nördlich und östlich von {npc:256978}: Töte ihre Hüter des Baus.",

	-- Step 63: Osi Mistpaw
	-- {npc:256646} Osi Mistpaw
	["Inside the burrow: {npc:256646} at the far end."] = "Im Bau: {npc:256646} am hinteren Ende.",

	-- Step 64: Bear berries
	["Bear berries"] = "Bärenbeeren",
	-- {npc:256978} Brerufa
	["The bear berries grow on the slopes around the burrow: a few on the hill north of {npc:256978}, most of them east of the burrow.\nCareful: Grimroot, an elite treant (level 60), walks the slopes west of the burrow, around 16-20,58-66: give him room."] = "Die Bärenbeeren wachsen auf den Hängen um den Bau: einige am Hügel nördlich von {npc:256978}, die meisten östlich des Baus.\nVorsicht: Grimroot, ein Treant (Elite, Stufe 60), läuft die Hänge westlich des Baus entlang, um 16-20,58-66: Lass ihn in Ruhe.",

	-- Step 65: Barkskin Burrow
	["Barkskin Burrow"] = "Barkskin-Höhle",
	-- {npc:260661} Suma Mossmane · {npc:256660} Thobon Sapclaw · {area:16848} Elderwild · {area:16867} Shrine of Aviana
	["Back to Osi, then the two elders at the back of the burrow. {npc:260661} stands beside Osi, {npc:256660} a little north-west of them, where the recording met him. {npc:260661}'s moss grows around {area:16848}, later in this guide; {npc:256660}'s amulets come from the harpies at the {area:16867}, also later in this guide, and you bring both back here then."] = "Zurück zu Osi, dann zu den beiden Ältesten am hinteren Ende des Baus. {npc:260661} steht neben Osi, {npc:256660} ein Stück nordwestlich von ihnen, wo die Aufzeichnung ihn traf. Das Moos von {npc:260661} wächst um {area:16848}, später in diesem Guide; die Amulette von {npc:256660} kommen von den Harpyien bei {area:16867}, ebenfalls später in diesem Guide, und dann bringst du beides hierher zurück.",
	-- {quest:93826} Deal Dread to Deadwood
	["{quest:93826}: on your way back here later; keep it"] = "{quest:93826}: auf dem späteren Rückweg hierher; behalte ihn",

	-- Step 66: The Western Post
	-- {area:16848} Elderwild · {npc:244517} Sefira Everbright · {npc:249968} Hnaz Blunderflame · {npc:244511} Zet'gan · {npc:244512} Ortak Lomgok
	["North up the valley to {area:16848}, where the Alliance outpost ({npc:244517}, {npc:249968}) and the Horde's ({npc:244511}, {npc:244512}) stand next to each other."] = "Das Tal hinauf nach Norden nach {area:16848}, wo der Außenposten der Allianz ({npc:244517}, {npc:249968}) und der der Horde ({npc:244511}, {npc:244512}) nebeneinander stehen.",

	-- Step 67: The Western Post
	-- {area:16848} Elderwild · {npc:244511} Zet'gan · {npc:244512} Ortak Lomgok · {npc:265788} Kal'tinzan
	["North up the valley to {area:16848}, where the Horde outpost ({npc:244511}, {npc:244512}, {npc:265788}) and the Alliance's stand next to each other."] = "Das Tal hinauf nach Norden nach {area:16848}, wo der Außenposten der Horde ({npc:244511}, {npc:244512}, {npc:265788}) und der der Allianz nebeneinander stehen.",

	-- Step 69: Elderwild
	-- {area:16848} Elderwild
	["The two outposts of {area:16848}."] = "Die beiden Außenposten von {area:16848}.",
	-- {npc:244512} Ortak Lomgok · {quest:96616} Herbs for the Bruised and Weary · {area:16868} Mourning's Rest
	["{npc:244512}: {quest:96616}, on the way back from {area:16868}"] = "{npc:244512}: {quest:96616}, auf dem Rückweg aus {area:16868}",

	-- Step 70: Final Death
	-- {quest:92591} Final Death · {npc:260148} Scourge Reanimator · {area:16868} Mourning's Rest
	["{quest:92591}'s {npc:260148} is level 59-60: this guide burns its bone pile once you are 58, on one of its two passes through {area:16868}."] = "Der {npc:260148} von {quest:92591} ist Stufe 59-60: Dieser Guide verbrennt seinen Knochenhaufen einmal, wenn du 58 bist, auf einem seiner beiden Wege durch {area:16868}.",

	-- Step 71: Final Death
	-- {quest:92592} Final Death · {npc:260148} Scourge Reanimator · {area:16868} Mourning's Rest
	["{quest:92592}'s {npc:260148} is level 59-60: this guide burns its bone pile once you are 58, on one of its two passes through {area:16868}."] = "Der {npc:260148} von {quest:92592} ist Stufe 59-60: Dieser Guide verbrennt seinen Knochenhaufen, sobald du 58 bist, auf einem seiner beiden Durchgänge durch {area:16868}.",

	-- Step 72: Final Death
	-- {npc:260148} Scourge Reanimator · {quest:92591} Final Death
	["A group choice at your level: the {npc:260148} that answers {quest:92591}'s bone pile is level 59-60."] = "Eine Gruppenwahl auf deiner Stufe: Der {npc:260148}, der zum Knochenhaufen von {quest:92591} gehört, ist Stufe 59-60.",

	-- Step 73: Final Death
	-- {npc:260148} Scourge Reanimator · {quest:92592} Final Death
	["A group choice at your level: the {npc:260148} that answers {quest:92592}'s bone pile is level 59-60."] = "Eine Gruppenwahl auf deiner Stufe: Der {npc:260148}, der zum Knochenhaufen von {quest:92592} gehört, ist Stufe 59-60.",

	-- Step 74: Moonveil Moss
	-- {npc:260661} Suma Mossmane · {area:16848} Elderwild
	["The moss for {npc:260661} grows around {area:16848}: by the outposts and on the slopes north of them."] = "Das Moos für {npc:260661} wächst um {area:16848}: bei den Außenposten und auf den Hängen nördlich von ihnen.",

	-- Step 75: Eluneth
	-- {npc:264089} Eluneth · {area:16868} Mourning's Rest
	["South-east to {npc:264089} on the slope above {area:16868}."] = "Nach Südosten zu {npc:264089} auf dem Hang über {area:16868}.",

	-- Step 76: Owl feathers
	["Owl feathers"] = "Eulenschwingen",
	-- {npc:264089} Eluneth · {area:16848} Elderwild
	-- plural, as words: Hyjal Owls = {npc:249053} Hyjal Owl · Death Wailers = {npc:249226} Death Wailer
	["The Hyjal Owls roost on the slopes between {npc:264089} and Barkskin Burrow: their feathers are for {area:16848}.\nCareful: Death Wailers (61, rare elites) drift over the western slopes: give them a wide berth.\nCareful: Grimroot, an elite treant (level 60), walks the slopes beside {npc:264089}. He leaves you alone unless you hit him: don't, and pull the owls away from his path."] = "Die Hyjal-Eulen nisten an den Hängen zwischen {npc:264089} und Barkskin Burrow: ihre Federn sind für {area:16848}.\nVorsicht: Todesheuler (61, seltene Elites) ziehen über die westlichen Hänge: geh ihnen aus dem Weg.\nVorsicht: Grimroot, ein Elite-Treant (Stufe 60), läuft an den Hängen neben {npc:264089} umher. Er lässt dich in Ruhe, solange du ihn nicht angreifst: tu es nicht und locke die Eulen von seinem Weg weg.",

	-- Step 77: Unmarked Grave
	-- {area:16868} Mourning's Rest
	-- plural, as words: Fleshflay Raveners = {npc:249228} Fleshflay Ravener
	["At the northern end of {area:16868}: something has dug up the grave. The Fleshflay Raveners around it carry what was taken."] = "Am nördlichen Ende von {area:16868}: Etwas hat das Grab ausgegraben. Die Fleischschinderräuber darum tragen das mit, was gestohlen wurde.",

	-- Step 78: Mourning's Rest
	-- {area:16868} Mourning's Rest · {area:16848} Elderwild
	-- plural, as words: Fleshflay Raveners = {npc:249228} Fleshflay Ravener · Forgotten Soldiers = {npc:249247} Forgotten Soldier · Death Wailers = {npc:249226} Death Wailer
	["The Scourge hold the ruins of {area:16868}, east of {area:16848}: Fleshflay Raveners and Forgotten Soldiers everywhere, Eternal Sentries among them.\nCareful: Death Wailers (61, rare elites) drift over {area:16868}: keep out of their way.\nCareful: Grimroot, the elite treant (level 60), walks the slopes on the way in. He leaves you alone unless you hit him: give him room."] = "Die Scourge halten die Ruinen von {area:16868}, östlich von {area:16848}: Fleischschinderräuber und Vergessene Soldaten überall, Eternal Sentries darunter.\nVorsicht: Todesheuler (61, seltene Eliten) ziehen über {area:16868}: Geh ihnen aus dem Weg.\nVorsicht: Grimroot, der Elite-Treant (Stufe 60), läuft auf den Hängen auf dem Weg dorthin umher. Er lässt dich in Ruhe, es sei denn, du greifst ihn an: Gib ihm Raum.",

	-- Step 79: Final Death
	-- {area:16868} Mourning's Rest · {item:274411} Survivor's Torch · {npc:260148} Scourge Reanimator
	["Burn the bone pile at the south-eastern end of {area:16868} with the {item:274411}: the {npc:260148} that answers carries the amulet.\nCareful: the {npc:260148} is level 59-60: burn the bone pile last, at full health, with the ruins around it cleared."] = "Verbrenn den Knochenhaufen am südöstlichen Ende von {area:16868} mit dem {item:274411}: Der {npc:260148}, der antwortet, trägt das Amulett.\nVorsicht: Der {npc:260148} ist Stufe 59-60: Verbrenn den Knochenhaufen als Letztes, bei voller Gesundheit und mit geräumten Ruinen drumherum.",

	-- Step 80: Final Death
	-- {npc:260148} Scourge Reanimator
	["A group choice below level 58: the {npc:260148} that answers the burnt bone pile is level 59-60. Grouping up is advised; alone, this guide comes back past the pile later."] = "Eine Gruppenwahl unter Stufe 58: Der {npc:260148}, der zum verbrannten Knochenhaufen gehört, ist Stufe 59-60. Eine Gruppe ist ratsam; allein kommt dieser Guide später am Haufen vorbei.",

	-- Step 81: Eluneth and the veteran
	-- {npc:264089} Eluneth
	["{npc:264089} and the veteran"] = "{npc:264089} und der Veteran",
	-- {npc:264089} Eluneth · {npc:255009} Veteran of the Third War · {area:16868} Mourning's Rest
	["Back to {npc:264089}, then the ghostly {npc:255009} on your way west. He doesn't keep to one spot: players have met him anywhere in {area:16868} from its western edge (20,60) north-east to about 25,51, so if he isn't at the arrow, look along that line."] = "",

	-- Step 82: Hyjal Silphium
	-- {area:16868} Mourning's Rest · {npc:244512} Ortak Lomgok · {area:16848} Elderwild
	-- plural, as words: Death Wailers = {npc:249226} Death Wailer
	["North-east up the slope from the veteran, north of {area:16868}: {npc:244512}'s silphium grows in the meadows there, where the Horde players in our recordings picked it. Then ride west to {area:16848}.\nCareful: Death Wailers (61, rare elites) drift over these slopes: keep out of their way."] = "Von dem Veteran nach Nordosten den Hang hinauf, nördlich von {area:16868}: Das Silphium für {npc:244512} wächst auf den Wiesen dort, wo die Horde-Spieler in unseren Aufzeichnungen es gepflückt haben. Dann reite nach Westen nach {area:16848}.\nVorsicht: Todesheuler (61, seltene Elite) treiben über diese Hänge: Weiche ihnen aus.",

	-- Step 83: Elderwild
	["West to the Alliance outpost."] = "Nach Westen zum Außenposten der Allianz.",

	-- Step 85: To the Summit of Eternity
	-- {quest:91688} To the Summit of Eternity · {npc:254915} Thisalee Crow
	["{quest:91688}: for {npc:254915}, later in this guide; keep it"] = "{quest:91688}: für {npc:254915}, später in diesem Guide; behalte ihn",

	-- Step 86: Daythor Brellan and Sefira Everbright
	-- {npc:264521} Daythor Brellan · {npc:244517} Sefira Everbright
	["{npc:264521} and {npc:244517}"] = "{npc:264521} und {npc:244517}",
	-- {npc:244517} Sefira Everbright · {npc:264521} Daythor Brellan
	["The worker {npc:244517} means is a peasant just north of her; {npc:264521} stands between them."] = "Die Spur von {npc:244517} führt zu einem Bauern knapp nördlich von ihr; {npc:264521} steht zwischen ihnen.",
	-- {quest:94832} Belle's Ring · {npc:2329} Michelle Belle · {area:87} Goldshire
	["{quest:94832}: {npc:2329} at the Lion's Pride Inn in {area:87}; take it only if you'll pass by"] = "{quest:94832}: {npc:2329} in der Gaststätte „Zum Stolzen Löwen“ in {area:87}; nimm ihn nur an, wenn du vorbeikommst",

	-- Step 87: Elderwild
	-- {npc:244511} Zet'gan · {npc:244512} Ortak Lomgok · {npc:265788} Kal'tinzan
	["West to the Horde outpost: {npc:244511}, then {npc:244512} and {npc:265788} beside him."] = "Nach Westen zum Außenposten der Horde: {npc:244511}, dann {npc:244512} und {npc:265788} neben ihm.",
	-- {npc:265788} Kal'tinzan · {quest:91794} Flags of Our Forebears · {area:16866} Dae'gun
	["{npc:265788}: {quest:91794}: the flag and the heraldry are in {area:16866}, later in this guide; keep it"] = "{npc:265788}: {quest:91794}: Die Fahne und die Wappenarbeit sind in {area:16866}, später in diesem Guide; behalte ihn",

	-- Step 88: Maruke and Enho Runehoof
	-- {npc:265895} Maruke · {npc:265862} Enho Runehoof
	["{npc:265895} and {npc:265862}"] = "{npc:265895} und {npc:265862}",
	-- {npc:244512} Ortak Lomgok · {npc:265895} Maruke · {area:16848} Elderwild · {npc:265862} Enho Runehoof
	["{npc:244512}'s poultice is for two of the outpost's wounded: {npc:265895} lies at the north end of {area:16848}, {npc:265862} just south of {npc:244512}."] = "Der Umschlag von {npc:244512} ist für zwei der Verwundeten des Außenpostens: {npc:265895} liegt am Nordende von {area:16848}, {npc:265862} knapp südlich von {npc:244512}.",

	-- Step 89: Head Scratcher
	-- {quest:92446} Head Scratcher · {npc:244511} Zet'gan
	["{quest:92446} is elite (level 60 in our data): grouping up is advised. {npc:244511}'s rabbit carcass lures him out in the woods by the Deadwood camps south-east of here, on part 3's way back to Barkskin Burrow; his claws come back here at the end of this guide."] = "{quest:92446} ist Elite (Stufe 60 in unseren Daten): Eine Gruppe ist ratsam. Der Kaninchenkadaver von {npc:244511} lockt ihn in den Wäldern bei den Deadwood-Lagern südöstlich von hier heraus, auf dem Rückweg von Teil 3 zur Barkskin-Höhle; seine Klauen kommen am Ende dieses Guides hierher zurück.",

	-- Step 90: The overlook
	["The overlook"] = "Der Aussichtspunkt",
	["West to the overlook above the valley: the veteran's old scabbard lies there. Hand his quest in at the scabbard and take the next from it, then use the scabbard in your bags to call his spirit and listen to his story."] = "Nach Westen zum Aussichtspunkt über dem Tal: Die alte Scheide des Veteranen liegt dort. Gib seinen Quest an der Scheide ab und nimm den nächsten von ihr, dann benutze die Scheide in deiner Tasche, um seinen Geist zu rufen und seine Geschichte zu hören.",

	-- Step 91: Shalla'kal and Galvinquam Leafsyre
	-- {npc:255683} Shalla'kal · {npc:267109} Galvinquam Leafsyre
	["{npc:255683} and {npc:267109}"] = "{npc:255683} und {npc:267109}",
	-- {area:16868} Mourning's Rest · {area:17145} Cradle of Tranquility · {npc:255683} Shalla'kal · {npc:267109} Galvinquam Leafsyre
	["East past {area:16868} into the {area:17145}: {npc:255683}, the great cat, waits by the path, and {npc:267109} rests in the ruins just south of her."] = "Nach Osten an {area:16868} vorbei in den {area:17145}: {npc:255683}, die große Katze, wartet am Pfad, und {npc:267109} ruht in den Ruinen knapp südlich von ihr.",

	-- Step 92: Lisbael Highfeather
	-- {npc:268168} Lisbael Highfeather
	["East across the Cradle to {npc:268168}."] = "Nach Osten über die Wiege zu {npc:268168}.",
	-- {quest:96145} Past Wing and Claw · {npc:260825} Phoebe Highfeather
	["{quest:96145}: for {npc:260825}, later in this guide; keep it"] = "{quest:96145}: für {npc:260825}, später in diesem Guide; behalte ihn",

	-- Step 93: Jereman
	-- {npc:267158} Jereman
	["North to the old bridge over the Cradle: touch the crow effigy on it and {npc:267158}, the crow wild god, appears."] = "Nach Norden zur alten Brücke über die Wiege: Berühre das Raben-Effigie auf ihr, und {npc:267158}, der Wilde Gott der Raben, erscheint.",

	-- Step 94: The falls and the first kitten
	["The falls and the first kitten"] = "Die Fälle und das erste Kätzchen",
	-- {npc:267109} Galvinquam Leafsyre · {npc:255685} Solstice · {npc:255683} Shalla'kal
	["Fill {npc:267109}'s gourd at the falls beside the bridge. {npc:255685}, one of {npc:255683}'s kittens, plays just west of the falls: walk up to her."] = "Füll die Kürbisflasche von {npc:267109} an den Fällen neben der Brücke. {npc:255685}, eines der Kätzchen von {npc:255683}, spielt knapp westlich der Fälle: Geh zu ihr.",
	["fill the gourd"] = "füll die Kürbisflasche",

	-- Step 95: Johun "Punchy" Dillas's camp
	-- {npc:249234} Johun "Punchy" Dillas
	["{npc:249234}'s camp"] = "Das Camp von {npc:249234}",
	-- {npc:249234} Johun "Punchy" Dillas
	["North to {npc:249234} and his crates. Drive the skunks out from behind the crates without attacking them."] = "Nach Norden zu {npc:249234} und seinen Kisten. Treib die Stinktiere hinter den Kisten hervor, ohne sie anzugreifen.",

	-- Step 96: Brie
	-- {npc:255773} Brie · {npc:249234} Johun "Punchy" Dillas
	["{npc:255773}, the second kitten, plays just west of {npc:249234}'s camp."] = "{npc:255773}, das zweite Kätzchen, spielt knapp westlich des Camps von {npc:249234}.",

	-- Step 97: Foxes
	["Foxes"] = "Füchse",
	-- {npc:249234} Johun "Punchy" Dillas · {npc:255183} Jezerelle the Swaying · {npc:256830} Bannerwing Survivor
	["The Rustleaf Foxes are thick in the woods around {npc:249234}'s camp.\nCareful: {npc:255183} (61, rare) walks the woods north of the camp, and a {npc:256830} (60, rare) can turn up there too: leave them be."] = "Die Rostblattfüchse sind zahlreich in den Wäldern um das Lager von {npc:249234}.\nVorsicht: {npc:255183} (61, selten) streift durch die Wälder nördlich des Lagers, und ein {npc:256830} (60, selten) kann dort ebenfalls auftauchen: lass sie in Ruhe.",

	-- Step 99: Kala'th
	-- {npc:255693} Kala'th
	["West across the Cradle to {npc:255693}, another of the wild gods."] = "Nach Westen über die Wiege zu {npc:255693}, einem weiteren der Wilden Götter.",

	-- Step 100: The burnt buildings
	["The burnt buildings"] = "Die abgebrannten Gebäude",
	-- {npc:255693} Kala'th
	["The burnt buildings stand in the meadows east of {npc:255693}: the nails and brackets lie among the rubble."] = "Die abgebrannten Gebäude stehen auf den Wiesen östlich von {npc:255693}: Die Nägel und Winkel liegen zwischen dem Schutt.",

	-- Step 101: Predatory stags
	["Predatory stags"] = "Raubhirsche",
	-- {npc:255693} Kala'th
	-- plural, as words: Predatory Hyjal Stags = {npc:256809} Predatory Hyjal Stag · Spectral Frostwyrms = {npc:255691} Spectral Frostwyrm
	["The Predatory Hyjal Stags roam the same meadows, east of {npc:255693}.\nCareful: Spectral Frostwyrms (61, elites) circle over the western meadows: keep out from under them."] = "Die Räuberische Hyjalhirsche streifen über dieselben Wiesen, östlich von {npc:255693}.\nVorsicht: Spektrale Frostwyrme (61, Elite) kreisen über den westlichen Wiesen: Bleib nicht unter ihnen stehen.",

	-- Step 103: Marrosis
	-- {npc:267113} Marrosis · {area:16868} Mourning's Rest
	["South to {npc:267113}, another wild god, at {area:16868}'s eastern edge."] = "Nach Süden zu {npc:267113}, einem weiteren Wilden Gott, am östlichen Rand von {area:16868}.",
	-- {quest:92317} Stolen Life · {npc:256222} Ketharas
	["{quest:92317}: for {npc:256222}, later in this guide; keep it"] = "{quest:92317}: für {npc:256222}, später in diesem Guide; behalte ihn",

	-- Step 104: Bones and stolen life
	["Bones and stolen life"] = "Knochen und gestohlenes Leben",
	-- {area:16868} Mourning's Rest
	-- plural, as words: Fleshflay Raveners = {npc:249228} Fleshflay Ravener · Death Wailers = {npc:249226} Death Wailer · Spectral Frostwyrms = {npc:255691} Spectral Frostwyrm
	["The sun-bleached bones lie all over {area:16868}; the Fleshflay Raveners there carry the drop of stolen life.\nCareful: Death Wailers (61, rare elites) drift over {area:16868}: keep out of their way. Spectral Frostwyrms (61, elites) circle over the meadows around it: keep out from under them."] = "Die sonnenbleichen Knochen liegen überall in {area:16868}; die Fleischschinderräuber dort tragen den Tropfen des gestohlenen Lebens.\nVorsicht: Todesheuler (61, seltene Elite) treiben über {area:16868}: Weiche ihnen aus. Spektrale Frostwyrme (61, Elite) kreisen über die Wiesen drumherum: Bleib nicht unter ihnen stehen.",

	-- Step 105: Final Death
	-- {area:16868} Mourning's Rest · {item:274411} Survivor's Torch · {npc:260148} Scourge Reanimator · {area:16848} Elderwild
	["Burn the bone pile at the south-eastern end of {area:16868} with the {item:274411}: the {npc:260148} that answers carries the amulet. The hand-in waits for the ride back to {area:16848} at the end of this guide.\nCareful: the {npc:260148} is level 59-60: burn the bone pile last, at full health, with the ruins around it cleared."] = "Verbrenn den Knochenhaufen am südöstlichen Ende von {area:16868} mit dem {item:274411}: Der {npc:260148}, der antwortet, trägt das Amulett. Das Abgeben wartet auf die Rückreise nach {area:16848} am Ende dieses Guides.\nVorsicht: Der {npc:260148} ist Stufe 59-60: Verbrenn den Knochenhaufen als Letztes, bei voller Gesundheit und mit geräumten Ruinen drumherum.",

	-- Step 106: Final Death
	-- {npc:260148} Scourge Reanimator · {area:16848} Elderwild
	["A group choice below level 58: the {npc:260148} that answers the burnt bone pile is level 59-60. Grouping up is advised. The hand-in waits for the ride back to {area:16848} at the end of this guide."] = "Eine Gruppenwahl unter Stufe 58: Der {npc:260148}, der zum verbrannten Knochenhaufen gehört, ist Stufe 59-60. Eine Gruppe ist ratsam. Das Abgeben wartet auf die Rückreise nach {area:16848} am Ende dieses Guides.",

	-- Step 107: Final Death
	-- {npc:260148} Scourge Reanimator · {npc:244511} Zet'gan · {area:16848} Elderwild
	["A group choice below level 58: the {npc:260148} that answers the burnt bone pile is level 59-60. Grouping up is advised. {npc:244511} takes the amulet on the ride back to {area:16848} at the end of this guide."] = "Eine Gruppenwahl unter Stufe 58: Der {npc:260148}, der zum verbrannten Knochenhaufen gehört, ist Stufe 59-60. Eine Gruppe ist ratsam. {npc:244511} nimmt das Amulett auf der Rückreise nach {area:16848} am Ende dieses Guides an sich.",

	-- Step 109: Whisperfur
	-- {npc:255771} Whisperfur · {area:16868} Mourning's Rest
	["The last kitten, {npc:255771}, plays at the southern end of {area:16868}."] = "Das letzte Kätzchen, {npc:255771}, spielt am südlichen Ende von {area:16868}.",

	-- Step 110: Shalla'kal and Galvinquam Leafsyre
	-- {npc:255683} Shalla'kal · {npc:267109} Galvinquam Leafsyre
	["North to {npc:255683}, then {npc:267109} in the ruins south of her."] = "Nach Norden zu {npc:255683}, dann zu {npc:267109} in den Ruinen südlich von ihr.",

	-- Step 111: Corrupted Growth
	-- {area:16867} Shrine of Aviana · {npc:260825} Phoebe Highfeather
	["East from the Cradle towards the {area:16867}, where the Wormwing harpies nest: a corrupted growth on the shrine's western slope starts a quest for {npc:260825}."] = "Von der Wiege nach Osten in Richtung {area:16867}, wo die Wurmflügel-Harpyien nisten: Ein verderbtes Gewächs am westlichen Hang des Schreins startet einen Quest für {npc:260825}.",
	["remove the corrupted knots on the trees just north-west of the shrine, on your way"] = "entferne die verderbten Knollen an den Bäumen knapp nordwestlich des Schreins, auf dem Weg",

	-- Step 112: Skylord Omnuron
	-- {npc:254131} Skylord Omnuron · {npc:260825} Phoebe Highfeather · {area:16867} Shrine of Aviana
	["{npc:254131} and {npc:260825} stand together at the {area:16867}."] = "{npc:254131} und {npc:260825} stehen zusammen bei {area:16867}.",
	-- {quest:92500} A Bit of the Sky · {npc:256222} Ketharas
	["{quest:92500}: for {npc:256222}, later in this guide"] = "{quest:92500}: für {npc:256222}, später in diesem Guide",

	-- Step 114: The Shrine of Aviana
	-- {area:16867} Shrine of Aviana
	["The {area:16867}"] = "Der {area:16867}",

	-- Step 115: The harpy grounds
	["The harpy grounds"] = "Das Harpyienrevier",
	-- {npc:256660} Thobon Sapclaw · {object:650219} Jewel of the Horizon (no name in this language: may be words) · {npc:260826} Zarrat Wormwing
	["The Wormwing harpies nest on the slopes north-west of the shrine. They drop the pinfeathers and {npc:256660}'s amulets; the bangles lie in their nests, the {object:650219} in a nest on the western slope, and {npc:260826}, who has Omnuron's spear, is among them. The corrupted knots grow on the trees just north-west of the shrine."] = "Die Wurmflügel-Harpyien nisten auf den Hängen nordwestlich des Schreins. Sie lassen die Federspitzen und die Amulette von {npc:256660} fallen; die Armbänder liegen in ihren Nestern, das {object:650219} in einem Nest auf dem westlichen Hang, und {npc:260826}, der Omnurons Speer hat, ist unter ihnen. Die verderbten Knollen wachsen an den Bäumen knapp nordwestlich des Schreins.",

	-- Step 117: The way into the Deadwood camps
	["The way into the Deadwood camps"] = "Der Weg in die Totenwaldfell-Lager",
	-- {area:17144} Malorne's Retreat · {area:16868} Mourning's Rest
	["The Deadwood camps fill {area:17144}, a sunken valley whose northern end runs in under the cliffs: there is no way down into it from {area:16868}. Go round to the valley's mouth in the south-east and follow it west, then north up into the camps, as players do."] = "Die Totenwaldfell-Lager füllen {area:17144}, ein eingesunkenes Tal, dessen Nordende unter die Klippen führt: von {area:16868} aus gibt es keinen Weg hinab. Geh um das Tal herum zum Eingang im Südosten, folge ihm nach Westen und dann nach Norden in die Lager, wie es die Spieler tun.",
	-- {area:17144} Malorne's Retreat
	["the mouth of the valley up into {area:17144}"] = "der Taleingang hinauf nach {area:17144}",

	-- Step 118: The Deadwood camps
	["The Deadwood camps"] = "Die Deadwood-Lager",
	-- {quest:92446} Head Scratcher
	["South-west back towards Barkskin Burrow: the Deadwood camps on the slopes east of the burrow hold the Totemics and Fel-Tenders. An elite named {quest:92446} (level 60) may roam the camps' eastern end."] = "Nach Südwesten zurück zur Barkskin-Höhle: Die Deadwood-Lager auf den Hängen östlich des Baus bergen die Totemiker und Feuentender. Ein Elite namens {quest:92446} (Stufe 60) streift eventuell am östlichen Ende der Lager.",

	-- Step 119: Head Scratcher
	-- {quest:92446} Head Scratcher · {npc:244511} Zet'gan
	["{quest:92446} is elite (level 60 in our data): grouping up is advised. Put {npc:244511}'s rabbit carcass down in the woods at the camps' eastern end, where the Horde players in our recordings fought him, and take his claws."] = "{quest:92446} ist Elite (Stufe 60 in unseren Daten): Eine Gruppe ist ratsam. Leg den Kaninchenkadaver von {npc:244511} im Wald am östlichen Ende der Lager ab, wo die Horde-Spieler in unseren Aufzeichnungen gegen ihn kämpften, und nimm seine Klauen.",

	-- Step 120: Barkskin Burrow
	-- {npc:260661} Suma Mossmane · {npc:256660} Thobon Sapclaw
	["Into the burrow for the elders, {npc:260661} and {npc:256660}."] = "In den Bau zu den Ältesten, {npc:260661} und {npc:256660}.",

	-- Step 121: Galvinquam Leafsyre
	-- {area:17145} Cradle of Tranquility · {npc:267109} Galvinquam Leafsyre · {npc:255683} Shalla'kal
	["North-east into the {area:17145}: {npc:267109} rests in the ruins south of {npc:255683}, on your way."] = "Nach Nordosten in den {area:17145}: {npc:267109} ruht in den Ruinen südlich von {npc:255683}, auf dem Weg.",
	-- {quest:96991} Trail Assist · {npc:264795} Marn Euhorn · {area:16849} Summit of Eternity
	["{quest:96991}: for {npc:264795} at the {area:16849}, later in this guide"] = "{quest:96991}: für {npc:264795} bei {area:16849}, später in diesem Guide",

	-- Step 122: Jereman
	-- {npc:267158} Jereman
	["On to the old bridge over the Cradle: touch the crow effigy on it and {npc:267158} appears again."] = "Weiter zur alten Brücke über die Wiege: Berühre das Raben-Effigie auf ihr, und {npc:267158} erscheint erneut.",
	-- {quest:96964} A Clever Creature · {npc:259695} Renalard · {area:16866} Dae'gun
	["{quest:96964}: for {npc:259695} in {area:16866}, just ahead"] = "{quest:96964}: für {npc:259695} in {area:16866}, gleich vorn",

	-- Step 123: Johun "Punchy" Dillas
	-- {npc:249234} Johun "Punchy" Dillas · {area:16866} Dae'gun
	["North-east across the Cradle to {npc:249234}'s camp at the edge of {area:16866}."] = "Nach Nordosten über die Wiege zum Camp von {npc:249234} am Rand von {area:16866}.",

	-- Step 124: Elaena Moonwhisper, Witherbeard and Yashiro
	-- {npc:263406} Elaena Moonwhisper · {npc:249052} Witherbeard · {npc:267121} Yashiro
	["{npc:263406}, {npc:249052} and {npc:267121}"] = "{npc:263406}, {npc:249052} und {npc:267121}",
	-- {area:16866} Dae'gun · {npc:263406} Elaena Moonwhisper · {npc:249052} Witherbeard · {npc:267121} Yashiro
	["Into {area:16866}, north of the Cradle: the ruins of a Horde base, now held by demons. {npc:263406} and {npc:249052} camp at its western edge; {npc:267121}, a blademaster, waits a little east of them. Doomguards (elites, levels 58-59) walk among the demons: pull carefully."] = "In {area:16866}, nördlich der Wiege: Die Ruinen einer Hordenbasis, jetzt von Dämonen gehalten. {npc:263406} und {npc:249052} lagern an ihrem westlichen Rand; {npc:267121}, ein Klingenmeister, wartet ein Stück östlich von ihnen. Schreckenswächter (Elite, Stufe 58-59) laufen zwischen den Dämonen: Zieh vorsichtig.",

	-- Step 125: Maerion Thaelemaches
	-- {npc:267097} Maerion Thaelemaches · {area:16866} Dae'gun · {quest:97009} Maerion's Misery · {npc:267439} Doomguard Xarkul
	-- plural, as words: Defiling Hounds = {npc:249230} Defiling Hound · Legion Hulks = {npc:249238} Legion Hulk
	["North-east to {npc:267097} at the northern ruins of {area:16866}: take {quest:97009} so the Defiling Hounds drop their spikes while you work the other errands here.\nCareful: Legion Hulks (60, rare elites) stomp through {area:16866}'s camps, and {npc:267439}, an elite (level 61), walks this corner: give them room."] = "Nach Nordosten zu {npc:267097} bei den nördlichen Ruinen von {area:16866}: Nimm {quest:97009}, damit die Besudelnden Bluthunde ihre Stacheln fallen lassen, während du hier die anderen Aufgaben erledigst.\nVorsicht: Legion Hulks (60, seltene Elites) stapfen durch die Lager von {area:16866}, und {npc:267439}, ein Elite (Stufe 61), läuft in dieser Ecke: Gib ihnen Raum.",

	-- Step 126: Renalard
	-- {area:16866} Dae'gun · {npc:259695} Renalard
	["South-east across {area:16866} to {npc:259695}, the wild god, indoors at its south-eastern edge."] = "Nach Südosten über {area:16866} zu {npc:259695}, dem Wilden Gott, im Inneren an dessen südöstlichem Rand.",
	-- {quest:92335} Ashes of the Legion Ascent · {npc:256222} Ketharas
	["{quest:92335}: for {npc:256222}, later in this guide"] = "{quest:92335}: für {npc:256222}, später in diesem Guide",

	-- Step 127: Dae'gun
	-- {area:16866} Dae'gun · {npc:259695} Renalard · {npc:265788} Kal'tinzan · {item:253249} Horde Flag · {object:656786} Troll Remains (no name in this language: may be words) · {quest:96998} Tribal Colors · {npc:255183} Jezerelle the Swaying · {npc:267439} Doomguard Xarkul
	-- plural, as words: Felguard Sentinels = {npc:249229} Felguard Sentinel · Defiling Hounds = {npc:249230} Defiling Hound · Legion Hulks = {npc:249238} Legion Hulk
	["Work west back through {area:16866}: the Felguard Sentinels and Defiling Hounds are everywhere, the hounds carry the essence, and the Horde base's rubble (wire, scrap and dung) lies all over it. Light the two bonfires on your way, scout the Horde tower in the middle, take Azgalor's ashes west of the tower, and pick up the abandoned supplies, a few just north-west of {npc:259695} and the rest in the western half: {npc:259695}'s tuft of fur, used on a demon, distracts it while you take them.\nHorde: the demons here also drop the Scraps of Horde Heraldry for {npc:265788}, the old {item:253249} stands in the camp north of the south bonfire, and the {object:656786} at the camp's eastern edge start {quest:96998}.\nCareful: Legion Hulks (60, rare elites) stomp through {area:16866}'s camps: give them room. {npc:255183} (61, rare) walks the camp north of the south bonfire: keep away from her.\nCareful: Doomguards (elites, 58-59) stand among the demons, and {npc:267439} (elite, 61) walks the camp: pull the hounds and sentinels to you, away from them."] = "Arbeite dich nach Westen durch {area:16866} zurück: Die Teufelswächter und Besudelnde Bluthunde sind überall, die Hunde tragen die Essenz, und der Schutt der Hordenbasis (Draht, Plunder und Dung) liegt überall. Zünd die beiden Freudenfeuer auf dem Weg an, ergründe den Hordenturm in der Mitte, nimm Azgalors Asche westlich des Turms, und heb die verlassenen Vorräte, einige knapp nordwestlich von {npc:259695} und die übrigen in der westlichen Hälfte: Das Fellbüschel von {npc:259695}, auf einen Dämon verwendet, lenkt ihn ab, während du sie nimmst.\nHorde: Die Dämonen hier lassen auch die Fragmente der Hordenheraldik für {npc:265788} fallen, der alte {item:253249} steht im Camp nördlich des südlichen Freudenfeuers, und die {object:656786} am östlichen Rand des Camps starten {quest:96998}.\nVorsicht: Legionskolosse (60, seltene Elite) stampfen durch die Lager von {area:16866}: Lass ihnen Raum. {npc:255183} (61, selten) läuft durch das Camp nördlich des südlichen Freudenfeuers: Halte dich von ihr fern.\nVorsicht: Schreckenswächter (Elite, 58-59) stehen zwischen den Dämonen, und {npc:267439} (Elite, 61) läuft durch das Camp: Zieh die Hunde und Wächter zu dir weg von ihnen.",
	["light it"] = "anzünden",
	["scout the Horde tower"] = "ergründe den Hordenturm",
	-- {object:656786} Troll Remains (no name in this language: may be words) · {quest:96998} Tribal Colors · {npc:244511} Zet'gan · {area:16848} Elderwild
	["{object:656786}: {quest:96998}, for {npc:244511} in {area:16848}; keep it"] = "{object:656786}: {quest:96998}, für {npc:244511} in {area:16848}; behalte ihn",

	-- Step 129: Drawing Down the Malevolent
	-- {npc:263394} Bethra'zel the Feeble · {npc:252457} Mazzogore · {npc:263406} Elaena Moonwhisper
	["{npc:263394} and {npc:252457} are level 60 elites until {npc:263406}'s eye drains them: drain each one first, then fight it. Drained, they are no longer elite and you can take them alone; players in our recordings killed both once drained."] = "{npc:263394} und {npc:252457} sind Level-60-Elite, solange das Auge von {npc:263406} sie nicht entleert: entleere jede einzelne zuerst, dann kämpfe sie. Entleert, sind sie nicht mehr Elite und du kannst sie allein nehmen; Spieler in unseren Aufnahmen haben beide einmal entleert getötet.",

	-- Step 131: Bethra'zel the Feeble
	-- {npc:263394} Bethra'zel the Feeble · {npc:263406} Elaena Moonwhisper · {npc:252457} Mazzogore · {npc:267439} Doomguard Xarkul · {area:16866} Dae'gun
	-- plural, as words: Legion Hulks = {npc:249238} Legion Hulk
	["North-east to {npc:263394}. Drain him first: use {npc:263406}'s eye on him, and only then fight him. Undrained, he and {npc:252457} are level 60 elites. {npc:267439}, an elite (level 61), walks this corner of {area:16866}: keep out of his way.\nCareful: Legion Hulks (60, rare elites) stomp through {area:16866}'s camps: give them room."] = "Nach Nordosten zu {npc:263394}. Entleere ihn zuerst: Benutze das Auge von {npc:263406} auf ihn, und erst dann bekämpfe ihn. Unentleert sind er und {npc:252457} Eliten der Stufe 60. {npc:267439}, ein Elite (Stufe 61), läuft durch diese Ecke von {area:16866}: Weiche ihm aus.\nVorsicht: Legionskolosse (60, seltene Elite) stampfen durch die Lager von {area:16866}: Lass ihnen Raum.",

	-- Step 132: Maerion Thaelemaches
	-- {npc:267097} Maerion Thaelemaches · {area:16866} Dae'gun · {npc:263394} Bethra'zel the Feeble · {npc:267439} Doomguard Xarkul
	-- plural, as words: Defiling Hounds = {npc:249230} Defiling Hound · Legion Hulks = {npc:249238} Legion Hulk
	["North-east back to {npc:267097}, in the corner of {area:16866} where {npc:263394} stands: the Defiling Hounds around him drop any spikes you still need.\nCareful: Legion Hulks (60, rare elites) stomp through {area:16866}'s camps, and {npc:267439}, an elite (level 61), walks this corner: give them room."] = "Zurück nach Nordosten zu {npc:267097}, in die Ecke von {area:16866}, in der {npc:263394} steht: Die Besudelnden Bluthunde um ihn herum lassen alle Dornen fallen, die du noch brauchst.\nVorsicht: Legion Hulks (60, seltene Eliten) stampfen durch die Lager von {area:16866}, und {npc:267439}, ein Elite (Stufe 61), läuft durch diese Ecke: Lass sie in Ruhe.",

	-- Step 133: Mazzogore
	-- {npc:263426} Mazzogore the Weak · {area:16866} Dae'gun · {npc:263394} Bethra'zel the Feeble
	["South-west to {npc:263426}, in the middle of {area:16866}: drain him with the eye first, as {npc:263394}, then kill him. Undrained, he is a level 60 elite.\nCareful: Doomguards (elites, 58-59) stand around him: pull him out to you."] = "Nach Südwesten zu {npc:263426}, in der Mitte von {area:16866}: Entleere ihn zuerst mit dem Auge, wie {npc:263394}, dann töte ihn. Unentleert ist er ein Elite der Stufe 60.\nVorsicht: Schreckenswächter (Elite, 58-59) stehen um ihn herum: Zieh ihn zu dir heraus.",

	-- Step 134: Elaena Moonwhisper
	-- {quest:96025} As the Crow Flies · {npc:254915} Thisalee Crow
	["{quest:96025}: for {npc:254915} at the Summit"] = "{quest:96025}: für {npc:254915} auf dem Gipfel",

	-- Step 135: Renalard
	-- {npc:259695} Renalard
	["South-east to {npc:259695}."] = "Nach Südosten zu {npc:259695}.",

	-- Step 136: The Summit of Eternity
	-- {area:16849} Summit of Eternity
	["The {area:16849}"] = "Das {area:16849}",
	-- {area:16849} Summit of Eternity · {npc:41861} Fayran Elthas · {npc:264795} Marn Euhorn · {npc:243855} Toron Rockhoof · {npc:254915} Thisalee Crow · {npc:40833} Tiala Whitemane · {npc:243815} Sebelia
	["East up to the {area:16849}, the druids' camp. {npc:41861}, the flight master, stands at its north end; {npc:264795}, {npc:243855} and {npc:254915} along the path south; {npc:40833} indoors next to Thisalee; {npc:243815}, the innkeeper, at the south-east end."] = "Nach Osten hinauf zum {area:16849}, dem Camp der Druiden. {npc:41861}, der Flugmeister, steht an dessen Nordende; {npc:264795}, {npc:243855} und {npc:254915} entlang des Pfads nach Süden; {npc:40833} im Inneren neben Thisalee; {npc:243815}, der Gastwirt, am südöstlichen Ende.",
	-- {npc:41861} Fayran Elthas
	["{npc:41861}, at the flight point"] = "{npc:41861}, am Flugpunkt",
	-- {npc:243815} Sebelia · {quest:93197} Mending Communications · {npc:11118} Innkeeper Vizzie · {area:2255} Everlook
	["{npc:243815}: {quest:93197}: for {npc:11118} in {area:2255}, at the end"] = "{npc:243815}: {quest:93197}: für {npc:11118} in {area:2255}, am Ende",

	-- Step 138: As the Crow Flies
	-- {npc:254915} Thisalee Crow · {npc:263406} Elaena Moonwhisper
	["{npc:254915}, at the Summit, for {npc:263406}'s message."] = "{npc:254915}, auf dem Gipfel, für die Nachricht von {npc:263406}.",

	-- Step 139: The Summit's Blackthorne quests
	["The Summit's Blackthorne quests"] = "Die Blackthorne-Quests auf dem Gipfel",
	-- {npc:260674} Ve'han Talongrasp
	["A group stop: the Blackthorne camps north-east of the Summit hold elite Outrunners, Priests and a Courier (60) as often as the Cultists and Adepts, with {npc:260674} (60, elite) in the middle and Ghansurok (61, elite) on the ridge. Grouping up is encouraged, look for people to do it with. Skip these if you are alone."] = "Ein Gruppenstopp: Die Blackthorne-Lager nordöstlich des Gipfels bergen Kundschafter der Blackthorne, Priester und einen Kurier (60) ebenso oft wie die Kultisten und Adepten, mit {npc:260674} (60, Elite) in der Mitte und Ghansurok (61, Elite) auf dem Grat. Eine Gruppe ist empfehlenswert, such nach Leuten, mit denen du es tun kannst. Lass diese aus, wenn du allein bist.",

	-- Step 140: Fly to the Tainted Foothills
	-- {npc:260626} Bluebell · {npc:249235} Kaylaena Springwhisper · {npc:256222} Ketharas
	["Fly down to {npc:260626} for {npc:249235} and {npc:256222}."] = "Fliege hinunter zu {npc:260626} für {npc:249235} und {npc:256222}.",

	-- Step 141: Kaylaena Springwhisper's workshop
	["North to the workshop. Turn the two gears and connect the two battery terminals on both sides of her glaive thrower. Ghansurok, the elite chimaera (level 61), prowls around the workshop: watch for him while you work."] = "Nach Norden zur Werkstatt. Dreh die beiden Zahnräder und verbinde die beiden Batteriepole auf beiden Seiten ihres Glevenwerfers. Ghansurok, die Chimäre (Elite, Stufe 61), streift um die Werkstatt: Achte auf ihn, während du arbeitest.",

	-- Step 142: Ketharas
	["South-east to the Hermit's Abode with what the wild gods and Omnuron gave you."] = "Nach Südosten zur Einsiedlerhütte mit dem, was die Wilden Götter und Omnuron dir gaben.",

	-- Step 146: Final Death, still not done
	-- {quest:92591} Final Death
	["{quest:92591}, still not done"] = "{quest:92591}, noch nicht erledigt",
	-- {area:16868} Mourning's Rest · {quest:92591} Final Death
	["Still under 58 after the second pass through {area:16868}? Abandon {quest:92591}: the route doesn't come back for it."] = "Nach dem zweiten Durchgang durch {area:16868} immer noch unter 58? Gib {quest:92591} auf: Die Route kommt nicht mehr für ihn zurück.",

	-- Step 147: Final Death, still not done
	-- {quest:92592} Final Death
	["{quest:92592}, still not done"] = "{quest:92592}, noch nicht erledigt",
	-- {area:16868} Mourning's Rest · {quest:92592} Final Death
	["Still under 58 after the second pass through {area:16868}? Abandon {quest:92592}: the route doesn't come back for it."] = "Nach dem zweiten Durchgang durch {area:16868} immer noch unter 58? Gib {quest:92592} auf: Die Route kommt nicht mehr für ihn zurück.",

	-- Step 148: Back to Elderwild
	-- {area:16848} Elderwild
	["Back to {area:16848}"] = "Zurück nach {area:16848}",
	-- {area:16848} Elderwild · {npc:265788} Kal'tinzan · {npc:244511} Zet'gan
	["Horde: ride west across the foothills and north up the valley to {area:16848}, about four minutes, for {npc:265788}'s flags, {npc:244511}'s amulet and his war paint wrap, then back up to the Summit."] = "Horde: Reit westlich über die Vorgebirge und den Talauf nach Norden nach {area:16848}, etwa vier Minuten, für die Fahnen von {npc:265788}, das Amulett von {npc:244511} und sein Kriegsbemalungswickel, dann zurück hinauf zum Gipfel.",
	-- {npc:244511} Zet'gan · {quest:96999} Wrap Return · {npc:3187} Tai'tasi · {area:367} Sen'jin Village · {zone:1411} Durotar
	["{npc:244511}: {quest:96999}, for {npc:3187} in {area:367}, {zone:1411}; take it only if you'll pass by"] = "{npc:244511}: {quest:96999}, für {npc:3187} in {area:367}, {zone:1411}; nimm ihn nur an, wenn du vorbeikommst",

	-- Step 149: Back to Elderwild
	-- {npc:244517} Sefira Everbright · {area:16848} Elderwild
	["Alliance: the amulet from the second pass goes to {npc:244517}: ride west across the foothills and north up the valley to {area:16848}, about four minutes, then back up to the Summit."] = "Allianz: Das Amulett vom zweiten Durchgang geht zu {npc:244517}: Reit westlich über die Vorgebirge und den Talauf nach Norden nach {area:16848}, etwa vier Minuten, dann zurück hinauf zum Gipfel.",

	-- Step 151: To the Summit of Eternity
	-- {npc:244517} Sefira Everbright · {npc:254915} Thisalee Crow
	["{npc:244517}: for {npc:254915} at the Summit, next"] = "{npc:244517}: für {npc:254915} auf dem Gipfel, als Nächstes",

	-- Step 152: To the Summit of Eternity
	-- {npc:244511} Zet'gan · {npc:254915} Thisalee Crow
	["{npc:244511}: for {npc:254915} at the Summit, next"] = "{npc:244511}: für {npc:254915} auf dem Gipfel, als Nächstes",

	-- Step 153: Zet'gan
	-- {quest:92446} Head Scratcher
	["{quest:92446}'s claws"] = "Die Klauen von {quest:92446}",

	-- Step 154: Up to the Summit of Eternity
	-- {area:16849} Summit of Eternity
	["Up to the {area:16849}"] = "Hinauf nach {area:16849}",
	-- {area:16849} Summit of Eternity · {npc:260626} Bluebell
	["Back up to the {area:16849}: {npc:260626}, at the ancients' outpost, flies there, and your Hearthstone is bound there."] = "Zurück hinauf nach {area:16849}: {npc:260626}, am Außenposten der Uralten, fliegt dorthin, und dein Ruhestein ist dort angelegt.",

	-- Step 155: Tiala Whitemane
	-- {npc:254915} Thisalee Crow
	["Indoors at the Summit, next to {npc:254915}."] = "Im Inneren auf dem Gipfel, neben {npc:254915}.",

	-- Step 156: Thisalee Crow
	-- {npc:254915} Thisalee Crow · {npc:40833} Tiala Whitemane
	["{npc:254915}, next to {npc:40833} at the Summit."] = "{npc:254915}, neben {npc:40833} auf dem Gipfel.",

	-- Step 158: The Blackthorne camps
	["The Blackthorne camps"] = "Die Blackthorne-Lager",
	-- {npc:260674} Ve'han Talongrasp · {npc:40833} Tiala Whitemane
	["The Blackthorne cultists camp on the slopes north-east of the Summit (level 60, with elite Outrunners, Priests and a Courier among them: pull carefully). {npc:260674}, an elite (level 60) who leads them, stands among them: leave him be. Ghansurok, an elite chimaera (level 61), also roams the ridge north of the camps.\nUse {npc:40833}'s staff on a Pact member to strip its ward, then kill it, ten times: pick Cultists and Adepts, whom Thisalee wants dead too. The Cultists carry the kris and the Adepts the staff; the thorn seeds lie in the woods there, and the hippogryphs and chimaeras roam the slopes all around. Not finished in our recordings yet: if something here is off, tell us."] = "Die Blackthorne-Kultisten lagern auf den Hängen nordöstlich des Gipfels (Stufe 60, mit Kundschafter der Blackthornen, Priestern und einem Kurier unter ihnen: Zieh vorsichtig). {npc:260674}, ein Elite (Stufe 60), der sie anführt, steht unter ihnen: Lass ihn in Ruhe. Ghansurok, eine Chimäre (Elite, Stufe 61), streift auch über den Grat nördlich der Lager.\nBenutze den Stab von {npc:40833} auf einem Mitglied des Pakts, um seine Schutzkraft zu brechen, dann töte es, zehnmal: Such dir Kultisten und Adepten, die Thisalee ebenfalls tot will. Die Kultisten tragen den Kris, die Adepten den Stab; die Dornensamen liegen in den Wäldern dort, und die Hippogryphen und Chimären streifen über die Hänge ringsum. In unseren Aufzeichnungen noch nicht abgeschlossen: Wenn hier etwas nicht stimmt, sag es uns.",

	-- Step 159: The Blackthorne camps
	-- {npc:260674} Ve'han Talongrasp
	["The Blackthorne cultists camp on the slopes north-east of the Summit (level 60, with elite Outrunners, Priests and a Courier among them: pull carefully). {npc:260674}, an elite (level 60) who leads them, stands among them: leave him be. Ghansurok, an elite chimaera (level 61), also roams the ridge north of the camps.\nThe Cultists carry the kris and the Adepts the staff; the thorn seeds lie in the woods there, and the hippogryphs and chimaeras roam the slopes all around. Not finished in our recordings yet: if something here is off, tell us."] = "Die Blackthorne-Kultisten lagern auf den Hängen nordöstlich des Gipfels (Stufe 60, mit Kundschafter der Blackthornen, Priestern und einem Kurier unter ihnen: Zieh vorsichtig). {npc:260674}, ein Elite (Stufe 60), der sie anführt, steht unter ihnen: Lass ihn in Ruhe. Ghansurok, eine Chimäre (Elite, Stufe 61), streift auch über den Grat nördlich der Lager.\nDie Kultisten tragen den Kris, die Adepten den Stab; die Dornensamen liegen in den Wäldern dort, und die Hippogryphen und Chimären streifen über die Hänge ringsum. In unseren Aufzeichnungen noch nicht abgeschlossen: Wenn hier etwas nicht stimmt, sag es uns.",

	-- Step 162: Fly to Everlook
	-- {npc:41861} Fayran Elthas · {area:2255} Everlook
	["{npc:41861} flies you to {area:2255}."] = "{npc:41861} fliegt dich nach {area:2255}.",

	-- Step 163: Innkeeper Vizzie
	-- {npc:11118} Innkeeper Vizzie · {area:2255} Everlook · {zone:1452} Winterspring
	["{npc:11118} is in {area:2255}'s inn. She has more mail for you in {zone:1452}, outside this guide."] = "{npc:11118} ist in der Gaststätte von {area:2255}. Sie hat mehr Post für dich in {zone:1452}, außerhalb dieses Guides.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A group choice: {npc:263394} and {npc:252457} are level 60 elites until {npc:263406}'s eye drains them. Drain each one first, then fight it; players in our recordings killed both once drained. Grouping up is advised."] = "Eine Gruppenwahl: {npc:263394} und {npc:252457} sind Eliten der Stufe 60, bis {npc:263406} sie mit dem Auge entleert. Entleere jeweils einen zuerst, dann bekämpfe ihn; die Spieler in unseren Aufzeichnungen töteten beide, sobald sie entleert waren. Eine Gruppe ist ratsam.",
	-- ["Back to {npc:264089}, then the ghostly {npc:255009} at {area:16868}'s western edge, where the recording met him, on your way west."] = "Zurück zu {npc:264089}, dann zu dem geisterhaften {npc:255009} am westlichen Rand von {area:16868}, wo die Aufzeichnung ihn traf, auf dem Weg nach Westen.",
	-- ["North into the shrub field: the {npc:248395} drop the leaves, and the Scarlet Dart Tubers grow in the open ground, most of them in the field's western half. The ruined ballista stands at the field's north-eastern edge: plant the last seed there. Keep clear of {quest:91923} and {npc:248709}, the field's elites."] = "Nach Norden in das Strauchfeld: Die {npc:248395} lassen die Blätter fallen, und die Scharlachroten Dartknollen wachsen auf der offenen Fläche, die meisten in der westlichen Hälfte des Felds. Die zerstörte Balliste steht am nordöstlichen Rand des Felds: Pflanze den letzten Samen dort. Halte dich von {quest:91923} und {npc:248709} fern, den Eliten des Felds.",
	-- ["North-east to {npc:267097}, in the corner of {area:16866} where {npc:263394} stands. His Felhound Spikes come from the Defiling Hounds, and in the first recording about one hound in ten had one: kill the hounds around him while you are here, and leave his quest if the twelve spikes are slow to come.\nCareful: Legion Hulks (60, rare elites) stomp through {area:16866}'s camps, and {npc:267439}, an elite (level 61), walks this corner: give them room."] = "Nach Nordosten zu {npc:267097}, in der Ecke von {area:16866}, wo {npc:263394} steht. Seine Teufelshundstacheln kommen von den Besudelnden Bluthunden, und in der ersten Aufzeichnung hatte etwa jeder zehnte Hund einen: Töte die Hunde um ihn herum, während du hier bist, und lass seinen Quest, wenn die zwölf Dornen nur langsam kommen.\nVorsicht: Legionskolosse (60, seltene Elite) stampfen durch die Lager von {area:16866}, und {npc:267439}, ein Elite (Stufe 61), läuft durch diese Ecke: Lass ihnen Raum.",
	-- ["South Bonfire"] = "Südliches Freudenfeuer",
	-- ["South down the west side of the shrub field to the ancients' outpost: kill the {npc:248395} you pass for {npc:249235}. {npc:260626}, the flight mistress, waits by the outpost; {npc:248367} and {npc:265586} stand with the ancient {npc:248366}."] = "Nach Süden die Westseite des Strauchfelds hinab zum Außenposten der Uralten: Töte die {npc:248395}, an denen du vorbeikommst, für {npc:249235}. {npc:260626}, die Flugmeisterin, wartet beim Außenposten; {npc:248367} und {npc:265586} stehen bei dem Uralten {npc:248366}.",
	-- ["Southeast Bonfire"] = "Südöstliches Freudenfeuer",
	-- ["The Hyjal Owls roost on the slopes between {npc:264089} and Barkskin Burrow: their feathers are for {area:16848}.\nCareful: Death Wailers (61, rare elites) drift over the western slopes: give them a wide berth.\nCareful: Grimmwurzel, the elite treant (level 60), walks the western slopes here: pull the owls away from his path."] = "Die Hyjal-Eulen rasten auf den Hängen zwischen {npc:264089} und der Barkskin-Höhle: Ihre Schwingen sind für {area:16848}.\nVorsicht: Todesheuler (61, seltene Elite) treiben über die westlichen Hänge: Lass sie weit hinter dir.\nVorsicht: Grimmwurzel, der Treant (Elite, Stufe 60), läuft hier die westlichen Hänge entlang: Zieh die Eulen von seinem Weg weg.",
	-- ["The Rustleaf Foxes are thick in the woods around {npc:249234}'s camp.\nCareful: {npc:255183} (61, rare) walks the woods north of the camp: leave her be."] = "Die Rostblattfüchse sind in den Wäldern um das Camp von {npc:249234} dicht.\nVorsicht: {npc:255183} (61, selten) läuft durch die Wälder nördlich des Camps: Lass sie in Ruhe.",
	-- ["The Scourge hold the ruins of {area:16868}, east of {area:16848}: Fleshflay Raveners and Forgotten Soldiers everywhere, Eternal Sentries among them.\nCareful: Death Wailers (61, rare elites) drift over {area:16868}: keep out of their way.\nCareful: Grimmwurzel, the elite treant (level 60), walks the slopes on the way in: give him room."] = "Die Geißel hält die Ruinen von {area:16868}, östlich von {area:16848}: Fleischschinderräuber und Vergessene Soldaten überall, ewige Wächter unter ihnen.\nVorsicht: Todesheuler (61, seltene Elite) treiben über {area:16868}: Weiche ihnen aus.\nVorsicht: Grimmwurzel, der Treant (Elite, Stufe 60), läuft die Hänge auf dem Weg hinein entlang: Lass ihm Raum.",
	-- ["The bear berries grow on the slopes around the burrow: a few on the hill north of {npc:256978}, most of them east of the burrow.\nCareful: Grimmwurzel, an elite treant (level 60), walks the slopes west of the burrow, around 16-20,58-66: give him room."] = "Die Bärenbeeren wachsen auf den Hängen um den Bau: einige am Hügel nördlich von {npc:256978}, die meisten östlich des Baus.\nVorsicht: Grimmwurzel, ein Treant (Elite, Stufe 60), läuft die Hänge westlich des Baus entlang, um 16-20,58-66: Lass ihm Raum.",
	-- ["The ruined catapult and flying machine"] = "Die zerstörte Katapult- und Flugmaschine",
	-- ["Two of the wrecks {npc:256222} named lie at the east end of the fields: plant one of his seeds beside each."] = "Zwei der Wracks, die {npc:256222} nannte, liegen am Ostende der Felder: Pflanze neben jedem einen seiner Samen.",
	-- ["the {npc:262036}"] = "der {npc:262036}",
}
