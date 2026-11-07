-- Korean (koKR): Polestar: Mob Markers' interface strings.
-- Keys are the English strings exactly as the code writes them; a key
-- missing here, or commented out, shows in English. Grouped by the file that
-- first uses each key. docs/TRANSLATING.md explains the rest.

local _, ns = ...
if not (GetLocale and GetLocale() == "koKR") then return end
local L = ns.L

-- MobMarkers.lua
L["Polestar pastels"] = "Polestar 파스텔"
L["Polestar rings"] = "Polestar 고리"
L["Vivid"] = "선명"
L["Muted"] = "차분"
L["Colour-blind safe"] = "색맹 친화"
L["Light & night"] = "빛과 밤"
L["Mob spawns"] = "몹 등장 위치"
L["Mob spawns on the world map"] = "지도에 몹 등장 위치"
L["Every spawn point of the mobs your quests need, one skull colour per quest and a ring per mob."] = "퀘스트에 필요한 몹이 등장하는 모든 위치입니다. 퀘스트마다 해골 색 하나, 몹마다 고리 하나를 씁니다."
L["Legend"] = "범례"
L["Lists the quests and mobs on the shown map. Hover a row to highlight its markers, click it to turn them off or on."] = "표시된 지도의 퀘스트와 몹을 나열합니다. 줄에 마우스를 올리면 해당 표시가 강조되고, 클릭하면 켜거나 끕니다."
L["Mob spawns on the minimap"] = "미니맵에 몹 등장 위치"
L["The same spawn markers on the minimap."] = "같은 등장 위치 표시를 미니맵에도 보여줍니다."
L["Only the current step's mobs"] = "현재 단계의 몹만"
L["Marks only the quests Polestar's current guide step works on, not your whole quest log. With no guide running, the whole log shows."] = "퀘스트 목록 전체가 아니라 Polestar 가이드의 현재 단계가 다루는 퀘스트만 표시합니다. 진행 중인 가이드가 없으면 목록 전체를 보여줍니다."
L["Quest colours"] = "퀘스트 색"
L["The colours quests are given, in quest-log order: the skull's colour. The first quest keeps the skull's own colours."] = "퀘스트 목록 순서대로 퀘스트에 주는 색으로, 해골의 색입니다. 첫 번째 퀘스트는 해골 고유의 색을 유지합니다."
L["Mob colours"] = "몹 색"
L["The colours of the rings that tell a quest's mobs apart. A quest with one mob has no ring."] = "한 퀘스트의 몹들을 구별하는 고리의 색입니다. 몹이 하나뿐인 퀘스트에는 고리가 없습니다."
L["World map marker size"] = "지도 표시 크기"
L["Minimap marker size"] = "미니맵 표시 크기"
L["The medallion is drawn 1.6 times this."] = "메달은 이 크기의 1.6배로 그려집니다."
L["Medallion opacity"] = "메달 불투명도"
L["How solid the medallion under each skull is."] = "각 해골 아래 메달이 얼마나 진한지 정합니다."
L["Skull & ring opacity"] = "해골 및 고리 불투명도"
L["How solid the skull and the mob ring are."] = "해골과 몹 고리가 얼마나 진한지 정합니다."
L["Preview: a full quest log"] = "미리보기: 가득 찬 퀘스트 목록"
L["Marks 20 of your faction's quests for whatever zone the world map shows, instead of your quest log. Off again after a reload; also /pmm preview."] = "퀘스트 목록 대신 지도에 표시된 지역의 소속 진영 퀘스트 20개를 표시합니다. 다시 불러오면 꺼집니다. /pmm preview로도 켤 수 있습니다."
