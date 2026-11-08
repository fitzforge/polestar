-- Russian (ruRU): Polestar: Mob Markers' interface strings.
-- Keys are the English strings exactly as the code writes them; a key
-- missing here, or commented out, shows in English. Grouped by the file that
-- first uses each key. docs/TRANSLATING.md explains the rest.

local _, ns = ...
if not (GetLocale and GetLocale() == "ruRU") then return end
local L = ns.L

-- MobMarkers.lua
L["Polestar pastels"] = "Пастель Polestar"
L["Polestar rings"] = "Кольца Polestar"
L["Vivid"] = "Яркие"
L["Muted"] = "Приглушенные"
L["Colour-blind safe"] = "Для дальтоников"
L["Light & night"] = "Свет и ночь"
L["Mob spawns"] = "Места появления мобов"
L["Mob spawns on the world map"] = "Места появления мобов на карте"
L["Every spawn point of the mobs your quests need, one skull colour per quest and a ring per mob."] = "Все места появления мобов, нужных вашим заданиям: свой цвет черепа для каждого задания и кольцо для каждого моба."
L["Legend"] = "Легенда"
L["Lists the quests and mobs on the shown map. Hover a row to highlight its markers, click it to turn them off or on."] = "Список заданий и мобов на открытой карте. Наведите на строку, чтобы подсветить ее метки; щелкните, чтобы выключить или включить их."
L["Mob spawns on the minimap"] = "Места появления мобов на мини-карте"
L["The same spawn markers on the minimap."] = "Те же метки мест появления на мини-карте."
L["Only the current step's mobs"] = "Только мобы текущего шага"
L["Marks only the quests Polestar's current guide step works on, not your whole quest log. With no guide running, the whole log shows."] = "Отмечает только задания текущего шага гайда Polestar, а не весь журнал заданий. Если гайд не запущен, показывается весь журнал."
L["Quest colours"] = "Цвета заданий"
L["The colours quests are given, in quest-log order: the skull's colour. The first quest keeps the skull's own colours."] = "Цвета, которые задания получают в порядке журнала: это цвет черепа. Первое задание сохраняет собственные цвета черепа."
L["Mob colours"] = "Цвета мобов"
L["The colours of the rings that tell a quest's mobs apart. A quest with one mob has no ring."] = "Цвета колец, по которым различаются мобы одного задания. У задания с одним мобом кольца нет."
L["World map marker size"] = "Размер меток на карте"
L["Minimap marker size"] = "Размер меток на мини-карте"
L["The medallion is drawn 1.6 times this."] = "Медальон рисуется в 1,6 раза больше."
L["Medallion opacity"] = "Непрозрачность медальона"
L["How solid the medallion under each skull is."] = "Насколько плотный медальон под каждым черепом."
L["Skull & ring opacity"] = "Непрозрачность черепа и кольца"
L["How solid the skull and the mob ring are."] = "Насколько плотные череп и кольцо моба."
