-- Portuguese (Brazil) (ptBR): Polestar Recorder's interface strings.
-- Keys are the English strings exactly as the code writes them; a key
-- missing here, or commented out, shows in English. Grouped by the file that
-- first uses each key. docs/TRANSLATING.md explains the rest.

local _, ns = ...
if not (GetLocale and GetLocale() == "ptBR") then return end
local L = ns.L

-- Commands.lua
L["this client exposes no talent tree API"] = "este cliente não expõe API de árvore de talentos"
L["no active talent configuration (too low level?)"] = "nenhuma configuração de talentos ativa (nível baixo demais?)"
L["the talent configuration has no trees"] = "a configuração de talentos não tem árvores"
L["the talent trees returned no nodes"] = "as árvores de talentos não retornaram nós"
L["recording %s"] = "gravação %s"
L["on"] = "ativada"
L["off"] = "desativada"
L["session %s: %d events (%d breadcrumbs), %d min"] = "sessão %s: %d eventos (%d rastros), %d min"
L["%d events dropped by the per-session caps"] = "%d eventos descartados pelos limites por sessão"
L["no session yet"] = "nenhuma sessão ainda"
L["%d sessions stored, %d maps dumped"] = "%d sessões armazenadas, %d mapas exportados"
L[", talents dumped"] = ", talentos exportados"
L["this session: %s"] = "esta sessão: %s"
L["commands: /psrec on | off | mark <text> | maps | talents | legacy | factions | skills | clear"] = "comandos: /psrec on | off | mark <texto> | maps | talents | legacy | factions | skills | clear"
L["usage: /psrec mark <text>"] = "uso: /psrec mark <texto>"
L["recording is off; /psrec on first"] = "a gravação está desativada; use /psrec on primeiro"
L["marked: %s"] = "marcado: %s"
L["mark not recorded (session cap reached)"] = "marca não gravada (limite da sessão atingido)"
L["recorded %d maps"] = "%d mapas gravados"
L["no maps found (C_Map unavailable)"] = "nenhum mapa encontrado (C_Map indisponível)"
L["talents not recorded: %s"] = "talentos não gravados: %s"
L["recorded %d talent nodes in %d tree(s) for %s"] = "%d nós de talento gravados em %d árvore(s) para %s"
L["recorded %d achievements in %d categories, %d major factions (Legacy renown %s), %d Legacy tree nodes"] = "%d conquistas gravadas em %d categorias, %d facções principais (renome de Legado %s), %d nós da árvore de Legado"
L["factions not recorded: this client exposes no C_Reputation list"] = "facções não gravadas: este cliente não expõe lista C_Reputation"
L["recorded %d factions"] = "%d facções gravadas"
L["skills not recorded: this client exposes no C_SkillInfo list"] = "perícias não gravadas: este cliente não expõe lista C_SkillInfo"
L["recorded %d skill lines"] = "%d linhas de perícia gravadas"
L["all recordings cleared; new session %s"] = "todas as gravações apagadas; nova sessão %s"
L["this deletes every recorded session. Type |cffffd100/psrec clear confirm|r within %d seconds to proceed."] = "isto apaga todas as sessões gravadas. Digite |cffffd100/psrec clear confirm|r em até %d segundos para continuar."
L["unknown command: %s"] = "comando desconhecido: %s"
L["factions"] = "facções"
L["skills"] = "perícias"
L["legacy"] = "legado"
