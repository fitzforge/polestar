-- French (frFR): the guide forever/alliance/30-40/02-desolace (forever/alliance/30-40/02-desolace.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Nijel's Point
	-- {area:460} Sun Rock Retreat · {area:465} Charred Vale · {zone:1443} Desolace · {area:608} Nijel's Point
	["Follow the road west past {area:460} (Horde) and south-west through the {area:465} into {zone:1443}; {area:608} stands at the top of the pass."] = "Suivez la route vers l'ouest après {area:460} (Horde), puis au sud-ouest par {area:465} jusqu'en {zone:1443} ; {area:608} se trouve en haut du col.",
	-- {npc:5642} Vahlarriel Demonslayer · {area:599} Thunder Axe Fortress
	["{npc:5642}: the Burning Blade in {area:599}, where her search leads"] = "",

	-- Step 2: Malem chest
	["Malem chest"] = "Coffre de Malem",
	-- {area:608} Nijel's Point
	["The chest lies in the ruins south-west of {area:608}."] = "Le coffre se trouve dans les ruines au sud-ouest de {area:608}.",

	-- Step 3: Sargeron
	-- {area:603} Sargeron · {area:608} Nijel's Point
	-- plural, as words: Hatefury Rogues = {npc:4670} Hatefury Rogue · Hatefury Tricksters = {npc:4671} Hatefury Trickster
	["The Hatefury satyrs hold the ruins of {area:603}, east of {area:608}.\nCareful: Hatefury Rogues spawn stealthed, and Hatefury Tricksters have a poison proc on their attacks."] = "Les satyres Fielfurie tiennent les ruines de {area:603}, à l'est de {area:608}.\nAttention : les Voleurs Fielfurie apparaissent camouflés, et les attaques des Entourloupeurs Fielfurie peuvent empoisonner.",

	-- Step 6: Azore Aldamort
	-- {npc:11863} Azore Aldamort · {area:599} Thunder Axe Fortress
	["{npc:11863}'s tower stands on the hill west of {area:599}: take his quest first, the sceptre he wants is in the fortress."] = "La tour d'{npc:11863} se dresse sur la colline à l'ouest de {area:599} : prenez d'abord sa quête, le sceptre qu'il veut est dans la forteresse.",

	-- Step 7: Dalinda Malem
	-- {npc:5644} Dalinda Malem · {area:608} Nijel's Point
	["{npc:5644} hides inside the Burning Blade's fortress south-west of {area:608}."] = "{npc:5644} se cache dans la forteresse de la Lame ardente, au sud-ouest de {area:608}.",
	["Inside"] = "À l'intérieur",

	-- Step 8: Tyranis Malem and the Seer
	-- {npc:5643} Tyranis Malem
	["{npc:5643} and the Seer"] = "{npc:5643} et le Prophète",
	-- {npc:5643} Tyranis Malem · {npc:13019} Burning Blade Seer · {npc:5642} Vahlarriel Demonslayer
	["Her brother {npc:5643} (36) walks the fortress with the Burning Blade cultists (30-33): pull him alone. The {npc:13019} keeps the sceptre in the fortress's main building. {npc:5642} wants four of each kind of cultist on the way."] = "",
	-- {item:6767} Tyranis' Pendant
	["{item:6767}; inside"] = "{item:6767} ; à l'intérieur",
	-- {quest:5741} Sceptre of Light
	["{quest:5741}; on the top floor"] = "{quest:5741} ; au dernier étage",

	-- Step 9: Escort Dalinda Malem
	-- {npc:5644} Dalinda Malem
	["Escort {npc:5644}"] = "Escortez {npc:5644}",
	-- {npc:5644} Dalinda Malem
	["{npc:5644}, inside"] = "{npc:5644}, à l'intérieur",
	["Out of Thunder Axe Fortress"] = "Sortie de la Forteresse de Hache-Tonnerre",
	-- {npc:5644} Dalinda Malem · {npc:5642} Vahlarriel Demonslayer · {area:608} Nijel's Point
	["Lead {npc:5644} out of the fortress; she walks off once you are clear of it. {npc:5642} takes the turn-in at {area:608} at the end of the guide."] = "Faites sortir {npc:5644} de la forteresse ; elle s'en va une fois que vous en êtes sortis. La quête se rend à {npc:5642}, à {area:608}, à la fin du guide.",

	-- Step 10: Smeed Scrabblescrew
	-- {npc:11596} Smeed Scrabblescrew · {area:609} Kolkar Village · {area:596} Kodo Graveyard
	["{npc:11596}'s camp is on the road south of {area:609}, by the {area:596}."] = "Le camp de {npc:11596} est sur la route au sud de {area:609}, près de {area:596}.",

	-- Step 11: Kodo Graveyard
	-- {npc:11596} Smeed Scrabblescrew · {item:13892} Kodo Kombobulator · {npc:4702} Ancient Kodo
	-- plural, as words: Aged Kodos = {npc:4700} Aged Kodo · Scorpashi Lashers = {npc:4697} Scorpashi Lasher
	["Use {npc:11596}'s {item:13892} on an Aged, Dying or {npc:4702}: it becomes a tamed kodo that follows you. Walk it back to {npc:11596}'s camp; there, talk to the kodo: that counts it and lets you tame the next. Five kodos, one at a time; Aged Kodos also drop the hides, and the Scorpashi Lashers that hunt around the graveyard carry the venom."] = "",
	-- {npc:4702} Ancient Kodo
	["on an Aged, Dying or {npc:4702} in the graveyard; don't kill it"] = "",
	-- {npc:11596} Smeed Scrabblescrew
	["the tamed kodo, at {npc:11596}'s camp: talk to it, five times"] = "",

	-- Step 13: Kolkar Village
	-- {area:609} Kolkar Village · {npc:5752} Corporal Melkins
	["The Kolkar roam the plains around {area:609}; their ears are for {npc:5752}."] = "Les Kolkars parcourent les plaines autour de {area:609} ; leurs oreilles sont pour {npc:5752}.",

	-- Step 15: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "Prendre un vol pour {area:442}",
	-- {area:608} Nijel's Point
	["{area:608} flight master"] = "Maître de vol du {area:608}",

	-- Step 16: Boat to Stormwind Harbor
	-- {area:17203} Stormwind Harbor
	["Boat to {area:17203}"] = "Bateau pour {area:17203}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Escort the caravan"] = "Escortez la caravane",
	-- ["Fly to {area:415}"] = "Prendre un vol pour {area:415}",
	-- ["Follow the road west out of {area:415}; {area:413} lies north of it."] = "Suivez la route vers l'ouest en sortant d'{area:415} ; le {area:413} se trouve au nord.",
	-- ["From {area:415} head north-west into the hills: the {quest:1738} is a glowing tree north of the road to {area:413}. If you took {quest:65602}, the {item:190309} lies in a house among the trees north of {area:413} (26.6,22.0). Then back past {area:415} to the {area:1276}."] = "Depuis {area:415}, partez au nord-ouest dans les collines : {quest:1738} est un arbre lumineux au nord de la route du {area:413}. Si vous avez pris {quest:65602}, la {item:190309} se trouve dans une maison parmi les arbres au nord du {area:413} (26.6,22.0). Puis repassez par {area:415} jusqu'au {area:1276}.",
	-- ["From {area:415} head south-west to the {area:1276}, a tunnel through the mountains into Stonetalon."] = "Depuis {area:415}, partez au sud-ouest vers {area:1276}, un tunnel à travers les montagnes vers les Serres-Rocheuses.",
	-- ["From {area:415} ride north-west into the hills: the {quest:1738} is a glowing tree north of the road to {area:413}. If you took {quest:65602}, the {item:190309} lies in a house among the trees north of {area:413} (26.6,22.0). Then back past {area:415} to the {area:1276}."] = "Depuis {area:415}, partez au nord-ouest dans les collines : {quest:1738} est un arbre lumineux au nord de la route de {area:413}. Si vous avez pris {quest:65602}, {item:190309} se trouve dans une maison parmi les arbres au nord de {area:413} (26.6,22.0). Revenez ensuite par {area:415} jusqu'à {area:1276}.",
	-- ["From {zone:1455}'s {npc:1573}"] = "Depuis {npc:1573} à {zone:1455}",
	-- ["Hearth to {area:608}"] = "Pierre de foyer vers {area:608}",
	-- ["Her brother {npc:5643} (36) walks the fortress with the Burning Blade cultists (30-33): pull him alone. The {npc:13019} keeps the sceptre in the fortress's main building."] = "Son frère {npc:5643} (36) arpente la forteresse avec les sectateurs de la Lame ardente (30-33) : attirez-le seul. {npc:13019} garde le sceptre dans le bâtiment principal de la forteresse.",
	-- ["Scorpashi venom"] = "Venin scorpashi",
	-- ["Take the boat to {area:442} from Menethil's docks."] = "Prenez le bateau pour {area:442} aux quais du Port de Menethil.",
	-- ["Take the boat to {area:442} from Menethil's docks. {npc:3649} stands in {area:442}, north of the flight master."] = "Prenez le bateau pour {area:442} aux quais du Port de Menethil. {npc:3649} se tient à {area:442}, au nord du maître de vol.",
	-- ["The Gizelton Caravan waits at {area:2407}."] = "La caravane Gizelton attend à {area:2407}.",
	-- ["The Hatefury satyrs hold the ruins of {area:603}, east of {area:608}."] = "Les satyres Fielfurie tiennent les ruines de {area:603}, à l'est de {area:608}.",
	-- ["The Scorpashi scorpids hunt the hills around {area:2407} on the road south."] = "Les scorpides scorpashi chassent dans les collines autour de {area:2407}, sur la route du sud.",
	-- ["The {area:1276}"] = "{area:1276}",
	-- ["Use {npc:11596}'s {item:13892} on an {npc:4700} and walk the tamed kodo back to his camp, five times; Aged Kodos also drop the hides."] = "Utilisez le {item:13892} de {npc:11596} sur un {npc:4700} et ramenez le kodo apprivoisé à son camp, cinq fois ; les Vieux kodos lâchent aussi les peaux.",
	-- ["Walk with the caravan south past {area:609}; Kolkar ambushers jump it on the way. Stay close until it stops at {area:2617}. The ambushers are 34-35 and come in waves: skip it if you are below 33."] = "Accompagnez la caravane vers le sud après {area:609} ; des Embusqués kolkars l'attaquent en chemin. Restez près d'elle jusqu'à son arrêt à {area:2617}. Les embusqués sont de niveau 34-35 et arrivent par vagues : passez si vous êtes en dessous du niveau 33.",
	-- ["{item:190309}, north of {area:413}"] = "{item:190309}, au nord de {area:413}",
	-- ["{item:6249} on the way"] = "{item:6249} en chemin",
	-- ["{npc:3649}: {item:279915}, from Sylessa in Menethil"] = "{npc:3649} : {item:279915}, de la part de Sylessa au Port de Menethil",
}
