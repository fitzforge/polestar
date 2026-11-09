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
	-- {npc:3707} Ken'jai · {area:363} Valley of Trials · {npc:3706} Tai'jin · {area:362} Razor Hill · {spell:613} Lesser Heal
	["At 5, {npc:3707}, the priest trainer in the Den in the middle of the {area:363}, sends you to {npc:3706} in {area:362}. Train {spell:613} (Rank 2) from him while you are here: it opens at level 4 for 1 silver, and the next quest needs exactly that rank."] = "5级时，{area:363} 中央兽穴内的牧师训练师 {npc:3707} 会派你去 {area:362} 找 {npc:3706}。趁在这里，向他学习 {spell:613}（等级2）：此技能4级即可学习，费用1银币，下一个任务必须使用这个等级的技能。",

	-- Step 2: Tai'jin
	-- {area:363} Valley of Trials · {area:362} Razor Hill · {npc:3706} Tai'jin
	["Follow the road out of the {area:363} north-east to {area:362}. {npc:3706} is inside the barracks, the first building on the right as you come into town."] = "从 {area:363} 沿道路向东北前往 {area:362}。{npc:3706} 在兵营内，也就是进镇后右手边的第一栋建筑。",
	-- {spell:613} Lesser Heal · {npc:3707} Ken'jai
	["{spell:613} (Rank 2), if {npc:3707} did not teach it yet"] = "{spell:613}（等级 2），如果 {npc:3707} 还没教你。",

	-- Step 3: Grunt Kor'ja
	-- {npc:12430} Grunt Kor'ja · {area:362} Razor Hill · {spell:613} Lesser Heal · {spell:1243} Power Word: Fortitude
	["{npc:12430} kneels behind a group of rocks just off the road, a short walk south of {area:362}. Cast {spell:613} (Rank 2) on her first, then {spell:1243}. Rank 1 of {spell:613} does not count; drag Rank 2 onto your bar from the spellbook. She leaves once both land and is back in about 5 minutes."] = "{npc:12430}跪在路边不远的一堆岩石后，距{area:362}向南几步路。先对她施放{spell:613}（等级2），再施放{spell:1243}。等级1的{spell:613}不算数；从法术书中将等级2拖到动作条上。两个法术都生效后她就会离开，约5分钟后回来。",
	-- {npc:12430} Grunt Kor'ja
	["Heal and fortify {npc:12430}"] = "治疗{npc:12430}并施加真言术：韧",

	-- Step 4: Tai'jin
	-- {area:362} Razor Hill · {npc:3706} Tai'jin · {item:16606} Juju Hex Robes
	["Back in the {area:362} barracks: {npc:3706} gives you the {item:16606}."] = "返回 {area:362} 兵营：{npc:3706} 会给你 {item:16606}。",

	-- Step 5: In Favor of Darkness
	-- {npc:2123} Dark Cleric Duesten · {area:154} Deathknell · {npc:2129} Dark Cleric Beryl · {area:159} Brill · {spell:613} Lesser Heal
	["At 5, {npc:2123}, the priest trainer in the chapel of {area:154}, sends you to {npc:2129} in {area:159}. Train {spell:613} (Rank 2) from him while you are here: it opens at level 4 for 1 silver, and the next quest needs exactly that rank."] = "5级时，{area:154}小教堂中的牧师训练师{npc:2123}会派你去{area:159}找{npc:2129}。趁现在向他学习{spell:613}（等级2）：4级即可学习，花费1银，下一任务必须使用这个等级。",

	-- Step 6: Dark Cleric Beryl
	-- {area:154} Deathknell · {area:159} Brill · {npc:2129} Dark Cleric Beryl · {area:2119} Gallows' End Tavern
	["Follow the road east out of {area:154} to {area:159}. {npc:2129} is upstairs in the inn, {area:2119}."] = "沿道路向东离开 {area:154}，前往 {area:159}。{npc:2129} 在 {area:2119} 旅店的楼上。",
	-- {spell:613} Lesser Heal
	["{spell:613} (Rank 2), if Duesten did not teach it yet"] = "如果黑暗牧师杜斯滕还没教你，就学习 {spell:613}（等级2）",

	-- Step 7: Deathguard Kel
	-- {npc:12428} Deathguard Kel · {area:159} Brill · {spell:613} Lesser Heal · {spell:1243} Power Word: Fortitude
	["{npc:12428} kneels, half-dead, beside the north gate of {area:159}'s graveyard, a short walk north of the inn. Cast {spell:613} (Rank 2) on him first, then {spell:1243}: Fortitude first does not count, nor does Rank 1 of {spell:613}. If an addon gets in the way, cast both from the spellbook."] = "{npc:12428}奄奄一息地跪在{area:159}墓地北门旁，距旅店向北几步路。先对他施放{spell:613}（等级2），再施放{spell:1243}：先施放真言术：韧不算数，等级1的{spell:613}也不算。如果插件干扰施法，就从法术书中直接施放这两个法术。",
	-- {npc:12428} Deathguard Kel
	["Heal and fortify {npc:12428}"] = "治疗{npc:12428}并施加真言术：韧",

	-- Step 8: Dark Cleric Beryl
	-- {area:159} Brill · {item:16607} Acolyte's Sacrificial Robes
	["Back upstairs in the {area:159} inn: Beryl gives you the {item:16607}."] = "回到{area:159}旅店楼上：黑暗牧师贝里尔会给你{item:16607}。",
}
