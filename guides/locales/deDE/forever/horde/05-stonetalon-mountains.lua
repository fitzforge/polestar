-- German (deDE): the guide forever/horde/05-stonetalon-mountains (forever/horde/05-stonetalon-mountains.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Taskmaster Fizzule
	-- {area:382} Sludge Fen · {item:8051} Flare Gun
	["On the way north from Seereth's camp, keep east of the road to the Venture Co. tower north of the {area:382}. Before you go near Fizzule, use {item:8051} to fire two flares, then target him and /salute: he attacks anyone who comes in without signalling first."] = "Auf dem Weg nach Norden vom Lager von Seereth halte dich östlich der Straße zum Turm der Venture Co. nördlich des {area:382}. Bevor du in die Nähe von Fizzule kommst, benutze {item:8051}, um zwei Leuchtraketen abzufeuern, wähle ihn dann als Ziel und /salute: Er greift jeden an, der ohne Signal hereinkommt.",
	-- {quest:2478} Mission: Possible But Not Probable
	["{quest:2478} is for level 23 or more: the tower's drones are 25 and Gallywix a 23 elite. Do it when you can, with a group, from the Class guide Poisons (Horde)."] = "{quest:2478} ist für Stufe 23 oder höher: Die Drohnen des Turms sind 25 und Gallywix ein Elite der Stufe 23. Mach sie, wenn du kannst, mit einer Gruppe, aus dem Klassen-Guide Gifte (Horde).",

	-- Step 2: Kadrak
	-- {zone:1413} Barrens · {npc:8582} Kadrak · {area:1703} Mor'shan Rampart · {zone:1440} Ashenvale
	["From Seereth's camp head north-east across the {zone:1413} to the road north of the Crossroads; Rogues coming from Fizzule's tower head west to it. {npc:8582} stands on the watch tower of the {area:1703} where the road enters {zone:1440}."] = "Geh von Seereths Lager nach Nordosten durch {zone:1413} zur Straße nördlich des Wegekreuzes; Schurken, die von Fizzules Turm kommen, gehen nach Westen dorthin. {npc:8582} steht auf dem Wachturm am {area:1703}, wo die Straße nach {zone:1440} führt.",

	-- Step 3: Into Ashenvale
	-- {zone:1440} Ashenvale
	["Into {zone:1440}"] = "Nach {zone:1440}",
	-- {area:431} Splintertree Post
	["The road north to {area:431}"] = "Die Straße nach Norden zu {area:431}",

	-- Step 4: Splintertree Post
	-- {area:431} Splintertree Post · {npc:12696} Senani Thunderheart · {area:428} Night Run · {npc:12867} Kuray'bin · {zone:1440} Ashenvale
	-- plural, as words: Ashenvale Outrunners = {npc:12856} Ashenvale Outrunner
	["{area:431} is just north up the road. Coming in from the south, the flight master and {npc:12696}'s hunt board at {area:428} come first, then the vendors. {npc:12867} at the lumber camp offers Ashenvale Outrunners: leave it for the next {zone:1440} visit, at 26."] = "{area:431} liegt gleich nördlich die Straße hinauf. Von Süden kommend sind zuerst der Flugmeister und das Jagdbrett von {npc:12696} bei {area:428} dran, dann die Händler. {npc:12867} im Holzfällerlager bietet „Die Kundschafter von Ashenvale“ an: Heb sie dir für den nächsten Besuch in {zone:1440} auf, mit 26.",
	-- {npc:12696} Senani Thunderheart · {zone:1440} Ashenvale
	["{npc:12696}'s hunt targets (Ursangous, Shadumbra, Sharptalon) are for the next {zone:1440} visit, at 26."] = "Die Jagdziele von {npc:12696} (Ursangous, Shadumbra, Sharptalon) sind für den nächsten Besuch in {zone:1440}, bei 26.",

	-- Step 5: Va'xug Firefure
	-- {npc:267214} Va'xug Firefure · {area:415} Astranaar
	-- plural, as words: Shadowhorn Stags = {npc:3817} Shadowhorn Stag · Ashenvale Bears = {npc:3809} Ashenvale Bear
	["On the way west, {npc:267214} is stuck in a ravine south of the main road, south-east of {area:415}. Shadowhorn Stags and Ashenvale Bears roam the woods all around it."] = "Auf dem Weg nach Westen steckt {npc:267214} in einer Schlucht südlich der Hauptstraße fest, südöstlich von {area:415}. Schattenhornhirsche und Ashenvalebären streifen rundherum durch die Wälder.",

	-- Step 6: A Void Path
	-- {npc:267214} Va'xug Firefure · {npc:271181} Eye of Kilrogg
	["Steer {npc:267214}'s {npc:271181} out of the ravine to the main road within four minutes; if the channel breaks, ask {npc:267214} again."] = "Steuere {npc:267214}s {npc:271181} innerhalb von vier Minuten aus der Schlucht zur Hauptstraße; bricht die Kanalisierung ab, frag {npc:267214} erneut.",
	-- {npc:271181} Eye of Kilrogg
	["{npc:271181}, on the road"] = "{npc:271181}, auf der Straße",

	-- Step 7: Zoram'gar Outpost
	-- {zone:1440} Ashenvale · {area:415} Astranaar · {area:2897} Zoram'gar Outpost · {area:414} Zoram Strand · {npc:12719} Marukai · {npc:12721} Mitsuwa · {npc:12757} Karang Amakkar · {npc:12863} Warsong Runner
	["Head west along the main road across {zone:1440}, past {area:415} (Alliance: keep to the road), to the coast. {area:2897} is on the {area:414} in the north-west: {npc:12719}, {npc:12721} and {npc:12757} stand around it, the {npc:12863} beside the flight master. Its other quests are for the next visit, at 26."] = "Geh auf der Hauptstraße nach Westen durch {zone:1440}, an {area:415} vorbei (Allianz: Bleib auf der Straße), bis zur Küste. {area:2897} liegt am {area:414} im Nordwesten: {npc:12719}, {npc:12721} und {npc:12757} stehen darum, der {npc:12863} neben dem Flugmeister. Seine anderen Quests sind für den nächsten Besuch, bei 26.",
	-- {npc:12721} Mitsuwa
	["{npc:12721}: the troll charms are in Thistlefur Hold, east of the outpost"] = "{npc:12721}: Die Trollamulette sind in der Feste Thistlefur, östlich des Außenpostens",
	-- {npc:12717} Muglash
	["{npc:12717}: take it last, his escort starts at once"] = "{npc:12717}: Nimm sie zuletzt an, seine Eskorte startet sofort",

	-- Step 8: Vorsha the Lasher
	-- {npc:12717} Muglash · {npc:12719} Marukai
	["{npc:12717} walks north up the strand to a naga brazier. Put the brazier out, then guard him through the naga waves until Vorsha is dead; the Wrathtail naga drop the heads {npc:12719} wants."] = "{npc:12717} läuft die Küste nach Norden zu einem Nagabecken. Lösche das Becken, dann bewache ihn durch die Nagawellen, bis Vorsha tot ist; die Naga der Wrathtail lassen die Köpfe fallen, die {npc:12719} will.",
	["Naga brazier"] = "Nagakohlenpfanne",

	-- Step 9: Naga heads
	["Naga heads"] = "Nagaköpfe",
	["Every Wrathtail naga along the strand north of the outpost drops heads."] = "Jeder Naga der Rächerflossen am Strand nördlich des Außenpostens lässt Köpfe fallen.",

	-- Step 10: Zoram'gar Outpost
	["Back to the outpost before heading east to Thistlefur."] = "Zurück zum Außenposten, bevor du nach Osten zu Thistlefur gehst.",

	-- Step 11: Thistlefur Village
	["East of Zoram'gar, the Thistlefur furbolgs fill the village and the hills around their hold.\nCareful: A Shaman at 15% health or lower runs off to find help, which can pull extra furbolgs."] = "Östlich von Zoram'gar füllen die Furbolgs von Thistlefur das Dorf und die Hügel um ihre Feste.\nVorsicht: Ein Schamane mit 15% Gesundheit oder weniger rennt los, um Hilfe zu holen, was zusätzliche Furbolgs heranziehen kann.",

	-- Step 12: Thistlefur Hold
	["Thistlefur Hold"] = "Höhle der Distelfelle",
	-- {npc:12818} Ruul Snowhoof · {area:428} Night Run · {npc:3987} Dal Bloodclaw
	-- plural, as words: Troll Chests = {object:178144} Troll Chest
	["Inside the hold, Troll Chests lie along the tunnels. {npc:12818} is held deep inside: free him and protect him all the way out, then he runs home to {area:428}.\nCareful: Two scripted ambushes occur, each made up of three Thistlefurs (a Shaman, a Pathfinder and an Avenger, Ursa or Den Watcher): the first when you come back to the tunnel's fork inside the cave, the second just beyond the gate where {npc:3987} roams."] = "In der Feste liegen Trollkisten entlang der Tunnel. {npc:12818} wird tief im Inneren festgehalten: Befreie ihn und beschütze ihn den ganzen Weg hinaus, dann rennt er heim nach {area:428}.\nVorsicht: Es gibt zwei geskriptete Hinterhalte, jeder aus drei Thistlefur (einem Schamanen, einem Pfadfinder und einem Rächer, Ursa oder Höhlenwächter): der erste, wenn du zur Gabelung des Tunnels in der Höhle zurückkommst, der zweite direkt hinter dem Tor, wo {npc:3987} umherzieht.",
	["Below ground"] = "Unter der Erde",
	-- {npc:12818} Ruul Snowhoof
	["{npc:12818}, below ground"] = "{npc:12818}, unter Tage",

	-- Step 13: Zoram'gar Outpost
	-- {npc:12757} Karang Amakkar · {zone:1440} Ashenvale
	["Back west to Zoram'gar. {npc:12757} offers King of the Foulweald now; leave it for the next {zone:1440} visit at 26, when the walk east passes the Foulweald."] = "Zurück nach Westen nach Zoram'gar. {npc:12757} bietet jetzt „King of the Foulweald“ an; heb es dir für den nächsten Besuch in {zone:1440} bei 26 auf, wenn der Weg nach Osten an den Foulweald vorbeiführt.",

	-- Step 14: Splintertree Post
	-- {area:431} Splintertree Post · {npc:12837} Yama Snowhoof
	["Fly to {area:431}: {npc:12837} waits in the inn for news of Ruul."] = "Flieg nach {area:431}: {npc:12837} wartet im Gasthaus auf Nachricht von Ruul.",
	-- {npc:12837} Yama Snowhoof
	["{npc:12837}, inside the inn"] = "{npc:12837}, im Gasthaus",

	-- Step 15: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Flieg nach {area:1637}",
	-- {area:431} Splintertree Post · {area:1637} Orgrimmar
	["Out of the inn to the {area:431} flight master and fly to {area:1637}."] = "Raus aus dem Gasthaus zum Flugmeister von {area:431} und flieg nach {area:1637}.",
	-- {area:431} Splintertree Post
	["{area:431} flight master"] = "Flugmeister von {area:431}",

	-- Step 16: Druid trainer
	["Druid trainer"] = "Druidenlehrer",
	-- {npc:3034} Sheal Runetotem · {zone:1412} Mulgore · {zone:1454} Orgrimmar
	["{npc:3034} in {zone:1412}; {zone:1454} has no druid trainer"] = "{npc:3034} in {zone:1412}; {zone:1454} hat keinen Druidenlehrer",

	-- Step 18: The Binding
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {item:6626} Dogran's Pendant
	["{npc:5875} stands in the {object:172960}. Use {item:6626} on the summoning circle there and defeat the succubus to bind her."] = "{npc:5875} steht in {object:172960}. Benutze dort {item:6626} am Beschwörungskreis und besiege die Sukkubus, um sie zu binden.",

	-- Step 19: Shenthul
	-- {quest:2478} Mission: Possible But Not Probable · {npc:3401} Shenthul · {object:172960} Cleft of Shadow
	["If you did {quest:2478} with a group, {npc:3401} in the {object:172960} takes it now."] = "Wenn du {quest:2478} mit einer Gruppe gemacht hast, nimmt {npc:3401} im {object:172960} sie jetzt an.",
	-- {npc:2391} Serge Hinott · {area:272} Tarren Mill
	["{npc:2391} in {area:272} teaches Poisons: keep it"] = "{npc:2391} in {area:272} lehrt Gifte: behalte sie",

	-- Step 20: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "Zeppelin nach {zone:1458}",

	-- Step 21: Brill
	-- {npc:246152} Shari Stilwell · {area:159} Brill
	["{npc:246152} trains Paladins in {area:159}, a short walk north up the road from the zeppelin towers. Come back down the same road for Silverpine."] = "{npc:246152} bildet in {area:159} Paladine aus, ein kurzer Weg die Straße hinauf nach Norden von den Zeppelintürmen. Für den Silberwald kommst du dieselbe Straße zurück.",

	-- Step 22: Morbin Lightbane
	-- {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {object:36126} Royal Quarter · {npc:266484} Morbin Lightbane · {npc:10181} Lady Sylvanas Windrunner
	["For your {area:153} run: the zeppelin lands beside the ruins. Walk into the {zone:1458} through them and down to the {object:36126}: {npc:266484} stands there, near {npc:10181}."] = "Für deinen Run durch {area:153}: Der Zeppelin landet neben den Ruinen. Geh durch sie hinein nach {zone:1458} und hinunter ins {object:36126}: {npc:266484} steht dort, in der Nähe von {npc:10181}.",

	-- Step 23: Ruins of Lordaeron
	-- {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {item:268580} Intact Limbs · {npc:266484} Morbin Lightbane · {npc:250660} The Baron · {item:280438} Abominable Head · {npc:2055} Master Apothecary Faranell · {npc:256102} Crest of Lordaeron · {npc:7825} Oran Snakewrithe
	["The {area:153} is a dungeon for a group of five, about levels 15 to 22, in the ruined city above the {zone:1458}: its portal is in the ruins you walked through.\nInside: every undead can drop {item:268580} for {npc:266484}, so clear as you go. {npc:250660} can drop an {item:280438}, which starts a quest for {npc:2055}, and a {npc:256102} found inside starts one for {npc:7825}: both are in the {zone:1458}, on this route's next stop there."] = "{area:153} ist ein Dungeon für eine Gruppe aus fünf Spielern, etwa Stufe 15 bis 22, in der zerstörten Stadt über {zone:1458}: Das Portal liegt in den Ruinen, durch die du gegangen bist.\nDrinnen: Jeder Untote kann {item:268580} für {npc:266484} fallen lassen, also räum auf dem Weg alles ab. {npc:250660} kann {item:280438} fallen lassen; damit beginnt eine Quest für {npc:2055}, und mit {npc:256102} (drinnen zu finden) eine für {npc:7825}: Beide sind in {zone:1458}, beim nächsten Halt dieser Route dort.",
	-- {quest:92421} Light's Justice · {item:268580} Intact Limbs
	["{quest:92421}: the {item:268580}, inside"] = "{quest:92421}: {item:268580}, drinnen",

	-- Step 24: The Sepulcher
	-- {zone:1421} Silverpine Forest · {area:228} The Sepulcher
	["Out of the ruins, take the road south through Tirisfal into {zone:1421} and on to the {area:228}."] = "Nimm aus den Ruinen die Straße nach Süden durch Tirisfal in den {zone:1421} und weiter zum {area:228}.",

	-- Step 25: Strange Lockbox
	-- {area:240} Dead Field · {object:177844} Strange Lockbox · {item:15882} Half Pendant of Aquatic Endurance · {area:228} The Sepulcher
	["From the zeppelin towers, run south into Silverpine and west past the {area:240} to the coast: the {object:177844} lies at the bottom of very deep water there, beside an air fissure where you can breathe. Watch your breath on the way down. It holds the {item:15882} for Trial of the Sea Lion. Then on to the {area:228}."] = "Lauf von den Zeppelintürmen nach Süden nach Silberwald und westlich am {area:240} vorbei bis zur Küste: Die {object:177844} liegt dort am Grund sehr tiefen Wassers, neben einer Luftspalte, in der du atmen kannst. Achte auf deinen Atem auf dem Weg nach unten. Sie enthält die {item:15882} für Trial of the Sea Lion. Dann weiter zu {area:228}.",
	-- {item:15882} Half Pendant of Aquatic Endurance · {object:177844} Strange Lockbox
	["{item:15882}, from the {object:177844}"] = "{item:15882}, aus {object:177844}",

	-- Step 26: The Sepulcher
	-- {area:228} The Sepulcher · {object:177844} Strange Lockbox · {npc:2121} Shadow Priest Allister · {npc:1937} Apothecary Renferrel
	["Down the road through Silverpine to the {area:228}: from the zeppelin towers, south through Tirisfal; from the {object:177844}, south-east from the coast to the road. {npc:2121} and {npc:1937} stand by the crypt entrance."] = "Die Straße durch den Silberwald hinunter zum {area:228}: von den Zeppelintürmen nach Süden durch Tirisfal; von {object:177844} nach Südosten von der Küste zur Straße. {npc:2121} und {npc:1937} stehen am Eingang der Gruft.",
	-- {npc:1937} Apothecary Renferrel · {area:272} Tarren Mill
	["{npc:1937}: Lydon in {area:272}, next guide"] = "{npc:1937}: Lydon in {area:272}, nächster Guide",
	-- {npc:2121} Shadow Priest Allister · {quest:516} Beren's Peril · {area:233} Ambermill
	["{npc:2121}: {quest:516}, south-east of {area:233}"] = "{npc:2121}: {quest:516}, südöstlich von {area:233}",

	-- Step 27: Deathguard Podrig
	-- {npc:6389} Deathguard Podrig · {item:16210} Gordon's Crate · {zone:1458} Undercity
	["{npc:6389} stands just west of the crypt entrance: hand him {item:16210} from the {zone:1458}."] = "{npc:6389} steht gleich westlich des Eingangs der Gruft: Übergib ihm {item:16210} aus {zone:1458}.",

	-- Step 28: High Executor Hadrec
	-- {area:236} Shadowfang Keep · {area:287} Hillsbrad · {npc:1952} High Executor Hadrec
	["For your {area:236} run, at the end of the {area:287} guide: {npc:1952} stands below ground in the crypt."] = "Für deinen Run durch {area:236}, am Ende des Guides für {area:287}: {npc:1952} steht unter der Erde in der Gruft.",
	-- {npc:1952} High Executor Hadrec
	["{npc:1952}, below ground"] = "{npc:1952}, unter der Erde",

	-- Step 29: Silverpine Forest: kill these as you meet them
	-- {zone:1421} Silverpine Forest
	["{zone:1421}: kill these as you meet them"] = "{zone:1421}: Töte diese, wenn sie dir begegnen",
	-- {area:233} Ambermill · {quest:516} Beren's Peril
	-- plural, as words: Dalaran Watchers = {npc:1888} Dalaran Watcher · Ravenclaw Drudgers = {npc:1974} Ravenclaw Drudger · High Order Mages = {npc:254294} High Order Mage
	["South down the road past Pyrewood: Dalaran Watchers and Wizards patrol the roads around {area:233}, and south-west of the town the Ravenclaw Drudgers and Guardians haunt the ruins of {quest:516} in the south-east of the forest. Careful: High Order Mages (30) walk the same roads among the Watchers and Wizards: leave them."] = "Südlich die Straße hinunter an Pyrewood vorbei: Dalaran-Wächter und -Zauberer patrouillieren auf den Straßen um {area:233}, und südwestlich der Stadt suchen die Ravenclaw-Knechte und -Wächter von Ravenclaw die Ruinen von {quest:516} im Südosten des Waldes heim. Vorsicht: Magier des Hohen Ordens (30) laufen zwischen den Wächtern und Zauberern dieselben Straßen ab: Lass sie in Ruhe.",

	-- Step 30: Beren's Peril
	-- {quest:516} Beren's Peril · {npc:1973} Ravenclaw Guardian · {item:271343} Note Scrap · {object:645153} Offering Stone
	["The Ravenclaw undead haunt the ruins of {quest:516}, east of the road in the south-east of the forest; a {npc:1973} drops the {item:271343} that leads to the {object:645153}.\nAn elite spirit (20) often stands beside the {object:645153}: pull the Ravenclaws away from the stone before you fight them."] = "Die Untoten von Ravenclaw suchen die Ruinen von {quest:516} heim, östlich der Straße im Südosten des Waldes; ein {npc:1973} lässt das {item:271343} fallen, das zum {object:645153} führt.\nEin Elite-Geist (20) steht oft neben dem {object:645153}: Zieh die Ravenclawn vom Stein weg, bevor du sie bekämpfst.",
	-- {item:271343} Note Scrap · {npc:1973} Ravenclaw Guardian
	["{item:271343}, from a {npc:1973}"] = "{item:271343}, von einem {npc:1973}",
	-- {object:645153} Offering Stone · {quest:95883} The Tortured Soul · {item:271343} Note Scrap
	["the {object:645153} offers {quest:95883} once the {item:271343} is in; below ground"] = "der {object:645153} bietet {quest:95883} an, sobald das {item:271343} abgegeben ist; unter Tage",
	-- {item:271350} Tortured Soul
	-- plural, as words: Tortured Souls = {item:271350} Tortured Soul
	["{item:271350}, from the Tortured Souls among the ruins; below ground"] = "{item:271350}, von den Gequälten Seelen zwischen den Ruinen; unter Tage",

	-- Step 31: The Offering of Blood
	-- {item:210713} Tortured Soul · {object:645153} Offering Stone · {quest:95883} The Tortured Soul
	["The quest hands you a {item:210713}: use it beside the {object:645153} to offer your blood, then kill the elite spirit that answers.\n{quest:95883} is elite: grouping up is advised."] = "Die Quest gibt dir einen {item:210713}: Benutze ihn neben dem {object:645153}, um dein Blut zu opfern, und töte dann den Elite-Geist, der antwortet.\n{quest:95883} ist Elite: Eine Gruppe wird empfohlen.",
	-- {item:210713} Tortured Soul · {object:645153} Offering Stone
	["{item:210713}, beside the {object:645153}: summons the elite spirit"] = "{item:210713}, neben dem {object:645153}: beschwört den Elite-Geist",

	-- Step 32: Into Hillsbrad
	-- {area:287} Hillsbrad
	["Into {area:287}"] = "Nach {area:287}",
	-- {area:285} Southpoint Tower
	["The road east to {area:285}"] = "Die Straße nach Osten zu {area:285}",

	-- Step 33: Southpoint Tower
	-- {area:287} Hillsbrad · {npc:2214} Deathstalker Lesh · {area:285} Southpoint Tower
	["Back on the road south. Where it turns east into {area:287}, {npc:2214} waits at {area:285}."] = "Zurück auf die Straße nach Süden. Wo sie nach Osten nach {area:287} abbiegt, wartet {npc:2214} am {area:285}.",
	-- {npc:2214} Deathstalker Lesh · {area:272} Tarren Mill
	["{npc:2214}: Darthalia in {area:272}"] = "{npc:2214}: Darthalia in {area:272}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:8582}"] = "Zurück zu {npc:8582}",
	-- ["East of Ziz, the Venture Company is clear-cutting {area:461}; one of the Operators carries the blueprints. {npc:4276} mines in the small mine on the east side: stay with him while he mines, Venture Co. thugs come for him."] = "Östlich von Ziz holzt die Venture Co. {area:461} kahl; einer der Maschinenführer trägt die Baupläne. {npc:4276} baut in der kleinen Mine auf der Ostseite ab: Bleib bei ihm, während er abbaut, Schläger der Venture Co. kommen ihn holen.",
	-- ["Fly to {area:431} and head south down the road to the {area:1703}."] = "Flieg nach {area:431} und geh die Straße nach Süden hinunter zum {area:1703}.",
	-- ["Fly to {area:431} and ride south down the road to the {area:1703}."] = "Flieg nach {area:431} und reite die Straße nach Süden hinunter zum {area:1703}.",
	-- ["Follow the road east along the river, then north-east up into the hills to {area:272}."] = "Folge der Straße nach Osten am Fluss entlang, dann nach Nordosten hinauf in die Hügel nach {area:272}.",
	-- ["Follow the road north toward {area:467}. Antlered Coursers graze along the way; the Sap Beasts, Twilight Runners and Fey Dragons roam the woods below the Peak, and the Cenarion druids hold the grove there."] = "Folge der Straße nach Norden Richtung {area:467}. Gehörnte Renner grasen am Weg; die Blutsaftbestien, Mondlichtläufer und Siechdrachen streifen durch die Wälder unterhalb des Gipfels, und die Cenarischen Druiden halten den Hain dort.",
	-- ["Follow the road west to {area:460}."] = "Folge der Straße nach Westen zum {area:460}.",
	-- ["From the {area:380} follow the road north. {npc:8582} stands on the watch tower of the {area:1703} where the road enters {zone:1440}. Open the {item:16783} he gives you."] = "Folge von {area:380} der Straße nach Norden. {npc:8582} steht auf dem Wachturm am {area:1703}, wo die Straße nach {zone:1440} führt. Öffne {item:16783}, das er dir gibt.",
	-- ["Gaea Dirt Mounds"] = "Gaeaerdhügel",
	-- ["Gaea Seeds"] = "Gaeasamenkörner",
	-- ["Head back down the {area:1076} to {area:2539}."] = "Geh den {area:1076} zurück hinunter nach {area:2539}.",
	-- ["Head east to the {area:380} and fly to {zone:1454}. Take the zeppelin from the towers outside {zone:1454} to {zone:1420}; the {area:1497} lies below the {area:153}. The bat handler is in the {object:36078}."] = "Geh nach Osten zum {area:380} und flieg nach {zone:1454}. Nimm den Zeppelin von den Türmen vor {zone:1454} nach {zone:1420}; die {area:1497} liegt unter den {area:153}. Der Fledermausführer ist im {object:36078}.",
	-- ["Head south to the {area:380}, then west along the road out of the {zone:1413} into Stonetalon. The troll village of {area:2539} sits at the entrance of the canyon."] = "Geh nach Süden zum {area:380}, dann entlang der Straße nach Westen aus der {zone:1413} ins Steinkrallengebirge. Das Trolldorf {area:2539} liegt am Eingang der Schlucht.",
	-- ["Head west along the main road across {zone:1440}, past {area:415} (Alliance: keep to the road), to the coast. {area:2897} is on the {area:414} in the north-west. Its other quests are for the next visit, at 27."] = "Geh entlang der Hauptstraße nach Westen durch {zone:1440}, an {area:415} vorbei (Allianz: bleib auf der Straße), bis zur Küste. {area:2897} liegt am {area:414} im Nordwesten. Seine anderen Quests sind für den nächsten Besuch, mit 27.",
	-- ["If you already know the {area:272} flight path, fly there and skip to {area:272}. Otherwise fly from the {zone:1458} to the {area:228} and head south down the road past Pyrewood. The Ravenclaw undead haunt the ruins of {area:231} east of the road in the south-east of the forest; a {npc:1973} drops the {item:271343} that leads to the {object:645153}."] = "Kennst du den Flugpunkt {area:272} schon, flieg dorthin und spring zu {area:272}. Sonst flieg von der {zone:1458} zum {area:228} und geh die Straße nach Süden an Pyrewood vorbei. Die Untoten der Rabenklaue spuken in den Ruinen von {area:231} östlich der Straße im Südosten des Waldes; ein {npc:1973} lässt {item:271343} fallen, der zu {object:645153} führt.",
	-- ["If you already know the {area:272} flight path, fly there and skip to {area:272}. Otherwise fly from the {zone:1458} to the {area:228} and ride south down the road past Pyrewood. The Ravenclaw undead haunt the ruins of {area:231} east of the road in the south-east of the forest; a {npc:1973} drops the {item:271343} that leads to the {object:645153}."] = "Kennst du die Flugroute von {area:272} schon, flieg dorthin und spring weiter zu {area:272}. Sonst flieg von {zone:1458} zum {area:228} und reite die Straße nach Süden an Pyrewood vorbei. Die Untoten von Rabenklaue spuken in den Ruinen von {area:231} östlich der Straße im Südosten des Waldes; ein {npc:1973} lässt {item:271343} fallen, der zu {object:645153} führt.",
	-- ["Keep north on the road. The {npc:12862} waits at the Warsong lumber camp, south of Splintertree."] = "Bleib auf der Straße nach Norden. {npc:12862} wartet im Holzfällerlager der Warsong, südlich von Splintertree.",
	-- ["On the ride west, {npc:267214} is stuck in a ravine south of the main road, south-east of {area:415}. Shadowhorn Stags and Ashenvale Bears roam the woods all around it."] = "Auf dem Ritt nach Westen steckt {npc:267214} in einer Schlucht südlich der Hauptstraße fest, südöstlich von {area:415}. Schattenhornhirsche und Ashenvalebären streifen überall durch die Wälder drumherum.",
	-- ["Ride back down the {area:1076} to {area:2539}."] = "Reite den {area:1076} zurück hinunter nach {area:2539}.",
	-- ["Ride east to the {area:380} and fly to {zone:1454}. Take the zeppelin from the towers outside {zone:1454} to {zone:1420}; the {area:1497} lies below the {area:153}. The bat handler is in the {object:36078}."] = "Reite nach Osten nach {area:380} und flieg nach {zone:1454}. Nimm den Zeppelin von den Türmen vor {zone:1454} nach {zone:1420}; {area:1497} liegt unter den {area:153}. Der Fledermausführer ist im {object:36078}.",
	-- ["Ride south to the {area:380}, then west along the road out of the {zone:1413} into Stonetalon. The troll village of {area:2539} sits at the entrance of the canyon."] = "Reite nach Süden nach {area:380}, dann auf der Straße nach Westen aus dem {zone:1413} ins Steinkrallengebirge. Das Trolldorf {area:2539} liegt am Eingang der Schlucht.",
	-- ["Ride west along the main road across {zone:1440}, past {area:415} (Alliance: keep to the road), to the coast. {area:2897} is on the {area:414} in the north-west. Its other quests are for the next visit, at 27."] = "Reite auf der Hauptstraße nach Westen durch {zone:1440}, an {area:415} vorbei (Allianz: bleib auf der Straße), bis zur Küste. {area:2897} liegt am {area:414} im Nordwesten. Seine anderen Quests sind für den nächsten Besuch, mit 27.",
	-- ["South-west of Sun Rock lies the burned {area:465}. Plant the Gaea Seeds in the dirt mounds on the valley floor; the fire elementals drop {item:16312}. Bloodfury Harpies and Ambushers nest on the north side, Slayers and Roguefeathers to the south."] = "Südwestlich vom Sonnenfels liegt das {area:465}. Pflanz die Gaeasamenkörner in die Erdhügel auf dem Talgrund; die Feuerelementare lassen {item:16312} fallen. Harpyien und Wegelagerinnen der Blutfurien nisten auf der Nordseite, Töterinnen und Wildfedern im Süden.",
	-- ["Speak with {npc:10181}, in the {object:36126}: {quest:93739}"] = "Sprich mit {npc:10181} im {object:36126}: {quest:93739}",
	-- ["Sputtervalve in {area:392}: the next guide passes there"] = "Sputtervalve in {area:392}: Der nächste Guide kommt dort vorbei",
	-- ["Talk to {npc:10181}"] = "Sprich mit {npc:10181}",
	-- ["The Gaea Seeds lie in the grass around the southern shore of {area:464}, north of Sun Rock."] = "Die Gaeasamenkörner liegen im Gras am Südufer von {area:464}, nördlich vom Sonnenfels.",
	-- ["The road climbs north as the {area:1076}. {quest:1483} has a hut where the road forks east to {area:461}."] = "Die Straße steigt als {area:1076} nach Norden an. {quest:1483} hat eine Hütte, wo die Straße nach Osten zum {area:461} abzweigt.",
	-- ["The {npc:12864} patrols the road east of {area:428} toward the {area:430}."] = "{npc:12864} patrouilliert auf der Straße östlich von {area:428} Richtung {area:430}.",
	-- ["To the {area:1497}"] = "Nach {area:1497}",
	-- ["Use the {npc:212753} at the {object:645153} for a willing sacrifice and kill the {npc:212753} that answers. {quest:95883} is elite: grouping up is advised."] = "Benutze {npc:212753} an {object:645153} für ein freiwilliges Opfer und töte {npc:212753}, die antwortet. {quest:95883} ist Elite: Such dir am besten eine Gruppe.",
	-- ["{area:431} is just north up the road."] = "{area:431} liegt gleich nördlich die Straße hinauf.",
	-- ["{item:16746}, from the {item:16783}"] = "{item:16746}, aus dem {item:16783}",
	-- ["{item:271350}, from the Tortured Souls among the ruins"] = "{item:271350}, von den Gequälten Seelen in den Ruinen",
	-- ["{item:277936}, from any Bloodfury harpy"] = "{item:277936}, von jeder Harpyie der Blutfurien",
	-- ["{npc:11860}: Glittering Sunstones from the Bloodfury harpies"] = "{npc:11860}: Glitzernde Sonnensteine von den Harpyien der Blutfurien",
	-- ["{npc:11860}: Grish is at the {area:1718}, in the next guide"] = "{npc:11860}: Grish ist am {area:1718}, im nächsten Guide",
	-- ["{npc:11861}, beside {npc:11862}"] = "{npc:11861}, neben {npc:11862}",
	-- ["{npc:11862}, up on the ledge"] = "{npc:11862}, oben auf dem Felsvorsprung",
	-- ["{npc:12696} stands at {area:428}, the Warsong camp just north-east of Splintertree, beside the hunt board."] = "{npc:12696} steht bei {area:428}, dem Lager der Warsong gleich nordöstlich von Splintertree, neben dem Jagdbrett.",
	-- ["{npc:12696}'s hunt targets (Ursangous, Shadumbra, Sharptalon) are for the next {zone:1440} visit, at 27."] = "{npc:12696}s Jagdziele (Ursangus, Schattumbra, Scharfkralle) sind für den nächsten Besuch in {zone:1440}, mit 27.",
	-- ["{npc:12736} at Zoram'gar, at 27"] = "{npc:12736} in Zoram'gar, mit 27",
	-- ["{npc:12867} stands at the lumber camp. The night elf Outrunners stalk the woods south-east of it; they stealth, so watch for them."] = "{npc:12867} steht im Holzfällerlager. Die Kundschafter von Ashenvale pirschen durch die Wälder südöstlich davon; sie sind getarnt, also halte nach ihnen Ausschau.",
	-- ["{npc:4198}'s next quest, Ordanus, is on the Alliance side of {zone:1440}. Skip it."] = "{npc:4198}s nächste Quest, Ordanus, liegt auf der Allianzseite von {zone:1440}. Überspring sie.",
	-- ["{npc:4198}, outside the gate"] = "{npc:4198}, vor dem Tor",
	-- ["{npc:4606} stands in the {object:36070}."] = "{npc:4606} steht im {object:36070}.",
}
