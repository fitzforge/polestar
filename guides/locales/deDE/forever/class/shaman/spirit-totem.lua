-- German (deDE): the guide forever/class/shaman/spirit-totem (forever/class/shaman/spirit-totem.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:8412} Spirit Totem · {quest:8413} Da Voodoo
	["{quest:8412} and {quest:8413}"] = "{quest:8412} und {quest:8413}",
	-- {area:1417} Sunken Temple
	["Experience and gold at 50, ending in the {area:1417}; the Classic item choice may be gone in Forever."] = "Erfahrung und Gold mit Stufe 50, endet im {area:1417}; die Gegenstandswahl aus Classic könnte in Forever weg sein.",
	["Experience and gold"] = "Erfahrung und Gold",

	-- Step 1: Sagorne Creststrider
	-- {npc:13417} Sagorne Creststrider · {object:172957} Valley of Wisdom · {npc:6176} Bath'rah the Windwatcher
	["At 50 {npc:13417}, the shaman trainer in the {object:172957}, asks for the four elements for {npc:6176}."] = "Mit Stufe 50 verlangt {npc:13417}, der Schamanenlehrer im {object:172957}, die vier Elemente für {npc:6176}.",

	-- Step 2: Beram Skychaser
	-- {npc:3032} Beram Skychaser · {area:1640} Spirit Rise · {zone:1456} Thunder Bluff · {npc:6176} Bath'rah the Windwatcher · {quest:8410} Elemental Mastery · {quest:8412} Spirit Totem · {quest:8411} Mastering the Elements
	["At 50 {npc:3032}, a shaman trainer on {area:1640} in {zone:1456}, asks for the four elements for {npc:6176}. Skyborne: Forever's quest page lists {quest:8410} and {quest:8412} for Orcs, Tauren and Trolls only; if {npc:3032} has nothing for you, {npc:6176}'s own {quest:8411} is open to every Horde race, but {quest:8412} after it may still turn you away."] = "Mit Stufe 50 verlangt {npc:3032}, ein Schamanenlehrer auf {area:1640} in {zone:1456}, die vier Elemente für {npc:6176}. Himmelsgeborene: Die Questseite von Forever führt {quest:8410} und {quest:8412} nur für Orcs, Tauren und Trolle auf; hat {npc:3032} nichts für dich, steht {quest:8411} von {npc:6176} selbst allen Horde-Völkern offen, aber {quest:8412} danach könnte dich trotzdem abweisen.",

	-- Step 3: The four elements
	["The four elements"] = "Die vier Elemente",
	-- {item:7069} Elemental Air · {zone:1417} Arathi Highlands · {area:320} Refuge Pointe · {npc:2794} Summoned Guardian · {zone:1447} Azshara · {npc:14269} Seeker Aqualon · {area:69} Lakeshire
	-- plural, as words: Thundering Exiles = {npc:2762} Thundering Exile · Rumbling Exiles = {npc:2592} Rumbling Exile · Burning Exiles = {npc:2760} Burning Exile
	["One each of {item:7069}, Fire, Earth and Water; all four trade, so the auction house is quickest. To farm them, {zone:1417} has the exiles near {area:320} (level 38-39, about one kill in eight to ten, respawn under seven minutes): Thundering Exiles south-east of it (air), Rumbling Exiles south-west (earth), Burning Exiles far to the north-west (fire), and the {npc:2794} far to the south-west (water, about one in seven). Water comes easier from the Patches of Elemental Water in {zone:1447} (two in five) or {npc:14269} by {area:69} in Redridge."] = "Je einmal {item:7069}, Feuer, Erde und Wasser; alle vier sind handelbar, das Auktionshaus ist also am schnellsten. Zum Farmen: {zone:1417} hat die Exiles bei {area:320} (Stufe 38-39, etwa ein Kill von acht bis zehn, Respawn unter sieben Minuten): Thundering Exiles südöstlich davon (Luft), Rumbling Exiles südwestlich (Erde), Burning Exiles weit im Nordwesten (Feuer) und {npc:2794} weit im Südwesten (Wasser, etwa eins von sieben). Wasser fällt leichter bei den Patches of Elemental Water in {zone:1447} (zwei von fünf) oder bei {npc:14269} neben {area:69} im Rotkammgebirge.",
	-- {item:7069} Elemental Air
	-- plural, as words: Thundering Exiles = {npc:2762} Thundering Exile
	["{item:7069}: Thundering Exiles"] = "{item:7069}: Donnernde Verbannte",
	-- {item:7068} Elemental Fire
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile
	["{item:7068}: Burning Exiles"] = "{item:7068}: Brennende Verbannte",
	-- {item:7067} Elemental Earth
	-- plural, as words: Rumbling Exiles = {npc:2592} Rumbling Exile
	["{item:7067}: Rumbling Exiles"] = "{item:7067}: Rumpelnde Verbannte",
	-- {item:7070} Elemental Water · {npc:2794} Summoned Guardian · {zone:1447} Azshara
	["{item:7070}: the {npc:2794}, or {zone:1447}'s water patches"] = "{item:7070}: {npc:2794} oder die Wasserflecken in {zone:1447}",

	-- Step 4: Bath'rah the Windwatcher
	-- {npc:6176} Bath'rah the Windwatcher · {zone:1416} Alterac Mountains · {area:272} Tarren Mill
	["{npc:6176} camps in the ruins of the east of {zone:1416}: from {area:272} follow the river east of town north into the hills."] = "{npc:6176} lagert in den Ruinen im Osten von {zone:1416}: Folge von {area:272} aus dem Fluss östlich der Stadt nach Norden in die Hügel.",

	-- Step 5: Spider eye and bear claw
	["Spider eye and bear claw"] = "Spinnenauge und Bärenklaue",
	-- {area:813} Bulwark · {zone:1422} Western Plaguelands · {area:3197} Chillwind Camp · {item:20610} Bloodshot Spider Eye · {spell:3427} Infected Wound · {item:20611} Thick Black Claw · {area:159} Brill
	-- plural, as words: Venom Mist Lurkers = {npc:1822} Venom Mist Lurker · Diseased Black Bears = {npc:1815} Diseased Black Bear · Carrion Vultures = {npc:1809} Carrion Vulture · Plague Lurkers = {npc:1824} Plague Lurker
	["Eight of each. Fly or ride to the {area:813} and on to the west edge of the {zone:1422}, north-west of {area:3197}: the Venom Mist Lurkers (level 50-51, they poison) give the {item:20610} and the Diseased Black Bears (level 51-52, {spell:3427}) the {item:20611}, one kill in five each; the two Carrion Vultures there drop either. The bigger Diseased Grizzlies and Plague Lurkers further east almost never drop them. A few bears and lurkers also roam south-east of {area:159} in Tirisfal."] = "Je acht. Flieg oder reite nach {area:813} und weiter zum Westrand von {zone:1422}, nordwestlich von {area:3197}: Die Venom Mist Lurkers (Stufe 50-51, sie vergiften) lassen {item:20610} fallen und die Diseased Black Bears (Stufe 51-52, {spell:3427}) {item:20611}, jeweils bei einem von fünf Kills; die zwei Carrion Vultures dort lassen beides fallen. Die größeren Diseased Grizzlies und Plague Lurkers weiter östlich lassen sie fast nie fallen. Einige Bären und Lurkers streifen auch südöstlich von {area:159} in Tirisfal umher.",

	-- Step 7: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "{area:1417}",
	-- {area:75} Stonard · {area:1417} Sunken Temple · {area:1477} Temple of Atal'Hakkar · {area:74} Pool of Tears · {npc:5716} Zul'Lor · {spell:139} Renew · {npc:3560} Healing Ward
	-- plural, as words: Shadow Bolt Volleys = {spell:9081} Shadow Bolt Volley
	["A five-player dungeon: needs a group of five, about level 50-55. Fly to {area:75} and ride east. The {area:1417} ({area:1477}) stands in the middle of the {area:74}: climb the stairs on the ruin's south side, dive into the flooded hall, swim down through it and follow the stairs and passages down to the portal. Two feathers of each colour, one from each of six elite troll mini-bosses (level 51-52) on the balconies around the temple's great round room, every kill, and each player on the quest loots their own: Gasher and {npc:5716} the Amber, Hukku and Mijan the Blue, Zolo and Loro the Green. Mijan heals the others ({spell:139}, a {npc:3560}): kill him first; Hukku summons guardians and throws Shadow Bolt Volleys."] = "Ein Dungeon für fünf Spieler: Du brauchst eine Gruppe aus fünf, etwa Stufe 50-55. Flieg nach {area:75} und reite nach Osten. Der {area:1417} ({area:1477}) liegt mitten im {area:74}: Steig die Treppe an der Südseite der Ruine hinauf, tauch in die geflutete Halle, schwimm durch sie nach unten und folge den Treppen und Gängen hinab zum Portal. Zwei Federn jeder Farbe, eine von jedem von sechs Elite-Troll-Mini-Bossen (Stufe 51-52) auf den Balkonen um den großen runden Raum des Tempels, bei jedem Kill, und jeder Spieler mit der Quest plündert seine eigenen: Gasher und {npc:5716} die Bernsteinfarbene, Hukku und Mijan die Blaue, Zolo und Loro die Grüne. Mijan heilt die anderen ({spell:139}, ein {npc:3560}): Töte ihn zuerst; Hukku beschwört Wächter und wirft Schattenblitzsalven.",
	-- {item:20606} Amber Voodoo Feather · {npc:5716} Zul'Lor
	["{item:20606}: Gasher, {npc:5716}"] = "{item:20606}: Gasher, {npc:5716}",
	-- {item:20607} Blue Voodoo Feather
	["{item:20607}: Hukku, Mijan"] = "{item:20607}: Hukku, Mijan",
	-- {item:20608} Green Voodoo Feather
	["{item:20608}: Zolo, Loro"] = "{item:20608}: Zolo, Loro",

	-- Step 8: Bath'rah the Windwatcher
	-- {npc:6176} Bath'rah the Windwatcher
	["{npc:6176}: the old item choice may be gone, count on the experience"] = "{npc:6176}: die alte Gegenstandswahl könnte weg sein, rechne mit der Erfahrung",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 50 {npc:13417}, the shaman trainer in the {object:172957}, sends you to {npc:6176}."] = "Mit 50 schickt dich {npc:13417}, der Schamanenlehrer in {object:172957}, zu {npc:6176}.",
	-- ["At 50 {npc:3032}, a shaman trainer in {zone:1456}, sends you to {npc:6176}."] = "Mit 50 schickt dich {npc:3032}, ein Schamanenlehrer in {zone:1456}, zu {npc:6176}.",
	-- ["Experience and gold at 50, ending in the {area:1417}; Forever removed the Classic item choice."] = "Erfahrung und Gold mit 50, mit Abschluss in {area:1417}; Forever hat die Gegenstandsauswahl aus Classic entfernt.",
	-- ["In the {zone:1422}, the Venom Mist Lurkers drop the {item:20610} and the Diseased Black Bears the {item:20611} (about one kill in five each)."] = "In {zone:1422} lassen die Giftnebellauerer {item:20610} und die Kranken Schwarzbären {item:20611} fallen (jeweils etwa bei jedem fünften Kill).",
	-- ["In the {zone:1422}, the Venom Mist Lurkers drop the {item:20610} and the Diseased Black Bears the {item:20611} (about one kill in five each). Carrion birds can drop either, so keep what they give you on the way."] = "Im {zone:1422} lassen die Giftnebellauerer {item:20610} und die Kranken Schwarzbären {item:20611} fallen (je etwa jeder fünfte Kill). Aasvögel können beides fallen lassen, behalte also, was sie dir unterwegs geben.",
	-- ["One each of {item:7069}, Fire, Earth and Water. The Exiles of Arathi Highlands drop them, one element each, about one kill in ten: Thundering (air), Burning (fire), Rumbling (earth) and Cresting (water). Or buy them at the auction house."] = "Je eins von {item:7069}, Elementarfeuer, Elementarerde und Elementarwasser. Die Verbannten im Arathihochland lassen sie fallen, je ein Element pro Art, etwa bei jedem zehnten Kill: Donnernde (Luft), Brennende (Feuer), Rumpelnde (Erde) und Schäumende (Wasser). Oder kauf sie im Auktionshaus.",
	-- ["One each of {item:7069}, Fire, Earth and Water. The Exiles of {zone:1417} drop them, one element each, about one kill in ten: Thundering (air), Burning (fire), Rumbling (earth) and Cresting (water). Or buy them at the auction house."] = "Je eins von {item:7069}, Elementarfeuer, Elementarerde und Elementarwasser. Die Verbannten in {zone:1417} lassen sie fallen, je ein Element pro Art, etwa bei jedem zehnten Kill: Donnernde (Luft), Brennende (Feuer), Rumpelnde (Erde) und Schäumende (Wasser). Oder kauf sie im Auktionshaus.",
	-- ["The {area:1417} ({area:1477}) lies under the {area:74}; the arrow points at its entrance. Gasher or {npc:5716} drop the {item:20606}, Hukku or Mijan the Blue, Zolo or Loro the Green: all six are elite trolls inside. Bring a group."] = "{area:1417} ({area:1477}) liegt unter {area:74}; der Pfeil zeigt auf den Eingang. Schlitzer oder {npc:5716} lassen {item:20606} fallen, Hukku oder Mijan die blaue, Zolo oder Loro die grüne: Alle sechs sind Elitetrolle drinnen. Nimm eine Gruppe mit.",
	-- ["{item:7070}: Cresting Exiles"] = "{item:7070}: Schäumende Verbannte",
	-- ["{npc:6176} camps in the east of {zone:1416}, north-east of {area:272}."] = "{npc:6176} lagert im Osten von {zone:1416}, nordöstlich von {area:272}.",
}
