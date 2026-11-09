-- German (deDE): the guide forever/class/shaman/call-of-water-alliance (forever/class/shaman/call-of-water-alliance.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:94494} Call of Water
	["{quest:94494} (Alliance)"] = "{quest:94494} (Allianz)",
	-- {item:5177} Water Totem · {spell:5394} Healing Stream Totem
	["The {item:5177} that lets you place water totems, and {spell:5394} with it."] = "Das {item:5177}, mit dem du Wassertotems aufstellen kannst, und dazu {spell:5394}.",

	-- Step 1: Eldrun Stormbreaker
	-- {npc:258098} Eldrun Stormbreaker · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {npc:258043} Norric Lochthane · {zone:1432} Loch Modan
	["At 20 {npc:258098}, the shaman trainer in {zone:1455}'s {object:32362}, sends you to {npc:258043} in {zone:1432}."] = "Mit Stufe 20 schickt dich {npc:258098}, der Schamanenlehrer in {object:32362} von {zone:1455}, zu {npc:258043} in {zone:1432}.",

	-- Step 2: Norric Lochthane
	-- {npc:258043} Norric Lochthane · {area:146} Stonewrought Dam · {area:144} Thelsamar
	["{npc:258043}'s burrow hut stands on the north-western shore of the loch, below {area:146}, north of {area:144}."] = "Die Erdhütte von {npc:258043} steht am nordwestlichen Seeufer, unterhalb von {area:146}, nördlich von {area:144}.",

	-- Step 3: Hervdana Saegrund
	-- {npc:258203} Hervdana Saegrund · {zone:1437} Wetlands · {area:836} Dun Algaz · {zone:1432} Loch Modan
	["{npc:258203}'s family lives in a cave beneath the southern falls of the {zone:1437}, east of {area:836}: not in a town. Through the Algaz tunnel north of {zone:1432}, then east off the road."] = "Die Familie von {npc:258203} lebt in einer Höhle unter den südlichen Fällen der {zone:1437}, östlich von {area:836}: nicht in einer Stadt. Durch den Algaz-Tunnel nördlich von {zone:1432}, dann östlich von der Straße abbiegen.",

	-- Step 4: The brown waterskin
	["The brown waterskin"] = "Der braune Wasserschlauch",
	-- {item:265732} Unfilled Brown Waterskin · {npc:258203} Hervdana Saegrund · {object:147516} Dark Iron
	["Fill the {item:265732} at the bottom of the waterfalls below {npc:258203}'s cave, where the fresh water meets the brackish. {object:147516} dwarves roam near the falls."] = "Fülle {item:265732} am Fuß der Wasserfälle unterhalb der Höhle von {npc:258203}, dort wo das Süßwasser auf das Brackwasser trifft. In der Nähe der Fälle streifen {object:147516}-Zwerge umher.",

	-- Step 6: The red waterskin
	["The red waterskin"] = "Der rote Wasserschlauch",
	-- {area:71} Stonewatch Falls · {area:68} Lake Everstill · {zone:1455} Ironforge · {area:69} Lakeshire · {item:265747} Unfilled Red Waterskin · {npc:258203} Hervdana Saegrund
	-- plural, as words: Murloc Nightcrawlers = {npc:544} Murloc Nightcrawler
	["{area:71} pour out of {area:68} at the east end of Redridge (fly from {zone:1455} to {area:69}). Fill the {item:265747} at their foot, where the Murloc Nightcrawlers gather; pull the murlocs off the spot first. If the skin vanishes without counting, abandon the quest and take it again from {npc:258203} for a new one."] = "{area:71} ergießen sich aus {area:68} am Ostende des Rotkammgebirges (flieg von {zone:1455} nach {area:69}). Fülle {item:265747} an ihrem Fuß, wo sich die Murloc Nightcrawlers versammeln; zieh die Murlocs zuerst von der Stelle weg. Wenn der Schlauch verschwindet, ohne zu zählen, brich die Quest ab und nimm sie bei {npc:258203} erneut an, um einen neuen zu bekommen.",

	-- Step 8: The blue waterskin
	["The blue waterskin"] = "Der blaue Wasserschlauch",
	-- {area:150} Menethil Harbor · {area:442} Auberdine · {area:271} Southshore · {zone:1439} Darkshore · {area:415} Astranaar · {zone:1440} Ashenvale · {item:265772} Unfilled Blue Waterskin
	["Take the boat from {area:150} to {area:442} (it stops in {area:271} on the way), then fly or walk south through {zone:1439} to {area:415} in {zone:1440}. Fill the {item:265772} in the lake around the town, then the boat back to Menethil."] = "Nimm das Boot von {area:150} nach {area:442} (es hält unterwegs in {area:271}), dann flieg oder geh nach Süden durch {zone:1439} nach {area:415} in {zone:1440}. Fülle {item:265772} im See um die Stadt, dann nimm das Boot zurück nach Menethil.",

	-- Step 9: Hervdana Saegrund
	-- {item:7810} Vial of Purest Water · {npc:258043} Norric Lochthane
	["the {item:7810}, for {npc:258043}"] = "die {item:7810}, für {npc:258043}",

	-- Step 10: Norric Lochthane
	-- {npc:258043} Norric Lochthane · {area:146} Stonewrought Dam · {item:7810} Vial of Purest Water · {item:6637} Water Sapta · {item:7811} Remaining Drops of Purest Water · {zone:1436} Westfall
	["Back to {npc:258043} by {area:146} with the {item:7810}. He hands you the {item:6637} and the {item:7811}: keep both for {zone:1436}."] = "Zurück zu {npc:258043} bei {area:146} mit {item:7810}. Er gibt dir {item:6637} und {item:7811}: Behalte beides für {zone:1436}.",
	-- {npc:258043} Norric Lochthane · {item:6637} Water Sapta
	["{npc:258043}: your {item:6637}"] = "{npc:258043}: dein {item:6637}",

	-- Step 11: Lost the Water Sapta?
	-- {quest:94616} Water Sapta
	["Lost the {quest:94616}?"] = "{quest:94616} verloren?",
	-- {quest:94616} Water Sapta · {npc:258043} Norric Lochthane · {zone:1436} Westfall
	["Only if the {quest:94616} is gone from your bags: {npc:258043} gives you another before you leave for {zone:1436}."] = "Nur wenn {quest:94616} nicht mehr in deinen Taschen ist: {npc:258043} gibt dir eine neue, bevor du nach {zone:1436} aufbrichst.",
	-- {npc:258043} Norric Lochthane · {quest:94616} Water Sapta
	["{npc:258043}: a new {quest:94616}"] = "{npc:258043}: eine neue {quest:94616}",

	-- Step 12: Stendel's Pond
	-- {area:108} Sentinel Hill · {area:20} Moonbrook · {area:919} Stendel's Pond · {object:619896} Forgotten Shrine · {item:6637} Water Sapta · {npc:5894} Corrupt Minor Manifestation of Water · {spell:8056} Frost Shock · {spell:122} Frost Nova · {item:7811} Remaining Drops of Purest Water · {npc:258043} Norric Lochthane · {npc:5895} Minor Manifestation of Water · {item:7813} Shard of Water
	["Fly to {area:108} and head south to {area:20}: {area:919} and the {object:619896} lie just north of it. Drink the {item:6637} by the shrine to see the {npc:5894} (level 22, {spell:8056} and {spell:122}; one spawn, back three minutes after a kill), defeat it for its bracers (always dropped), then place them and the {item:7811} on the {object:619896} (this, not {npc:258043}, ends the quest). Click the shrine again: the {npc:5895} rises beside it; speak to it before you walk off (if it is gone, abandon and take the quest again at the shrine). It gives you the {item:7813}."] = "Flieg nach {area:108} und geh nach Süden zu {area:20}: {area:919} und {object:619896} liegen direkt nördlich davon. Trink {item:6637} am Schrein, um {npc:5894} (Stufe 22, {spell:8056} und {spell:122}; ein Spawn, drei Minuten nach einem Kill wieder da) zu sehen. Besiege ihn für seine Armschienen (fallen immer), und lege sie dann zusammen mit {item:7811} auf {object:619896} (das, nicht {npc:258043}, schließt die Quest ab). Klicke den Schrein noch einmal an: {npc:5895} erhebt sich daneben; sprich mit ihm, bevor du weggehst (ist er weg, brich ab und nimm die Quest am Schrein erneut an). Er gibt dir {item:7813}.",
	-- {npc:5895} Minor Manifestation of Water
	["{npc:5895}, beside the shrine"] = "{npc:5895}, neben dem Schrein",

	-- Step 13: Norric Lochthane
	-- {npc:258043} Norric Lochthane · {item:7813} Shard of Water · {item:5177} Water Totem
	["Back to {npc:258043} with the {item:7813}. Keep the {item:5177} in your bags for good: every water totem needs it."] = "Zurück zu {npc:258043} mit {item:7813}. Behalte {item:5177} dauerhaft in deinen Taschen: Jedes Wassertotem braucht ihn.",
	-- {npc:258043} Norric Lochthane · {spell:5394} Healing Stream Totem · {item:5177} Water Totem
	["{npc:258043}: {spell:5394} and your {item:5177}"] = "{npc:258043}: {spell:5394} und dein {item:5177}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 20 {npc:258098}, the shaman trainer in {zone:1455}, sends you to {npc:258043} in {zone:1432}."] = "Mit Stufe 20 schickt dich {npc:258098}, der Schamanenlehrer in {zone:1455}, zu {npc:258043} in {zone:1432}.",
	-- ["Fill the {item:265732} at the bottom of the waterfalls below {npc:258203}'s cave, where the fresh water meets the brackish."] = "Fülle den {item:265732} am Fuß der Wasserfälle unter {npc:258203}s Höhle, wo das Süßwasser auf das Brackwasser trifft.",
	-- ["{area:71} pour out of {area:68} at the east end of Redridge. Fill the {item:265747} at their foot, where the Murloc Nightcrawlers gather."] = "{area:71} ergießen sich am Ostende des Rotkammgebirges aus {area:68}. Füll {item:265747} an ihrem Fuß, wo sich die Murlocnachtkriecher sammeln.",
	-- ["{area:919} lies outside {area:20}. Drink the {item:6637} there and defeat the {npc:5894} for its bracers, then place them and the {item:7811} on the {object:619896}. The {npc:5895} it calls forth gives you the {item:7813}."] = "{area:919} liegt außerhalb von {area:20}. Trink dort das {item:6637} und besiege die {npc:5894}, um ihre Armschienen zu bekommen, und leg sie dann mit den {item:7811} auf den {object:619896}. Die {npc:5895}, die er herbeiruft, gibt dir den {item:7813}.",
	-- ["{npc:258043}'s burrow hut stands on the north-western edge of the loch, south of {area:146}."] = "{npc:258043}s Erdhütte steht am Nordwestufer des Sees, südlich des Gebiets {area:146}.",
	-- ["{npc:258203}'s family lives in a cave beneath the southern falls of the {zone:1437}."] = "{npc:258203}s Familie lebt in einer Höhle unter den südlichen Wasserfällen von {zone:1437}.",
	-- ["{npc:258203}: take the boat from {area:150} to {area:442} (it stops in {area:271} on the way), then go south to {area:415}. Fill the {item:265772} in the lake around the town."] = "{npc:258203}: Nimm das Boot ab {area:150} nach {area:442} (es hält unterwegs in {area:271}) und geh dann nach Süden nach {area:415}. Fülle den {item:265772} im See rund um die Stadt.",
	-- ["{npc:5895}, at the shrine"] = "{npc:5895}, am Schrein",
}
