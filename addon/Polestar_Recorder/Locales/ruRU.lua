-- Russian (ruRU): Polestar Recorder's interface strings.
-- Keys are the English strings exactly as the code writes them; a key
-- missing here, or commented out, shows in English. Grouped by the file that
-- first uses each key. docs/TRANSLATING.md explains the rest.

local _, ns = ...
if not (GetLocale and GetLocale() == "ruRU") then return end
local L = ns.L

-- Commands.lua
L["this client exposes no talent tree API"] = "этот клиент не предоставляет API дерева талантов"
L["no active talent configuration (too low level?)"] = "нет активной конфигурации талантов (слишком низкий уровень?)"
L["the talent configuration has no trees"] = "в конфигурации талантов нет деревьев"
L["the talent trees returned no nodes"] = "деревья талантов не вернули ни одного узла"
L["recording %s"] = "запись %s"
L["on"] = "вкл."
L["off"] = "выкл."
L["session %s: %d events (%d breadcrumbs), %d min"] = "сессия %s: %d событий (%d хлебных крошек), %d мин"
L["%d events dropped by the per-session caps"] = "%d событий отброшено из-за ограничений на сессию"
L["no session yet"] = "сессий пока нет"
L["%d sessions stored, %d maps dumped"] = "сохранено сессий: %d, выгружено карт: %d"
L[", talents dumped"] = ", таланты выгружены"
L["this session: %s"] = "эта сессия: %s"
L["commands: /psrec on | off | mark <text> | maps | talents | legacy | factions | skills | clear"] = "команды: /psrec on | off | mark <текст> | maps | talents | legacy | factions | skills | clear"
L["usage: /psrec mark <text>"] = "использование: /psrec mark <текст>"
L["recording is off; /psrec on first"] = "запись выключена; сначала введите /psrec on"
L["marked: %s"] = "отмечено: %s"
L["mark not recorded (session cap reached)"] = "отметка не записана (достигнут лимит сессии)"
L["recorded %d maps"] = "записано карт: %d"
L["no maps found (C_Map unavailable)"] = "карты не найдены (C_Map недоступен)"
L["talents not recorded: %s"] = "таланты не записаны: %s"
L["recorded %d talent nodes in %d tree(s) for %s"] = "записано узлов талантов: %d в деревьях (%d) для %s"
L["recorded %d achievements in %d categories, %d major factions (Legacy renown %s), %d Legacy tree nodes"] = "записано достижений: %d в категориях (%d), основных фракций: %d (известность Legacy %s), узлов дерева Legacy: %d"
L["factions not recorded: this client exposes no C_Reputation list"] = "фракции не записаны: этот клиент не предоставляет список C_Reputation"
L["recorded %d factions"] = "записано фракций: %d"
L["skills not recorded: this client exposes no C_SkillInfo list"] = "навыки не записаны: этот клиент не предоставляет список C_SkillInfo"
L["recorded %d skill lines"] = "записано линеек навыков: %d"
L["all recordings cleared; new session %s"] = "все записи удалены; новая сессия %s"
L["this deletes every recorded session. Type |cffffd100/psrec clear confirm|r within %d seconds to proceed."] = "это удалит все записанные сессии. Введите |cffffd100/psrec clear confirm|r в течение %d с, чтобы продолжить."
L["unknown command: %s"] = "неизвестная команда: %s"
L["factions"] = "фракции"
L["skills"] = "навыки"
L["legacy"] = "Legacy"
