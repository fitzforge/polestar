-- German (deDE): the guide forever/class/priest/confounding-flash-and-contingency-plan (forever/class/priest/confounding-flash-and-contingency-plan.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:94817} Confounding Flash · {quest:94818} Contingency Plan
	["{quest:94817} and {quest:94818}"] = "{quest:94817} und {quest:94818}",
	-- {quest:94817} Confounding Flash · {quest:94818} Contingency Plan
	["The Gnome priest spells, new in Forever: {quest:94817} at 10, {quest:94818} at 20. Free, no objectives."] = "Die Priesterzauber der Gnome, neu in Forever: {quest:94817} mit 10, {quest:94818} mit 20. Kostenlos, keine Ziele.",

	-- Step 1: Confounding Flash: Maxan Anvol
	-- {npc:1226} Maxan Anvol · {area:2102} Thunderbrew Distillery · {area:131} Kharanos · {quest:94817} Confounding Flash · {npc:258785} High Priestess Mims · {zone:1455} Ironforge
	["At 10, {npc:1226}, the priest trainer inside the {area:2102} in {area:131}, hands you a {quest:94817} letter for {npc:258785} in {zone:1455}. {area:131} is on the road up to the city."] = "Mit 10 gibt dir {npc:1226}, der Priesterlehrer in der {area:2102} in {area:131}, einen Brief {quest:94817} für {npc:258785} in {zone:1455}. {area:131} liegt an der Straße hinauf zur Stadt.",
	-- {npc:1226} Maxan Anvol · {quest:94817} Confounding Flash
	["{npc:1226}: take his {quest:94817} letter"] = "{npc:1226}: Nimm seinen Brief {quest:94817} an",

	-- Step 2: Confounding Flash: Priestess Josetta
	-- {zone:1429} Elwynn Forest · {npc:377} Priestess Josetta · {area:87} Goldshire · {quest:94817} Confounding Flash · {npc:258785} High Priestess Mims · {zone:1455} Ironforge
	["At 10 in {zone:1429}, {npc:377}, upstairs in the Lion's Pride Inn in {area:87}, hands you a {quest:94817} letter for {npc:258785} in {zone:1455}."] = "Mit 10 gibt dir in {zone:1429} {npc:377}, oben im Lion's Pride Inn in {area:87}, einen Brief {quest:94817} für {npc:258785} in {zone:1455}.",
	-- {npc:377} Priestess Josetta · {quest:94817} Confounding Flash
	["{npc:377}: take her {quest:94817} letter"] = "{npc:377}: Nimm ihren Brief {quest:94817} an",

	-- Step 3: Confounding Flash: High Priestess Laurena
	-- {zone:1453} Stormwind · {npc:376} High Priestess Laurena · {quest:94817} Confounding Flash · {npc:258785} High Priestess Mims · {zone:1455} Ironforge · {area:2257} Deeprun Tram · {object:28027} Dwarven District
	["At 10 in {zone:1453}, {npc:376} at the altar of the Cathedral of Light hands you a {quest:94817} letter for {npc:258785} in {zone:1455} (the {area:2257} from the {object:28027})."] = "Mit 10 gibt dir in {zone:1453} {npc:376} am Altar der Kathedrale des Lichts einen Brief {quest:94817} für {npc:258785} in {zone:1455} ({area:2257} vom {object:28027} aus).",
	-- {npc:376} High Priestess Laurena · {quest:94817} Confounding Flash
	["{npc:376}: take her {quest:94817} letter"] = "{npc:376}: Nimm ihren Brief {quest:94817} an",

	-- Step 4: Confounding Flash: High Priestess Mims
	-- {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {npc:11406} High Priest Rohan · {quest:94817} Confounding Flash
	["At 10, go to {npc:258785} in the {object:32386}, {zone:1455}'s {object:32362} (north-west of the city), right beside {npc:11406}: she gives {quest:94817} and takes it back at once. No letter needed. {quest:94817} confuses up to five enemies around you for 3 seconds (any damage wakes them) on a 2-minute cooldown: time to step back and heal, or to run."] = "Geh mit 10 zu {npc:258785} im {object:32386}, in {object:32362} von {zone:1455} (nordwestlich der Stadt), direkt neben {npc:11406}: Sie gibt dir {quest:94817} und nimmt sie sofort zurück. Kein Brief nötig. {quest:94817} verwirrt bis zu fünf Gegner um dich herum für 3 Sekunden (jeder Schaden weckt sie), bei 2 Minuten Abklingzeit: Zeit, um zurückzutreten und zu heilen oder um wegzulaufen.",

	-- Step 5: Confounding Flash: Maxan Anvol's letter
	-- {quest:94824} Confounding Flash · {npc:1226} Maxan Anvol
	["{quest:94824}: {npc:1226}'s letter"] = "{quest:94824}: der Brief von {npc:1226}",
	-- {area:131} Kharanos · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries (no name in this language: may be words) · {quest:94824} Confounding Flash
	["Follow the road up from {area:131} into {zone:1455} and to the {object:32362}: {npc:258785} in the {object:32386} takes the letter and teaches {quest:94824}."] = "Folge der Straße von {area:131} hinauf nach {zone:1455} und zu {object:32362}: {npc:258785} im {object:32386} nimmt den Brief entgegen und bringt dir {quest:94824} bei.",

	-- Step 6: Confounding Flash: Josetta's letter
	-- {quest:94822} Confounding Flash
	["{quest:94822}: Josetta's letter"] = "{quest:94822}: Josettas Brief",
	-- {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {area:2257} Deeprun Tram · {zone:1453} Stormwind · {object:28027} Dwarven District
	["Hand the letter to {npc:258785} in the {object:32386}, {zone:1455}'s {object:32362}: the {area:2257} from {zone:1453}'s {object:28027}."] = "Gib den Brief bei {npc:258785} im {object:32386}, in {object:32362} von {zone:1455}, ab: {area:2257} vom {object:28027} in {zone:1453}.",

	-- Step 7: Confounding Flash: Laurena's letter
	-- {quest:94821} Confounding Flash
	["{quest:94821}: Laurena's letter"] = "{quest:94821}: Laurenas Brief",

	-- Step 8: Confounding Flash: a letter from another trainer
	-- {quest:94823} Confounding Flash
	["{quest:94823}: a letter from another trainer"] = "{quest:94823}: ein Brief eines anderen Lehrers",
	-- {quest:94823} Confounding Flash · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words)
	["Any {quest:94823} letter goes to {npc:258785} in the {object:32386}, {zone:1455}'s {object:32362}."] = "Jeder Brief {quest:94823} geht an {npc:258785} im {object:32386}, in {object:32362} von {zone:1455}.",

	-- Step 9: Confounding Flash: a letter from another trainer
	-- {quest:94825} Confounding Flash
	["{quest:94825}: a letter from another trainer"] = "{quest:94825}: ein Brief eines anderen Lehrers",
	-- {quest:94825} Confounding Flash · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words)
	["Any {quest:94825} letter goes to {npc:258785} in the {object:32386}, {zone:1455}'s {object:32362}."] = "Jeder Brief {quest:94825} geht an {npc:258785} im {object:32386}, in {object:32362} von {zone:1455}.",

	-- Step 10: Confounding Flash: a letter from another trainer
	-- {quest:94826} Confounding Flash
	["{quest:94826}: a letter from another trainer"] = "{quest:94826}: ein Brief eines anderen Lehrers",
	-- {quest:94826} Confounding Flash · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words)
	["Any {quest:94826} letter goes to {npc:258785} in the {object:32386}, {zone:1455}'s {object:32362}."] = "Jeder Brief {quest:94826} geht an {npc:258785} im {object:32386}, in {object:32362} von {zone:1455}.",

	-- Step 11: Contingency Plan: High Priestess Laurena
	-- {zone:1453} Stormwind · {npc:376} High Priestess Laurena · {quest:94818} Contingency Plan · {npc:258785} High Priestess Mims · {zone:1455} Ironforge · {area:2257} Deeprun Tram · {object:28027} Dwarven District
	["At 20 in {zone:1453}, {npc:376} at the altar of the Cathedral of Light hands you a {quest:94818} letter for {npc:258785} in {zone:1455} (the {area:2257} from the {object:28027})."] = "Mit 20 gibt dir in {zone:1453} {npc:376} am Altar der Kathedrale des Lichts einen Brief {quest:94818} für {npc:258785} in {zone:1455} ({area:2257} vom {object:28027} aus).",
	-- {npc:376} High Priestess Laurena · {quest:94818} Contingency Plan
	["{npc:376}: take her {quest:94818} letter"] = "{npc:376}: Nimm ihren Brief {quest:94818} an",

	-- Step 12: Contingency Plan: High Priestess Mims
	-- {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries (no name in this language: may be words) · {quest:94818} Contingency Plan · {spell:139} Renew · {spell:17} Power Word: Shield
	["At 20, {npc:258785} in the {object:32386} teaches {quest:94818} with a quest she gives and takes back at once. {quest:94818} wards a friend for 30 seconds: if they drop below 35% health, they get a shield and a heal over time at once (it stacks with {spell:139} and {spell:17}). 5-minute cooldown."] = "Mit 20 bringt dir {npc:258785} im {object:32386} {quest:94818} mit einer Quest bei, die sie dir gibt und sofort zurücknimmt. {quest:94818} schützt einen Freund 30 Sekunden lang: Fällt sein Leben unter 35 %, bekommt er sofort einen Schild und eine Heilung über Zeit (sie wirkt zusätzlich zu {spell:139} und {spell:17}). 5 Minuten Abklingzeit.",

	-- Step 13: Contingency Plan: Laurena's letter
	-- {quest:94819} Contingency Plan
	["{quest:94819}: Laurena's letter"] = "{quest:94819}: Laurenas Brief",
	-- {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {area:2257} Deeprun Tram · {zone:1453} Stormwind · {object:28027} Dwarven District
	["Hand Laurena's letter to {npc:258785} in the {object:32386}, {zone:1455}'s {object:32362}: the {area:2257} from {zone:1453}'s {object:28027}."] = "Gib Laurenas Brief bei {npc:258785} im {object:32386}, in {object:32362} von {zone:1455}, ab: {area:2257} vom {object:28027} in {zone:1453}.",

	-- Step 14: Contingency Plan: a letter from another trainer
	-- {quest:94820} Contingency Plan
	["{quest:94820}: a letter from another trainer"] = "{quest:94820}: ein Brief eines anderen Lehrers",
	-- {quest:94820} Contingency Plan · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words)
	["Any {quest:94820} letter goes to {npc:258785} in the {object:32386}, {zone:1455}'s {object:32362}."] = "Jeder Brief {quest:94820} geht an {npc:258785} im {object:32386}, in {object:32362} von {zone:1455}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 10, go to {npc:258785} in the {object:32386}, in {zone:1455}'s {object:32362}. {npc:1226} in {area:131}, {npc:377} in {area:87} and {npc:376} in {zone:1453} send you to her with a quest of the same name (its text may say {zone:1453}: Mims is in {zone:1455})."] = "Geh mit 10 zu {npc:258785} in der {object:32386} in der {object:32362} von {zone:1455}. {npc:1226} in {area:131}, {npc:377} in {area:87} und {npc:376} in {zone:1453} schicken dich mit einer gleichnamigen Quest zu ihr (ihr Text nennt evtl. {zone:1453}: Mims ist in {zone:1455}).",
	-- ["At 20, {npc:258785} teaches {quest:94818}. {npc:376} in {zone:1453} sends you to her with a quest of the same name."] = "Mit 20 lehrt {npc:258785} {quest:94818}. {npc:376} in {zone:1453} schickt dich mit einer gleichnamigen Quest zu ihr.",
	-- ["The Gnome priest spells, new in Forever: one at 10, one at 20."] = "Die Priesterzauber der Gnome, neu in Forever: einer mit 10, einer mit 20.",
}
