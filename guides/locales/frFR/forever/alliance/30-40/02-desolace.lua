-- French (frFR): the guide forever/alliance/30-40/02-desolace (forever/alliance/30-40/02-desolace.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Menethil Harbor
	-- {zone:1455} Ironforge · {npc:1573} Gryth Thurden
	["From {zone:1455}'s {npc:1573}"] = "Depuis {npc:1573} à {zone:1455}",

	-- Step 2: Auberdine
	-- {area:442} Auberdine · {npc:3649} Thundris Windweaver
	["Take the boat to {area:442} from Menethil's docks. {npc:3649} stands in {area:442}, north of the flight master."] = "Prenez le bateau pour {area:442} aux quais du Port de Menethil. {npc:3649} se tient à {area:442}, au nord du maître de vol.",
	-- {npc:3649} Thundris Windweaver · {item:279915} Nord'el
	["{npc:3649}: {item:279915}, from Sylessa in Menethil"] = "{npc:3649} : {item:279915}, de la part de Sylessa au Port de Menethil",

	-- Step 3: Heartswood
	-- {area:415} Astranaar · {quest:1738} Heartswood · {area:413} Maestra's Post · {quest:65602} What Is Love? · {item:190309} Wooden Figurine · {area:1276} Talondeep Path
	["From {area:415} ride north-west into the hills: the {quest:1738} is a glowing tree north of the road to {area:413}. If you took {quest:65602}, the {item:190309} lies in a house among the trees north of {area:413} (26.6,22.0). Then back past {area:415} to the {area:1276}."] = "Depuis {area:415}, partez au nord-ouest dans les collines : {quest:1738} est un arbre lumineux au nord de la route de {area:413}. Si vous avez pris {quest:65602}, {item:190309} se trouve dans une maison parmi les arbres au nord de {area:413} (26.6,22.0). Revenez ensuite par {area:415} jusqu'à {area:1276}.",
	-- {item:190309} Wooden Figurine · {area:413} Maestra's Post
	["{item:190309}, north of {area:413}"] = "{item:190309}, au nord de {area:413}",

	-- Step 4: Talondeep Path
	-- {area:415} Astranaar · {area:1276} Talondeep Path
	["From {area:415} head south-west to the {area:1276}, a tunnel through the mountains into Stonetalon."] = "Depuis {area:415}, partez au sud-ouest vers {area:1276}, un tunnel à travers les montagnes vers les Serres-Rocheuses.",

	-- Step 5: Nijel's Point
	-- {area:460} Sun Rock Retreat · {area:465} Charred Vale · {zone:1443} Desolace · {area:608} Nijel's Point
	["Follow the road west past {area:460} (Horde) and south-west through the {area:465} into {zone:1443}; {area:608} stands at the top of the pass."] = "Suivez la route vers l'ouest après {area:460} (Horde), puis au sud-ouest par {area:465} jusqu'en {zone:1443} ; {area:608} se trouve en haut du col.",

	-- Step 6: Sargeron
	-- {area:603} Sargeron · {area:608} Nijel's Point
	["The Hatefury satyrs hold the ruins of {area:603}, east of {area:608}."] = "Les satyres Fielfurie tiennent les ruines de {area:603}, à l'est de {area:608}.",

	-- Step 8: Malem chest
	["Malem chest"] = "Coffre de Malem",
	-- {area:608} Nijel's Point
	["The chest lies in the ruins south-west of {area:608}."] = "Le coffre se trouve dans les ruines au sud-ouest de {area:608}.",

	-- Step 10: Azore Aldamort
	-- {npc:11863} Azore Aldamort · {area:599} Thunder Axe Fortress
	["{npc:11863}'s tower stands on the hill west of {area:599}: take his quest first, the sceptre he wants is in the fortress."] = "La tour d'{npc:11863} se dresse sur la colline à l'ouest de {area:599} : prenez d'abord sa quête, le sceptre qu'il veut est dans la forteresse.",

	-- Step 11: Dalinda Malem
	-- {npc:5644} Dalinda Malem · {area:608} Nijel's Point
	["{npc:5644} hides inside the Burning Blade's fortress south-west of {area:608}."] = "{npc:5644} se cache dans la forteresse de la Lame ardente, au sud-ouest de {area:608}.",

	-- Step 12: Tyranis Malem and the Seer
	-- {npc:5643} Tyranis Malem
	["{npc:5643} and the Seer"] = "{npc:5643} et le Prophète",
	-- {npc:5643} Tyranis Malem · {npc:13019} Burning Blade Seer
	["Her brother {npc:5643} (36) walks the fortress with the Burning Blade cultists (30-33): pull him alone. The {npc:13019} keeps the sceptre in the fortress's main building."] = "Son frère {npc:5643} (36) arpente la forteresse avec les sectateurs de la Lame ardente (30-33) : attirez-le seul. {npc:13019} garde le sceptre dans le bâtiment principal de la forteresse.",

	-- Step 13: Escort Dalinda Malem
	-- {npc:5644} Dalinda Malem
	["Escort {npc:5644}"] = "Escortez {npc:5644}",
	["Out of Thunder Axe Fortress"] = "Sortie de la Forteresse de Hache-Tonnerre",
	-- {npc:5644} Dalinda Malem · {npc:5642} Vahlarriel Demonslayer · {area:608} Nijel's Point
	["Lead {npc:5644} out of the fortress; she walks off once you are clear of it. {npc:5642} takes the turn-in at {area:608} at the end of the guide."] = "Faites sortir {npc:5644} de la forteresse ; elle s'en va une fois que vous en êtes sortis. La quête se rend à {npc:5642}, à {area:608}, à la fin du guide.",

	-- Step 15: Scorpashi venom
	["Scorpashi venom"] = "Venin scorpashi",
	-- {area:2407} Kormek's Hut
	["The Scorpashi scorpids hunt the hills around {area:2407} on the road south."] = "Les scorpides scorpashi chassent dans les collines autour de {area:2407}, sur la route du sud.",

	-- Step 16: Cork Gizelton
	-- {area:2407} Kormek's Hut
	["The Gizelton Caravan waits at {area:2407}."] = "La caravane Gizelton attend à {area:2407}.",

	-- Step 17: Escort the caravan
	["Escort the caravan"] = "Escortez la caravane",
	-- {area:609} Kolkar Village · {area:2617} Scrabblescrew's Camp
	["Walk with the caravan south past {area:609}; Kolkar ambushers jump it on the way. Stay close until it stops at {area:2617}. The ambushers are 34-35 and come in waves: skip it if you are below 33."] = "Accompagnez la caravane vers le sud après {area:609} ; des Embusqués kolkars l'attaquent en chemin. Restez près d'elle jusqu'à son arrêt à {area:2617}. Les embusqués sont de niveau 34-35 et arrivent par vagues : passez si vous êtes en dessous du niveau 33.",

	-- Step 18: Smeed Scrabblescrew
	-- {npc:11596} Smeed Scrabblescrew · {area:609} Kolkar Village · {area:596} Kodo Graveyard
	["{npc:11596}'s camp is on the road south of {area:609}, by the {area:596}."] = "Le camp de {npc:11596} est sur la route au sud de {area:609}, près de {area:596}.",

	-- Step 19: Kodo Graveyard
	-- {npc:11596} Smeed Scrabblescrew · {item:13892} Kodo Kombobulator · {npc:4700} Aged Kodo
	-- plural, as words: Aged Kodos = {npc:4700} Aged Kodo
	["Use {npc:11596}'s {item:13892} on an {npc:4700} and walk the tamed kodo back to his camp, five times; Aged Kodos also drop the hides."] = "Utilisez le {item:13892} de {npc:11596} sur un {npc:4700} et ramenez le kodo apprivoisé à son camp, cinq fois ; les Vieux kodos lâchent aussi les peaux.",

	-- Step 21: Kolkar Village
	-- {area:609} Kolkar Village · {npc:5752} Corporal Melkins
	["The Kolkar roam the plains around {area:609}; their ears are for {npc:5752}."] = "Les Kolkars parcourent les plaines autour de {area:609} ; leurs oreilles sont pour {npc:5752}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {area:1276}"] = "{area:1276}",
}
