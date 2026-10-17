-- Chinese (simplified) (zhCN): the guide forever/class/warrior/whirlwind-weapon (forever/class/warrior/whirlwind-weapon.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:2458} Berserker Stance · {spell:1680} Whirlwind
	["{spell:2458} at 30 and a {spell:1680} axe, sword or warhammer at 40."] = "30级的{spell:2458}，以及40级的{spell:1680}斧、剑或战锤。",

	-- Step 1: The Islander (Stormwind)
	-- {npc:5479} Wu Shen · {object:2100} Old Town · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens
	["At 30, {npc:5479} in {object:2100}, beside the Pig and Whistle, sends you to {npc:6236} on {area:720} in the {zone:1413}."] = "30级时，{object:2100}酒馆旁的{npc:5479}会让你去{zone:1413}的{area:720}找{npc:6236}。",

	-- Step 2: The Islander (Ironforge)
	-- {npc:5113} Kelv Sternhammer · {zone:1455} Ironforge · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens
	["At 30, {npc:5113}, the warrior trainer of {zone:1455}, sends you to {npc:6236} on {area:720} in the {zone:1413}."] = "30级时，{zone:1455}的战士训练师{npc:5113}会让你去{zone:1413}的{area:720}找{npc:6236}。",

	-- Step 3: The Islander (Orgrimmar)
	-- {npc:3354} Sorek · {object:172958} Valley of Honor · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens
	["At 30, {npc:3354} in the {object:172958} sends you to {npc:6236} on {area:720} in the {zone:1413}."] = "30级时，{object:172958}的{npc:3354}会让你去{zone:1413}的{area:720}找{npc:6236}。",

	-- Step 4: The Islander (Thunder Bluff)
	-- {npc:3041} Torm Ragetotem · {zone:1456} Thunder Bluff · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens
	["At 30, {npc:3041}, the warrior trainer of {zone:1456}, sends you to {npc:6236} on {area:720} in the {zone:1413}."] = "30级时，{zone:1456}的战士训练师{npc:3041}会让你去{zone:1413}的{area:720}找{npc:6236}。",

	-- Step 5: The Islander (Undercity)
	-- {npc:4595} Baltus Fowler · {zone:1458} Undercity · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens
	["At 30, {npc:4595}, a warrior trainer of the {zone:1458}, sends you to {npc:6236} on {area:720} in the {zone:1413}."] = "30级时，{zone:1458}的一位战士训练师{npc:4595}会让你去{zone:1413}的{area:720}找{npc:6236}。",

	-- Step 6: The Affray
	-- {area:392} Ratchet · {area:720} Fray Island · {npc:6236} Klannoc Macleod · {npc:6238} Big Will
	["Ride south along the coast from {area:392} to {area:720}. {npc:6236} stands by the arena: step on the grate to start the fight; the challengers come one at a time, then {npc:6238} (33)."] = "从{area:392}沿海岸向南骑到{area:720}。{npc:6236}站在竞技场旁：踩上格栅开始战斗；挑战者一个接一个上场，最后是{npc:6238}（33级）。",
	-- {npc:6238} Big Will
	["Defeat the challengers and {npc:6238}"] = "击败挑战者和{npc:6238}",

	-- Step 7: Bath'rah the Windwatcher
	-- {npc:6176} Bath'rah the Windwatcher · {zone:1416} Alterac Mountains · {zone:1424} Hillsbrad Foothills · {item:3357} Liferoot · {item:3901} Bloodscalp Tusk · {quest:1714} Essence of the Exile
	["{npc:6176} camps in the south-east of {zone:1416}, above {zone:1424}; his cauldron stands beside him. He asks for a {item:3357}, a {item:3901} and the {quest:1714}, which his cauldron brews from three charms."] = "{npc:6176}在{zone:1416}东南部、{zone:1424}上方扎营；他的大锅就在旁边。他要一个{item:3357}、一个{item:3901}和{quest:1714}，后者由他的大锅用三个护符熬制。",

	-- Step 8: The exiles of Arathi
	["The exiles of Arathi"] = "阿拉希的流放者",
	-- {zone:1417} Arathi Highlands
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Thundering Exiles = {npc:2762} Thundering Exile · Cresting Exiles = {npc:2761} Cresting Exile
	["Three kinds of elemental exiles roam {zone:1417}: Burning Exiles in the north-west, Thundering Exiles in the middle, Cresting Exiles in the north-east. Each drops its charm."] = "{zone:1417}有三种元素流放者：西北部的{npc:2760}、中部的{npc:2762}、东北部的{npc:2761}。每种都掉落各自的护符。",
	-- {item:4479} Burning Charm
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile
	["{item:4479} from the Burning Exiles"] = "{item:4479}，来自{npc:2760}",
	-- {item:4480} Thundering Charm
	-- plural, as words: Thundering Exiles = {npc:2762} Thundering Exile
	["{item:4480} from the Thundering Exiles"] = "{item:4480}，来自{npc:2762}",
	-- {item:4481} Cresting Charm
	-- plural, as words: Cresting Exiles = {npc:2761} Cresting Exile
	["{item:4481} from the Cresting Exiles"] = "{item:4481}，来自{npc:2761}",

	-- Step 9: Essence of the Exile
	-- {item:3357} Liferoot · {skill:182} Herbalism
	["{item:3357}: {skill:182}, or the auction house"] = "{item:3357}：{skill:182}，或拍卖行",

	-- Step 10: Bloodscalp Tusk
	-- {zone:1434} Stranglethorn Vale · {item:3901} Bloodscalp Tusk
	["The Bloodscalp trolls hold the north-west of {zone:1434}; they drop the {item:3901}."] = "血顶巨魔占据着{zone:1434}西北部；他们掉落{item:3901}。",

	-- Step 11: The Summoning
	-- {quest:1712} Cyclonian · {npc:6176} Bath'rah the Windwatcher · {item:6894} Whirlwind Heart
	["{quest:1712} waits just north of {npc:6176}'s camp and carries the {item:6894}. {quest:1712} is elite: grouping up is advised."] = "{quest:1712}在{npc:6176}营地北边不远处等候，身上带着{item:6894}。{quest:1712}是精英：建议组队。",
	-- {item:6894} Whirlwind Heart · {quest:1712} Cyclonian
	["{item:6894} from {quest:1712}"] = "{item:6894}，来自{quest:1712}",
}
