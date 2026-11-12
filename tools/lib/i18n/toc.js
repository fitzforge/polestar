'use strict';
// The game's AddOns list shows each addon's `## Title` and `## Notes`, and in
// a client language the `## Title-<locale>` and `## Notes-<locale>` beside
// them. These are the translations of every Polestar addon's, written once
// here (AI translations, glossary: data/i18n/glossary; Polestar, Codex
// and the names of people and projects are kept as they are).
//
//   tocLines(addon) -> ['## Title-deDE: ...', '## Notes-deDE: ...', ...]
//     for every locale (LOCALE_CODES order). addon: the folder name;
//     the language folders Polestar_<locale> name their own language.
//   languageAddon(locale) -> 'Polestar_<locale>': our guides' texts
//     (Texts.lua) and the game's names (Names.lua) in that language, one
//     load-on-demand folder (rust/crates/forge-guide/src/toc.rs is the twin)
//   languageToc(locale, iface, version) -> its TOC, written alike by
//     `forge guide compile` and `forge data names`
//   retiredLanguageAddons(locale) -> the two folders it replaced (0.3.0)
// The TOCs in the repository carry these lines as they are; the generated
// ones (Codex, QuestDB, ItemDB, Guides, the language folders) get them from their
// builders. tests/i18n-toc.test.js checks every TOC under addon/.

const { LOCALES, LOCALE_CODES } = require('./locales');
const { GENERATED_MARKER } = require('../pack/format');

const TEXT = {
	Polestar: {
		title: { deDE: 'Polestar', esES: 'Polestar', esMX: 'Polestar', frFR: 'Polestar', koKR: 'Polestar', ptBR: 'Polestar', ruRU: 'Polestar', zhCN: 'Polestar', zhTW: 'Polestar' },
		notes: {
			deDE: 'Leveling-Guides für World of Warcraft: Forever.',
			esES: 'Guías para subir de nivel en World of Warcraft: Forever.',
			esMX: 'Guías para subir de nivel en World of Warcraft: Forever.',
			frFR: 'Guides de montée en niveau pour World of Warcraft: Forever.',
			koKR: 'World of Warcraft: Forever 레벨업 가이드.',
			ptBR: 'Guias de evolução para World of Warcraft: Forever.',
			ruRU: 'Гайды по прокачке для World of Warcraft: Forever.',
			zhCN: '魔兽世界：Forever 练级指南。',
			zhTW: 'World of Warcraft: Forever 的升級指南。',
		},
	},
	Polestar_Codex: {
		title: { deDE: 'Polestar Codex', esES: 'Polestar Codex', esMX: 'Polestar Codex', frFR: 'Polestar Codex', koKR: 'Polestar Codex', ptBR: 'Polestar Codex', ruRU: 'Polestar Codex', zhCN: 'Polestar Codex', zhTW: 'Polestar Codex' },
		notes: {
			deDE: 'Teil von Polestar: Gegenstände, Reittiere, Haustiere, NPCs, Quests und wo man sie bekommt, Dungeons und Rares, für Nachschlagen, Dungeons und Rares. Wird bei Bedarf geladen.',
			esES: 'Parte de Polestar: objetos, monturas, mascotas, PNJ, misiones y dónde conseguirlos, mazmorras y raros, para Buscador, Mazmorras y Raros. Se carga bajo demanda.',
			esMX: 'Parte de Polestar: objetos, monturas, mascotas, PNJ, misiones y dónde conseguirlos, calabozos y raros, para Buscador, Calabozos y Raros. Se carga bajo demanda.',
			frFR: 'Fait partie de Polestar : objets, montures, mascottes, PNJ, quêtes et où les obtenir, donjons et rares, pour Recherche, Donjons et Rares. Chargé à la demande.',
			koKR: 'Polestar의 일부: 아이템, 탈것, 애완동물, NPC, 퀘스트와 얻는 곳, 던전과 희귀 몬스터. 찾아보기, 던전, 희귀에서 씁니다. 필요할 때 불러옵니다.',
			ptBR: 'Parte do Polestar: itens, montarias, mascotes, PNJs, missões e onde obtê-los, masmorras e raros, para Consulta, Masmorras e Raros. Carregado sob demanda.',
			ruRU: 'Часть Polestar: предметы, транспорт, питомцы, NPC, задания и где их получить, подземелья и редкие существа для разделов «Поиск», «Подземелья» и «Редкие». Загружается по требованию.',
			zhCN: 'Polestar 的组成部分：物品、坐骑、宠物、NPC、任务及其获取途径、地下城和稀有怪物，供查询、地下城和稀有页面使用。按需加载。',
			zhTW: 'Polestar 的一部分：物品、坐騎、寵物、NPC、任務及其取得方式、地城與稀有怪物，供查詢、地城與稀有頁面使用。按需載入。',
		},
	},
	Polestar_Experimental: {
		title: { deDE: 'Polestar: experimentelle Guides', esES: 'Polestar: guías experimentales', esMX: 'Polestar: guías experimentales', frFR: 'Polestar : guides expérimentaux', koKR: 'Polestar 실험 가이드', ptBR: 'Polestar: guias experimentais', ruRU: 'Polestar: экспериментальные гайды', zhCN: 'Polestar 实验指南', zhTW: 'Polestar 實驗指南' },
		notes: {
			deDE: 'Teil von Polestar: experimentelle Guides für die neuen Zonen von Forever (Alpha). Aus, bis du es unter Optionen, Community-Guides einschaltest.',
			esES: 'Parte de Polestar: guías experimentales para las nuevas zonas de Forever (alfa). Desactivado hasta que lo actives en Opciones, Guías de la comunidad.',
			esMX: 'Parte de Polestar: guías experimentales para las nuevas zonas de Forever (alfa). Desactivado hasta que lo actives en Opciones, Guías de la comunidad.',
			frFR: 'Fait partie de Polestar : guides expérimentaux pour les nouvelles zones de Forever (alpha). Désactivé tant que vous ne l\'activez pas dans Options, Guides de la communauté.',
			koKR: 'Polestar의 일부: Forever 신규 지역용 실험 가이드(알파). 설정 > 커뮤니티 가이드에서 켜기 전까지는 꺼져 있습니다.',
			ptBR: 'Parte do Polestar: guias experimentais para as novas zonas do Forever (alfa). Desligado até você ligá-lo em Opções, Guias da comunidade.',
			ruRU: 'Часть Polestar: экспериментальные гайды для новых зон Forever (альфа). Выключено, пока вы не включите его в разделе «Настройки», «Гайды сообщества».',
			zhCN: 'Polestar 的组成部分：Forever 新区域的实验性指南（Alpha 版）。在“选项”>“社区指南”中开启前保持关闭。',
			zhTW: 'Polestar 的一部分：Forever 新區域的實驗性指南（Alpha 版）。在「選項」>「社群指南」中開啟前保持關閉。',
		},
	},
	Polestar_Guides: {
		title: { deDE: 'Polestar Guides', esES: 'Polestar: guías', esMX: 'Polestar: guías', frFR: 'Polestar : guides', koKR: 'Polestar 가이드', ptBR: 'Polestar: guias', ruRU: 'Polestar: гайды', zhCN: 'Polestar 指南', zhTW: 'Polestar 指南' },
		notes: {
			deDE: 'Leveling-, Berufs-, Ruf- und Sammel-Guides für Polestar.',
			esES: 'Guías de subida de nivel, profesiones, reputación y coleccionables para Polestar.',
			esMX: 'Guías de subida de nivel, profesiones, reputación y coleccionables para Polestar.',
			frFR: 'Guides de montée en niveau, de métiers, de réputation et de collection pour Polestar.',
			koKR: 'Polestar용 레벨업, 전문 기술, 평판, 수집품 가이드.',
			ptBR: 'Guias de evolução, profissões, reputação e colecionáveis para o Polestar.',
			ruRU: 'Гайды по прокачке, профессиям, репутации и коллекциям для Polestar.',
			zhCN: 'Polestar 的练级、专业、声望和收藏指南。',
			zhTW: 'Polestar 的升級、專業、聲望與收藏指南。',
		},
	},
	Polestar_Guides_Alliance: {
		title: { deDE: 'Polestar Guides (Allianz)', esES: 'Polestar: guías (Alianza)', esMX: 'Polestar: guías (Alianza)', frFR: 'Polestar : guides (Alliance)', koKR: 'Polestar 가이드 (얼라이언스)', ptBR: 'Polestar: guias (Aliança)', ruRU: 'Polestar: гайды (Альянс)', zhCN: 'Polestar 指南（联盟）', zhTW: 'Polestar 指南（聯盟）' },
		notes: {
			deDE: 'Guides von Polestar für Charaktere der Allianz. Wird bei Bedarf geladen.',
			esES: 'Guías de Polestar para personajes de la Alianza. Se carga bajo demanda.',
			esMX: 'Guías de Polestar para personajes de la Alianza. Se carga bajo demanda.',
			frFR: 'Guides de Polestar pour les personnages de l\'Alliance. Chargé à la demande.',
			koKR: '얼라이언스 캐릭터를 위한 Polestar 가이드. 필요할 때 불러옵니다.',
			ptBR: 'Guias do Polestar para personagens da Aliança. Carregado sob demanda.',
			ruRU: 'Гайды Polestar для персонажей Альянса. Загружается по требованию.',
			zhCN: 'Polestar 的联盟角色指南。按需加载。',
			zhTW: 'Polestar 的聯盟角色指南。按需載入。',
		},
	},
	Polestar_Guides_Horde: {
		title: { deDE: 'Polestar Guides (Horde)', esES: 'Polestar: guías (Horda)', esMX: 'Polestar: guías (Horda)', frFR: 'Polestar : guides (Horde)', koKR: 'Polestar 가이드 (호드)', ptBR: 'Polestar: guias (Horda)', ruRU: 'Polestar: гайды (Орда)', zhCN: 'Polestar 指南（部落）', zhTW: 'Polestar 指南（部落）' },
		notes: {
			deDE: 'Guides von Polestar für Charaktere der Horde. Wird bei Bedarf geladen.',
			esES: 'Guías de Polestar para personajes de la Horda. Se carga bajo demanda.',
			esMX: 'Guías de Polestar para personajes de la Horda. Se carga bajo demanda.',
			frFR: 'Guides de Polestar pour les personnages de la Horde. Chargé à la demande.',
			koKR: '호드 캐릭터를 위한 Polestar 가이드. 필요할 때 불러옵니다.',
			ptBR: 'Guias do Polestar para personagens da Horda. Carregado sob demanda.',
			ruRU: 'Гайды Polestar для персонажей Орды. Загружается по требованию.',
			zhCN: 'Polestar 的部落角色指南。按需加载。',
			zhTW: 'Polestar 的部落角色指南。按需載入。',
		},
	},
	Polestar_ItemDB: {
		title: { deDE: 'Polestar Gegenstandsdaten', esES: 'Polestar: datos de objetos', esMX: 'Polestar: datos de objetos', frFR: 'Polestar : données d\'objets', koKR: 'Polestar 아이템 데이터', ptBR: 'Polestar: dados de itens', ruRU: 'Polestar: данные предметов', zhCN: 'Polestar 物品数据', zhTW: 'Polestar 物品資料' },
		notes: {
			deDE: 'Gegenstandswerte für Polestars Ausrüstungsratschläge. Wird bei Bedarf geladen.',
			esES: 'Estadísticas de objetos para los consejos de equipo de Polestar. Se carga bajo demanda.',
			esMX: 'Estadísticas de objetos para los consejos de equipo de Polestar. Se carga bajo demanda.',
			frFR: 'Caractéristiques des objets pour les conseils d\'équipement de Polestar. Chargé à la demande.',
			koKR: 'Polestar 장비 조언에 쓰는 아이템 능력치. 필요할 때 불러옵니다.',
			ptBR: 'Atributos de itens para as dicas de equipamento do Polestar. Carregado sob demanda.',
			ruRU: 'Характеристики предметов для советов Polestar по снаряжению. Загружается по требованию.',
			zhCN: 'Polestar 装备建议所用的物品属性。按需加载。',
			zhTW: 'Polestar 裝備建議所用的物品屬性。按需載入。',
		},
	},
	Polestar_Nav: {
		title: { deDE: 'Polestar Navigation', esES: 'Polestar: navegación', esMX: 'Polestar: navegación', frFR: 'Polestar : navigation', koKR: 'Polestar 길찾기', ptBR: 'Polestar: navegação', ruRU: 'Polestar: навигация', zhCN: 'Polestar 导航', zhTW: 'Polestar 導航' },
		notes: {
			deDE: 'Teil von Polestar: Laufwege für den Pfeil, mit Polestars eigener Wegfindung, entstanden aus der Wegfindung von Shortest Path Forever (Cillian Berragan, github.com/cjber/shortest-path-forever, mit seiner Erlaubnis verwendet). Wird bei Bedarf geladen.',
			esES: 'Parte de Polestar: rutas a pie para la flecha, con el cálculo de rutas propio de Polestar, que partió del de Shortest Path Forever (Cillian Berragan, github.com/cjber/shortest-path-forever, usado con su permiso). Se carga bajo demanda.',
			esMX: 'Parte de Polestar: rutas a pie para la flecha, con el cálculo de rutas propio de Polestar, que partió del de Shortest Path Forever (Cillian Berragan, github.com/cjber/shortest-path-forever, usado con su permiso). Se carga bajo demanda.',
			frFR: 'Fait partie de Polestar : itinéraires à pied pour la flèche, calculés par le routeur de Polestar, issu de celui de Shortest Path Forever (Cillian Berragan, github.com/cjber/shortest-path-forever, utilisé avec sa permission). Chargé à la demande.',
			koKR: 'Polestar의 일부: 화살표용 도보 경로. Shortest Path Forever의 길찾기(Cillian Berragan, github.com/cjber/shortest-path-forever, 허락을 받아 사용)에서 출발한 Polestar 자체 길찾기를 씁니다. 필요할 때 불러옵니다.',
			ptBR: 'Parte do Polestar: rotas a pé para a seta, com o cálculo de rotas próprio do Polestar, que partiu do Shortest Path Forever (Cillian Berragan, github.com/cjber/shortest-path-forever, usado com permissão dele). Carregado sob demanda.',
			ruRU: 'Часть Polestar: пешие маршруты для стрелки, построенные собственным алгоритмом Polestar, выросшим из алгоритма Shortest Path Forever (Cillian Berragan, github.com/cjber/shortest-path-forever, используется с его разрешения). Загружается по требованию.',
			zhCN: 'Polestar 的组成部分：为箭头提供步行路线，采用 Polestar 自己的寻路，源自 Shortest Path Forever 的寻路（Cillian Berragan，github.com/cjber/shortest-path-forever，经其许可使用）。按需加载。',
			zhTW: 'Polestar 的一部分：為箭頭提供步行路線，採用 Polestar 自己的尋路，源自 Shortest Path Forever 的尋路（Cillian Berragan，github.com/cjber/shortest-path-forever，經其許可使用）。按需載入。',
		},
	},
	Polestar_Options: {
		title: { deDE: 'Polestar-Einstellungen', esES: 'Polestar: configuración', esMX: 'Polestar: configuración', frFR: 'Polestar : réglages', koKR: 'Polestar 설정', ptBR: 'Polestar: opções', ruRU: 'Polestar: настройки', zhCN: 'Polestar 设置', zhTW: 'Polestar 設定' },
		notes: {
			deDE: 'Teil von Polestar: das Einstellungsfenster, seine Darstellungsseiten und ihre Vorschauen. Wird geladen, wenn du die Einstellungen öffnest.',
			esES: 'Parte de Polestar: la ventana de configuración, sus páginas de aspecto y sus vistas previas. Se carga al abrir la configuración.',
			esMX: 'Parte de Polestar: la ventana de configuración, sus páginas de aspecto y sus vistas previas. Se carga al abrir la configuración.',
			frFR: 'Fait partie de Polestar : la fenêtre des réglages, ses pages d\'apparence et leurs aperçus. Chargé à l\'ouverture des réglages.',
			koKR: 'Polestar의 일부: 설정 창과 모양 페이지, 그 미리 보기. 설정을 열 때 불러옵니다.',
			ptBR: 'Parte do Polestar: a janela de opções, suas páginas de aparência e as prévias delas. Carregado ao abrir as opções.',
			ruRU: 'Часть Polestar: окно настроек, его страницы оформления и их предпросмотр. Загружается при открытии настроек.',
			zhCN: 'Polestar 的组成部分：设置窗口、外观页面及其预览。打开设置时加载。',
			zhTW: 'Polestar 的一部分：設定視窗、外觀頁面及其預覽。開啟設定時載入。',
		},
	},
	Polestar_QuestDB: {
		title: { deDE: 'Polestar Quest-Datenbank', esES: 'Polestar: base de datos de misiones', esMX: 'Polestar: base de datos de misiones', frFR: 'Polestar : base de données des quêtes', koKR: 'Polestar 퀘스트 데이터베이스', ptBR: 'Polestar: banco de dados de missões', ruRU: 'Polestar: база заданий', zhCN: 'Polestar 任务数据库', zhTW: 'Polestar 任務資料庫' },
		notes: {
			deDE: 'Quest-, NPC-, Objekt- und Gegenstandsdaten für Polestars Questmarkierungen und Tooltips. Wird bei Bedarf geladen.',
			esES: 'Datos de misiones, PNJ y objetos para los marcadores de misión y las descripciones emergentes de Polestar. Se carga bajo demanda.',
			esMX: 'Datos de misiones, PNJ y objetos para los marcadores de misión y las descripciones emergentes de Polestar. Se carga bajo demanda.',
			frFR: 'Données des quêtes, PNJ et objets pour les marqueurs de quête et les infobulles de Polestar. Chargé à la demande.',
			koKR: 'Polestar 퀘스트 표시와 툴팁에 쓰는 퀘스트, NPC, 물체, 아이템 데이터. 필요할 때 불러옵니다.',
			ptBR: 'Dados de missões, PNJs, objetos e itens para os marcadores de missão e as dicas do Polestar. Carregado sob demanda.',
			ruRU: 'Данные заданий, NPC, объектов и предметов для меток заданий и подсказок Polestar. Загружается по требованию.',
			zhCN: 'Polestar 任务标记和鼠标提示所用的任务、NPC、物体和物品数据。按需加载。',
			zhTW: 'Polestar 任務標記與滑鼠提示所用的任務、NPC、物件與物品資料。按需載入。',
		},
	},
	Polestar_Recorder: {
		title: { deDE: 'Polestar Recorder', esES: 'Polestar Recorder', esMX: 'Polestar Recorder', frFR: 'Polestar : enregistreur', koKR: 'Polestar 기록기', ptBR: 'Polestar: gravador', ruRU: 'Polestar: запись', zhCN: 'Polestar 记录器', zhTW: 'Polestar 記錄器' },
		notes: {
			deDE: 'Zeichnet beim Spielen Quests, Wege und Weltdaten auf, um Polestar-Guides zu schreiben. /psrec',
			esES: 'Graba misiones, rutas y datos del mundo mientras juegas, para crear guías de Polestar. /psrec',
			esMX: 'Graba misiones, rutas y datos del mundo mientras juegas, para crear guías de Polestar. /psrec',
			frFR: 'Enregistre les quêtes, les trajets et les données du monde pendant que vous jouez, pour écrire des guides Polestar. /psrec',
			koKR: '플레이하는 동안 퀘스트, 경로, 월드 데이터를 기록해 Polestar 가이드 작성에 씁니다. /psrec',
			ptBR: 'Grava missões, rotas e dados do mundo enquanto você joga, para criar guias do Polestar. /psrec',
			ruRU: 'Записывает задания, маршруты и данные мира во время игры, для создания гайдов Polestar. /psrec',
			zhCN: '在游戏时记录任务、路线和世界数据，用于编写 Polestar 指南。/psrec',
			zhTW: '在遊戲時記錄任務、路線與世界資料，用於撰寫 Polestar 指南。/psrec',
		},
	},
	// The Skin API's checks for another addon's skin or scheme: loaded with the first one registered.
	Polestar_SkinAPI: {
		title: { deDE: 'Polestar: Design-Schnittstelle', esES: 'Polestar: API de temas', esMX: 'Polestar: API de temas', frFR: 'Polestar : API des habillages', koKR: 'Polestar 스킨 API', ptBR: 'Polestar: API de temas', ruRU: 'Polestar: API оформлений', zhCN: 'Polestar 皮肤接口', zhTW: 'Polestar 皮膚介面' },
		notes: {
			deDE: 'Teil von Polestar: die Prüfungen, die ein Design aus einem anderen Addon durchläuft. Wird geladen, wenn du eines verwendest.',
			esES: 'Parte de Polestar: las comprobaciones por las que pasa un tema de otro addon. Se carga cuando usas uno.',
			esMX: 'Parte de Polestar: las comprobaciones por las que pasa un tema de otro addon. Se carga cuando usas uno.',
			frFR: "Fait partie de Polestar : les vérifications que passe un habillage venu d'un autre addon. Chargé quand vous en utilisez un.",
			koKR: 'Polestar의 일부: 다른 애드온의 스킨이 거치는 검사. 스킨을 사용할 때 불러옵니다.',
			ptBR: 'Parte do Polestar: as verificações pelas quais passa um tema de outro addon. Carregado quando você usa um.',
			ruRU: 'Часть Polestar: проверки, которые проходит оформление из другого аддона. Загружается, когда вы его используете.',
			zhCN: 'Polestar 的组成部分：其他插件提供的皮肤需通过的检查。使用皮肤时加载。',
			zhTW: 'Polestar 的一部分：其他插件提供的皮膚需通過的檢查。使用皮膚時載入。',
		},
	},
	// The game looks (WoW Forever, Blizzard, Classic) and Hearth: loaded the first time one is painted.
	Polestar_Looks: {
		title: { deDE: 'Polestar: Designs', esES: 'Polestar: temas', esMX: 'Polestar: temas', frFR: 'Polestar : habillages', koKR: 'Polestar 스킨', ptBR: 'Polestar: temas', ruRU: 'Polestar: оформления', zhCN: 'Polestar 皮肤', zhTW: 'Polestar 皮膚' },
		notes: {
			deDE: 'Teil von Polestar: die Designs WoW Forever, Blizzard, Classic und Hearth. Wird geladen, wenn du eines auswählst.',
			esES: 'Parte de Polestar: los temas WoW Forever, Blizzard, Classic y Hearth. Se carga cuando eliges uno.',
			esMX: 'Parte de Polestar: los temas WoW Forever, Blizzard, Classic y Hearth. Se carga cuando eliges uno.',
			frFR: 'Fait partie de Polestar : les habillages WoW Forever, Blizzard, Classic et Hearth. Chargé quand vous en choisissez un.',
			koKR: 'Polestar의 일부: WoW Forever, Blizzard, Classic, Hearth 스킨. 하나를 고를 때 불러옵니다.',
			ptBR: 'Parte do Polestar: os temas WoW Forever, Blizzard, Classic e Hearth. Carregado quando você escolhe um.',
			ruRU: 'Часть Polestar: оформления WoW Forever, Blizzard, Classic и Hearth. Загружается, когда вы выбираете одно из них.',
			zhCN: 'Polestar 的组成部分：WoW Forever、Blizzard、Classic 和 Hearth 皮肤。选择其中一个时加载。',
			zhTW: 'Polestar 的一部分：WoW Forever、Blizzard、Classic 和 Hearth 皮膚。選擇其中一個時載入。',
		},
	},
	// The Skin API's example (docs/SKINS-API.md): in the repository only, never in a release.
	Polestar_Skin_Example: {
		title: { deDE: 'Polestar: Design-Beispiel', esES: 'Polestar: tema de ejemplo', esMX: 'Polestar: tema de ejemplo', frFR: "Polestar : habillage d'exemple", koKR: 'Polestar 스킨 예제', ptBR: 'Polestar: tema de exemplo', ruRU: 'Polestar: пример оформления', zhCN: 'Polestar 皮肤示例', zhTW: 'Polestar 皮膚範例' },
		notes: {
			deDE: 'Ein Beispiel-Design für Polestar (Moonlit) für Design-Autoren. Nicht Teil von Polestars Veröffentlichung.',
			esES: 'Un tema de ejemplo para Polestar (Moonlit), para autores de temas. No forma parte de la versión de Polestar.',
			esMX: 'Un tema de ejemplo para Polestar (Moonlit), para autores de temas. No forma parte de la versión de Polestar.',
			frFR: "Un habillage d'exemple pour Polestar (Moonlit), pour les auteurs d'habillages. Ne fait pas partie de la version publiée de Polestar.",
			koKR: '스킨 제작자를 위한 Polestar 예제 스킨(Moonlit). Polestar 배포판에는 포함되지 않습니다.',
			ptBR: 'Um tema de exemplo para o Polestar (Moonlit), para autores de temas. Não faz parte da versão do Polestar.',
			ruRU: 'Пример оформления для Polestar (Moonlit) для авторов оформлений. Не входит в выпуск Polestar.',
			zhCN: '供皮肤作者参考的 Polestar 示例皮肤（Moonlit）。不属于 Polestar 的发行版。',
			zhTW: '供皮膚作者參考的 Polestar 範例皮膚（Moonlit）。不屬於 Polestar 的發行版本。',
		},
	},
	// The skins in the download (docs/skins): each an addon of its own, enabled in the AddOns list.
	Polestar_Skin_Vellum: {
		title: { deDE: 'Polestar-Design: Vellum', esES: 'Polestar, tema: Vellum', esMX: 'Polestar, tema: Vellum', frFR: 'Polestar, habillage : Vellum', koKR: 'Polestar 스킨: Vellum', ptBR: 'Polestar, tema: Vellum', ruRU: 'Polestar, оформление: Vellum', zhCN: 'Polestar 皮肤：Vellum', zhTW: 'Polestar 皮膚：Vellum' },
		notes: {
			deDE: 'Ein Pergament-Design für Polestar: der Guide als Seite des Questlogs, dunkle Tinte auf Papier.',
			esES: 'Un tema de pergamino para Polestar: la guía como una página del registro de misiones, tinta oscura sobre papel.',
			esMX: 'Un tema de pergamino para Polestar: la guía como una página del registro de misiones, tinta oscura sobre papel.',
			frFR: 'Un habillage parchemin pour Polestar : le guide comme une page du journal de quêtes, encre sombre sur papier.',
			koKR: 'Polestar의 양피지 스킨: 퀘스트 일지의 한 페이지처럼, 종이 위의 짙은 잉크.',
			ptBR: 'Um tema de pergaminho para o Polestar: o guia como uma página do registro de missões, tinta escura sobre papel.',
			ruRU: 'Пергаментное оформление для Polestar: гайд как страница журнала заданий, тёмные чернила на бумаге.',
			zhCN: 'Polestar 的羊皮纸皮肤：指南如同任务日志的一页，纸上深色墨迹。',
			zhTW: 'Polestar 的羊皮紙皮膚：指南如同任務日誌的一頁，紙上深色墨跡。',
		},
	},
	Polestar_Skin_Lumen: {
		title: { deDE: 'Polestar-Design: Lumen', esES: 'Polestar, tema: Lumen', esMX: 'Polestar, tema: Lumen', frFR: 'Polestar, habillage : Lumen', koKR: 'Polestar 스킨: Lumen', ptBR: 'Polestar, tema: Lumen', ruRU: 'Polestar, оформление: Lumen', zhCN: 'Polestar 皮肤：Lumen', zhTW: 'Polestar 皮膚：Lumen' },
		notes: {
			deDE: 'Ein Head-up-Design für Polestar: kein Rahmen, Eckmarken und eine cyanfarbene Linie, kompakte Schrift über der Spielwelt.',
			esES: 'Un tema de visor para Polestar: sin marco, marcas en las esquinas y una línea cian, texto compacto sobre el mundo.',
			esMX: 'Un tema de visor para Polestar: sin marco, marcas en las esquinas y una línea cian, texto compacto sobre el mundo.',
			frFR: 'Un habillage tête haute pour Polestar : sans cadre, des repères aux coins et une ligne cyan, un texte compact sur le monde.',
			koKR: 'Polestar의 HUD 스킨: 테두리 없이 모서리 표시와 청록색 선 하나, 월드 위의 촘촘한 글자.',
			ptBR: 'Um tema de HUD para o Polestar: sem moldura, marcas nos cantos e uma linha ciano, texto compacto sobre o mundo.',
			ruRU: 'HUD-оформление для Polestar: без рамки, метки по углам и одна бирюзовая линия, компактный текст поверх мира.',
			zhCN: 'Polestar 的抬头显示皮肤：无边框，角标和一条青色线，游戏世界上的紧凑文字。',
			zhTW: 'Polestar 的抬頭顯示皮膚：無邊框，角標與一條青色線，遊戲世界上的緊湊文字。',
		},
	},
	Polestar_Skin_Beacon: {
		title: { deDE: 'Polestar-Design: Beacon', esES: 'Polestar, tema: Beacon', esMX: 'Polestar, tema: Beacon', frFR: 'Polestar, habillage : Beacon', koKR: 'Polestar 스킨: Beacon', ptBR: 'Polestar, tema: Beacon', ruRU: 'Polestar, оформление: Beacon', zhCN: 'Polestar 皮肤：Beacon', zhTW: 'Polestar 皮膚：Beacon' },
		notes: {
			deDE: 'Ein kontrastreiches Design für Polestar: schwarze Flächen, größere weiße Schrift, gelber Akzent, kräftige Ränder, größere Markierungen und Pfeil.',
			esES: 'Un tema de alto contraste para Polestar: fondos negros, texto blanco más grande, acento amarillo, bordes marcados, marcadores y flecha más grandes.',
			esMX: 'Un tema de alto contraste para Polestar: fondos negros, texto blanco más grande, acento amarillo, bordes marcados, marcadores y flecha más grandes.',
			frFR: 'Un habillage à fort contraste pour Polestar : fonds noirs, texte blanc plus grand, accent jaune, bords marqués, repères et flèche plus grands.',
			koKR: 'Polestar의 고대비 스킨: 검은 바탕, 한 단계 큰 흰 글자, 노란 강조색, 굵은 테두리, 더 큰 표시와 화살표.',
			ptBR: 'Um tema de alto contraste para o Polestar: fundos pretos, texto branco maior, destaque amarelo, bordas fortes, marcadores e seta maiores.',
			ruRU: 'Высококонтрастное оформление для Polestar: чёрный фон, более крупный белый текст, жёлтый акцент, чёткие края, крупнее метки и стрелка.',
			zhCN: 'Polestar 的高对比度皮肤：黑色底面，更大的白色文字，黄色强调色，清晰边框，更大的标记和箭头。',
			zhTW: 'Polestar 的高對比皮膚：黑色底面，更大的白色文字，黃色強調色，清晰邊框，更大的標記與箭頭。',
		},
	},
	Polestar_Skin_Aurora: {
		title: { deDE: 'Polestar-Design: Aurora', esES: 'Polestar, tema: Aurora', esMX: 'Polestar, tema: Aurora', frFR: 'Polestar, habillage : Aurora', koKR: 'Polestar 스킨: Aurora', ptBR: 'Polestar, tema: Aurora', ruRU: 'Polestar, оформление: Aurora', zhCN: 'Polestar 皮肤：Aurora', zhTW: 'Polestar 皮膚：Aurora' },
		notes: {
			deDE: 'Nordlichter über Polestar: türkises und violettes Licht oben in jedem Fenster, leuchtende Kanten, eine tiefe Nacht.',
			esES: 'La aurora boreal sobre Polestar: luz turquesa y violeta en lo alto de cada ventana, bordes que brillan, una noche profunda.',
			esMX: 'La aurora boreal sobre Polestar: luz turquesa y violeta en lo alto de cada ventana, bordes que brillan, una noche profunda.',
			frFR: 'Les aurores boréales sur Polestar : une lumière turquoise et violette en haut de chaque fenêtre, des bords lumineux, une nuit profonde.',
			koKR: 'Polestar 위의 오로라: 모든 창 위쪽의 청록빛과 보랏빛, 빛나는 테두리, 깊은 밤.',
			ptBR: 'A aurora boreal sobre o Polestar: luz turquesa e violeta no alto de cada janela, bordas que brilham, uma noite profunda.',
			ruRU: 'Северное сияние над Polestar: бирюзовый и фиолетовый свет вверху каждого окна, светящиеся края, глубокая ночь.',
			zhCN: 'Polestar 上空的极光：每个窗口顶部的青色与紫色光芒，发光的边框，深邃的夜色。',
			zhTW: 'Polestar 上空的極光：每個視窗頂部的青色與紫色光芒，發光的邊框，深邃的夜色。',
		},
	},
	Polestar_Skin_Hairline: {
		title: { deDE: 'Polestar-Design: Hairline', esES: 'Polestar, tema: Hairline', esMX: 'Polestar, tema: Hairline', frFR: 'Polestar, habillage : Hairline', koKR: 'Polestar 스킨: Hairline', ptBR: 'Polestar, tema: Hairline', ruRU: 'Polestar, оформление: Hairline', zhCN: 'Polestar 皮肤：Hairline', zhTW: 'Polestar 皮膚：Hairline' },
		notes: {
			deDE: 'Der leichteste Strich für Polestar: Rahmen aus einzelnen Haarlinien, umrandete Schaltflächen, leichte schmale Schrift mit Luft, deine Klassenfarbe als Akzent.',
			esES: 'El trazo más ligero para Polestar: marcos de una sola línea fina, botones solo con contorno, letra condensada ligera con aire alrededor, el color de tu clase como acento.',
			esMX: 'El trazo más ligero para Polestar: marcos de una sola línea fina, botones solo con contorno, letra condensada ligera con aire alrededor, el color de tu clase como acento.',
			frFR: "La touche la plus légère pour Polestar : des cadres d'un seul trait fin, des boutons en contour, des caractères condensés légers et aérés, la couleur de votre classe en accent.",
			koKR: 'Polestar를 위한 가장 가벼운 스킨: 가는 선 하나로 된 테두리, 외곽선 버튼, 여유 있는 가는 좁은 글꼴, 직업 색상의 강조색.',
			ptBR: 'O traço mais leve para o Polestar: molduras de uma só linha fina, botões só com contorno, letra condensada leve com espaço ao redor, a cor da sua classe como destaque.',
			ruRU: 'Самое лёгкое оформление для Polestar: рамки из одной тонкой линии, кнопки-контуры, лёгкий узкий шрифт с простором, цвет вашего класса как акцент.',
			zhCN: 'Polestar 最轻盈的皮肤：单根细线的边框，仅描边的按钮，疏朗的细窄字体，以职业颜色为强调色。',
			zhTW: 'Polestar 最輕盈的皮膚：單根細線的邊框，僅描邊的按鈕，疏朗的細窄字體，以職業顏色為強調色。',
		},
	},
	Polestar_Skin_Umbra: {
		title: { deDE: 'Polestar-Design: Umbra', esES: 'Polestar, tema: Umbra', esMX: 'Polestar, tema: Umbra', frFR: 'Polestar, habillage : Umbra', koKR: 'Polestar 스킨: Umbra', ptBR: 'Polestar, tema: Umbra', ruRU: 'Polestar, оформление: Umbra', zhCN: 'Polestar 皮肤：Umbra', zhTW: 'Polestar 皮膚：Umbra' },
		notes: {
			deDE: 'Ein dunkler Modus für Polestar: anthrazitfarbene Fenster in einer weichen Vignette, ein stählernes Leuchten an den Kanten, ein tiefer Schatten; auf Polestars Rahmen oder auf der abgedunkelten Grafik des Spiels.',
			esES: 'Un modo oscuro para Polestar: ventanas color carbón hundidas en una viñeta suave, un brillo acero en sus bordes, una sombra profunda; sobre los marcos de Polestar o sobre el arte del juego, atenuado.',
			esMX: 'Un modo oscuro para Polestar: ventanas color carbón hundidas en una viñeta suave, un brillo acero en sus bordes, una sombra profunda; sobre los marcos de Polestar o sobre el arte del juego, atenuado.',
			frFR: 'Un mode sombre pour Polestar : des fenêtres anthracite dans un vignettage doux, une lueur acier sur leurs bords, une ombre profonde ; sur les cadres de Polestar ou sur les graphismes du jeu, assombris.',
			koKR: 'Polestar의 다크 모드: 부드러운 비네트에 잠긴 차콜 창, 가장자리의 강철빛, 깊은 그림자. Polestar의 프레임 또는 어둡게 한 게임 자체 그래픽 위에.',
			ptBR: 'Um modo escuro para o Polestar: janelas cor de carvão numa vinheta suave, um brilho de aço nas bordas, uma sombra profunda; nas molduras do Polestar ou na arte do próprio jogo, escurecida.',
			ruRU: 'Тёмный режим для Polestar: графитовые окна в мягкой виньетке, стальное свечение по краям, глубокая тень; на рамках Polestar или на затемнённой графике игры.',
			zhCN: 'Polestar 的深色模式：沉在柔和暗角中的炭灰窗口，边缘钢色微光，深邃阴影；用于 Polestar 的窗框或调暗的游戏自带美术。',
			zhTW: 'Polestar 的深色模式：沉在柔和暗角中的炭灰視窗，邊緣鋼色微光，深邃陰影；用於 Polestar 的窗框或調暗的遊戲自帶美術。',
		},
	},
	Polestar_Skin_Waymark: {
		title: { deDE: 'Polestar-Design: Waymark', esES: 'Polestar, tema: Waymark', esMX: 'Polestar, tema: Waymark', frFR: 'Polestar, habillage : Waymark', koKR: 'Polestar 스킨: Waymark', ptBR: 'Polestar, tema: Waymark', ruRU: 'Polestar, оформление: Waymark', zhCN: 'Polestar 皮肤：Waymark', zhTW: 'Polestar 皮膚：Waymark' },
		notes: {
			deDE: 'Ein Design für Polestar, das dem Land folgt, in dem du levelst: dunkles Kartenpapier, eine Kompassrose und eine gestrichelte Route, der Ladebildschirm des Kontinents hinter der Kopfzeile, seine Farbe auf dem Akzent und ein Pfeil als Kompassnadel.',
			esES: 'Un tema para Polestar que sigue la tierra donde subes de nivel: papel de carta oscuro, una rosa de los vientos y una ruta discontinua, la pantalla de carga del continente tras la cabecera, su color en el acento y una flecha de aguja de brújula.',
			esMX: 'Un tema para Polestar que sigue la tierra donde subes de nivel: papel de carta oscuro, una rosa de los vientos y una ruta discontinua, la pantalla de carga del continente tras la cabecera, su color en el acento y una flecha de aguja de brújula.',
			frFR: "Un habillage pour Polestar qui suit la terre où vous montez de niveau : un papier de carte sombre, une rose des vents et une route en pointillés, l'écran de chargement du continent derrière l'en-tête, sa couleur en accent et une flèche en aiguille de boussole.",
			koKR: '레벨업하는 땅을 따라가는 Polestar 스킨: 어두운 지도 종이, 나침반 장미와 점선 경로, 머리글 뒤의 대륙 로딩 화면, 강조색에 그 대륙의 색, 나침반 바늘 화살표.',
			ptBR: 'Um tema para o Polestar que acompanha a terra onde você sobe de nível: papel de carta escuro, uma rosa dos ventos e uma rota tracejada, a tela de carregamento do continente atrás do cabeçalho, sua cor no destaque e uma seta de agulha de bússola.',
			ruRU: 'Оформление для Polestar, которое следует за землёй, где вы качаетесь: тёмная бумага карты, роза ветров и пунктирный маршрут, экран загрузки континента за заголовком, его цвет на акценте и стрелка-стрелка компаса.',
			zhCN: '随你升级所在之地变化的 Polestar 皮肤：深色海图纸，罗盘玫瑰与虚线航线，标题后方是大陆的载入画面，强调色取其颜色，罗盘指针箭头。',
			zhTW: '隨你升級所在之地變化的 Polestar 皮膚：深色海圖紙，羅盤玫瑰與虛線航線，標題後方是大陸的載入畫面，強調色取其顏色，羅盤指針箭頭。',
		},
	},
	Polestar_Skin_Lanterns: {
		title: { deDE: 'Polestar-Design: Lanterns', esES: 'Polestar, tema: Lanterns', esMX: 'Polestar, tema: Lanterns', frFR: 'Polestar, habillage : Lanterns', koKR: 'Polestar 스킨: Lanterns', ptBR: 'Polestar, tema: Lanterns', ruRU: 'Polestar, оформление: Lanterns', zhCN: 'Polestar 皮肤：Lanterns', zhTW: 'Polestar 皮膚：Lanterns' },
		notes: {
			deDE: 'Zehn Stimmungsfarben für Polestar, je ein Paar: abgerundete Fenster, pillenförmige Reiter und Schaltflächen, getönte Flächen und zwei sanfte Lichter in gegenüberliegenden Ecken.',
			esES: 'Diez colores de ambiente para Polestar, cada uno un par: ventanas redondeadas, pestañas y botones en forma de píldora, fondos teñidos y dos luces suaves en esquinas opuestas.',
			esMX: 'Diez colores de ambiente para Polestar, cada uno un par: ventanas redondeadas, pestañas y botones en forma de píldora, fondos teñidos y dos luces suaves en esquinas opuestas.',
			frFR: 'Dix ambiances colorées pour Polestar, chacune une paire : des fenêtres arrondies, des onglets et boutons en pilule, des fonds teintés et deux lueurs douces aux coins opposés.',
			koKR: 'Polestar의 분위기 색 열 가지, 각각 한 쌍: 둥근 창, 알약 모양 탭과 버튼, 물든 바탕과 마주 보는 모서리의 부드러운 빛 두 개.',
			ptBR: 'Dez cores de clima para o Polestar, cada uma um par: janelas arredondadas, abas e botões em pílula, fundos tingidos e duas luzes suaves em cantos opostos.',
			ruRU: 'Десять цветовых настроений для Polestar, каждое парой: скруглённые окна, вкладки и кнопки-капсулы, подкрашенный фон и два мягких огня в противоположных углах.',
			zhCN: 'Polestar 的十种氛围配色，每种一对颜色：圆角窗口，胶囊形标签与按钮，染色底面和对角两盏柔光。',
			zhTW: 'Polestar 的十種氛圍配色，每種一對顏色：圓角視窗，膠囊形標籤與按鈕，染色底面和對角兩盞柔光。',
		},
	},
	Polestar_Skin_Sheen: {
		title: { deDE: 'Polestar-Design: Sheen', esES: 'Polestar, tema: Sheen', esMX: 'Polestar, tema: Sheen', frFR: 'Polestar, habillage : Sheen', koKR: 'Polestar 스킨: Sheen', ptBR: 'Polestar, tema: Sheen', ruRU: 'Polestar, оформление: Sheen', zhCN: 'Polestar 皮肤：Sheen', zhTW: 'Polestar 皮膚：Sheen' },
		notes: {
			deDE: 'Glas und Glanz für Polestar: abgeschrägte, durchscheinende Scheiben, Glanz auf jeder Schaltfläche und jedem Reiter, Licht über dem Glas, deine Klassenfarbe, die in den Akzent übergeht.',
			esES: 'Cristal y brillo para Polestar: paneles translúcidos biselados, brillo en cada botón y pestaña, luz sobre el cristal, el color de tu clase fundiéndose con el acento.',
			esMX: 'Cristal y brillo para Polestar: paneles translúcidos biselados, brillo en cada botón y pestaña, luz sobre el cristal, el color de tu clase fundiéndose con el acento.',
			frFR: "Verre et brillance pour Polestar : des panneaux translucides biseautés, un reflet sur chaque bouton et onglet, de la lumière sur le verre, la couleur de votre classe qui se fond dans l'accent.",
			koKR: 'Polestar를 위한 유리와 광택: 경사진 반투명 판, 모든 버튼과 탭의 광택, 유리를 가로지르는 빛, 강조색으로 이어지는 직업 색상.',
			ptBR: 'Vidro e brilho para o Polestar: painéis translúcidos chanfrados, brilho em cada botão e aba, luz sobre o vidro, a cor da sua classe fundindo-se ao destaque.',
			ruRU: 'Стекло и блеск для Polestar: полупрозрачные панели со скосом, блик на каждой кнопке и вкладке, свет поперёк стекла, цвет вашего класса, переходящий в акцент.',
			zhCN: 'Polestar 的玻璃与光泽：带斜面的半透明面板，每个按钮和标签上的光泽，横过玻璃的光，职业颜色渐入强调色。',
			zhTW: 'Polestar 的玻璃與光澤：帶斜面的半透明面板，每個按鈕和標籤上的光澤，橫過玻璃的光，職業顏色漸入強調色。',
		},
	},
};

// The per-language folders: { title, notes } templates, %1 the locale code,
// %2 the folder's language in this language.
const LANGUAGE_PREFIX = 'Polestar_';
const PER_LANGUAGE = {
	[LANGUAGE_PREFIX]: {
		deDE: ['Polestar - %2', 'Guide-Texte und Spielnamen für Polestar (Quests, NPCs, Objekte, Gegenstände, Instanzen und mehr). Sprache: %2. Wird bei Bedarf geladen, nur in einem Client dieser Sprache.'],
		esES: ['Polestar - %2', 'Textos de las guías y nombres del juego para Polestar (misiones, PNJ, objetos, instancias y más). Idioma: %2. Se carga bajo demanda solo en un cliente en ese idioma.'],
		esMX: ['Polestar - %2', 'Textos de las guías y nombres del juego para Polestar (misiones, PNJ, objetos, instancias y más). Idioma: %2. Se carga bajo demanda solo en un cliente en ese idioma.'],
		frFR: ['Polestar - %2', 'Textes des guides et noms du jeu pour Polestar (quêtes, PNJ, objets, instances et plus). Langue : %2. Chargé à la demande, uniquement sur un client dans cette langue.'],
		koKR: ['Polestar - %2', 'Polestar 가이드 텍스트와 게임 이름(퀘스트, NPC, 물체, 아이템, 인스턴스 등). 언어: %2. 해당 언어 클라이언트에서만 필요할 때 불러옵니다.'],
		ptBR: ['Polestar - %2', 'Textos dos guias e nomes do jogo para o Polestar (missões, PNJs, objetos, itens, instâncias e mais). Idioma: %2. Carregado sob demanda, só em um cliente nesse idioma.'],
		ruRU: ['Polestar - %2', 'Тексты гайдов и названия из игры для Polestar (задания, NPC, объекты, предметы, подземелья и другое). Язык: %2. Загружается по требованию, только в клиенте на этом языке.'],
		zhCN: ['Polestar - %2', 'Polestar 的指南文本和游戏名称（任务、NPC、物体、物品、副本等）。语言：%2。仅在该语言的客户端中按需加载。'],
		zhTW: ['Polestar - %2', 'Polestar 的指南文字與遊戲名稱（任務、NPC、物件、物品、副本等）。語言：%2。僅在該語言的用戶端中按需載入。'],
	},
};

// Each language's name in each language, as it reads after "Language:".
const LANGUAGE_NAMES = {
	deDE: { deDE: 'Deutsch', esES: 'Spanisch (Spanien)', esMX: 'Spanisch (Lateinamerika)', frFR: 'Französisch', koKR: 'Koreanisch', ptBR: 'Portugiesisch (Brasilien)', ruRU: 'Russisch', zhCN: 'Chinesisch (vereinfacht)', zhTW: 'Chinesisch (traditionell)' },
	esES: { deDE: 'alemán', esES: 'español (España)', esMX: 'español (Latinoamérica)', frFR: 'francés', koKR: 'coreano', ptBR: 'portugués (Brasil)', ruRU: 'ruso', zhCN: 'chino (simplificado)', zhTW: 'chino (tradicional)' },
	esMX: { deDE: 'alemán', esES: 'español (España)', esMX: 'español (Latinoamérica)', frFR: 'francés', koKR: 'coreano', ptBR: 'portugués (Brasil)', ruRU: 'ruso', zhCN: 'chino (simplificado)', zhTW: 'chino (tradicional)' },
	frFR: { deDE: 'allemand', esES: 'espagnol (Espagne)', esMX: 'espagnol (Amérique latine)', frFR: 'français', koKR: 'coréen', ptBR: 'portugais (Brésil)', ruRU: 'russe', zhCN: 'chinois (simplifié)', zhTW: 'chinois (traditionnel)' },
	koKR: { deDE: '독일어', esES: '스페인어(스페인)', esMX: '스페인어(중남미)', frFR: '프랑스어', koKR: '한국어', ptBR: '포르투갈어(브라질)', ruRU: '러시아어', zhCN: '중국어(간체)', zhTW: '중국어(번체)' },
	ptBR: { deDE: 'alemão', esES: 'espanhol (Espanha)', esMX: 'espanhol (América Latina)', frFR: 'francês', koKR: 'coreano', ptBR: 'português (Brasil)', ruRU: 'russo', zhCN: 'chinês (simplificado)', zhTW: 'chinês (tradicional)' },
	ruRU: { deDE: 'немецкий', esES: 'испанский (Испания)', esMX: 'испанский (Латинская Америка)', frFR: 'французский', koKR: 'корейский', ptBR: 'португальский (Бразилия)', ruRU: 'русский', zhCN: 'китайский (упрощенный)', zhTW: 'китайский (традиционный)' },
	zhCN: { deDE: '德语', esES: '西班牙语（西班牙）', esMX: '西班牙语（拉丁美洲）', frFR: '法语', koKR: '韩语', ptBR: '葡萄牙语（巴西）', ruRU: '俄语', zhCN: '简体中文', zhTW: '繁体中文' },
	zhTW: { deDE: '德語', esES: '西班牙語（西班牙）', esMX: '西班牙語（拉丁美洲）', frFR: '法語', koKR: '韓語', ptBR: '葡萄牙語（巴西）', ruRU: '俄語', zhCN: '簡體中文', zhTW: '繁體中文' },
};

// Our pack's race parts (Polestar_Guides_<race file>: a race's class chains
// and the baked legs of the guides it may follow): { title, notes } templates,
// %2 the race in this language (the addon's own Locales/ names).
const RACE_PART_PREFIX = 'Polestar_Guides_';
const PER_RACE = {
	deDE: ['Polestar Guides (%2)', 'Leveling-Guides von Polestar und ihre Laufwege für Charaktere der Rasse %2. Wird bei Bedarf geladen.'],
	esES: ['Polestar: guías (%2)', 'Guías de subida de nivel de Polestar y sus rutas a pie para personajes de la raza %2. Se carga bajo demanda.'],
	esMX: ['Polestar: guías (%2)', 'Guías de subida de nivel de Polestar y sus rutas a pie para personajes de la raza %2. Se carga bajo demanda.'],
	frFR: ['Polestar : guides (%2)', 'Guides de montée en niveau de Polestar et leurs trajets à pied pour les personnages de la race %2. Chargé à la demande.'],
	koKR: ['Polestar 가이드 (%2)', '%2 캐릭터를 위한 Polestar 레벨업 가이드와 도보 경로. 필요할 때 불러옵니다.'],
	ptBR: ['Polestar: guias (%2)', 'Guias de evolução do Polestar e suas rotas a pé para personagens da raça %2. Carregado sob demanda.'],
	ruRU: ['Polestar: гайды (%2)', 'Гайды Polestar по прокачке и их пешие маршруты для персонажей расы «%2». Загружается по требованию.'],
	zhCN: ['Polestar 指南（%2）', 'Polestar 为%2角色提供的练级指南及其步行路线。按需加载。'],
	zhTW: ['Polestar 指南（%2）', 'Polestar 為%2角色提供的升級指南及其步行路線。按需載入。'],
};
// Each race (by race file) in each language, as addon/Polestar/Locales/ has it.
const RACE_NAMES = {
	deDE: { Human: 'Mensch', Orc: 'Orc', Dwarf: 'Zwerg', NightElf: 'Nachtelf', Scourge: 'Untoter', Tauren: 'Tauren', Gnome: 'Gnom', Troll: 'Troll', Skyborne: 'Himmelsgeborene' },
	esES: { Human: 'Humano', Orc: 'Orco', Dwarf: 'Enano', NightElf: 'Elfo de la noche', Scourge: 'No-muerto', Tauren: 'Tauren', Gnome: 'Gnomo', Troll: 'Trol', Skyborne: 'Cielonato' },
	esMX: { Human: 'Humano', Orc: 'Orco', Dwarf: 'Enano', NightElf: 'Elfo de la noche', Scourge: 'No-muerto', Tauren: 'Tauren', Gnome: 'Gnomo', Troll: 'Trol', Skyborne: 'Cielonato' },
	frFR: { Human: 'Humain', Orc: 'Orc', Dwarf: 'Nain', NightElf: 'Elfe de la nuit', Scourge: 'Mort-vivant', Tauren: 'Tauren', Gnome: 'Gnome', Troll: 'Troll', Skyborne: 'Éolide' },
	koKR: { Human: '인간', Orc: '오크', Dwarf: '드워프', NightElf: '나이트 엘프', Scourge: '언데드', Tauren: '타우렌', Gnome: '노움', Troll: '트롤', Skyborne: '스카이본' },
	ptBR: { Human: 'Humano', Orc: 'Orc', Dwarf: 'Anão', NightElf: 'Elfo Noturno', Scourge: 'Morto-vivo', Tauren: 'Tauren', Gnome: 'Gnomo', Troll: 'Troll', Skyborne: 'Celonato' },
	ruRU: { Human: 'Человек', Orc: 'Орк', Dwarf: 'Дворф', NightElf: 'Ночной эльф', Scourge: 'Нежить', Tauren: 'Таурен', Gnome: 'Гном', Troll: 'Тролль', Skyborne: 'Небеснорожденный' },
	zhCN: { Human: '人类', Orc: '兽人', Dwarf: '矮人', NightElf: '暗夜精灵', Scourge: '亡灵', Tauren: '牛头人', Gnome: '侏儒', Troll: '巨魔', Skyborne: '天裔' },
	zhTW: { Human: '人類', Orc: '獸人', Dwarf: '矮人', NightElf: '夜精靈', Scourge: '不死族', Tauren: '牛頭人', Gnome: '地精', Troll: '食人妖', Skyborne: '天裔精靈' },
};

// addon -> { [locale]: { title, notes } }
function tocText(addon) {
	const fixed = TEXT[addon];
	if (fixed) return Object.fromEntries(LOCALE_CODES.map((l) => [l, { title: fixed.title[l], notes: fixed.notes[l] }]));
	const race = addon.startsWith(RACE_PART_PREFIX) ? addon.slice(RACE_PART_PREFIX.length) : null;
	if (race && RACE_NAMES.deDE[race]) {
		const fill = (s, l) => s.replace('%2', RACE_NAMES[l][race]);
		return Object.fromEntries(LOCALE_CODES.map((l) => [l, { title: fill(PER_RACE[l][0], l), notes: fill(PER_RACE[l][1], l) }]));
	}
	for (const [prefix, templates] of Object.entries(PER_LANGUAGE)) {
		if (!addon.startsWith(prefix)) continue;
		const pack = addon.slice(prefix.length);
		if (!LOCALE_CODES.includes(pack)) break;
		const fill = (s, l) => s.replace('%1', pack).replace('%2', LANGUAGE_NAMES[l][pack]);
		return Object.fromEntries(LOCALE_CODES.map((l) => [l, { title: fill(templates[l][0], l), notes: fill(templates[l][1], l) }]));
	}
	throw new Error(`no AddOns-list translations for ${addon} (tools/lib/i18n/toc.js)`);
}

function tocLines(addon) {
	const text = tocText(addon);
	const out = [];
	for (const l of LOCALE_CODES) out.push(`## Title-${l}: ${text[l].title}`, `## Notes-${l}: ${text[l].notes}`);
	return out;
}

const languageAddon = (locale) => `${LANGUAGE_PREFIX}${locale}`;
const retiredLanguageAddons = (locale) => [`Polestar_Guides_${locale}`, `Polestar_Names_${locale}`];
// The language folder's files, in load order: every writer of the folder lists both.
const LANGUAGE_FILES = ['Names.lua', 'Texts.lua'];

function languageToc(locale, iface, version) {
	const language = LOCALES[locale].language;
	return `${[
		`## Interface: ${iface}`,
		`## Title: Polestar - ${language}`,
		`## Notes: Guide texts and the game's names (quests, NPCs, objects, items, instances and more) in ${language} for Polestar. Loaded on demand on a ${language} client.`,
		...tocLines(languageAddon(locale)),
		'## Author: Polestar',
		`## Version: ${version}`,
		'## Category: Polestar',
		'## Group: Polestar',
		'## LoadOnDemand: 1',
		'## Dependencies: Polestar',
		'## X-Polestar-Texts: guides',
		`## X-Polestar-Locale: ${locale}`,
		'## X-License: GPL-3.0-only',
		`# ${GENERATED_MARKER} (Texts.lua) and \`forge data names\` (Names.lua). Do not edit: rebuild with those commands.`,
		'',
		...LANGUAGE_FILES,
	].join('\n')}\n`;
}

module.exports = { tocText, tocLines, languageAddon, languageToc, retiredLanguageAddons, LANGUAGE_PREFIX, LANGUAGE_FILES, TOC_ADDONS: Object.keys(TEXT) };
