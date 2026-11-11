-- German (deDE): the guide forever/class/warlock/impsys-request (forever/class/warlock/impsys-request.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:14470} Impsy
	["A staff, off-hand or robe for your 50s; {npc:14470}'s own errand, not a step of the Dreadsteed chain."] = "Ein Stab, ein Schildhand-Gegenstand oder eine Robe für deine 50er; ein eigener Auftrag von {npc:14470}, kein Schritt der Schreckensross-Questreihe.",

	-- Step 1: An Imp's Request (Stormwind)
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:14470} Impsy · {zone:1448} Felwood · {item:14256} Felcloth
	["At 50 {npc:461} in the {object:2164}, in the {object:2101}, sends you to {npc:14470} in {zone:1448} with a piece of {item:14256}."] = "Mit Stufe 50 schickt dich {npc:461} im {object:2164}, im {object:2101}, mit einem Stück {item:14256} zu {npc:14470} in {zone:1448}.",

	-- Step 2: An Imp's Request (Ironforge)
	-- {npc:5172} Briarthorn · {zone:1455} Ironforge · {npc:14470} Impsy · {zone:1448} Felwood · {item:14256} Felcloth
	["At 50 {npc:5172} in {zone:1455} sends you to {npc:14470} in {zone:1448} with a piece of {item:14256}."] = "Mit Stufe 50 schickt dich {npc:5172} in {zone:1455} mit einem Stück {item:14256} zu {npc:14470} in {zone:1448}.",

	-- Step 3: An Imp's Request (Orgrimmar)
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow · {npc:14470} Impsy · {zone:1448} Felwood · {item:14256} Felcloth
	["At 50 {npc:3326} in the {object:172960} sends you to {npc:14470} in {zone:1448} with a piece of {item:14256}."] = "Mit Stufe 50 schickt dich {npc:3326} im {object:172960} mit einem Stück {item:14256} zu {npc:14470} in {zone:1448}.",

	-- Step 4: An Imp's Request (Undercity)
	-- {npc:4563} Kaal Soulreaper · {object:36082} Magic Quarter · {npc:14470} Impsy · {zone:1448} Felwood · {item:14256} Felcloth
	["At 50 {npc:4563} in the {object:36082} sends you to {npc:14470} in {zone:1448} with a piece of {item:14256}."] = "Mit Stufe 50 schickt dich {npc:4563} im {object:36082} mit einem Stück {item:14256} zu {npc:14470} in {zone:1448}.",

	-- Step 5: Felcloth
	-- {item:14256} Felcloth · {zone:1448} Felwood · {quest:8419} An Imp's Request · {npc:14470} Impsy · {quest:8420} Hot and Itchy
	["One {item:14256}: the Jadefire satyrs of {zone:1448} drop it about one kill in fourteen, and so do the Legashi satyrs and the Felguard Sentries you hunt for Niby's essences. Quicker: buy one at the Auction House. You need it for the trainer's {quest:8419} or for {npc:14470}'s own {quest:8420}, the same errand: whichever you hold."] = "Ein {item:14256}: Die Jadefire-Satyrn in {zone:1448} lassen es etwa bei jedem vierzehnten Kill fallen, ebenso die Legashi-Satyrn und die Felguard Sentries, die du für Nibys Essenzen jagst. Schneller: Kauf eines im Auktionshaus. Du brauchst es für {quest:8419} des Lehrers oder für {npc:14470}s eigene {quest:8420}, derselbe Auftrag: Nimm, was du hast.",

	-- Step 6: Impsy
	-- {npc:14470} Impsy · {npc:14469} Niby the Almighty · {area:1997} Bloodvenom Post · {area:1765} Bloodvenom Falls · {quest:8419} An Imp's Request · {item:20613} Rotting Wood · {item:20614} Bloodvenom Essence
	["{npc:14470} waits beside {npc:14469} on a rise just north-east of {area:1997}: coming north over the {area:1765} bridge, they stand off the road to the east, past a few oozes. Hand him the trainer's {quest:8419} with the cloth. Next he wants ten {item:20613} and four {item:20614}."] = "{npc:14470} wartet neben {npc:14469} auf einer Anhöhe direkt nordöstlich von {area:1997}: Wenn du von Süden über die Brücke von {area:1765} nach Norden kommst, stehen sie östlich abseits der Straße, hinter ein paar Schlämmen. Gib ihm {quest:8419} des Lehrers mit dem Stoff. Als Nächstes will er zehn {item:20613} und vier {item:20614}.",

	-- Step 7: Impsy: Hot and Itchy
	-- {npc:14470} Impsy · {npc:14469} Niby the Almighty · {area:1997} Bloodvenom Post · {area:1765} Bloodvenom Falls · {quest:8420} Hot and Itchy · {item:20613} Rotting Wood · {item:20614} Bloodvenom Essence
	["{npc:14470} waits beside {npc:14469} on a rise just north-east of {area:1997}: coming north over the {area:1765} bridge, they stand off the road to the east, past a few oozes. Take his own {quest:8420} and hand him the cloth at once. Next he wants ten {item:20613} and four {item:20614}."] = "{npc:14470} wartet neben {npc:14469} auf einer Anhöhe direkt nordöstlich von {area:1997}: Wenn du von Süden über die Brücke von {area:1765} nach Norden kommst, stehen sie östlich abseits der Straße, hinter ein paar Schlämmen. Nimm seine eigene {quest:8420} an und gib ihm sofort den Stoff. Als Nächstes will er zehn {item:20613} und vier {item:20614}.",

	-- Step 8: Rotting Wood and Bloodvenom
	-- {item:20613} Rotting Wood
	["{item:20613} and Bloodvenom"] = "{item:20613} und Blutgift",
	-- {area:1767} Irontree Woods · {zone:1448} Felwood · {area:1998} Talonbranch Glade · {item:20613} Rotting Wood · {npc:7149} Withered Protector · {npc:14470} Impsy
	-- plural, as words: Tainted Oozes = {npc:7092} Tainted Ooze
	["The Irontree treants (level 52) of {area:1767}, in northern {zone:1448} west of {area:1998}, drop {item:20613} one time in four; the big {npc:7149} (55) often drops three at once but hits hard and dazes. The Tainted Oozes (51) around {npc:14470} and along the Bloodvenom drop the essence one time in five."] = "Die Irontree-Treants (Stufe 52) von {area:1767} im nördlichen {zone:1448} westlich von {area:1998} lassen {item:20613} bei jedem vierten Kill fallen; der große {npc:7149} (55) lässt oft drei auf einmal fallen, schlägt aber hart zu und betäubt. Die Tainted Oozes (51) um {npc:14470} und entlang der Bloodvenom lassen die Essenz bei jedem fünften Kill fallen.",

	-- Step 9: Impsy again
	-- {npc:14470} Impsy
	["{npc:14470} again"] = "Wieder {npc:14470}",
	-- {npc:14470} Impsy · {item:20609} Voodoo Feathers · {area:1417} Sunken Temple
	["{npc:14470} now wants six {item:20609} from the {area:1417}: a dungeon run."] = "{npc:14470} will nun sechs {item:20609} aus dem {area:1417}: ein Dungeon-Durchlauf.",

	-- Step 10: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "{area:1417}",
	-- {area:1417} Sunken Temple · {area:1477} Temple of Atal'Hakkar · {area:74} Pool of Tears · {npc:5716} Zul'Lor
	["The {area:1417} ({area:1477}, level 50-56, a group of five) stands in the middle of the {area:74}: swim down into the temple and take the stairs to the entrance. The six troll guardians (level 51-52, elite) stand on the balconies around the central pit, each with adds; each drops his feather every time: Gasher and {npc:5716} the Amber, Hukku and Mijan the Blue, Zolo and Loro the Green. Not soloable at 52."] = "Der {area:1417} ({area:1477}, Stufe 50-56, Gruppe aus fünf) liegt mitten im {area:74}: Tauch in den Tempel hinunter und nimm die Treppe zum Eingang. Die sechs Troll-Wächter (Stufe 51-52, Elite) stehen auf den Balkonen um die zentrale Grube, jeder mit Adds; jeder lässt seine Feder jedes Mal fallen: Gasher und {npc:5716} die Bernsteinfarbene, Hukku und Mijan die Blaue, Zolo und Loro die Grüne. Mit 52 nicht solo machbar.",
	-- {npc:5716} Zul'Lor
	-- plural, as words: Amber Voodoo Feathers = {item:20606} Amber Voodoo Feather
	["Amber Voodoo Feathers: Gasher, {npc:5716}"] = "Amber Voodoo Feathers: Gasher, {npc:5716}",
	-- plural, as words: Blue Voodoo Feathers = {item:20607} Blue Voodoo Feather
	["Blue Voodoo Feathers: Hukku, Mijan"] = "Blue Voodoo Feathers: Hukku, Mijan",
	-- plural, as words: Green Voodoo Feathers = {item:20608} Green Voodoo Feather
	["Green Voodoo Feathers: Zolo, Loro"] = "Green Voodoo Feathers: Zolo, Loro",

	-- Step 11: Trolls of a Feather
	-- {item:20536} Soul Harvester · {item:20534} Abyss Shard · {item:20530} Robes of Servitude
	["Choose the {item:20536} (staff), the {item:20534} (off-hand) or the {item:20530}."] = "Wähle {item:20536} (Stab), {item:20534} (Nebenhand) oder {item:20530}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 50 {npc:3326} in the {object:172960} sends you to {npc:14470} in {zone:1448}."] = "Mit 50 schickt dich {npc:3326} in der {object:172960} zu {npc:14470} in {zone:1448}.",
	-- ["At 50 {npc:4563} in the {object:36082} sends you to {npc:14470} in {zone:1448}."] = "Mit 50 schickt dich {npc:4563} im {object:36082} zu {npc:14470} in {zone:1448}.",
	-- ["At 50 {npc:461} in the {object:2164}, in the {object:2101}, sends you to {npc:14470} in {zone:1448}."] = "Mit 50 schickt dich {npc:461} im {object:2164} im {object:2101} zu {npc:14470} in {zone:1448}.",
	-- ["At 50 {npc:5172} in {zone:1455} sends you to {npc:14470} in {zone:1448}."] = "Mit 50 schickt dich {npc:5172} in {zone:1455} zu {npc:14470} in {zone:1448}.",
	-- ["The Irontree treants in northern {zone:1448} drop the {item:20613}; the Tainted Oozes around {area:1763} the {item:20614}."] = "Die Treants der Eisenstämme im Norden von {zone:1448} lassen {item:20613} fallen; die Besudelten Brühschlammer rund um {area:1763} {item:20614}.",
	-- ["The six troll guardians of the {area:1417}, a level 50 dungeon, each drop a Voodoo Feather: bring a group of five. The temple stands in the middle of the {area:74}; swim down into it to reach the entrance."] = "Die sechs Trollwächter im {area:1417}, einem Dungeon der Stufe 50, lassen je eine Voodoofeder fallen: Bring eine Gruppe von fünf mit. Der Tempel steht mitten im {area:74}; tauch hinab, um den Eingang zu erreichen.",
	-- ["{npc:14470} waits beside {npc:14469} in central {zone:1448}, just east of {area:1763}. This chain is {npc:14470}'s own and is not part of the Dreadsteed chain; Niby and {npc:14470} also give the {item:18762} chain here."] = "{npc:14470} wartet neben {npc:14469} in der Mitte von {zone:1448}, knapp östlich von {area:1763}. Diese Questreihe gehört {npc:14470} allein und ist kein Teil der Schreckensross-Questreihe; Niby der Allmächtige und {npc:14470} geben hier auch die Questreihe um {item:18762}.",
	-- ["{npc:14470} wants one {item:14256}: the Jadefire satyrs and the demons of {area:1763} drop it."] = "{npc:14470} will einen {item:14256}: Die Jadefeuersatyrn und die Dämonen von {area:1763} lassen ihn fallen.",
}
