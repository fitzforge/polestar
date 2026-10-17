-- German (deDE): the guide forever/reputation/thorium-brotherhood (forever/reputation/thorium-brotherhood.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Thorium Brotherhood Reputation"] = "Ruf: Thoriumbruderschaft",

	-- Step 1: Master Smith Burninate
	-- {area:1446} Thorium Point · {zone:1427} Searing Gorge · {faction:59} Thorium Brotherhood
	["{area:1446}, on the scaffolds in the north-west of {zone:1427}, is the Brotherhood's outpost. The {faction:59} starts out Neutral. Forever's Legacy Diplomat perk increases reputation gains."] = "{area:1446} auf den Gerüsten im Nordwesten der {zone:1427} ist der Außenposten der Bruderschaft. Bei {faction:59} beginnst du neutral. Der Vermächtnis-Vorteil „Diplomat“ von Forever erhöht den Rufgewinn.",

	-- Step 2: Secret Plans: Fiery Flux
	-- {area:1443} Slag Pit · {object:147516} Dark Iron · {item:18945} Dark Iron Residue
	["The plans lie in the {area:1443} of the Cauldron, guarded by {object:147516} dwarves. {object:147516} dwarves also drop {item:18945}, which Burninate takes for Gaining Acceptance."] = "Die Pläne liegen in der {area:1443} im Kessel, bewacht von Zwergen der {object:147516}. Zwerge der {object:147516} lassen auch {item:18945} fallen, das Meisterschmied Burninate für „Erlangte Anerkennung“ annimmt.",

	-- Step 3: Back to Burninate
	["Back to Burninate"] = "Zurück zu Meisterschmied Burninate",

	-- Step 4: Fiery Flux supplies to Friendly
	-- {item:18942} Fiery Flux
	["{item:18942} supplies to Friendly"] = "Nachschub an {item:18942} bis Freundlich",
	-- {item:3356} Kingsblood · {item:4234} Heavy Leather · {item:18944} Incendosaur Scale · {zone:1427} Searing Gorge
	-- plural, as words: Iron Bars = {item:3575} Iron Bar · Incendosaurs = {npc:9318} Incendosaur
	["Restoring Fiery Flux Supplies repeats in three versions: {item:3356}, Iron Bars or {item:4234}, each with Coal and an {item:18944}. Incendosaurs (level 47-49) in the north of {zone:1427} drop a scale every time; Burninate himself sells Coal."] = "Nachschub an feurigem Fluxus wiederholt sich in drei Versionen: {item:3356}, Eisenbarren oder {item:4234}, jeweils mit Kohle und {item:18944}. Incendosaurier (Stufe 47-49) im Norden der {zone:1427} lassen jedes Mal eine Schuppe fallen; Burninate selbst verkauft Kohle.",
	-- {npc:14624} Master Smith Burninate
	["{npc:14624}: Restoring Fiery Flux Supplies"] = "{npc:14624}: Nachschub an feurigem Fluxus",

	-- Step 5: Lokhtos Darkbargainer to Honored
	-- {npc:12944} Lokhtos Darkbargainer
	["{npc:12944} to Honored"] = "{npc:12944} bis Wohlwollend",
	-- {npc:12944} Lokhtos Darkbargainer · {area:1584} Blackrock Depths · {item:11099} Dark Iron Ore · {skill:186} Mining · {item:11382} Blood of the Mountain · {item:17010} Fiery Core · {item:17011} Lava Core · {item:17012} Core Leather · {npc:14387} Lothos Riftwaker · {area:1445} Blackrock Mountain · {area:2717} Molten Core
	-- plural, as words: Dark Iron Deposits = {object:165658} Dark Iron Deposit
	["{npc:12944} trades in the Grim Guzzler inside {area:1584}. His Favor Amongst the Brotherhood turn-ins take {item:11099} (mined from Dark Iron Deposits with {skill:186}), {item:11382}, {item:17010}, {item:17011} and {item:17012}. {npc:14387} at the {area:1445} entrance offers attunement to the {area:2717}."] = "{npc:12944} handelt im Grimmigen Säufer in {area:1584}. Seine Abgaben „Gunst der Bruderschaft“ nehmen {item:11099} (mit {skill:186} aus Dunkeleisenablagerungen abgebaut), {item:11382}, {item:17010}, {item:17011} und {item:17012}. {npc:14387} am Eingang des {area:1445} bietet die Einstimmung auf den {area:2717} an.",
	-- {item:11099} Dark Iron Ore
	["{item:11099}: Favor Amongst the Brotherhood, {item:11099} at Lokhtos, repeatable."] = "{item:11099}: Gunst der Bruderschaft, {item:11099} bei Lokhtos Darkbargainer, wiederholbar.",

	-- Step 6: Thorium Brotherhood to Revered
	-- {faction:59} Thorium Brotherhood
	["{faction:59} to Revered"] = "{faction:59} bis Respektvoll",
	-- {area:2717} Molten Core · {item:11382} Blood of the Mountain
	-- plural, as words: Fiery Cores = {item:17010} Fiery Core · Lava Cores = {item:17011} Lava Core · Lava Elementals = {npc:12076} Lava Elemental · Lava Reavers = {npc:12100} Lava Reaver · Molten Destroyers = {npc:11659} Molten Destroyer
	["The {area:2717} materials carry the rest: Fiery Cores drop from Firewalkers, Flameguards and Firelords, and Lava Cores from Lava Elementals, Lava Reavers and Molten Destroyers there. {item:11382} comes from Molten Destroyers and rarely elsewhere."] = "Die Materialien aus dem {area:2717} bringen den Rest: Feuerkerne fallen dort bei Feuergängern, Flammenwächtern und Feuerlords, Lavakerne bei Lavaelementaren, Lavahäschern und Geschmolzenen Zerstörern. {item:11382} stammt von Geschmolzenen Zerstörern und selten anderswo.",
	-- {area:2717} Molten Core · {item:17010} Fiery Core · {item:17011} Lava Core · {item:17012} Core Leather · {item:11382} Blood of the Mountain
	["{area:2717} materials: Favor Amongst the Brotherhood, {item:17010}, {item:17011}, {item:17012} and {item:11382}, all repeatable at Lokhtos."] = "Materialien aus dem {area:2717}: Gunst der Bruderschaft, {item:17010}, {item:17011}, {item:17012} und {item:11382}, alle wiederholbar bei Lokhtos Darkbargainer.",

	-- Step 7: Thorium Brotherhood to Exalted
	-- {faction:59} Thorium Brotherhood
	["{faction:59} to Exalted"] = "{faction:59} bis Ehrfürchtig",
	-- {area:2717} Molten Core · {item:11099} Dark Iron Ore
	["Keep turning in {area:2717} materials and {item:11099} at Lokhtos until Exalted."] = "Gib weiter Materialien aus dem {area:2717} und {item:11099} bei Lokhtos Darkbargainer ab, bis du ehrfürchtig bist.",
}
