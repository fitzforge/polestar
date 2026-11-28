-- Chinese (traditional) (zhTW): the guide forever/professions/lockpicking (forever/professions/lockpicking.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Reach level 16
	["Reach level 16"] = "",
	-- {spell:1804} Pick Lock
	["{spell:1804} needs level 16."] = "",

	-- Step 2: Learn Pick Lock
	-- {spell:1804} Pick Lock
	["Learn {spell:1804}"] = "",
	-- {skill:633} Lockpicking
	["Any Rogue trainer teaches it; it starts {skill:633}."] = "",

	-- Step 3: Buy Thieves' Tools
	-- {item:5060} Thieves' Tools
	["Buy {item:5060}"] = "",
	-- {spell:1804} Pick Lock
	["A tool: {spell:1804} does not work without it in your bags."] = "",

	-- Step 4: Pick the Buccaneer's Strongboxes until 80 · the pirate ship near Ratchet · Pick Lock: Spellbook (P by default)
	-- {area:392} Ratchet · {spell:1804} Pick Lock
	["Pick the Buccaneer's Strongboxes until 80 · the pirate ship near {area:392} · {spell:1804}: Spellbook (P by default)"] = "",
	-- {object:123462} The Jewel of the Southsea
	["They come back within seconds. {object:123462} in the hold spawns a deadly mob."] = "",
	-- {area:392} Ratchet
	["the pirate ship near {area:392}"] = "",

	-- Step 5: Pick the Practice Lockboxes until 80 · north of Lake Everstill, Redridge · Pick Lock: Spellbook (P by default)
	-- {area:68} Lake Everstill · {spell:1804} Pick Lock
	["Pick the Practice Lockboxes until 80 · north of {area:68}, Redridge · {spell:1804}: Spellbook (P by default)"] = "",
	["They come back within seconds."] = "",
	-- {area:68} Lake Everstill
	["north of {area:68}, Redridge"] = "",

	-- Step 6: Reach level 20
	["Reach level 20"] = "",
	-- {skill:633} Lockpicking
	["{skill:633} stops at 5 times your level: 100 needs level 20."] = "",

	-- Step 7: Pick the Buccaneer's Strongboxes until 100 · the pirate ship near Ratchet · Pick Lock: Spellbook (P by default)
	-- {area:392} Ratchet · {spell:1804} Pick Lock
	["Pick the Buccaneer's Strongboxes until 100 · the pirate ship near {area:392} · {spell:1804}: Spellbook (P by default)"] = "",

	-- Step 8: Pick the Practice Lockboxes until 100 · north of Lake Everstill, Redridge · Pick Lock: Spellbook (P by default)
	-- {area:68} Lake Everstill · {spell:1804} Pick Lock
	["Pick the Practice Lockboxes until 100 · north of {area:68}, Redridge · {spell:1804}: Spellbook (P by default)"] = "",

	-- Step 9: Reach level 30
	["Reach level 30"] = "",
	-- {skill:633} Lockpicking
	["{skill:633} stops at 5 times your level: 150 needs level 30."] = "",

	-- Step 10: Pick the Waterlogged Footlockers until 150 · Zoram Strand shore, Ashenvale · Pick Lock: Spellbook (P by default)
	-- {area:414} Zoram Strand · {zone:1440} Ashenvale · {spell:1804} Pick Lock
	-- plural, as words: Waterlogged Footlockers = {object:179487} Waterlogged Footlocker
	["Pick the Waterlogged Footlockers until 150 · {area:414} shore, {zone:1440} · {spell:1804}: Spellbook (P by default)"] = "",
	["From 110 the ones in the water work too."] = "",
	-- {area:414} Zoram Strand · {zone:1440} Ashenvale
	["{area:414} shore, {zone:1440}"] = "",

	-- Step 11: Reach level 45
	["Reach level 45"] = "",
	-- {skill:633} Lockpicking
	["{skill:633} stops at 5 times your level: 225 needs level 45."] = "",

	-- Step 12: Pick the Battered Footlockers until 225 · Angor Fortress, Badlands · Pick Lock: Spellbook (P by default)
	-- {area:338} Angor Fortress · {zone:1418} Badlands · {spell:1804} Pick Lock
	-- plural, as words: Battered Footlockers = {object:179486} Battered Footlocker
	["Pick the Battered Footlockers until 225 · {area:338}, {zone:1418} · {spell:1804}: Spellbook (P by default)"] = "",
	["From 175 the Dented ones count too: a point every time up to 215."] = "",

	-- Step 13: Reach level 60
	["Reach level 60"] = "",
	-- {skill:633} Lockpicking
	["{skill:633} stops at 5 times your level: 300 needs level 60."] = "",

	-- Step 14: Pick the Dented Footlockers until 300 · The Slag Pit, Searing Gorge or Lost Rigger Cove, Tanaris · Pick Lock: Spellbook (P by default)
	-- {area:1443} The Slag Pit · {zone:1427} Searing Gorge · {area:1336} Lost Rigger Cove · {zone:1446} Tanaris · {spell:1804} Pick Lock
	-- plural, as words: Dented Footlockers = {object:179492} Dented Footlocker
	["Pick the Dented Footlockers until 300 · {area:1443}, {zone:1427} or {area:1336}, {zone:1446} · {spell:1804}: Spellbook (P by default)"] = "",
	["Points all the way to 300; past 290 a point comes less often."] = "",
}
