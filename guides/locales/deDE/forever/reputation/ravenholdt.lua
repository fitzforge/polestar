-- German (deDE): the guide forever/reputation/ravenholdt (forever/reputation/ravenholdt.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Ravenholdt Reputation"] = "Ruf: Rabenholdt",
	["The assassins' guild: Forever's new rogue quests, then Syndicate kills and Heavy Junkboxes to Exalted."] = "Die Gilde der Assassinen: Forevers neue Schurken-Quests, dann Kills an der Syndicate und Heavy Junkboxes bis Ehrfürchtig.",
	-- {faction:349} Ravenholdt
	["{faction:349} reputation (no vendor or reward in Forever's data)"] = "Ruf bei {faction:349} (kein Händler oder Belohnung in Forevers Daten)",

	-- Step 1: The Manor, Ravenholdt
	-- {item:17126} Elegant Letter · {area:275} Durnholde Keep · {npc:6707} Fahrad
	["Rogues from level 24: ask your class trainer in a capital \"May I have it, please?\" for the {item:17126}, and read it. The path up to the manor starts in the hills north of {area:275}. In the tunnel on the way lies a chest: do not open it (an elite guard jumps out), just walk past it to earn the Rite of Cunning. {npc:6707} waits on the manor's balcony."] = "Schurken ab Stufe 24: Frag deinen Klassenlehrer in einer Hauptstadt „May I have it, please?“ nach dem {item:17126} und lies ihn. Der Pfad hinauf zum Herrenhaus beginnt in den Hügeln nördlich von {area:275}. Im Tunnel auf dem Weg liegt eine Truhe: Öffne sie nicht (eine Elite-Wache springt heraus), geh einfach daran vorbei, um den Rite of Cunning zu erhalten. {npc:6707} wartet auf dem Balkon des Herrenhauses.",
	-- {item:17126} Elegant Letter
	["{item:17126}, from your class trainer"] = "{item:17126}, von deinem Klassenlehrer",
	["walk past the trapped chest in the tunnel"] = "geh an der Truhe mit der Falle im Tunnel vorbei",
	-- {npc:6707} Fahrad
	["{npc:6707}: 100 reputation"] = "{npc:6707}: 100 Ruf",

	-- Step 2: Myrokos Silentform
	-- {npc:13085} Myrokos Silentform · {quest:96779} Syndicate Sabotage · {quest:96781} What's the Big Idea? · {quest:96782} Covert Extraction · {quest:96786} The Syndicate Sting · {quest:96783} A Way In · {item:5140} Flash Powder
	["{npc:13085}, in the manor, has Forever's new rogue quests: 100 reputation each for {quest:96779}, {quest:96781} and {quest:96782}, which follows it, and 300 for {quest:96786} at the end of the Stromgarde chain ({quest:96783} and the two quests after it pay nothing). All can be done solo with stealth from level 30; below that, the Master of Deception talent and a {item:5140} for Vanish help."] = "{npc:13085} im Herrenhaus hat Forevers neue Schurken-Quests: je 100 Ruf für {quest:96779}, {quest:96781} und {quest:96782}, die darauf folgt, und 300 für {quest:96786} am Ende der Stromgarde-Reihe ({quest:96783} und die zwei Quests danach zahlen nichts). Alle sind ab Stufe 30 allein mit Tarnung machbar; darunter helfen das Talent Meister der Täuschung und ein {item:5140} für Verschwinden.",

	-- Step 3: Durnholde Keep: Lord Tomas
	-- {npc:266216} Lord Tomas · {area:275} Durnholde Keep · {area:271} Southshore
	["{npc:266216} is inside {area:275}, the Syndicate fortress east of {area:271}. Stealth past the guards in the courtyard."] = "{npc:266216} ist in {area:275}, der Festung der Syndicate östlich von {area:271}. Schleich an den Wachen im Hof vorbei.",

	-- Step 4: Strahnbrad: Barton
	-- {area:280} Strahnbrad
	["{area:280}: Barton"] = "{area:280}: Barton",
	-- {area:280} Strahnbrad
	["Barton hides in a house in {area:280}, among stealthed Syndicate. Pick his pocket for the report; Distract turns him around if you are under his level."] = "Barton versteckt sich in einem Haus in {area:280}, zwischen getarnten Syndicate. Beklaue ihn für den Bericht; Ablenken dreht ihn um, wenn du unter seiner Stufe bist.",
	-- {item:275482} Barton's Scouting Report
	["{item:275482}: pickpocket Barton"] = "{item:275482}: Barton bestehlen",

	-- Step 5: Northfold Manor: a uniform
	-- {area:313} Northfold Manor
	["{area:313}: a uniform"] = "{area:313}: eine Uniform",
	-- {object:656157} Syndicate Footlocker · {area:313} Northfold Manor · {quest:96783} A Way In · {item:275706} Syndicate Uniform
	["The {object:656157} stands among the Syndicate camps of {area:313}, north of Stromgarde. Open it to finish {quest:96783} and take the {item:275706}."] = "Die {object:656157} steht zwischen den Lagern der Syndicate in {area:313}, nördlich von Stromgarde. Öffne sie, um {quest:96783} abzuschließen und die {item:275706} zu nehmen.",

	-- Step 6: Stromgarde: Anastasia Miller
	-- {npc:266847} Anastasia Miller
	["Stromgarde: {npc:266847}"] = "Stromgarde: {npc:266847}",
	-- {item:275706} Syndicate Uniform · {npc:266847} Anastasia Miller
	["Put on the {item:275706} and go into Stromgarde. {npc:266847} waits on a ledge just outside the castle; players reach her by jumping from the roof of the house beside the ledge. Her stash is upstairs in a house near the keep."] = "Zieh die {item:275706} an und geh nach Stromgarde. {npc:266847} wartet auf einem Felsvorsprung direkt vor der Burg; Spieler erreichen sie, indem sie vom Dach des Hauses neben dem Vorsprung springen. Ihr Versteck ist oben in einem Haus nahe der Festung.",
	-- {item:275709} Stolen Funds
	["{item:275709}, in Anastasia's Stash upstairs"] = "{item:275709}, in Anastasias Versteck im Obergeschoss",

	-- Step 7: Thoradin's Wall: the shipment
	-- {area:1057} Thoradin's Wall
	["{area:1057}: the shipment"] = "{area:1057}: die Lieferung",
	-- {area:1057} Thoradin's Wall · {zone:1417} Arathi Highlands · {item:275882} Intercepted Shipment · {npc:13085} Myrokos Silentform
	["The hand-off is at the southern end of {area:1057}, in the west of the {zone:1417}: two Syndicate guard the box. Kill them or lure them off, then take the {item:275882}. Keep the uniform: {npc:13085} wants it back."] = "Die Übergabe ist am Südende von {area:1057}, im Westen des {zone:1417}: Zwei Syndicate bewachen die Kiste. Töte sie oder lock sie weg und nimm dann die {item:275882}. Behalte die Uniform: {npc:13085} will sie zurück.",

	-- Step 8: Back to Myrokos Silentform
	-- {npc:13085} Myrokos Silentform
	["Back to {npc:13085}"] = "Zurück zu {npc:13085}",
	-- {quest:96782} Covert Extraction · {quest:96781} What's the Big Idea?
	["{quest:96782}, after {quest:96781}"] = "{quest:96782}, nach {quest:96781}",

	-- Step 9: Ruins of Alterac: the Perenolde heirlooms
	-- {area:281} Ruins of Alterac
	["{area:281}: the Perenolde heirlooms"] = "{area:281}: die Erbstücke der Perenolde",
	-- {area:281} Ruins of Alterac · {zone:1416} Alterac Mountains
	["The two heirlooms lie in two towers of the {area:281}, the ogre-held ruin in the middle of the {zone:1416}. The tower with the sword is ringed by elite ogres: stay in stealth. Neither item is guarded once you are inside."] = "Die beiden Erbstücke liegen in zwei Türmen der {area:281}, der von Ogern gehaltenen Ruine mitten im {zone:1416}. Der Turm mit dem Schwert ist von Elite-Ogern umringt: Bleib in Tarnung. Keiner der Gegenstände wird bewacht, sobald du drinnen bist.",
	-- {item:275636} Royal Aegis of Perenolde
	["{item:275636}, the shield"] = "{item:275636}, der Schild",
	-- {item:275635} Blade of House Perenolde
	["{item:275635}, the sword"] = "{item:275635}, das Schwert",

	-- Step 10: Syndicate Emblems to Friendly
	-- {quest:6701} Syndicate Emblems
	["{quest:6701} to Friendly"] = "{quest:6701} bis Freundlich",
	-- {npc:6766} Ravenholdt Guard · {quest:6701} Syndicate Emblems
	-- plural, as words: Syndicate Prowlers = {npc:2588} Syndicate Prowler
	["Neutral to Friendly is 3,000 reputation; the quests above pay 700 of it. Any {npc:6766} on the path takes {quest:6701}, 100 reputation each, until you reach Friendly: 23 emblems after the quests. Pick the pockets of Syndicate humans; they never drop emblems when killed. The Arathi camps pay best: Syndicate Prowlers and Conjurors carry one about a quarter of the time. Kill what you have robbed so the next ones respawn fresh."] = "Von Neutral bis Freundlich sind es 3.000 Ruf; die Quests oben bringen davon 700. Jeder {npc:6766} auf dem Pfad nimmt {quest:6701} an, je 100 Ruf, bis du Freundlich erreichst: 23 Embleme nach den Quests. Beklaue die Menschen der Syndicate; getötet lassen sie nie Embleme fallen. Die Lager in Arathi zahlen am besten: Syndicate Prowlers und Conjurors tragen etwa in einem Viertel der Fälle eines. Töte, wen du bestohlen hast, damit die nächsten frisch respawnen.",
	-- {item:17124} Syndicate Emblem
	["{item:17124}: pickpocket Syndicate"] = "{item:17124}: Syndicate bestehlen",
	-- {npc:6766} Ravenholdt Guard
	["a {npc:6766}: 100 per emblem"] = "ein {npc:6766}: 100 pro Emblem",

	-- Step 11: Syndicate kills to the end of Honored
	["Syndicate kills to the end of Honored"] = "Kills an der Syndicate bis Ende Wohlwollend",
	-- {faction:349} Ravenholdt · {zone:1416} Alterac Mountains
	-- plural, as words: Syndicate Assassins = {npc:2246} Syndicate Assassin
	["Everyone, not only rogues: in Classic every Syndicate human gave {faction:349} 5 reputation up to the end of Honored (11,999 of 12,000) and not one point more, so 0 to there is 4,200 kills (3,600 after a rogue's quests and emblems). This step ticks at Honored; keep killing until the bar stops moving, then go on to the junkboxes. The highest Syndicate are in the north-west of the {zone:1416}, Syndicate Assassins and Enforcers (level 38-40), with Syndicate Sentries (36-37) nearer the middle. At 60 all Syndicate are grey, and in Classic grey kills gave about a fifth: farm them before 48 if you can. Legacy Diplomat adds up to 10%."] = "Für alle, nicht nur Schurken: In Classic gab jeder Mensch der Syndicate {faction:349} 5 Ruf bis zum Ende von Wohlwollend (11.999 von 12.000) und keinen Punkt mehr, also sind es von 0 bis dorthin 4.200 Kills (3.600 nach den Quests und Emblemen eines Schurken). Dieser Schritt wird bei Wohlwollend abgehakt; töte weiter, bis die Leiste sich nicht mehr bewegt, und geh dann zu den Junkboxes. Die höchsten Syndicate sind im Nordwesten des {zone:1416}, Syndicate Assassins und Enforcers (Stufe 38-40), mit Syndicate Sentries (36-37) näher an der Mitte. Auf 60 sind alle Syndicate grau, und in Classic gaben graue Kills etwa ein Fünftel: Farme sie vor 48, wenn du kannst. Vermächtnis-Vorteil „Diplomat“ gibt bis zu 10 % mehr.",
	-- {npc:2246} Syndicate Assassin
	["{npc:2246}, level 38-39"] = "{npc:2246}, Stufe 38-39",
	-- {npc:2247} Syndicate Enforcer
	["{npc:2247}, level 39-40"] = "{npc:2247}, Stufe 39-40",
	-- {npc:2243} Syndicate Sentry
	["{npc:2243}, level 36-37"] = "{npc:2243}, Stufe 36-37",

	-- Step 12: A Simple Request, rogues 50+
	-- {quest:8233} A Simple Request
	["{quest:8233}, rogues 50+"] = "{quest:8233}, Schurken ab 50",
	-- {npc:6768} Lord Jorach Ravenholdt · {quest:8234} Sealed Azure Bag · {zone:1447} Azshara · {quest:8235} Encoded Fragments · {quest:8236} The Azure Key · {area:1477} Temple of Atal'Hakkar
	-- plural, as words: Timbermaw Shamans = {npc:6188} Timbermaw Shaman · Forest Oozes = {npc:8766} Forest Ooze
	["At level 50 your class trainer has another letter for you, and {npc:6768} a short chain: 360 reputation in all. The {quest:8234} drops from Timbermaw Shamans in northern {zone:1447} (about 1 in 27, or pick their pockets); the {quest:8235} from Forest Oozes in {zone:1447} (4 in 5). {quest:8236} comes from Morphaz, an elite drake deep in the {area:1477}: a five-player dungeon, group up."] = "Auf Stufe 50 hat dein Klassenlehrer einen weiteren Brief für dich, und {npc:6768} eine kurze Reihe: insgesamt 360 Ruf. Die {quest:8234} fällt von Timbermaw Shamans im nördlichen {zone:1447} (etwa 1 von 27, oder beklaue sie); die {quest:8235} von Forest Oozes in {zone:1447} (4 von 5). {quest:8236} kommt von Morphaz, einem Elite-Drachen tief im {area:1477}: ein Dungeon für fünf Spieler, bildet eine Gruppe.",
	-- {quest:8234} Sealed Azure Bag
	-- plural, as words: Timbermaw Shamans = {npc:6188} Timbermaw Shaman
	["{quest:8234}: Timbermaw Shamans"] = "{quest:8234}: von Timbermaw-Shamanen",
	-- {item:20023} Encoded Fragment
	-- plural, as words: Forest Oozes = {npc:8766} Forest Ooze
	["{item:20023}: Forest Oozes"] = "{item:20023}: von Forest Oozes",
	-- {item:20022} Azure Key · {area:1477} Temple of Atal'Hakkar
	["{item:20022}: Morphaz, {area:1477} (group)"] = "{item:20022}: Morphaz, {area:1477} (Gruppe)",

	-- Step 13: Heavy Junkboxes to Exalted
	["Heavy Junkboxes to Exalted"] = "Heavy Junkboxes bis Ehrfürchtig",
	-- {quest:8249} Junkboxes Needed · {npc:6707} Fahrad · {item:20086} Dusksteel Throwing Knife · {area:1583} Blackrock Spire · {area:1584} Blackrock Depths
	["From the top of Honored to Exalted is 21,001 reputation, and {quest:8249} is the only way: {npc:6707} pays 50 and a {item:20086} for every five Heavy Junkboxes (Classic Era paid 75), 421 turn-ins and 2,105 boxes. Boxes count at any standing, so take the cheap kills to their cap first. Any class can hand them in. Rogues get them by picking the pockets of humanoids around level 50 and up: Lower {area:1583} and {area:1584} are the classic spots, pick every pocket, reset and go again. The boxes do not bind, so everyone else buys them from rogues or at the auction house. Hand them in unopened; an opened box you empty vanishes, so leave one item in it."] = "Von der Spitze von Wohlwollend bis Ehrfürchtig sind es 21.001 Ruf, und {quest:8249} ist der einzige Weg: {npc:6707} zahlt 50 und ein {item:20086} für je fünf Heavy Junkboxes (Classic Era zahlte 75), 421 Abgaben und 2.105 Kisten. Die Kisten zählen bei jedem Rufrang, nimm also zuerst die billigen Kills bis zu ihrem Limit. Jede Klasse kann sie abgeben. Schurken bekommen sie, indem sie Humanoide ab etwa Stufe 50 beklauen: Untere {area:1583} und {area:1584} sind die klassischen Orte, beklaue jeden, setz zurück und beginn von vorn. Die Kisten werden nicht gebunden, alle anderen kaufen sie also bei Schurken oder im Auktionshaus. Gib sie ungeöffnet ab; eine geöffnete Kiste, die du leerst, verschwindet, lass also einen Gegenstand darin.",
	-- {item:16885} Heavy Junkbox · {area:1445} Blackrock Mountain
	["{item:16885}: pickpocket level 50+ humanoids, {area:1445}"] = "{item:16885}: Humanoide ab Stufe 50 beklauen, {area:1445}",
	-- {npc:6707} Fahrad
	["{npc:6707}: 50 per five boxes"] = "{npc:6707}: 50 pro fünf Kisten",
}
