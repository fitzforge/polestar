-- Chinese (simplified) (zhCN): the guide forever/class/mage/spellfire-robes (forever/class/mage/spellfire-robes.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1458} Undercity · {zone:1421} Silverpine Forest
	["A robe at 15 for Horde mages, from the {zone:1458} and {zone:1421}."] = "部落法师15级的长袍，任务在{zone:1458}和{zone:1421}。",

	-- Step 1: Uthel'nay (Orgrimmar)
	-- {npc:7311} Uthel'nay · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["{npc:7311} is one of {zone:1454}'s mage trainers. Then take the zeppelin to {zone:1420} from the tower outside {zone:1454}'s main gate."] = "{npc:7311}是{zone:1454}的法师训练师之一。然后在{zone:1454}正门外的塔上乘飞艇前往{zone:1420}。",

	-- Step 2: Cain Firesong (Brill)
	-- {npc:2128} Cain Firesong · {area:159} Brill
	["{npc:2128} is the {area:159} mage trainer."] = "{npc:2128}是{area:159}的法师训练师。",

	-- Step 3: Anastasia Hartwell
	-- {npc:4568} Anastasia Hartwell · {object:36082} Magic Quarter · {item:7247} Chest of Containment Coffers · {item:7308} Cantation of Manifestation
	["{npc:4568} stands in the {object:36082}. The {item:7247} and the {item:7308} lie behind her."] = "{npc:4568}站在{object:36082}。{item:7247}和{item:7308}放在她身后。",

	-- Step 4: The alchemist shop
	["The alchemist shop"] = "炼金商店",
	-- {item:7308} Cantation of Manifestation · {npc:6492} Rift Spawn · {item:7247} Chest of Containment Coffers
	["Algernon's alchemist shop is in the Apothecarium. Use the {item:7308} there to make the {npc:6492} visible, subdue one with your spells, then use the {item:7247} to throw down a coffer and capture it."] = "奥格诺恩的炼金商店在幽暗城的炼金区。在那里使用{item:7308}让{npc:6492}现形，用法术制服一只，然后使用{item:7247}扔下一个箱子将其捕获。",

	-- Step 5: Back to Anastasia Hartwell
	-- {npc:4568} Anastasia Hartwell
	["Back to {npc:4568}"] = "回到{npc:4568}处",

	-- Step 6: Linen Cloth
	-- {item:2589} Linen Cloth
	["Humanoids drop {item:2589}; the Undercity Auction House sells it."] = "人型生物会掉落{item:2589}；幽暗城拍卖行也有出售。",

	-- Step 7: Ambermill
	-- {zone:1458} Undercity · {zone:1421} Silverpine Forest · {area:279} Dalaran · {area:233} Ambermill · {area:228} Sepulcher · {npc:1867} Dalaran Apprentice · {item:7293} Dalaran Mana Gem
	["Leave the {zone:1458} and follow the road south through {zone:1421}. The {area:279} mages hold {area:233}, south-east of the {area:228}; every {npc:1867}, Mage, Protector, Warder, Conjuror, Watcher and Wizard can drop a {item:7293}."] = "离开{zone:1458}，沿道路向南穿过{zone:1421}。{area:279}法师占据着{area:228}东南的{area:233}；每个{npc:1867}、达拉然法师、达拉然保卫者、达拉然守卫、达拉然咒术师、达拉然卫士和达拉然巫师都可能掉落{item:7293}。",

	-- Step 8: Josef Gregorian
	-- {zone:1458} Undercity · {npc:4576} Josef Gregorian · {npc:11048} Victor Ward · {npc:11049} Rhiannon Davis
	["Back to the {zone:1458}. {npc:4576}, {npc:11048} and {npc:11049} keep the tailor's shop."] = "回到{zone:1458}。{npc:4576}、{npc:11048}和{npc:11049}经营裁缝店。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Algernon's alchemist shop is in the {object:36072}. Use the {item:7308} there to make the {npc:6492} visible, subdue one with your spells, then use the {item:7247} to throw down a coffer and capture it."] = "奥格诺恩的炼金商店在{object:36072}。在那里使用{item:7308}让{npc:6492}显形，用法术削弱一个，然后使用{item:7247}扔下一个封灵箱捕获它。",
}
