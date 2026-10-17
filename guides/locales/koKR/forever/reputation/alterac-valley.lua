-- Korean (koKR): the guide forever/reputation/alterac-valley (forever/reputation/alterac-valley.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Alterac Valley Reputation"] = "알터랙 계곡 평판",

	-- Step 1: Stormpike Guard to Friendly
	-- {faction:730} Stormpike Guard
	["{faction:730} to Friendly"] = "{faction:730}: 약간 우호적까지",
	-- {faction:730} Stormpike Guard · {area:2959} Dun Baldar · {zone:1459} Alterac Valley · {quest:7223} Armor Scraps · {npc:13257} Murgot Deepforge
	["The {faction:730} holds {area:2959} in the north of {zone:1459}. Destroying towers, taking graveyards and mines, and killing captains and generals all pay reputation to the whole team. Loot {quest:7223} from fallen enemies for {npc:13257}. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:730}은(는) {zone:1459} 북쪽의 {area:2959}을(를) 지키고 있습니다. 탑 파괴, 무덤과 광산 점령, 대위와 장군 처치는 모두 팀 전체에 평판을 줍니다. 쓰러진 적에게서 {quest:7223}을(를) 획득해 {npc:13257}에게 가져가십시오. Forever의 외교관 유산 특전은 평판 획득량을 늘려 줍니다.",
	-- {npc:12096} Stormpike Quartermaster · {item:17542} Coldtooth Supplies
	["{npc:12096}: Irondeep and {item:17542} from the mines"] = "{npc:12096}: 광산에서 얻은 깊은무쇠 광산 보급품과 {item:17542}",

	-- Step 2: Stormpike Guard to Honored
	-- {faction:730} Stormpike Guard
	["{faction:730} to Honored"] = "{faction:730}: 우호적까지",
	-- {zone:1459} Alterac Valley · {quest:7223} Armor Scraps · {npc:13257} Murgot Deepforge · {npc:13442} Arch Druid Renferal · {npc:13419} Ivus the Forest Lord · {npc:13577} Stormpike Ram Rider Commander
	-- plural, as words: Storm Crystals = {item:17423} Storm Crystal · Frostwolf Hides = {item:17643} Frostwolf Hide
	["Keep winning {zone:1459}. More {quest:7223} ({npc:13257}), Storm Crystals for {npc:13442} (they summon {npc:13419}) and Frostwolf Hides for the {npc:13577} all repeat."] = "{zone:1459}에서 계속 승리하십시오. {quest:7223} 추가 제출({npc:13257}), {npc:13442}에게 폭풍 수정 제출({npc:13419} 소환), {npc:13577}에게 서리늑대 통가죽 제출은 모두 반복할 수 있습니다.",
	-- {npc:13257} Murgot Deepforge · {quest:7223} Armor Scraps
	["{npc:13257}: More {quest:7223}"] = "{npc:13257}: {quest:7223} 추가 제출",
	-- {npc:13442} Arch Druid Renferal
	["{npc:13442}: Crystal Cluster"] = "{npc:13442}: 폭풍 수정 묶음",

	-- Step 3: Stormpike Guard to Revered
	-- {faction:730} Stormpike Guard
	["{faction:730} to Revered"] = "{faction:730}: 매우 우호적까지",
	-- {npc:11946} Drek'Thar
	["Full games that kill {npc:11946} after the towers fall pay the most."] = "탑을 모두 무너뜨린 뒤 {npc:11946}까지 처치하는 완전한 전투가 가장 많은 평판을 줍니다.",

	-- Step 4: Stormpike Guard to Exalted
	-- {faction:730} Stormpike Guard
	["{faction:730} to Exalted"] = "{faction:730}: 확고한 동맹까지",
	-- {faction:730} Stormpike Guard
	["Exalted with the {faction:730} earns a Legacy Point."] = "{faction:730}와(과) 확고한 동맹이 되면 유산 점수 1점을 얻습니다.",

	-- Step 5: Frostwolf Clan to Friendly
	-- {faction:729} Frostwolf Clan
	["{faction:729} to Friendly"] = "{faction:729}: 약간 우호적까지",
	-- {faction:729} Frostwolf Clan · {area:2978} Frostwolf Keep · {zone:1459} Alterac Valley · {item:17422} Armor Scraps · {npc:13176} Smith Regzar
	["The {faction:729} holds {area:2978} in the south of {zone:1459}. Destroying towers, taking graveyards and mines, and killing captains and generals all pay reputation to the whole team. Loot {item:17422} from fallen enemies for {npc:13176}. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:729}은(는) {zone:1459} 남쪽의 {area:2978}을(를) 지키고 있습니다. 탑 파괴, 무덤과 광산 점령, 대위와 장군 처치는 모두 팀 전체에 평판을 줍니다. 쓰러진 적에게서 {item:17422}을(를) 획득해 {npc:13176}에게 가져가십시오. Forever의 외교관 유산 특전은 평판 획득량을 늘려 줍니다.",
	-- {npc:12097} Frostwolf Quartermaster · {item:17522} Irondeep Supplies
	["{npc:12097}: Coldtooth and {item:17522} from the mines"] = "{npc:12097}: 광산에서 얻은 얼음이빨 광산 보급품과 {item:17522}",

	-- Step 6: Frostwolf Clan to Honored
	-- {faction:729} Frostwolf Clan
	["{faction:729} to Honored"] = "{faction:729}: 우호적까지",
	-- {zone:1459} Alterac Valley · {npc:13176} Smith Regzar · {item:17306} Stormpike Soldier's Blood · {npc:13236} Primalist Thurloga · {npc:13256} Lokholar the Ice Lord · {npc:13441} Frostwolf Wolf Rider Commander
	-- plural, as words: Alterac Ram Hides = {item:17642} Alterac Ram Hide
	["Keep winning {zone:1459}. More Booty! ({npc:13176}), {item:17306} for {npc:13236} (it summons {npc:13256}) and Alterac Ram Hides for the {npc:13441} all repeat."] = "{zone:1459}에서 계속 승리하세요. 추가 전리품!({npc:13176}), {npc:13236}에게 주는 {item:17306}({npc:13256} 소환), {npc:13441}에게 주는 {item:17642}은(는) 모두 반복할 수 있습니다.",
	-- {npc:13176} Smith Regzar
	["{npc:13176}: More Booty!"] = "{npc:13176}: 추가 전리품!",
	-- {npc:13236} Primalist Thurloga
	["{npc:13236}: A Gallon of Blood"] = "{npc:13236}: 한 사발의 피",

	-- Step 7: Frostwolf Clan to Revered
	-- {faction:729} Frostwolf Clan
	["{faction:729} to Revered"] = "{faction:729}: 매우 우호적까지",
	-- {npc:11948} Vanndar Stormpike
	["Full games that kill {npc:11948} after the towers fall pay the most."] = "탑을 모두 무너뜨린 뒤 {npc:11948}까지 처치하는 완전한 전투가 가장 많은 평판을 줍니다.",

	-- Step 8: Frostwolf Clan to Exalted
	-- {faction:729} Frostwolf Clan
	["{faction:729} to Exalted"] = "{faction:729}: 확고한 동맹까지",
	-- {faction:729} Frostwolf Clan
	["Exalted with the {faction:729} earns a Legacy Point."] = "{faction:729}와(과) 확고한 동맹이 되면 유산 점수 1점을 얻습니다.",
}
