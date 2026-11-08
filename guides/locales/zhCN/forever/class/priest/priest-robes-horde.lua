-- Chinese (simplified) (zhCN): the guide forever/class/priest/priest-robes-horde (forever/class/priest/priest-robes-horde.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Priest Robes at 5 (Horde)"] = "5级牧师长袍（部落）",
	["A free uncommon robe at 5: heal and fortify a wounded guard near your first town."] = "5级免费获得一件优秀长袍：在你的第一个城镇附近治疗并强化一名受伤的卫兵。",

	-- Step 1: In Favor of Spirituality
	-- {npc:3707} Ken'jai · {npc:3706} Tai'jin · {object:3224} Razor Hill (no name in this language: may be words)
	["At 5, {npc:3707}, the priest trainer in the Den in the middle of the Valley of Trials, sends you to {npc:3706} in {object:3224}. Train Lesser Heal (Rank 2) from him while you are here: it opens at level 4 for 1 silver, and the next quest needs exactly that rank."] = "",

	-- Step 2: Tai'jin
	-- {object:3224} Razor Hill (no name in this language: may be words) · {npc:3706} Tai'jin
	["Follow the road out of the Valley of Trials north-east to {object:3224}. {npc:3706} is inside the barracks, the first building on the right as you come into town."] = "",
	-- {npc:3707} Ken'jai
	["Lesser Heal (Rank 2), if {npc:3707} did not teach it yet"] = "",

	-- Step 3: Grunt Kor'ja
	-- {npc:12430} Grunt Kor'ja · {object:3224} Razor Hill (no name in this language: may be words)
	["{npc:12430} kneels behind a group of rocks just off the road, a short walk south of {object:3224}. Cast Lesser Heal (Rank 2) on her first, then Power Word: Fortitude. Rank 1 of Lesser Heal does not count; drag Rank 2 onto your bar from the spellbook. She leaves once both land and is back in about 5 minutes."] = "",
	-- {npc:12430} Grunt Kor'ja
	["Heal and fortify {npc:12430}"] = "",

	-- Step 4: Tai'jin
	-- {object:3224} Razor Hill (no name in this language: may be words) · {npc:3706} Tai'jin · {item:16606} Juju Hex Robes
	["Back in the {object:3224} barracks: {npc:3706} gives you the {item:16606}."] = "",

	-- Step 5: In Favor of Darkness
	-- {npc:2123} Dark Cleric Duesten · {npc:2129} Dark Cleric Beryl
	["At 5, {npc:2123}, the priest trainer in the chapel of Deathknell, sends you to {npc:2129} in Brill. Train Lesser Heal (Rank 2) from him while you are here: it opens at level 4 for 1 silver, and the next quest needs exactly that rank."] = "",

	-- Step 6: Dark Cleric Beryl
	-- {npc:2129} Dark Cleric Beryl
	["Follow the road east out of Deathknell to Brill. {npc:2129} is upstairs in the inn, Gallows' End Tavern."] = "",
	["Lesser Heal (Rank 2), if Duesten did not teach it yet"] = "",

	-- Step 7: Deathguard Kel
	-- {npc:12428} Deathguard Kel
	["{npc:12428} kneels, half-dead, beside the north gate of Brill's graveyard, a short walk north of the inn. Cast Lesser Heal (Rank 2) on him first, then Power Word: Fortitude: Fortitude first does not count, nor does Rank 1 of Lesser Heal. If an addon gets in the way, cast both from the spellbook."] = "",
	-- {npc:12428} Deathguard Kel
	["Heal and fortify {npc:12428}"] = "",

	-- Step 8: Dark Cleric Beryl
	-- {item:16607} Acolyte's Sacrificial Robes
	["Back upstairs in the Brill inn: Beryl gives you the {item:16607}."] = "",
}
