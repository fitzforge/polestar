-- Chinese (traditional) (zhTW): the guide forever/class/priest/priest-robes-horde (forever/class/priest/priest-robes-horde.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Priest Robes at 5 (Horde)"] = "5級牧師長袍（部落）",
	["A free uncommon robe at 5: heal and fortify a wounded guard near your first town."] = "5級免費獲得一件優秀長袍：在你的第一個城鎮附近治療並強化一名受傷的衛兵。",

	-- Step 1: In Favor of Spirituality
	-- {npc:3707} Ken'jai · {area:363} Valley of Trials · {npc:3706} Tai'jin · {area:362} Razor Hill · {spell:613} Lesser Heal
	["At 5, {npc:3707}, the priest trainer in the Den in the middle of the {area:363}, sends you to {npc:3706} in {area:362}. Train {spell:613} (Rank 2) from him while you are here: it opens at level 4 for 1 silver, and the next quest needs exactly that rank."] = "5級時，{area:363}中部獸穴的牧師訓練師{npc:3707}派你去{area:362}找{npc:3706}。趁在這裡時向他學習{spell:613}（2級）：4級花1銀就能學，下一個任務正好需要這個等級。",

	-- Step 2: Tai'jin
	-- {area:363} Valley of Trials · {area:362} Razor Hill · {npc:3706} Tai'jin
	["Follow the road out of the {area:363} north-east to {area:362}. {npc:3706} is inside the barracks, the first building on the right as you come into town."] = "沿道路從{area:363}向東北前往{area:362}。{npc:3706}在兵營裡，即進城後右手邊第一座建築。",
	-- {spell:613} Lesser Heal · {npc:3707} Ken'jai
	["{spell:613} (Rank 2), if {npc:3707} did not teach it yet"] = "{spell:613}（2級），如果{npc:3707}還沒教你",

	-- Step 3: Grunt Kor'ja
	-- {npc:12430} Grunt Kor'ja · {area:362} Razor Hill · {spell:613} Lesser Heal · {spell:1243} Power Word: Fortitude
	["{npc:12430} kneels behind a group of rocks just off the road, a short walk south of {area:362}. Cast {spell:613} (Rank 2) on her first, then {spell:1243}. Rank 1 of {spell:613} does not count; drag Rank 2 onto your bar from the spellbook. She leaves once both land and is back in about 5 minutes."] = "{npc:12430}跪在路邊的一堆岩石後面，就在{area:362}南邊不遠處。先對她施放{spell:613}（2級），再施放{spell:1243}。{spell:613}的1級不算數；從法術書裡把2級拖到動作條上。兩個法術都命中後她就離開，大約5分鐘後回來。",
	-- {npc:12430} Grunt Kor'ja
	["Heal and fortify {npc:12430}"] = "治療{npc:12430}並為她施放耐力",

	-- Step 4: Tai'jin
	-- {area:362} Razor Hill · {npc:3706} Tai'jin · {item:16606} Juju Hex Robes
	["Back in the {area:362} barracks: {npc:3706} gives you the {item:16606}."] = "回到{area:362}的兵營：{npc:3706}給你{item:16606}。",

	-- Step 5: In Favor of Darkness
	-- {npc:2123} Dark Cleric Duesten · {area:154} Deathknell · {npc:2129} Dark Cleric Beryl · {area:159} Brill · {spell:613} Lesser Heal
	["At 5, {npc:2123}, the priest trainer in the chapel of {area:154}, sends you to {npc:2129} in {area:159}. Train {spell:613} (Rank 2) from him while you are here: it opens at level 4 for 1 silver, and the next quest needs exactly that rank."] = "5級時，{area:154}禮拜堂的牧師訓練師{npc:2123}派你去{area:159}找{npc:2129}。趁在這裡時向他學習{spell:613}（2級）：4級花1銀就能學，下一個任務正好需要這個等級。",

	-- Step 6: Dark Cleric Beryl
	-- {area:154} Deathknell · {area:159} Brill · {npc:2129} Dark Cleric Beryl · {area:2119} Gallows' End Tavern
	["Follow the road east out of {area:154} to {area:159}. {npc:2129} is upstairs in the inn, {area:2119}."] = "沿道路向東出{area:154}前往{area:159}。{npc:2129}在旅店{area:2119}的樓上。",
	-- {spell:613} Lesser Heal
	["{spell:613} (Rank 2), if Duesten did not teach it yet"] = "{spell:613}（2級），如果Duesten還沒教你",

	-- Step 7: Deathguard Kel
	-- {npc:12428} Deathguard Kel · {area:159} Brill · {spell:613} Lesser Heal · {spell:1243} Power Word: Fortitude
	["{npc:12428} kneels, half-dead, beside the north gate of {area:159}'s graveyard, a short walk north of the inn. Cast {spell:613} (Rank 2) on him first, then {spell:1243}: Fortitude first does not count, nor does Rank 1 of {spell:613}. If an addon gets in the way, cast both from the spellbook."] = "{npc:12428}半死不活地跪在{area:159}墓地北門旁，就在旅店北面不遠處。先對他施放{spell:613}（2級），再施放{spell:1243}：先加韌不算數，{spell:613}的1級也不算。如果外掛干擾，就從法術書裡施放這兩個法術。",
	-- {npc:12428} Deathguard Kel
	["Heal and fortify {npc:12428}"] = "治療{npc:12428}並為他施放韌性",

	-- Step 8: Dark Cleric Beryl
	-- {area:159} Brill · {item:16607} Acolyte's Sacrificial Robes
	["Back upstairs in the {area:159} inn: Beryl gives you the {item:16607}."] = "回到{area:159}旅店樓上：Beryl給你{item:16607}。",
}
