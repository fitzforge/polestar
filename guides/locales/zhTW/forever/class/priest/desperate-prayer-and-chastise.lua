-- Chinese (traditional) (zhTW): the guide forever/class/priest/desperate-prayer-and-chastise (forever/class/priest/desperate-prayer-and-chastise.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:5634} Desperate Prayer · {quest:5641} Chastise
	["{quest:5634} and {quest:5641}"] = "{quest:5634}與{quest:5641}",
	-- {quest:5634} Desperate Prayer · {quest:5641} Chastise
	["The Human and Dwarf priest spells: {quest:5634} at 10, {quest:5641} for Dwarves at 20."] = "人類和矮人的牧師法術：10級的{quest:5634}，以及矮人20級的{quest:5641}。",

	-- Step 1: Desperate Prayer
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries · {zone:1455} Ironforge · {object:32362} Mystic Ward · {npc:376} High Priestess Laurena · {zone:1453} Stormwind · {area:2257} Deeprun Tram
	["At 10, go to {npc:11406} in the {object:32386}, in {zone:1455}'s {object:32362}. Forever's quest text names Rohan, but the quest data has {npc:376} in {zone:1453}'s Cathedral of Light take it: try Rohan first, then Laurena (the {area:2257} links the cities)."] = "10級時，到{zone:1455}{object:32362}的{object:32386}找{npc:11406}。Forever 的任務文字寫的是洛漢，但任務資料顯示由{zone:1453}光明大教堂的{npc:376}接收：先試洛漢，再試勞瑞娜（{area:2257}連接兩座城市）。",

	-- Step 2: High Priestess Laurena
	-- {npc:376} High Priestess Laurena · {area:2257} Deeprun Tram · {object:171524} Tinker Town
	["If Rohan did not take it: {npc:376} is in the Cathedral of Light. Take the {area:2257} from {object:171524}."] = "如果洛漢沒有接收：{npc:376}在光明大教堂。從{object:171524}搭乘{area:2257}。",

	-- Step 3: Chastise
	-- {npc:11406} High Priest Rohan · {quest:5641} Chastise · {npc:376} High Priestess Laurena · {zone:1453} Stormwind · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["At 20, {npc:11406} teaches {quest:5641}. {npc:376} in {zone:1453} and {npc:11401} in {zone:1457} send you to him with a quest of the same name."] = "20級時，{npc:11406}會教你{quest:5641}。{zone:1453}的{npc:376}和{zone:1457}的{npc:11401}會用同名任務派你去找他。",
}
