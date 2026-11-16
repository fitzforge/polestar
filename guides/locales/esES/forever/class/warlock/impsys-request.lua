-- Spanish (Spain) (esES): the guide forever/class/warlock/impsys-request (forever/class/warlock/impsys-request.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:14470} Impsy
	["A staff, off-hand or robe for your 50s; {npc:14470}'s own errand, not a step of the Dreadsteed chain."] = "Un bastón, objeto de mano izquierda o toga para la cincuentena; un encargo propio de {npc:14470}, no un paso de la cadena del Corcel nefasto.",

	-- Step 1: An Imp's Request (Stormwind)
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:14470} Impsy · {zone:1448} Felwood · {item:14256} Felcloth
	["At 50 {npc:461} in the {object:2164}, in the {object:2101}, sends you to {npc:14470} in {zone:1448} with a piece of {item:14256}."] = "A nivel 50 {npc:461}, en {object:2164}, en {object:2101}, te envía con {npc:14470} en {zone:1448} con un trozo de {item:14256}.",

	-- Step 2: An Imp's Request (Ironforge)
	-- {npc:5172} Briarthorn · {zone:1455} Ironforge · {npc:14470} Impsy · {zone:1448} Felwood · {item:14256} Felcloth
	["At 50 {npc:5172} in {zone:1455} sends you to {npc:14470} in {zone:1448} with a piece of {item:14256}."] = "A nivel 50 {npc:5172}, en {zone:1455}, te envía con {npc:14470} en {zone:1448} con un trozo de {item:14256}.",

	-- Step 3: An Imp's Request (Orgrimmar)
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow · {npc:14470} Impsy · {zone:1448} Felwood · {item:14256} Felcloth
	["At 50 {npc:3326} in the {object:172960} sends you to {npc:14470} in {zone:1448} with a piece of {item:14256}."] = "A nivel 50 {npc:3326}, en {object:172960}, te envía con {npc:14470} en {zone:1448} con un trozo de {item:14256}.",

	-- Step 4: An Imp's Request (Undercity)
	-- {npc:4563} Kaal Soulreaper · {object:36082} Magic Quarter · {npc:14470} Impsy · {zone:1448} Felwood · {item:14256} Felcloth
	["At 50 {npc:4563} in the {object:36082} sends you to {npc:14470} in {zone:1448} with a piece of {item:14256}."] = "A nivel 50 {npc:4563}, en {object:36082}, te envía con {npc:14470} en {zone:1448} con un trozo de {item:14256}.",

	-- Step 5: Felcloth
	-- {item:14256} Felcloth · {zone:1448} Felwood · {quest:8419} An Imp's Request · {npc:14470} Impsy · {quest:8420} Hot and Itchy
	["One {item:14256}: the Jadefire satyrs of {zone:1448} drop it about one kill in fourteen, and so do the Legashi satyrs and the Felguard Sentries you hunt for Niby's essences. Quicker: buy one at the Auction House. You need it for the trainer's {quest:8419} or for {npc:14470}'s own {quest:8420}, the same errand: whichever you hold."] = "",

	-- Step 6: Impsy
	-- {npc:14470} Impsy · {npc:14469} Niby the Almighty · {area:1997} Bloodvenom Post · {area:1765} Bloodvenom Falls · {quest:8419} An Imp's Request · {item:20613} Rotting Wood · {item:20614} Bloodvenom Essence
	["{npc:14470} waits beside {npc:14469} on a rise just north-east of {area:1997}: coming north over the {area:1765} bridge, they stand off the road to the east, past a few oozes. Hand him the trainer's {quest:8419} with the cloth. Next he wants ten {item:20613} and four {item:20614}."] = "",

	-- Step 7: Impsy: Hot and Itchy
	-- {npc:14470} Impsy · {npc:14469} Niby the Almighty · {area:1997} Bloodvenom Post · {area:1765} Bloodvenom Falls · {quest:8420} Hot and Itchy · {item:20613} Rotting Wood · {item:20614} Bloodvenom Essence
	["{npc:14470} waits beside {npc:14469} on a rise just north-east of {area:1997}: coming north over the {area:1765} bridge, they stand off the road to the east, past a few oozes. Take his own {quest:8420} and hand him the cloth at once. Next he wants ten {item:20613} and four {item:20614}."] = "",

	-- Step 8: Rotting Wood and Bloodvenom
	-- {item:20613} Rotting Wood
	["{item:20613} and Bloodvenom"] = "{item:20613} y veneno de sangre",
	-- {area:1767} Irontree Woods · {zone:1448} Felwood · {area:1998} Talonbranch Glade · {item:20613} Rotting Wood · {npc:7149} Withered Protector · {npc:14470} Impsy
	-- plural, as words: Tainted Oozes = {npc:7092} Tainted Ooze
	["The Irontree treants (level 52) of {area:1767}, in northern {zone:1448} west of {area:1998}, drop {item:20613} one time in four; the big {npc:7149} (55) often drops three at once but hits hard and dazes. The Tainted Oozes (51) around {npc:14470} and along the Bloodvenom drop the essence one time in five."] = "",

	-- Step 9: Impsy again
	-- {npc:14470} Impsy
	["{npc:14470} again"] = "{npc:14470} de nuevo",
	-- {npc:14470} Impsy · {item:20609} Voodoo Feathers · {area:1417} Sunken Temple
	["{npc:14470} now wants six {item:20609} from the {area:1417}: a dungeon run."] = "",

	-- Step 10: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "El {area:1417}",
	-- {area:1417} Sunken Temple · {area:1477} Temple of Atal'Hakkar · {area:74} Pool of Tears · {npc:5716} Zul'Lor
	["The {area:1417} ({area:1477}, level 50-56, a group of five) stands in the middle of the {area:74}: swim down into the temple and take the stairs to the entrance. The six troll guardians (level 51-52, elite) stand on the balconies around the central pit, each with adds; each drops his feather every time: Gasher and {npc:5716} the Amber, Hukku and Mijan the Blue, Zolo and Loro the Green. Not soloable at 52."] = "",
	-- {npc:5716} Zul'Lor
	-- plural, as words: Amber Voodoo Feathers = {item:20606} Amber Voodoo Feather
	["Amber Voodoo Feathers: Gasher, {npc:5716}"] = "",
	-- plural, as words: Blue Voodoo Feathers = {item:20607} Blue Voodoo Feather
	["Blue Voodoo Feathers: Hukku, Mijan"] = "",
	-- plural, as words: Green Voodoo Feathers = {item:20608} Green Voodoo Feather
	["Green Voodoo Feathers: Zolo, Loro"] = "",

	-- Step 11: Trolls of a Feather
	-- {item:20536} Soul Harvester · {item:20534} Abyss Shard · {item:20530} Robes of Servitude
	["Choose the {item:20536} (staff), the {item:20534} (off-hand) or the {item:20530}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Irontree treants in northern {zone:1448} drop the {item:20613}; the Tainted Oozes around {area:1763} the {item:20614}."] = "Los ents Troncoferro del norte de {zone:1448} sueltan {item:20613}; los Mocos corruptos de alrededor de {area:1763}, {item:20614}.",
	-- ["The six troll guardians of the {area:1417}, a level 50 dungeon, each drop a Voodoo Feather: bring a group of five. The temple stands in the middle of the {area:74}; swim down into it to reach the entrance."] = "Los seis guardianes trols del {area:1417}, una mazmorra de nivel 50, sueltan cada uno una pluma vudú: lleva un grupo de cinco. El templo está en medio de {area:74}; bucea hasta él para llegar a la entrada.",
	-- ["{npc:14470} waits beside {npc:14469} in central {zone:1448}, just east of {area:1763}. This chain is {npc:14470}'s own and is not part of the Dreadsteed chain; Niby and {npc:14470} also give the {item:18762} chain here."] = "{npc:14470} espera junto a {npc:14469} en el centro de {zone:1448}, justo al este de {area:1763}. Esta cadena es propia de {npc:14470} y no forma parte de la del Corcel nefasto; Niby y {npc:14470} también dan aquí la cadena de {item:18762}.",
	-- ["{npc:14470} wants one {item:14256}: the Jadefire satyrs and the demons of {area:1763} drop it."] = "{npc:14470} quiere una {item:14256}: la sueltan los sátiros Fuego de Jade y los demonios de {area:1763}.",
}
