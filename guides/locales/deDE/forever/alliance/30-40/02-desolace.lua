-- German (deDE): the guide forever/alliance/30-40/02-desolace (forever/alliance/30-40/02-desolace.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Menethil Harbor
	-- {zone:1455} Ironforge · {npc:1573} Gryth Thurden
	["From {zone:1455}'s {npc:1573}"] = "Von {npc:1573} in {zone:1455}",

	-- Step 2: Auberdine
	-- {area:442} Auberdine
	["Take the boat to {area:442} from Menethil's docks."] = "Nimm das Schiff von Menethils Anlegestelle nach {area:442}.",

	-- Step 3: Heartswood
	-- {area:415} Astranaar · {quest:1738} Heartswood · {area:413} Maestra's Post · {quest:65602} What Is Love? · {item:190309} Wooden Figurine · {area:1276} Talondeep Path
	["From {area:415} head north-west into the hills: the {quest:1738} is a glowing tree north of the road to {area:413}. If you took {quest:65602}, the {item:190309} lies in a house among the trees north of {area:413} (26.6,22.0). Then back past {area:415} to the {area:1276}."] = "Geh von {area:415} nach Nordwesten in die Hügel: {quest:1738} ist ein leuchtender Baum nördlich der Straße nach {area:413}. Hast du {quest:65602} angenommen, liegt {item:190309} in einem Haus zwischen den Bäumen nördlich von {area:413} (26,6, 22,0). Geh dann zurück an {area:415} vorbei zum {area:1276}.",
	-- {item:190309} Wooden Figurine · {area:413} Maestra's Post
	["{item:190309}, north of {area:413}"] = "{item:190309}, nördlich von {area:413}",

	-- Step 4: Talondeep Path
	-- {area:415} Astranaar · {area:1276} Talondeep Path
	["From {area:415} head south-west to the {area:1276}, a tunnel through the mountains into Stonetalon."] = "Reite von {area:415} nach Südwesten zum {area:1276}, einem Tunnel durch die Berge ins Steinkrallengebirge.",

	-- Step 5: Nijel's Point
	-- {area:460} Sun Rock Retreat · {area:465} Charred Vale · {zone:1443} Desolace · {area:608} Nijel's Point
	["Follow the road west past {area:460} (Horde) and south-west through the {area:465} into {zone:1443}; {area:608} stands at the top of the pass."] = "Folge der Straße nach Westen an {area:460} (Horde) vorbei und nach Südwesten durch {area:465} nach {zone:1443}; {area:608} liegt oben am Pass.",

	-- Step 6: Sargeron
	-- {area:603} Sargeron · {area:608} Nijel's Point
	["The Hatefury satyrs hold the ruins of {area:603}, east of {area:608}."] = "Die Satyrn der Zornsäer halten die Ruinen von {area:603}, östlich von {area:608}.",

	-- Step 8: Malem chest
	["Malem chest"] = "Truhe der Malems",
	-- {area:608} Nijel's Point
	["The chest lies in the ruins south-west of {area:608}."] = "Die Truhe liegt in den Ruinen südwestlich von {area:608}.",

	-- Step 10: Azore Aldamort
	-- {npc:11863} Azore Aldamort · {area:599} Thunder Axe Fortress
	["{npc:11863}'s tower stands on the hill west of {area:599}: take his quest first, the sceptre he wants is in the fortress."] = "{npc:11863}s Turm steht auf dem Hügel westlich von {area:599}: Nimm zuerst seine Quest an, das Zepter, das er will, ist in der Festung.",

	-- Step 11: Dalinda Malem
	-- {npc:5644} Dalinda Malem · {area:608} Nijel's Point
	["{npc:5644} hides inside the Burning Blade's fortress south-west of {area:608}."] = "{npc:5644} versteckt sich in der Festung der Burning Blade südwestlich von {area:608}.",

	-- Step 12: Tyranis Malem and the Seer
	-- {npc:5643} Tyranis Malem
	["{npc:5643} and the Seer"] = "{npc:5643} und der Seher",
	-- {npc:5643} Tyranis Malem · {npc:13019} Burning Blade Seer
	["Her brother {npc:5643} (36) walks the fortress with the Burning Blade cultists (30-33): pull him alone. The {npc:13019} keeps the sceptre in the fortress's main building."] = "Ihr Bruder {npc:5643} (36) läuft mit den Kultisten der Burning Blade (30-33) durch die Festung: Zieh ihn allein. {npc:13019} hat das Zepter im Hauptgebäude der Festung.",

	-- Step 13: Escort Dalinda Malem
	-- {npc:5644} Dalinda Malem
	["Escort {npc:5644}"] = "{npc:5644} eskortieren",
	["Out of Thunder Axe Fortress"] = "Raus aus der Festung Thunder Axe",
	-- {npc:5644} Dalinda Malem · {npc:5642} Vahlarriel Demonslayer · {area:608} Nijel's Point
	["Lead {npc:5644} out of the fortress; she walks off once you are clear of it. {npc:5642} takes the turn-in at {area:608} at the end of the guide."] = "Führ {npc:5644} aus der Festung; sie geht ihrer Wege, sobald ihr draußen seid. {npc:5642} nimmt die Abgabe am Ende des Guides in {area:608} entgegen.",

	-- Step 15: Scorpashi venom
	["Scorpashi venom"] = "Skorpashigift",
	-- {area:2407} Kormek's Hut
	["The Scorpashi scorpids hunt the hills around {area:2407} on the road south."] = "Die Skorpashi-Skorpide jagen in den Hügeln um {area:2407} an der Straße nach Süden.",

	-- Step 16: Cork Gizelton
	-- {area:2407} Kormek's Hut
	["The Gizelton Caravan waits at {area:2407}."] = "Gizeltons Karawane wartet bei {area:2407}.",

	-- Step 17: Escort the caravan
	["Escort the caravan"] = "Die Karawane eskortieren",
	-- {area:609} Kolkar Village · {area:2617} Scrabblescrew's Camp
	["Walk with the caravan south past {area:609}; Kolkar ambushers jump it on the way. Stay close until it stops at {area:2617}. The ambushers are 34-35 and come in waves: skip it if you are below 33."] = "Geh mit der Karawane nach Süden an {area:609} vorbei; unterwegs überfallen sie Wegelagerer der Kolkar. Bleib dicht dran, bis sie bei {area:2617} anhält. Die Wegelagerer sind Stufe 34-35 und kommen in Wellen: Überspring sie, wenn du unter 33 bist.",

	-- Step 18: Smeed Scrabblescrew
	-- {npc:11596} Smeed Scrabblescrew · {area:609} Kolkar Village · {area:596} Kodo Graveyard
	["{npc:11596}'s camp is on the road south of {area:609}, by the {area:596}."] = "{npc:11596}s Lager liegt an der Straße südlich von {area:609}, beim {area:596}.",

	-- Step 19: Kodo Graveyard
	-- {npc:11596} Smeed Scrabblescrew · {item:13892} Kodo Kombobulator · {npc:4700} Aged Kodo
	-- plural, as words: Aged Kodos = {npc:4700} Aged Kodo
	["Use {npc:11596}'s {item:13892} on an {npc:4700} and walk the tamed kodo back to his camp, five times; Aged Kodos also drop the hides."] = "Benutze {npc:11596}s {item:13892} an einem {npc:4700} und führ den gezähmten Kodo zu seinem Lager zurück, fünfmal; Gealterte Kodos lassen auch die Bälge fallen.",

	-- Step 21: Kolkar Village
	-- {area:609} Kolkar Village · {npc:5752} Corporal Melkins
	["The Kolkar roam the plains around {area:609}; their ears are for {npc:5752}."] = "Die Kolkar streifen über die Ebenen um {area:609}; ihre Ohren sind für {npc:5752}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["From {area:415} ride north-west into the hills: the {quest:1738} is a glowing tree north of the road to {area:413}. If you took {quest:65602}, the {item:190309} lies in a house among the trees north of {area:413} (26.6,22.0). Then back past {area:415} to the {area:1276}."] = "Reite von {area:415} nach Nordwesten in die Hügel: {quest:1738} ist ein leuchtender Baum nördlich der Straße nach {area:413}. Falls du {quest:65602} angenommen hast, liegt {item:190309} in einem Haus zwischen den Bäumen nördlich von {area:413} (26.6,22.0). Dann zurück an {area:415} vorbei zum {area:1276}.",
	-- ["Take the boat to {area:442} from Menethil's docks. {npc:3649} stands in {area:442}, north of the flight master."] = "Nimm das Schiff von Menethils Anlegestelle nach {area:442}. {npc:3649} steht in {area:442}, nördlich des Flugmeisters.",
	-- ["The {area:1276}"] = "{area:1276}",
	-- ["{npc:3649}: {item:279915}, from Sylessa in Menethil"] = "{npc:3649}: {item:279915}, von Sylessa in Menethil",
}
