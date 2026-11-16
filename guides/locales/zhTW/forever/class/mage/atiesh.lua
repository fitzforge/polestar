-- Chinese (traditional) (zhTW): the guide forever/class/mage/atiesh (forever/class/mage/atiesh.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:2279} Stratholme
	["The legendary staff of the Guardian: forty splinters from Naxxramas, two raid bosses and a demon in {area:2279}."] = "守護者的傳說法杖：四十塊納克薩瑪斯碎片、兩個團隊副本首領，以及{area:2279}中的一個惡魔。",

	-- Step 1: Splinters of Atiesh
	["Splinters of Atiesh"] = "埃提耶什的碎片",
	-- {area:2277} Plaguewood · {zone:1423} Eastern Plaguelands · {npc:15990} Kel'Thuzad
	["Forty Splinters of Atiesh drop in Naxxramas, the 40-player raid in the necropolis over the {area:2277} in {zone:1423}: each of its twelve bosses before Sapphiron and {npc:15990}, and the Four Horsemen's chest, drops one about a third of the time, and the raid shares them out. It takes many weeks of clears. Keep every splinter in one stack."] = "納克薩瑪斯是位於{zone:1423}的{area:2277}上空那座浮空墓穴中的40人團隊副本，會掉落四十塊埃提耶什的碎片：薩菲隆和{npc:15990}之前的十二個首領，以及天啟四騎士的箱子，各約三分之一機率掉一塊，由團隊平分。湊齊要花數週的通關。把所有碎片收在同一疊裡。",
	-- {spell:28324} Forming Frame of Atiesh · {quest:9250} Frame of Atiesh
	["{spell:28324}: forty splinters become the {quest:9250}"] = "{spell:28324}：四十塊碎片合成{quest:9250}",

	-- Step 2: Anachronos
	-- {quest:9250} Frame of Atiesh · {npc:15192} Anachronos · {area:2300} Caverns of Time · {zone:1446} Tanaris · {area:976} Gadgetzan
	["Right-click the {quest:9250} to start the quest, then take it to {npc:15192}, the bronze dragon in elf form who stands outside the {area:2300} in eastern {zone:1446}. Fly to {area:976} and ride east."] = "右鍵點選{quest:9250}開始任務，然後把它交給{npc:15192}——這位以精靈形態出現的青銅龍站在{zone:1446}東部{area:2300}外。飛到{area:976}，再向東騎。",

	-- Step 3: The Staff Head and the Base
	["The Staff Head and the Base"] = "杖頭與杖座",
	-- {item:22733} Staff Head of Atiesh · {npc:15990} Kel'Thuzad · {item:22734} Base of Atiesh · {npc:15727} C'Thun · {area:16076} Temple of Ahn'Qiraj · {area:3478} Gates of Ahn'Qiraj · {zone:1451} Silithus
	["Two more raid bosses, a full 40-player raid each, both pieces always drop: the {item:22733} from {npc:15990} on his throne at the top of Naxxramas, the {item:22734} from {npc:15727} at the bottom of the {area:16076}, behind the {area:3478} in southern {zone:1451}. Each boss comes back once a week."] = "還有兩個團隊副本首領，每個都需要一支滿編40人團隊，兩件物品必定掉落：{item:22733}來自納克薩瑪斯頂層王座上的{npc:15990}，{item:22734}來自{zone:1451}南部{area:3478}之後、{area:16076}底部的{npc:15727}。每個首領每週重新出現一次。",
	-- {item:22733} Staff Head of Atiesh · {npc:15990} Kel'Thuzad
	["{item:22733}: {npc:15990}, Naxxramas"] = "{item:22733}：{npc:15990}，納克薩瑪斯",
	-- {item:22734} Base of Atiesh · {npc:15727} C'Thun · {area:16076} Temple of Ahn'Qiraj · {object:176146} Gate of Ahn'Qiraj (no name in this language: may be words)
	["{item:22734}: {npc:15727}, {area:16076}, past the {object:176146}"] = "{item:22734}：{npc:15727}，{area:16076}，穿過{object:176146}",

	-- Step 4: Back to Anachronos
	-- {npc:15192} Anachronos
	["Back to {npc:15192}"] = "回到{npc:15192}",
	-- {npc:16387} Atiesh
	["your class's {npc:16387} quest; he hands you the befouled staff"] = "你職業的{npc:16387}任務；他會把被汙染的法杖交給你",

	-- Step 5: Atiesh, Hand of Sargeras
	-- {npc:16387} Atiesh
	["{npc:16387}, Hand of Sargeras"] = "{npc:16387}，薩格拉斯之手",
	-- {area:2279} Stratholme · {zone:1423} Eastern Plaguelands · {object:175433} Festival Lane · {object:181206} Consecrated Earth · {npc:16387} Atiesh · {spell:17466} Unholy Aura · {spell:28342} Breath of Sargeras
	["Take the befouled staff to {area:2279}, the dungeon at the north end of {zone:1423}, through the main gate. On {object:175433} find the patch of {object:181206} with a small white flame on it, stand on it and use the staff: {npc:16387}, Hand of Sargeras (level 63 boss) steps out. Bring a strong group: his {spell:17466} hurts everyone and cannot be dispelled (shadow resistance helps), his {spell:28342} curse must be removed at once, and a warrior's Disarm makes him drop his sword, which a melee player can pick up and use against him. He stays up to two and a half hours, so you can regroup."] = "帶著被汙染的法杖前往{zone:1423}北端的地城{area:2279}，從正門進入。在{object:175433}上找到那片{object:181206}，上面有一小簇白色火焰，站上去並用法杖：{npc:16387}（薩格拉斯之手，63級首領）就會現身。帶上強力的隊伍：他的{spell:17466}會傷害所有人且無法驅散（暗影抗性有用），他的{spell:28342}詛咒必須立刻解除；戰士的“繳械”能讓他丟掉佩劍，近戰玩家可以撿起來反過來對付他。他會停留長達兩個半小時，所以可以重整隊伍。",
	-- {object:181206} Consecrated Earth · {area:2279} Stratholme
	["the befouled staff, on the {object:181206} inside {area:2279}"] = "被汙染的法杖，在{area:2279}內的{object:181206}上",

	-- Step 6: The Greatstaff
	["The Greatstaff"] = "傳說之杖",
	-- {npc:15192} Anachronos · {area:2300} Caverns of Time
	["Back to {npc:15192} at the {area:2300}."] = "回到{area:2300}的{npc:15192}。",
}
