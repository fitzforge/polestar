-- German (deDE): the guide forever/class/paladin/holy-mightstone (forever/class/paladin/holy-mightstone.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A one-use stone that makes you much stronger against undead for 10 minutes; the old item choice may be gone in Forever."] = "",

	-- Step 1: Lord Grayson Shadowbreaker
	-- {npc:928} Lord Grayson Shadowbreaker · {zone:1422} Western Plaguelands · {npc:5149} Brandur Ironhammer · {zone:1455} Ironforge
	["At 50 {npc:928}, the paladin trainer in the Cathedral of Light, sends you to Chillwind Camp in the {zone:1422}. {npc:5149} in {zone:1455} gives the same quest."] = "",

	-- Step 2: Brandur Ironhammer
	-- {npc:5149} Brandur Ironhammer · {object:32362} Mystic Ward (no name in this language: may be words) · {zone:1422} Western Plaguelands · {npc:928} Lord Grayson Shadowbreaker · {zone:1453} Stormwind
	["At 50 {npc:5149}, the paladin trainer in the {object:32362}, sends you to Chillwind Camp in the {zone:1422}. {npc:928} in {zone:1453} gives the same quest."] = "",

	-- Step 3: Chillwind Camp
	["Chillwind Camp"] = "",
	-- {zone:1422} Western Plaguelands · {npc:10838} Commander Ashlam Valorfist · {npc:10840} Argent Officer Pureheart
	["Chillwind Camp is the Alliance camp at the south end of the {zone:1422}, north of the Alterac foothills. {npc:10838} commands it; {npc:10840} stands in the same camp."] = "",

	-- Step 4: The Argent Dawn Commission
	-- {item:12846} Argent Dawn Commission
	["The {item:12846}"] = "",
	-- {item:12846} Argent Dawn Commission · {npc:10840} Argent Officer Pureheart
	["The Scourge drop no Scourgestones unless you wear an {item:12846}. {npc:10840} gives you one through her quest, {item:12846}, which you hand in straight away (if you already have one from Light's Hope Chapel, wear that). Equip it in a trinket slot: it shows as a buff that never runs out. Keep it on until you have 20 stones."] = "",
	-- {item:12846} Argent Dawn Commission
	["{item:12846}: equip it"] = "",

	-- Step 5: Minion's Scourgestones
	-- plural, as words: Minion's Scourgestones = {item:12840} Minion's Scourgestone
	["Minion's Scourgestones"] = "Geißelsteine des Dieners",
	-- {zone:1422} Western Plaguelands · {item:12840} Minion's Scourgestone
	-- plural, as words: Flesh Golems = {npc:1805} Flesh Golem · Skeletal Guardians = {npc:10390} Skeletal Guardian · Dark Summoners = {npc:8551} Dark Summoner
	["Kill the Scourge of the {zone:1422} with the Commission on: skeletons, ghouls and cultists (level 50-58) drop a {item:12840} about two kills in five. Sorrow Hill, just east of Chillwind Camp around Uther's Tomb, is the closest farm. Avoid the Flesh Golems that patrol the fields; Skeletal Guardians cast Cone of Cold and Arcane Explosion up close, Dark Summoners run for help at low health."] = "",
	-- {item:12840} Minion's Scourgestone
	["{item:12840} x20"] = "",

	-- Step 6: High Priest Thel'danis
	-- {npc:1854} High Priest Thel'danis · {item:20612} Inert Scourgestone
	["{npc:1854} keeps watch at Uther's Tomb on Sorrow Hill, east of the camp. He turns your 20 stones into one {item:20612}: keep it."] = "",

	-- Step 7: Commander Ashlam Valorfist
	["Back to Chillwind Camp. Ashlam needs the voodoo of the Sunken Temple's trolls for the stone."] = "",

	-- Step 8: The Sunken Temple
	["The Sunken Temple"] = "",
	-- {zone:1435} Swamp of Sorrows · {npc:5716} Zul'Lor
	["The Temple of Atal'Hakkar, the Sunken Temple, lies in the Pool of Tears in eastern {zone:1435}: go up the ruin's stairs, dive into the flooded hall and follow the stairs down to the portal. It is a dungeon for a group of five at about 50-55. Six elite troll minibosses (level 51-52) stand on the balconies around the temple's great round room, each behind a pack of elites on its side path. Each drops its feather every time: Gasher and {npc:5716} the Amber, Hukku and Mijan the Blue, Zolo and Loro the Green; you need all six. Hukku calls guardians and throws Shadow Bolt Volleys, Mijan heals: kill them first."] = "",
	["The Temple of Atal'Hakkar"] = "",
	-- {item:20606} Amber Voodoo Feather · {npc:5716} Zul'Lor
	["{item:20606} x2: Gasher, {npc:5716}"] = "",
	-- {item:20607} Blue Voodoo Feather
	["{item:20607} x2: Hukku, Mijan"] = "",
	-- {item:20608} Green Voodoo Feather
	["{item:20608} x2: Zolo, Loro"] = "",

	-- Step 9: Forging the Mightstone
	-- {item:20620} Holy Mightstone · {item:20505} Chivalrous Signet · {item:20504} Lightforged Blade · {item:20512} Sanctified Orb
	["Back to Ashlam in Chillwind Camp: he forges the {item:20620}. Look at the reward window before you hand in: Classic also offered the {item:20505}, the {item:20504} or the {item:20512}, and Forever's notes say that choice may be gone. Use the stone before a fight against undead (Stratholme, Scholomance): it lasts ten minutes and is gone after one use."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A one-use stone that makes you much stronger against undead for 10 minutes; the old choice rewards are gone."] = "Ein Stein zum einmaligen Gebrauch, der dich 10 Minuten lang viel stärker gegen Untote macht; die alten Belohnungen zur Auswahl gibt es nicht mehr.",
	-- ["The Scourge throughout the {zone:1422} drop Minion's Scourgestones."] = "Die Geißel überall in {zone:1422} lässt Geißelsteine des Dieners fallen.",
	-- ["The {area:1417}"] = "{area:1417}",
	-- ["{area:1477} lies in the {area:74} in eastern {zone:1435}. Inside, Gasher and {npc:5716} drop the {item:20606}, Hukku and Mijan the Blue, Zolo and Loro the Green."] = "{area:1477} liegt in {area:74} im Osten von {zone:1435}. Drinnen lassen Schlitzer und {npc:5716} {item:20606} fallen, Hukku und Mijan die blaue, Zolo und Loro die grüne.",
	-- ["{item:20606}, inside"] = "{item:20606}, drinnen",
	-- ["{item:20607}, inside"] = "{item:20607}, drinnen",
	-- ["{item:20608}, inside"] = "{item:20608}, drinnen",
	-- ["{npc:10838} commands {area:3197} in the south of the {zone:1422}."] = "{npc:10838} befehligt {area:3197} im Süden von {zone:1422}.",
	-- ["{npc:5149} is in the {object:32362}."] = "{npc:5149} ist in {object:32362}.",
	-- ["{npc:928} is in the Cathedral of Light."] = "{npc:928} ist in der Kathedrale des Lichts.",
}
