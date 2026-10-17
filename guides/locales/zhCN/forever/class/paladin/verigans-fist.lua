-- Chinese (simplified) (zhCN): the guide forever/class/paladin/verigans-fist (forever/class/paladin/verigans-fist.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["The Alliance paladin's rare two-handed mace for the 20s, with a shield on the way."] = "联盟圣骑士20多级的稀有双手锤，途中还能拿到一面盾牌。",

	-- Step 1: The Tome of Valor (Ironforge)
	-- {npc:6179} Tiza Battleforge · {object:32362} Mystic Ward · {item:6776} Tome of Valor · {npc:6171} Duthorian Rall · {zone:1453} Stormwind · {zone:1455} Ironforge
	["At 20 {npc:6179} in the {object:32362} gives you the {item:6776}; it sends you to {npc:6171} in {zone:1453}'s Cathedral of Light. Take the tram from {zone:1455} to {zone:1453}."] = "20级时，{object:32362}的{npc:6179}会给你{item:6776}；它会让你去找{zone:1453}光明大教堂的{npc:6171}。从{zone:1455}乘地铁前往{zone:1453}。",

	-- Step 2: The Tome of Valor
	-- {npc:6171} Duthorian Rall · {item:6776} Tome of Valor
	["{npc:6171} stands in the Cathedral of Light. Right-click the {item:6776} to start its quest."] = "{npc:6171}站在光明大教堂里。右键点击{item:6776}开始它的任务。",
	-- {item:6776} Tome of Valor
	["from the {item:6776}"] = "来自{item:6776}",

	-- Step 3: Daphne Stilwell
	-- {npc:6182} Daphne Stilwell · {zone:1436} Westfall
	["{npc:6182}'s farmhouse stands on the south-west coast of {zone:1436}. Waves of Defias attack it during her quest: keep her alive, and heal her if she needs it."] = "{npc:6182}的农舍位于{zone:1436}西南海岸。她的任务期间迪菲亚兄弟会会一波波来袭：保护她存活，需要时为她治疗。",
	-- {npc:6182} Daphne Stilwell
	["Protect {npc:6182}"] = "保护{npc:6182}",

	-- Step 5: Jordan Stilwell
	-- {npc:6181} Jordan Stilwell · {zone:1455} Ironforge · {item:6996} Jordan's Weapon Notes
	["{npc:6181} stands outside the gates of {zone:1455}. He gives you {item:6996}, which list the four parts."] = "{npc:6181}站在{zone:1455}大门外。他会给你{item:6996}，上面列出了四个部件。",

	-- Step 6: Bailor Stonehand
	-- {npc:6241} Bailor Stonehand · {area:144} Thelsamar
	["{npc:6241} is in {area:144}."] = "{npc:6241}在{area:144}。",

	-- Step 7: Bailor's Ore
	-- {zone:1432} Loch Modan
	["The ore crate lies by the trees in the middle of the Mo'grosh ogre camp in north-east {zone:1432}. The Mo'grosh ogres are elite: grouping up is advised."] = "矿石箱放在{zone:1432}东北部莫格罗什食人魔营地中央的树旁。莫格罗什食人魔是精英：建议组队。",
	-- {object:92420} Bailor's Ore
	["{object:92420} crate"] = "{object:92420}箱子",

	-- Step 8: Back to Bailor Stonehand
	-- {npc:6241} Bailor Stonehand
	["Back to {npc:6241}"] = "回到{npc:6241}处",
	-- {npc:6241} Bailor Stonehand · {item:6993} Jordan's Refined Ore Shipment
	["{npc:6241} turns the ore into {item:6993}."] = "{npc:6241}会把矿石变成{item:6993}。",

	-- Step 9: Whitestone Oak Lumber
	-- {area:1581} The Deadmines · {area:20} Moonbrook
	-- plural, as words: Goblin Woodcarvers = {npc:641} Goblin Woodcarver
	["{area:1581} is a group of five under {area:20}; the instance portal is inside the {area:20} mine. The Goblin Woodcarvers in the Mast Room, with Sneed, drop the lumber."] = "{area:1581}是{area:20}地下的五人副本；副本传送门在{area:20}的矿洞里。桅杆室里与斯尼德一起的地精木匠掉落木材。",
	-- {area:1581} The Deadmines · {area:20} Moonbrook
	["{area:1581}, in the {area:20} mine"] = "{area:1581}，在{area:20}的矿洞里",
	-- plural, as words: Goblin Woodcarvers = {npc:641} Goblin Woodcarver
	["Goblin Woodcarvers, inside"] = "地精木匠，在副本内",

	-- Step 10: Jordan's Smithing Hammer
	-- {area:236} Shadowfang Keep · {zone:1421} Silverpine Forest
	["{area:236} is a level 20-30 dungeon in southern {zone:1421}. The hammer lies on a box inside the stables, at the far end of the courtyard before the ramp up."] = "{area:236}是{zone:1421}南部的20-30级地下城。铁锤放在马厩里的一个箱子上，在庭院尽头、上坡之前。",
	-- {object:91138} Jordan's Hammer
	["{object:91138}, inside"] = "{object:91138}，在副本内",

	-- Step 11: Thundris Windweaver
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["{npc:3649} is in {area:442}."] = "{npc:3649}在{area:442}。",

	-- Step 12: The Corrupted Kor Gem
	-- {item:6995} Corrupted Kor Gem
	["The {item:6995}"] = "{item:6995}",
	-- {area:2797} Blackfathom Deeps · {zone:1440} Ashenvale · {item:6995} Corrupted Kor Gem
	["The Blackfathom naga by the entrance of {area:2797} on {zone:1440}'s north-west coast drop the {item:6995}. They are elite: grouping up is advised."] = "{zone:1440}西北海岸{area:2797}入口附近的黑暗深渊纳迦掉落{item:6995}。它们是精英：建议组队。",

	-- Step 13: The Purified Kor Gem
	-- {item:7083} Purified Kor Gem
	["The {item:7083}"] = "{item:7083}",
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["Back to {npc:3649} in {area:442}: he purifies the gem."] = "回到{area:442}找{npc:3649}：他会净化宝石。",

	-- Step 14: Verigan's Fist
	-- {npc:6181} Jordan Stilwell · {zone:1455} Ironforge
	["Bring the four parts to {npc:6181} outside {zone:1455}."] = "把四个部件交给{zone:1455}外的{npc:6181}。",
}
