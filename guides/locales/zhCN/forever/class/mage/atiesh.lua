-- Chinese (simplified) (zhCN): the guide forever/class/mage/atiesh (forever/class/mage/atiesh.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:2279} Stratholme
	["The legendary staff of the Guardian: forty splinters from Naxxramas, two raid bosses and a demon in {area:2279}."] = "守护者的传说法杖：来自纳克萨玛斯的四十块碎片、两个团队首领，以及{area:2279}中的一个恶魔。",

	-- Step 1: Splinters of Atiesh
	["Splinters of Atiesh"] = "埃提耶什的碎片",
	-- {area:2277} Plaguewood · {zone:1423} Eastern Plaguelands · {npc:15990} Kel'Thuzad
	["Forty Splinters of Atiesh drop in Naxxramas, the 40-player raid in the necropolis over the {area:2277} in {zone:1423}: each of its twelve bosses before Sapphiron and {npc:15990}, and the Four Horsemen's chest, drops one about a third of the time, and the raid shares them out. It takes many weeks of clears. Keep every splinter in one stack."] = "需要在纳克萨玛斯收集四十块埃提耶什的碎片。这座 40 人团队副本位于{zone:1423}的{area:2277}上空。萨菲隆和{npc:15990}之前的十二名首领，以及天启四骑士的箱子，各有约三分之一几率掉落一块，由团队分配。通常需要连续多周通关。将所有碎片放在同一叠中。",
	-- {spell:28324} Forming Frame of Atiesh · {quest:9250} Frame of Atiesh
	["{spell:28324}: forty splinters become the {quest:9250}"] = "{spell:28324}：将四十块碎片合成{quest:9250}",

	-- Step 2: Anachronos
	-- {quest:9250} Frame of Atiesh · {npc:15192} Anachronos · {area:2300} Caverns of Time · {zone:1446} Tanaris · {area:976} Gadgetzan
	["Right-click the {quest:9250} to start the quest, then take it to {npc:15192}, the bronze dragon in elf form who stands outside the {area:2300} in eastern {zone:1446}. Fly to {area:976} and ride east."] = "右键点击{quest:9250}开始任务，再将它带给{zone:1446}东部{area:2300}外的{npc:15192}；他是以精灵形态出现的青铜龙。飞往{area:976}，再向东骑行。",

	-- Step 3: The Staff Head and the Base
	["The Staff Head and the Base"] = "杖头与杖柄末端",
	-- {item:22733} Staff Head of Atiesh · {npc:15990} Kel'Thuzad · {item:22734} Base of Atiesh · {npc:15727} C'Thun · {area:16076} Temple of Ahn'Qiraj · {area:3478} Gates of Ahn'Qiraj · {zone:1451} Silithus
	["Two more raid bosses, a full 40-player raid each, both pieces always drop: the {item:22733} from {npc:15990} on his throne at the top of Naxxramas, the {item:22734} from {npc:15727} at the bottom of the {area:16076}, behind the {area:3478} in southern {zone:1451}. Each boss comes back once a week."] = "还需击败两名团队首领，均需要完整的 40 人团队，两件任务物品必定掉落。{item:22733}来自纳克萨玛斯顶层王座上的{npc:15990}，{item:22734}来自{zone:1451}南部{area:3478}后方、{area:16076}底层的{npc:15727}。两名首领均每周刷新。",
	-- {item:22733} Staff Head of Atiesh · {npc:15990} Kel'Thuzad
	["{item:22733}: {npc:15990}, Naxxramas"] = "{item:22733}：纳克萨玛斯的{npc:15990}",
	-- {item:22734} Base of Atiesh · {npc:15727} C'Thun · {area:16076} Temple of Ahn'Qiraj · {object:176146} Gate of Ahn'Qiraj (no name in this language: may be words)
	["{item:22734}: {npc:15727}, {area:16076}, past the {object:176146}"] = "{item:22734}：越过{object:176146}，前往{area:16076}的{npc:15727}",

	-- Step 4: Back to Anachronos
	-- {npc:15192} Anachronos
	["Back to {npc:15192}"] = "返回{npc:15192}",
	-- {npc:16387} Atiesh
	["your class's {npc:16387} quest; he hands you the befouled staff"] = "接取本职业的{npc:16387}任务，他会交给你被玷污的法杖",

	-- Step 5: Atiesh, Hand of Sargeras
	-- {npc:16387} Atiesh
	["{npc:16387}, Hand of Sargeras"] = "{npc:16387}，萨格拉斯之手",
	-- {area:2279} Stratholme · {zone:1423} Eastern Plaguelands · {object:175433} Festival Lane (no name in this language: may be words) · {object:181206} Consecrated Earth (no name in this language: may be words) · {npc:16387} Atiesh · {spell:17466} Unholy Aura · {spell:28342} Breath of Sargeras
	["Take the befouled staff to {area:2279}, the dungeon at the north end of {zone:1423}, through the main gate. On {object:175433} find the patch of {object:181206} with a small white flame on it, stand on it and use the staff: {npc:16387}, Hand of Sargeras (level 63 boss) steps out. Bring a strong group: his {spell:17466} hurts everyone and cannot be dispelled (shadow resistance helps), his {spell:28342} curse must be removed at once, and a warrior's Disarm makes him drop his sword, which a melee player can pick up and use against him. He stays up to two and a half hours, so you can regroup."] = "将被玷污的法杖带到{zone:1423}北端的副本{area:2279}，从正门进入。在{object:175433}找到一块冒着白色小火苗的{object:181206}，站上去使用法杖，63 级首领萨格拉斯之手{npc:16387}就会出现。请组建实力足够的小队：它的{spell:17466}会伤害所有人且无法驱散，暗影抗性有帮助；{spell:28342}诅咒必须立即解除。战士缴械会使它掉落武器，近战玩家可拾取并用于攻击它。首领最多停留两个半小时，有时间重新组织队伍。",
	-- {object:181206} Consecrated Earth (no name in this language: may be words) · {area:2279} Stratholme
	["the befouled staff, on the {object:181206} inside {area:2279}"] = "在{area:2279}内的{object:181206}处使用被玷污的法杖",

	-- Step 6: The Greatstaff
	["The Greatstaff"] = "守护者的传说之杖",
	-- {npc:15192} Anachronos · {area:2300} Caverns of Time
	["Back to {npc:15192} at the {area:2300}."] = "返回{area:2300}的{npc:15192}处。",
}
