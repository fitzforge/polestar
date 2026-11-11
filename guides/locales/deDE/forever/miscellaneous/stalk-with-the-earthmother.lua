-- German (deDE): the guide forever/miscellaneous/stalk-with-the-earthmother (forever/miscellaneous/stalk-with-the-earthmother.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:205729} Boarton Shadetotem · {zone:1456} Thunder Bluff
	["A one-hand blade or mace at 11 from {npc:205729}'s three tests in and around {zone:1456}, for a Tauren of any class."] = "Eine Einhandklinge oder ein Einhandstreitkolben auf Stufe 11 durch die drei Prüfungen von {npc:205729} in und um {zone:1456}, für einen Tauren jeder Klasse.",

	-- Step 1: Boarton Shadetotem
	-- {npc:205729} Boarton Shadetotem · {zone:1456} Thunder Bluff · {item:206159} Venture Co Disguise · {npc:3051} Supervisor Fizsprocket
	-- plural, as words: Venture Co. Workers = {npc:2978} Venture Co. Worker
	["{npc:205729} hides in stealth on the main mesa of {zone:1456}, south of its pool: walk to where the arrow points until his outline shows. He hands you the {item:206159}. The quest opens at level 4, but the mine holds Venture Co. Workers (level 8-9), Supervisors (9-10) and {npc:3051} (12): go at 9 or 10."] = "{npc:205729} versteckt sich getarnt auf der Hauptmesa von {zone:1456}, südlich des Teichs: Geh dorthin, wohin der Pfeil zeigt, bis seine Umrisse sichtbar werden. Er gibt dir die {item:206159}. Die Quest beginnt auf Stufe 4, aber in der Mine sind Venture Co. Workers (Stufe 8-9), Supervisors (9-10) und {npc:3051} (12): Geh mit Stufe 9 oder 10.",

	-- Step 2: The Venture Co. Mine
	-- {zone:1412} Mulgore · {area:360} The Venture Co. Mine · {object:403041} Blasting Supplies (no name in this language: may be words)
	["Ride down the lift and south-east across {zone:1412} to the {area:360}. Put on the disguise, then open the carts of {object:403041} inside the mine and on the slope outside it; stay on the upper levels where you can, the lower tunnels are packed. Five charges."] = "Fahr mit dem Aufzug nach unten und reite durch {zone:1412} nach Südosten zur {area:360}. Zieh die Verkleidung an, öffne dann die Loren mit {object:403041} in der Mine und am Hang davor; bleib möglichst auf den oberen Ebenen, die unteren Tunnel sind überfüllt. Fünf Ladungen.",
	-- {item:206157} Seaforium Mining Charge · {object:403041} Blasting Supplies (no name in this language: may be words)
	["{item:206157}, from the {object:403041}"] = "{item:206157}, von den {object:403041}",

	-- Step 3: Boarton Shadetotem
	-- {npc:205729} Boarton Shadetotem · {zone:1456} Thunder Bluff · {item:206176} Mortar and Pestle
	["Back to {npc:205729} in {zone:1456}. He gives you the {item:206176} for his next test."] = "Zurück zu {npc:205729} in {zone:1456}. Er gibt dir den {item:206176} für seine nächste Prüfung.",

	-- Step 4: Windfury Cones
	-- plural, as words: Windfury Cones = {item:206170} Windfury Cone
	["Windfury Cones"] = "Windfury Cones",
	-- {area:819} Windfury Ridge · {zone:1456} Thunder Bluff · {item:206176} Mortar and Pestle
	-- plural, as words: Windfury Cones = {item:206170} Windfury Cone
	["Windfury Cones lie on the ground under the harpies' nest trees on {area:819}, north-west of {zone:1456}; the harpies do not drop them. The Windfury Sorceresses (level 9-10) and Matriarchs (10-11) there stand close together: pick the cones from the edges. Once you have eight, use the {item:206176} to grind them."] = "Windfury Cones liegen am Boden unter den Nestbäumen der Harpyien auf {area:819}, nordwestlich von {zone:1456}; die Harpyien lassen sie nicht fallen. Die Windfury Sorceresses (Stufe 9-10) und Matriarchs (10-11) dort stehen dicht beieinander: Sammle die Zapfen an den Rändern auf. Hast du acht, zermahle sie mit dem {item:206176}.",
	["the mortar takes all eight"] = "der Mörser nimmt alle acht",
	-- {item:206175} Pine Salve
	["grind the eight cones into the {item:206175}"] = "zermahle die acht Zapfen im {item:206175}",

	-- Step 5: Boarton Shadetotem
	-- {npc:205729} Boarton Shadetotem · {item:206344} Knife Set
	["Back to {npc:205729}. He hands you the {item:206344} for the last test."] = "Zurück zu {npc:205729}. Er gibt dir das {item:206344} für die letzte Prüfung.",

	-- Step 6: Raw Brilliant Smallfish
	-- {item:6291} Raw Brilliant Smallfish · {npc:8674} Auctioneer Stampi · {npc:3028} Kah Mistrunner · {skill:356} Fishing · {npc:3029} Sewa Mistrunner · {item:6256} Fishing Pole · {item:6529} Shiny Bauble · {item:206344} Knife Set
	["Buy a {item:6291} at the Auction House ({npc:8674}, north of the pool), or fish one yourself: {npc:3028} trains {skill:356} and {npc:3029} beside him sells the {item:6256} and a {item:6529}; the pool on the main mesa gives smallfish at any skill. Then use the {item:206344} on it, wherever you are."] = "Kaufe einen {item:6291} im Auktionshaus ({npc:8674}, nördlich des Teichs) oder angle dir einen selbst: {npc:3028} bildet in {skill:356} aus, und {npc:3029} neben ihm verkauft die {item:6256} und einen {item:6529}; der Teich auf der Hauptmesa gibt Fischlein bei jeder Fertigkeit. Benutze dann das {item:206344} an ihm, wo immer du bist.",
	-- {item:6291} Raw Brilliant Smallfish
	["{item:6291}: the Auction House, or the pool; the knife takes it"] = "{item:6291}: das Auktionshaus oder der Teich; das Messer nimmt ihn",
	-- {item:206345} Fish Chunks · {npc:205729} Boarton Shadetotem
	["fillet the smallfish into {item:206345} (where players did it, on the way back to {npc:205729})"] = "filetiere das Fischlein zu {item:206345} (dort, wo Spieler es taten, auf dem Rückweg zu {npc:205729})",

	-- Step 7: Boarton Shadetotem
	-- {npc:205729} Boarton Shadetotem · {item:277988} Hoof-Holstered Blade · {item:278002} Valley Cosh
	["Take your weapon from {npc:205729}: the {item:277988} or the {item:278002}."] = "Nimm deine Waffe von {npc:205729}: die {item:277988} oder den {item:278002}.",
}
