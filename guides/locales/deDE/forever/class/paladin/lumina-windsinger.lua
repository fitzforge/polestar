-- German (deDE): the guide forever/class/paladin/lumina-windsinger (forever/class/paladin/lumina-windsinger.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:268484} Moonsilver Blade · {item:267369} Wolfsbane
	["{item:268484} and {item:267369} (Forsaken)"] = "{item:268484} und {item:267369} (Verlassene)",
	-- {quest:91862} Lumina Windsinger · {quest:95140} Old Fire-Eye
	["The Forsaken paladin's two-handed sword: rescue {quest:91862}, gather three parts, slay {quest:95140}."] = "Das Zweihandschwert des verlassenen Paladins: Rette {quest:91862}, sammle drei Teile, erschlage {quest:95140}.",

	-- Step 1: Danitha Morr
	-- {npc:246378} Danitha Morr · {area:16602} Bandarion Keep · {area:156} Solliden Farmstead · {area:228} Sepulcher · {zone:1421} Silverpine Forest
	["At 18 {npc:246378}, inside {area:16602} on the bluffs north-west of the {area:156}, sends you south to the {area:228} in {zone:1421}."] = "Mit Stufe 18 schickt dich {npc:246378} in {area:16602} auf den Klippen nordwestlich des {area:156} nach Süden zum {area:228} in {zone:1421}.",

	-- Step 2: Sepulcher
	-- {npc:248840} Trevan Rol · {area:228} Sepulcher · {npc:259611} Deathguard Baldren
	["{npc:248840} stands in the lower part of the {area:228}, below the surface; {npc:259611} keeps watch near the town's entrance."] = "{npc:248840} steht im unteren Teil des {area:228}, unter der Oberfläche; {npc:259611} hält Wache nahe dem Eingang der Stadt.",

	-- Step 3: The pyre on Fenris Isle
	-- {area:172} Fenris Isle
	["The pyre on {area:172}"] = "Der Scheiterhaufen auf der {area:172}",
	-- {area:172} Fenris Isle · {area:228} Sepulcher · {object:566037} Charred Remains
	["{area:172} lies in the lake north-east of the {area:228}. The gnolls' pyre, with the {object:566037}, is on its shore: click the remains to hand in, and click them again for the next quest. The body is a tauren's, not the elf's."] = "{area:172} liegt im See nordöstlich des {area:228}. Der Scheiterhaufen der Gnolle mit {object:566037} steht an seinem Ufer: Klick die Überreste an, um abzugeben, und klick sie noch einmal für die nächste Quest an. Der Leichnam gehört einem Tauren, nicht der Elfe.",
	-- {object:566037} Charred Remains
	["from the {object:566037}"] = "von den {object:566037}",

	-- Step 4: Fenris Keep
	-- {quest:91862} Lumina Windsinger · {area:235} Fenris Keep · {item:267412} Fenris Isle Key · {npc:1944} Rot Hide Bruiser
	["{quest:91862} is caged in the basement of {area:235}, at the north end of the isle. The Rot Hide gnolls (level 18-19) fill the keep: they pull in big groups across floors and players report very fast respawns, so clear a path and keep moving. Any of them can carry the {item:267412} (often the first kill); the rare {npc:1944} (22) and Snarlmane (23) can too. If her cage is empty, another player is escorting her: wait for her to come back."] = "{quest:91862} ist im Keller von {area:235} am Nordende der Insel in einen Käfig gesperrt. Die Rot Hide-Gnolle (Stufe 18-19) füllen die Festung: Sie kommen in großen Gruppen über Stockwerke hinweg, und Spieler berichten von sehr schnellen Respawns, also räum einen Weg frei und bleib in Bewegung. Jeder von ihnen kann {item:267412} tragen (oft der erste Kill); die Rares {npc:1944} (22) und Snarlmane (23) auch. Ist ihr Käfig leer, eskortiert sie ein anderer Spieler: Warte, bis sie zurückkommt.",
	-- {item:267412} Fenris Isle Key
	["{item:267412}, from the Rot Hide gnolls"] = "{item:267412}, von den Gnollen der Moderfelle",

	-- Step 5: Free Lumina Windsinger
	-- {npc:248755} Lumina Windsinger
	["Free {npc:248755}"] = "Befreie {npc:248755}",
	-- {npc:248755} Lumina Windsinger · {area:228} Sepulcher
	["Hand in the key first: starting the escort before that gives the key quest no credit. Then open the cage: {npc:248755} walks out through the keep and its courtyard while the gnolls attack, then runs for the dock and makes her own way back to the {area:228}. Stay close and keep her alive; if she dies, take the quest again when she is back in her cage."] = "Gib zuerst den Schlüssel ab: Beginnst du die Eskorte davor, bekommt die Schlüsselquest keinen Fortschritt. Öffne dann den Käfig: {npc:248755} geht durch die Festung und ihren Hof, während die Gnolle angreifen, läuft dann zum Dock und findet allein ihren Weg zurück zum {area:228}. Bleib dicht bei ihr und halte sie am Leben; stirbt sie, nimm die Quest noch einmal an, wenn sie wieder in ihrem Käfig ist.",

	-- Step 6: Back to the Sepulcher
	-- {area:228} Sepulcher
	["Back to the {area:228}"] = "Zurück zum {area:228}",
	-- {npc:259620} Lumina Windsinger · {npc:248840} Trevan Rol · {area:228} Sepulcher · {quest:95034} The Debt
	["{npc:259620} waits beside {npc:248840} in the {area:228} (a different {npc:259620} from the one you escorted). For {quest:95034}, click through every line of her story."] = "{npc:259620} wartet neben {npc:248840} im {area:228} (ein anderer {npc:259620} als der, den du eskortiert hast). Klick für {quest:95034} jede Zeile ihrer Geschichte durch.",
	-- {npc:259620} Lumina Windsinger · {area:228} Sepulcher
	["{npc:259620}, the {area:228}"] = "{npc:259620}, das {area:228}",
	-- {npc:259620} Lumina Windsinger
	["{npc:259620}: hear her story to the end"] = "{npc:259620}: hör ihre Geschichte bis zum Ende",

	-- Step 7: A Moon-Kissed Blade
	-- {npc:259620} Lumina Windsinger · {quest:95140} Old Fire-Eye · {npc:248840} Trevan Rol
	["At 20 {npc:259620} asks for a blade that can kill {quest:95140}. Talk to {npc:248840} beside her for his Weapon Notes, which list the parts, and keep them: he wants them back with the parts. Three parts, in any order: two from dungeons (a group of five each) and a gem from elite naga outside a third."] = "Mit Stufe 20 bittet {npc:259620} um eine Klinge, die {quest:95140} töten kann. Sprich mit {npc:248840} neben ihr für seine Weapon Notes, die die Teile auflisten, und behalte sie: Er will sie mit den Teilen zurück. Drei Teile in beliebiger Reihenfolge: zwei aus Dungeons (je eine Gruppe aus fünf) und ein Edelstein von Naga-Elite vor einem dritten.",
	-- {item:267454} Trevan's Weapon Notes · {npc:248840} Trevan Rol
	["{item:267454}: talk to {npc:248840}"] = "{item:267454}: sprich mit {npc:248840}",

	-- Step 8: The Enchanted Silver Ingot
	-- {item:267361} Enchanted Silver Ingot
	["The {item:267361}"] = "{item:267361}",
	-- {area:236} Shadowfang Keep · {npc:4275} Archmage Arugal
	["{area:236} is the dungeon in south Silverpine, for a group of five in the low to mid 20s. The ingot sits on the table next to {npc:4275} at the very end. A friend's cleared instance works: walk in and run to the table."] = "{area:236} ist der Dungeon im Süden von Silverpine, für eine Gruppe aus fünf in den niedrigen bis mittleren Zwanzigern. Der Barren liegt auf dem Tisch neben {npc:4275} ganz am Ende. Die bereits geräumte Instanz eines Freundes geht: Lauf hinein und renn zum Tisch.",
	-- {item:267361} Enchanted Silver Ingot
	["{item:267361}, on Arugal's table"] = "{item:267361}, auf Arugals Tisch",

	-- Step 9: Whitestone Oak Lumber
	-- {area:1581} The Deadmines · {area:20} Moonbrook · {zone:1436} Westfall · {zone:1458} Undercity · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1434} Stranglethorn Vale · {zone:1431} Duskwood
	-- plural, as words: Goblin Woodcarvers = {npc:641} Goblin Woodcarver
	["{area:1581} lies under {area:20} in {zone:1436}, Alliance land: a group of five at about 17-24. From the {zone:1458} take the zeppelin to {object:3202} in {zone:1434} and go north through {zone:1431} into {zone:1436}. The way in is the {area:20} mine. The Goblin Woodcarvers (elite, level 18-19) in Sneed's mast room drop the lumber every time."] = "{area:1581} liegt unter {area:20} in {zone:1436}, Allianzgebiet: eine Gruppe aus fünf mit etwa Stufe 17-24. Nimm von {zone:1458} den Zeppelin nach {object:3202} in {zone:1434} und geh nach Norden durch {zone:1431} nach {zone:1436}. Der Weg hinein ist die Mine von {area:20}. Die Goblin Woodcarvers (Elite, Stufe 18-19) in Sneeds Mastraum lassen das Holz jedes Mal fallen.",
	-- {area:1581} The Deadmines · {area:20} Moonbrook
	["{area:1581}, in the {area:20} mine"] = "{area:1581}, in der Mine von {area:20}",
	-- plural, as words: Goblin Woodcarvers = {npc:641} Goblin Woodcarver
	["Goblin Woodcarvers, inside"] = "Goblin-Holzschnitzer, drinnen",

	-- Step 10: Ulric Frostveil
	-- {npc:259649} Ulric Frostveil · {area:2897} Zoram'gar Outpost · {zone:1440} Ashenvale · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1458} Undercity · {zone:1454} Orgrimmar · {zone:1413} Barrens
	["{npc:259649} waits at {area:2897} on {zone:1440}'s west coast: take the zeppelin from {object:3202} (or the {zone:1458}) to {zone:1454}, then go north through the {zone:1413} into {zone:1440} and west along the road. Andruk, the outpost's wind rider master, saves you the walk next time. Take {npc:259649}'s quest before you hunt the naga: the Kor Gem only drops while you have it."] = "{npc:259649} wartet in {area:2897} an der Westküste von {zone:1440}: Nimm den Zeppelin von {object:3202} (oder aus {zone:1458}) nach {zone:1454}, geh dann nördlich durch {zone:1413} nach {zone:1440} und folge der Straße nach Westen. Andruk, der Windreitermeister des Außenpostens, erspart dir den Weg beim nächsten Mal. Nimm die Quest von {npc:259649} an, bevor du die Naga jagst: Der Kor Gem fällt nur, solange du sie hast.",

	-- Step 11: The Corrupted Kor Gem
	-- {item:6995} Corrupted Kor Gem
	["The {item:6995}"] = "{item:6995}",
	-- {area:2797} Blackfathom Deeps · {item:6995} Corrupted Kor Gem · {spell:122} Frost Nova
	["The naga stand in the flooded ruins and passages around the {area:2797} entrance, just north of Zoram'gar: you do not need to enter the instance (its first naga drop the gem too). Tide Priestesses (level 20-21), Oracles (21-22) and Sea Witches (23-24) drop the {item:6995}, one in two. All are elite: grouping up is encouraged. Players solo them one at a time, with difficulty; a group of three makes it easy. They heal themselves, run for help at low health, and the Sea Witches cast {spell:122} up close. Some players report no drop while in a raid group."] = "Die Naga stehen in den überfluteten Ruinen und Gängen rund um den Eingang von {area:2797}, nördlich von Zoram'gar: Du musst die Instanz nicht betreten (auch ihre ersten Naga lassen den Kor Gem fallen). Tide Priestesses (Stufe 20-21), Oracles (21-22) und Sea Witches (23-24) lassen den {item:6995} fallen, jede zweite. Alle sind Elite: Sich zu gruppieren ist empfehlenswert. Solo schaffst du sie nur einzeln und mit Mühe; mit einer Gruppe aus drei Spielern ist es leicht. Sie heilen sich selbst, rufen bei wenig Leben um Hilfe, und die Sea Witches wirken aus der Nähe {spell:122}. Manche Spieler berichten, dass in einer Schlachtzugsgruppe nichts fällt.",

	-- Step 12: The Purified Kor Gem
	-- {item:272448} Purified Kor Gem
	["The {item:272448}"] = "Der {item:272448}",
	-- {npc:259649} Ulric Frostveil · {item:272448} Purified Kor Gem · {npc:248840} Trevan Rol
	["Back to {npc:259649} at Zoram'gar: he cleanses the gem. Keep the {item:272448} for {npc:248840}."] = "Zurück zu {npc:259649} in Zoram'gar: Er reinigt den Kor Gem. Behalte den {item:272448} für {npc:248840}.",

	-- Step 13: Trevan Rol
	-- {npc:248840} Trevan Rol · {area:228} Sepulcher · {item:268192} Bundle of Blacksmithing Materials · {area:272} Tarren Mill
	["Bring the lumber, the ingot and the gem to {npc:248840} in the {area:228}. He gives you a {item:268192} for a smith in {area:272}: keep it in your bags."] = "Bring das Holz, den Barren und den Kor Gem zu {npc:248840} in {area:228}. Er gibt dir {item:268192} für einen Schmied in {area:272}: Behalte es in deinen Taschen.",

	-- Step 14: Ott
	-- {npc:3539} Ott · {area:272} Tarren Mill · {zone:1424} Hillsbrad Foothills · {quest:95125} Ott's Masterwork
	["{npc:3539}, the weaponsmith, stands just south of {area:272} in {zone:1424}. Accepting {quest:95125} starts the forging: step back and wait near him until he is done."] = "{npc:3539}, der Waffenschmied, steht südlich von {area:272} in {zone:1424}. Mit dem Annehmen von {quest:95125} beginnt das Schmieden: Tritt zurück und warte in seiner Nähe, bis er fertig ist.",
	-- {npc:3539} Ott
	["Watch {npc:3539} forge the blade"] = "Sieh {npc:3539} beim Schmieden der Klinge zu",
	-- {npc:3539} Ott · {quest:95125} Ott's Masterwork
	["{npc:3539} gives you {quest:95125}"] = "{npc:3539} gibt dir {quest:95125}",

	-- Step 15: The Moonsilver Blade
	-- {npc:248840} Trevan Rol · {area:228} Sepulcher · {item:268484} Moonsilver Blade
	["Back to {npc:248840} in the {area:228}'s lower part: he hands you the {item:268484}, a two-handed sword."] = "Zurück zu {npc:248840} im unteren Teil von {area:228}: Er überreicht dir {item:268484}, ein Zweihandschwert.",

	-- Step 16: Two-Handed Swords
	-- {npc:11870} Archibald · {zone:1458} Undercity · {object:36070} War Quarter · {spell:202} Two-Handed Swords
	["The blade is a two-handed sword, and you need the skill to hit a level 25 elite with it. {npc:11870}, the weapon master in the {zone:1458}'s {object:36070}, teaches {spell:202} for a small fee; then swing it on easy mobs until the skill is near its cap (five points per level)."] = "Die Klinge ist ein Zweihandschwert, und du brauchst die Fertigkeit, um damit einen Elite der Stufe 25 zu treffen. {npc:11870}, der Waffenmeister im {object:36070} von {zone:1458}, bringt dir {spell:202} gegen eine kleine Gebühr bei; übe dann mit dem Schwert an leichten Mobs, bis die Fertigkeit fast am Maximum ist (fünf Punkte pro Stufe).",

	-- Step 17: Old Fire-Eye
	-- {item:268484} Moonsilver Blade · {quest:95140} Old Fire-Eye · {area:228} Sepulcher · {area:17065} Gilneas
	["Equip the {item:268484}. {quest:95140}, the great worgen, roams the woods south of the {area:228} toward the gates of {area:17065}. He is elite (level 25): grouping up is encouraged; one player needed a second, another soloed him at 25. A purple shield guards him until your first swing with the blade lands: a message tells you it broke."] = "Rüste {item:268484} aus. {quest:95140}, der große Worgen, streift durch die Wälder südlich von {area:228} in Richtung der Tore von {area:17065}. Er ist Elite (Stufe 25): Sich zu gruppieren ist empfehlenswert; ein Spieler brauchte einen zweiten, ein anderer hat ihn solo auf Stufe 25 geschafft. Ein violetter Schild schützt ihn, bis dein erster Schlag mit der Klinge trifft: Eine Meldung verrät dir, dass er zerbrochen ist.",
	-- {quest:95140} Old Fire-Eye · {item:268484} Moonsilver Blade
	["{quest:95140}, with the {item:268484} equipped"] = "{quest:95140}, mit ausgerüstetem {item:268484}",

	-- Step 18: Wolfsbane
	-- {npc:259620} Lumina Windsinger · {area:228} Sepulcher · {item:268484} Moonsilver Blade · {item:267369} Wolfsbane
	["Back to {npc:259620} in the {area:228} with the {item:268484} (the quest asks for it): she takes it and blesses it with the magic of her people into {item:267369}."] = "Zurück zu {npc:259620} in {area:228} mit {item:268484} (die Quest verlangt es): Sie nimmt es entgegen und segnet es mit der Magie ihres Volkes zu {item:267369}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Free her with the key, then stay close while she fights her way out of the keep."] = "Befreie sie mit dem Schlüssel und bleib dann in ihrer Nähe, während sie sich aus der Burg kämpft.",
	-- ["Head south through {zone:1421} to the {area:228}. {npc:248840} stands in the town; {npc:259611} keeps watch near its entrance."] = "Geh nach Süden durch {zone:1421} zum {area:228}. {npc:248840} steht in der Stadt; {npc:259611} hält in der Nähe des Eingangs Wache.",
	-- ["No item yet: a Forsaken paladin rescue story; its sequel, the {item:268484}, cannot be finished yet."] = "Noch kein Gegenstand: eine Rettungsgeschichte für Paladine der Verlassenen; die Fortsetzung, die {item:268484}, kann noch nicht abgeschlossen werden.",
	-- ["Once she is clear of {area:235}, Lumina waits for you in the {area:228}. Speak with her again to hear what really happened on the road."] = "Sobald sie aus {area:235} heraus ist, wartet Lumina im Ort {area:228} auf dich. Sprich erneut mit ihr, um zu erfahren, was auf der Straße wirklich geschah.",
	-- ["Once she is clear of {area:235}, {npc:259620} waits for you in the {area:228}. Speak with her again to hear what really happened on the road."] = "Sobald sie aus {area:235} heraus ist, wartet {npc:259620} im {area:228} auf dich. Sprich erneut mit ihr, um zu erfahren, was auf der Straße wirklich geschah.",
	-- ["Rescuing {quest:91862}"] = "{quest:91862} retten",
	-- ["Ride south through {zone:1421} to the {area:228}. {npc:248840} stands in the town; {npc:259611} keeps watch near its entrance."] = "Reite nach Süden durch {zone:1421} zum {area:228}. {npc:248840} steht im Ort; {npc:259611} hält nahe dem Eingang Wache.",
	-- ["{area:172} lies in the lake east of the {area:228}. The charred remains are on its shore."] = "Die {area:172} liegt im See östlich vom {area:228}. Die verkohlten Überreste sind am Ufer.",
	-- ["{npc:246378} leads the Paladins of Tyr's Watch from inside {area:16602}, on the bluffs north-west of the {area:156}."] = "{npc:246378} führt die Paladine von Tyrs Wacht aus {area:16602} heraus, auf den Klippen nordwestlich von {area:156}.",
	-- ["{quest:91862} is caged inside {area:235}, at the north end of the isle. The Rot Hide gnolls around her carry the key."] = "{quest:91862} ist in {area:235} eingesperrt, am Nordende der Insel. Die Gnolle der Moderfelle um sie herum tragen den Schlüssel.",
	-- ["{zone:1458} and Earthen Ring reputation"] = "Ruf bei {zone:1458} und beim Irdenen Ring",
}
