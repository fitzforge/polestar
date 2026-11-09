-- Spanish (Latin America) (esMX): the guide forever/class/hunter/rhokdelar (forever/class/hunter/rhokdelar.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Rhok'delar and Lok'delar"] = "Rhok'delar y Lok'delar",
	["The hunter's epic bow chain: in Classic the stave and sinew became Rhok'delar and Lok'delar (unconfirmed in Forever)."] = "La cadena del arco épico del cazador: en Classic el báculo y el tendón se convertían en Rhok'delar y Lok'delar (sin confirmar en Forever).",

	-- Step 1: The Ancient Petrified Leaf
	-- {item:18703} Ancient Petrified Leaf
	["The {item:18703}"] = "{item:18703}",
	-- {area:2717} Molten Core · {area:254} Blackrock Mountain · {npc:12018} Majordomo Executus · {object:179703} Cache of the Firelord · {item:18703} Ancient Petrified Leaf
	["{area:2717} is a 40-player raid inside {area:254}. When {npc:12018} yields, the {object:179703} appears; it holds the {item:18703} about half the time, one per kill, so it may take several weeks of raids. Right-click the leaf to start the quest."] = "",
	-- {item:18703} Ancient Petrified Leaf
	["from the {item:18703}"] = "de la {item:18703}",

	-- Step 2: Vartrus the Ancient
	-- {npc:14526} Hastat the Ancient · {area:1767} Irontree Woods · {zone:1448} Felwood · {area:1998} Talonbranch Glade · {area:1997} Bloodvenom Post · {quest:7636} Stave of the Ancients
	["Vartrus, Stoma and {npc:14526} are petrified trees on a small island in a ring-shaped lake in {area:1767}, north {zone:1448}. Their spirits only appear when someone carrying the leaf climbs the island's little hill to its east edge. Alliance: fly to {area:1998}; Horde: fly to {area:1997}. Vartrus gives {quest:7636}, Stoma A Proper String, Hastat the quiver; each can be handed in on its own."] = "",
	-- {npc:14526} Hastat the Ancient
	["{npc:14526}: the quiver, last in this guide"] = "{npc:14526}: el carcaj, al final de esta guía",

	-- Step 3: Before the demons
	["Before the demons"] = "",
	-- {item:9224} Potion of Demon Slaying · {skill:171} Alchemy · {spell:19878} Track Demons
	-- plural, as words: Major Mana Potions = {item:13444} Major Mana Potion
	["The four demons are level 60 elites disguised as friendly travellers; talk to one and say you know what it is, and it turns into its demon form. Fight every one alone: no pet (dismiss it), no other player's heal, buff or attack once the fight starts, or the demon calls you a coward and vanishes, with a 3 hour wait for it to return (also after it dies). Buffs and potions you take before the pull are fine, and a friend may stand by to kill wandering monsters or enemy players, as long as they never touch the demon or you. Bring a {item:9224} ({skill:171} or the auction house), Major Mana Potions for the long kites, and a melee weapon with the Demonslaying enchant if you can. {spell:19878}, from your trainer, shows the disguised demons on the minimap. In a group, set loot to free for all so you can loot the head."] = "",
	-- {spell:19878} Track Demons
	["Learn {spell:19878} and get demon-slaying potions"] = "",

	-- Step 4: Simone the Inconspicuous
	-- {npc:14527} Simone the Inconspicuous · {spell:19878} Track Demons · {npc:14533} Simone the Seductress · {spell:421} Chain Lightning · {spell:3034} Viper Sting · {spell:23205} Temptress' Kiss
	["{npc:14527}, a troll with a wolf, walks a long path that starts at the lake in western Un'Goro and can reach the south of the crater; use {spell:19878}. Talk to her and she becomes {npc:14533}, and her wolf Precious a Felstalker. The hardest of the four: Freezing Trap Precious and pull Simone well away from it, or kite Precious away and kill it first, let Simone reset and come back for her alone. Her {spell:421} hits hard, so drain her mana with {spell:3034} (a 15-second cooldown on Forever) and keep her busy; her {spell:23205} cuts your ranged attack power, so finish her in melee. Loot her head before Precious breaks free."] = "",

	-- Step 5: Franklin the Friendly
	-- {npc:14529} Franklin the Friendly · {zone:1428} Burning Steppes · {area:254} Blackrock Mountain · {npc:14534} Klinfran the Crazed · {spell:3043} Scorpid Sting · {spell:23257} Demonic Frenzy · {spell:19801} Tranquilizing Shot · {spell:2974} Wing Clip · {spell:2973} Raptor Strike
	["{npc:14529}, a human, wanders the western {zone:1428} south of {area:254}. Talk to him and he becomes {npc:14534}, the easiest of the four. Keep {spell:3043} on him the whole fight: while it lasts he barely hurts you. When he goes into {spell:23257}, remove it with {spell:19801} and never stand in melee while it is up; between frenzies you can fight him in melee with {spell:2974} and {spell:2973}. He cannot leave the {zone:1428}, so kite him around the trees if needed."] = "",

	-- Step 6: Nelson the Nice
	-- {npc:14536} Nelson the Nice · {area:3428} Ahn'Qiraj · {zone:1451} Silithus · {npc:14530} Solenor the Slayer · {spell:23272} Soul Flame · {object:164639} Frost Trap (no name in this language: may be words) · {spell:5384} Feign Death · {spell:2974} Wing Clip · {npc:14761} Creeping Doom · {spell:2643} Multi-Shot
	["{npc:14536}, a gnome, walks around the gates of {area:3428} in the far south-west of {zone:1451}. Talk to him and he becomes {npc:14530}. He enrages with {spell:23272} as he turns: drop a {object:164639}, {spell:5384}, and he resets without the enrage. {spell:2974} roots him for a long time; while rooted he fears you and sends beetles ({npc:14761}): kill them fast with traps and {spell:2643} before they wear you down."] = "",

	-- Step 7: Artorius the Amiable
	-- {npc:14531} Artorius the Amiable · {zone:1452} Winterspring · {area:2255} Everlook · {npc:14535} Artorius the Doombringer · {spell:23298} Demonic Doom · {spell:5118} Aspect of the Cheetah · {spell:1978} Serpent Sting · {spell:23299} Stinging Trauma · {spell:23257} Demonic Frenzy · {spell:19801} Tranquilizing Shot
	["{npc:14531}, a tauren, walks a loop in the rocks of northern {zone:1452}, north of {area:2255}. Talk to him and he becomes {npc:14535}. Within 30 yards of him {spell:23298} hits hard: keep your distance and kite him the whole fight, {spell:5118} on, south down the road. {spell:1978} on him adds {spell:23299}, extra Nature damage, so keep it ticking while you run; his {spell:23257} can be removed with {spell:19801}, but distance matters more. It is a long fight: bring mana potions and plan your kiting path."] = "",

	-- Step 8: Onyxia
	["Onyxia"] = "Onyxia",
	-- {area:2159} Onyxia's Lair · {area:511} Wyrmbog · {zone:1445} Dustwallow Marsh · {item:18705} Mature Black Dragon Sinew
	["Onyxia is the 40-player raid boss of {area:2159}, a cave in the {area:511} of southern {zone:1445}; she returns once a week. She drops one {item:18705} in about two kills of five, lootable without the quest, so only one hunter per kill gets it: settle who first."] = "",
	-- {item:18705} Mature Black Dragon Sinew
	["{item:18705}, from Onyxia"] = "{item:18705}, de Onyxia",

	-- Step 9: Back to the Ancients
	["Back to the Ancients"] = "De vuelta con los Ancestros",

	-- Step 10: Rhok'delar and Lok'delar
	-- {item:18707} Ancient Rune Etched Stave · {item:18724} Enchanted Black Dragon Sinew · {item:18715} Lok'delar, Stave of the Ancient Keepers
	["Not confirmed in Forever. In Classic, using the {item:18707} with the {item:18724} in your bags made Rhok'delar, and talking to Vartrus once more then gave {item:18715}, at no extra cost."] = "",
	-- {item:18707} Ancient Rune Etched Stave
	["{item:18707}, by Vartrus"] = "{item:18707}, con Vartrus",
	-- {npc:14524} Vartrus the Ancient
	["{npc:14524}: Lok'delar in Classic"] = "{npc:14524}: Lok'delar en Classic",

	-- Step 11: Azuregos
	-- {item:18704} Mature Blue Dragon Sinew · {npc:6109} Azuregos · {zone:1447} Azshara · {area:2245} Mazthoril · {area:2255} Everlook · {zone:1452} Winterspring
	["Hastat's quiver needs the {item:18704}. {npc:6109}, a world boss for a raid, stands in southern {zone:1447}, returns only every two to four days and drops it nearly every kill. The elite Cobalt dragonkin in and around {area:2245}, the cave south of {area:2255} in {zone:1452}, drop it about once in 200 kills; Manaclaw there a little more often. Skip the rest of this guide if you do not want the quiver."] = "",
	-- {item:18704} Mature Blue Dragon Sinew · {npc:6109} Azuregos
	["{item:18704}, from {npc:6109}"] = "{item:18704}, de {npc:6109}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Azuregos"] = "Azuregos",
	-- ["Hastat's quiver needs the {item:18704}. {npc:6109}, a world boss for a raid, roams the south of {zone:1447} and drops it most of the time; the Cobalt dragonkin of {zone:1452} drop it very rarely. Skip the rest of this guide if you do not want the quiver."] = "El carcaj de Hastat requiere el {item:18704}. {npc:6109}, un jefe de mundo para banda, recorre el sur de {zone:1447} y casi siempre lo suelta; los dracónidos de cobalto de {zone:1452} lo sueltan muy rara vez. Omite el resto de esta guía si no quieres el carcaj.",
	-- ["Not confirmed in Forever. In Classic, using the {item:18707} with the {item:18724} in your bags made Rhok'delar, and Vartrus then gave {item:18715} ({spell:425121})."] = "Sin confirmar en Forever. En Classic, usar el {item:18707} con el {item:18724} en tus bolsas creaba Rhok'delar, y luego Vartrus daba {item:18715} ({spell:425121}).",
	-- ["Onyxia drops the {item:18705}; she is the 40-player raid boss of {area:2159}, a cave in the {area:511} of southern {zone:1445}."] = "Onyxia suelta el {item:18705}; es la jefa de banda de 40 jugadores de {area:2159}, una cueva en {area:511}, al sur de {zone:1445}.",
	-- ["The {object:179703} appears in {area:2717} when {npc:12018} yields; it holds the {item:18703} about half the time. {area:2717} is a 40-player raid inside {area:254}. Right-click the leaf to start the quest."] = "El {object:179703} aparece en {area:2717} cuando {npc:12018} se rinde; contiene la {item:18703} más o menos la mitad de las veces. {area:2717} es una banda de 40 jugadores dentro de {area:254}. Haz clic derecho en la hoja para empezar la misión.",
	-- ["Vartrus, Stoma and {npc:14526} stand together in the north of {zone:1448}. Alliance: {area:1998} is the nearest flight point; Horde: {area:1997}."] = "Vartrus, Stoma y {npc:14526} están juntos en el norte de {zone:1448}. Alianza: {area:1998} es el punto de vuelo más cercano; Horda: {area:1997}.",
	-- ["{npc:14527}, a troll, stands in the west of {zone:1449}. Talk to her and she becomes {npc:14533}, with a pet of her own. Alone, without your pet."] = "{npc:14527}, una trol, está en el oeste de {zone:1449}. Habla con ella y se convierte en {npc:14533}, con su propia mascota. Solo, sin tu mascota.",
	-- ["{npc:14529}, a human, stands in the west of the {zone:1428}. Talk to him and he becomes {npc:14534}. Alone, without your pet."] = "{npc:14529}, un humano, está en el oeste de {zone:1428}. Habla con él y se convierte en {npc:14534}. Solo, sin tu mascota.",
	-- ["{npc:14531}, a tauren, waits in the north-east of {zone:1452}. Talk to him and he becomes {npc:14535}. Fight every demon alone and without your pet: help of any kind makes it vanish. Loot the head."] = "{npc:14531}, un tauren, espera en el noreste de {zone:1452}. Habla con él y se convierte en {npc:14535}. Pelea con cada demonio solo y sin tu mascota: cualquier ayuda lo hace desaparecer. Despoja la cabeza.",
	-- ["{npc:14536}, a gnome, stands in the south-west of {zone:1451}. Talk to him and he becomes {npc:14530}. Alone, without your pet; keep away from the beetles he calls."] = "{npc:14536}, un gnomo, está en el suroeste de {zone:1451}. Habla con él y se convierte en {npc:14530}. Solo, sin tu mascota; aléjate de los escarabajos que invoca.",
}
