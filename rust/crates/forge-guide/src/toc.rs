//! Port of tools/lib/i18n/toc.js.
//!
//! The game's AddOns list shows each addon's `## Title` and `## Notes`, and in
//! a client language the `## Title-<locale>` and `## Notes-<locale>` beside
//! them. These are the translations of every Polestar addon's, written once
//! here (AI translations, glossary: data/i18n/glossary; Polestar, Codex
//! and the names of people and projects are kept as they are).
//!
//!   toc_lines(addon) -> ["## Title-deDE: ...", "## Notes-deDE: ...", ...]
//!     for every locale (LOCALE_CODES order). addon: the folder name;
//!     the language folders Polestar_<locale> name their own language.

use crate::locales::LOCALE_CODES;

/// Every Polestar addon with fixed AddOns-list texts: (addon, titles, notes), each in LOCALE_CODES order.
static TEXT: &[(&str, [&str; 9], [&str; 9])] = &[
	(
		"Polestar",
		["Polestar", "Polestar", "Polestar", "Polestar", "Polestar", "Polestar", "Polestar", "Polestar", "Polestar"],
		[
			"Leveling-Guides für World of Warcraft: Forever.",
			"Guías para subir de nivel en World of Warcraft: Forever.",
			"Guías para subir de nivel en World of Warcraft: Forever.",
			"Guides de montée en niveau pour World of Warcraft: Forever.",
			"World of Warcraft: Forever 레벨업 가이드.",
			"Guias de evolução para World of Warcraft: Forever.",
			"Гайды по прокачке для World of Warcraft: Forever.",
			"魔兽世界：Forever 练级指南。",
			"World of Warcraft: Forever 的升級指南。",
		],
	),
	(
		"Polestar_Codex",
		["Polestar Codex", "Polestar Codex", "Polestar Codex", "Polestar Codex", "Polestar Codex", "Polestar Codex", "Polestar Codex", "Polestar Codex", "Polestar Codex"],
		[
			"Teil von Polestar: Gegenstände, Reittiere, Haustiere, NPCs, Quests und wo man sie bekommt, Dungeons und Rares, für Nachschlagen, Dungeons und Rares. Wird bei Bedarf geladen.",
			"Parte de Polestar: objetos, monturas, mascotas, PNJ, misiones y dónde conseguirlos, mazmorras y raros, para Buscador, Mazmorras y Raros. Se carga bajo demanda.",
			"Parte de Polestar: objetos, monturas, mascotas, PNJ, misiones y dónde conseguirlos, calabozos y raros, para Buscador, Calabozos y Raros. Se carga bajo demanda.",
			"Fait partie de Polestar : objets, montures, mascottes, PNJ, quêtes et où les obtenir, donjons et rares, pour Recherche, Donjons et Rares. Chargé à la demande.",
			"Polestar의 일부: 아이템, 탈것, 애완동물, NPC, 퀘스트와 얻는 곳, 던전과 희귀 몬스터. 찾아보기, 던전, 희귀에서 씁니다. 필요할 때 불러옵니다.",
			"Parte do Polestar: itens, montarias, mascotes, PNJs, missões e onde obtê-los, masmorras e raros, para Consulta, Masmorras e Raros. Carregado sob demanda.",
			"Часть Polestar: предметы, транспорт, питомцы, NPC, задания и где их получить, подземелья и редкие существа для разделов «Поиск», «Подземелья» и «Редкие». Загружается по требованию.",
			"Polestar 的组成部分：物品、坐骑、宠物、NPC、任务及其获取途径、地下城和稀有怪物，供查询、地下城和稀有页面使用。按需加载。",
			"Polestar 的一部分：物品、坐騎、寵物、NPC、任務及其取得方式、地城與稀有怪物，供查詢、地城與稀有頁面使用。按需載入。",
		],
	),
	(
		"Polestar_Guides",
		["Polestar Guides", "Polestar: guías", "Polestar: guías", "Polestar : guides", "Polestar 가이드", "Polestar: guias", "Polestar: гайды", "Polestar 指南", "Polestar 指南"],
		[
			"Leveling-, Berufs-, Ruf- und Sammel-Guides für Polestar.",
			"Guías de subida de nivel, profesiones, reputación y coleccionables para Polestar.",
			"Guías de subida de nivel, profesiones, reputación y coleccionables para Polestar.",
			"Guides de montée en niveau, de métiers, de réputation et de collection pour Polestar.",
			"Polestar용 레벨업, 전문 기술, 평판, 수집품 가이드.",
			"Guias de evolução, profissões, reputação e colecionáveis para o Polestar.",
			"Гайды по прокачке, профессиям, репутации и коллекциям для Polestar.",
			"Polestar 的练级、专业、声望和收藏指南。",
			"Polestar 的升級、專業、聲望與收藏指南。",
		],
	),
	(
		"Polestar_Guides_Alliance",
		["Polestar Guides (Allianz)", "Polestar: guías (Alianza)", "Polestar: guías (Alianza)", "Polestar : guides (Alliance)", "Polestar 가이드 (얼라이언스)", "Polestar: guias (Aliança)", "Polestar: гайды (Альянс)", "Polestar 指南（联盟）", "Polestar 指南（聯盟）"],
		[
			"Guides von Polestar für Charaktere der Allianz, mit den Laufwegen jedes Volkes. Wird bei Bedarf geladen.",
			"Guías de Polestar para personajes de la Alianza, con los recorridos de cada raza. Se carga bajo demanda.",
			"Guías de Polestar para personajes de la Alianza, con los recorridos de cada raza. Se carga bajo demanda.",
			"Guides de Polestar pour les personnages de l'Alliance, avec les trajets de chaque race. Chargé à la demande.",
			"얼라이언스 캐릭터를 위한 Polestar 가이드와 종족별 도보 경로. 필요할 때 불러옵니다.",
			"Guias do Polestar para personagens da Aliança, com os trajetos de cada raça. Carregado sob demanda.",
			"Гайды Polestar для персонажей Альянса с пешими маршрутами каждой расы. Загружается по требованию.",
			"Polestar 的联盟角色指南，含各种族的步行路线。按需加载。",
			"Polestar 的聯盟角色指南，含各種族的步行路線。按需載入。",
		],
	),
	(
		"Polestar_Guides_Horde",
		["Polestar Guides (Horde)", "Polestar: guías (Horda)", "Polestar: guías (Horda)", "Polestar : guides (Horde)", "Polestar 가이드 (호드)", "Polestar: guias (Horda)", "Polestar: гайды (Орда)", "Polestar 指南（部落）", "Polestar 指南（部落）"],
		[
			"Guides von Polestar für Charaktere der Horde, mit den Laufwegen jedes Volkes. Wird bei Bedarf geladen.",
			"Guías de Polestar para personajes de la Horda, con los recorridos de cada raza. Se carga bajo demanda.",
			"Guías de Polestar para personajes de la Horda, con los recorridos de cada raza. Se carga bajo demanda.",
			"Guides de Polestar pour les personnages de la Horde, avec les trajets de chaque race. Chargé à la demande.",
			"호드 캐릭터를 위한 Polestar 가이드와 종족별 도보 경로. 필요할 때 불러옵니다.",
			"Guias do Polestar para personagens da Horda, com os trajetos de cada raça. Carregado sob demanda.",
			"Гайды Polestar для персонажей Орды с пешими маршрутами каждой расы. Загружается по требованию.",
			"Polestar 的部落角色指南，含各种族的步行路线。按需加载。",
			"Polestar 的部落角色指南，含各種族的步行路線。按需載入。",
		],
	),
	(
		"Polestar_ItemDB",
		["Polestar Gegenstandsdaten", "Polestar: datos de objetos", "Polestar: datos de objetos", "Polestar : données d'objets", "Polestar 아이템 데이터", "Polestar: dados de itens", "Polestar: данные предметов", "Polestar 物品数据", "Polestar 物品資料"],
		[
			"Gegenstandswerte für Polestars Ausrüstungsratschläge. Wird bei Bedarf geladen.",
			"Estadísticas de objetos para los consejos de equipo de Polestar. Se carga bajo demanda.",
			"Estadísticas de objetos para los consejos de equipo de Polestar. Se carga bajo demanda.",
			"Caractéristiques des objets pour les conseils d'équipement de Polestar. Chargé à la demande.",
			"Polestar 장비 조언에 쓰는 아이템 능력치. 필요할 때 불러옵니다.",
			"Atributos de itens para as dicas de equipamento do Polestar. Carregado sob demanda.",
			"Характеристики предметов для советов Polestar по снаряжению. Загружается по требованию.",
			"Polestar 装备建议所用的物品属性。按需加载。",
			"Polestar 裝備建議所用的物品屬性。按需載入。",
		],
	),
	(
		"Polestar_Nav",
		["Polestar Navigation", "Polestar: navegación", "Polestar: navegación", "Polestar : navigation", "Polestar 길찾기", "Polestar: navegação", "Polestar: навигация", "Polestar 导航", "Polestar 導航"],
		[
			"Teil von Polestar: Laufwege für den Pfeil, mit Polestars eigener Wegfindung, entstanden aus der Wegfindung von Shortest Path Forever (Cillian Berragan, github.com/cjber/shortest-path-forever, mit seiner Erlaubnis verwendet). Wird bei Bedarf geladen.",
			"Parte de Polestar: rutas a pie para la flecha, con el cálculo de rutas propio de Polestar, que partió del de Shortest Path Forever (Cillian Berragan, github.com/cjber/shortest-path-forever, usado con su permiso). Se carga bajo demanda.",
			"Parte de Polestar: rutas a pie para la flecha, con el cálculo de rutas propio de Polestar, que partió del de Shortest Path Forever (Cillian Berragan, github.com/cjber/shortest-path-forever, usado con su permiso). Se carga bajo demanda.",
			"Fait partie de Polestar : itinéraires à pied pour la flèche, calculés par le routeur de Polestar, issu de celui de Shortest Path Forever (Cillian Berragan, github.com/cjber/shortest-path-forever, utilisé avec sa permission). Chargé à la demande.",
			"Polestar의 일부: 화살표용 도보 경로. Shortest Path Forever의 길찾기(Cillian Berragan, github.com/cjber/shortest-path-forever, 허락을 받아 사용)에서 출발한 Polestar 자체 길찾기를 씁니다. 필요할 때 불러옵니다.",
			"Parte do Polestar: rotas a pé para a seta, com o cálculo de rotas próprio do Polestar, que partiu do Shortest Path Forever (Cillian Berragan, github.com/cjber/shortest-path-forever, usado com permissão dele). Carregado sob demanda.",
			"Часть Polestar: пешие маршруты для стрелки, построенные собственным алгоритмом Polestar, выросшим из алгоритма Shortest Path Forever (Cillian Berragan, github.com/cjber/shortest-path-forever, используется с его разрешения). Загружается по требованию.",
			"Polestar 的组成部分：为箭头提供步行路线，采用 Polestar 自己的寻路，源自 Shortest Path Forever 的寻路（Cillian Berragan，github.com/cjber/shortest-path-forever，经其许可使用）。按需加载。",
			"Polestar 的一部分：為箭頭提供步行路線，採用 Polestar 自己的尋路，源自 Shortest Path Forever 的尋路（Cillian Berragan，github.com/cjber/shortest-path-forever，經其許可使用）。按需載入。",
		],
	),
	(
		"Polestar_Nav_EK",
		["Polestar Navigation (Östliche Königreiche)", "Polestar: navegación (Reinos del Este)", "Polestar: navegación (Reinos del Este)", "Polestar : navigation (Royaumes de l'Est)", "Polestar 길찾기 (동부 왕국)", "Polestar: navegação (Reinos do Leste)", "Polestar: навигация (Восточные королевства)", "Polestar 导航（东部王国）", "Polestar 導航（東部王國）"],
		[
			"Laufkarten der Östlichen Königreiche für Polestars Pfeil, aus Leffes Navigationskarten. Wird auf diesem Kontinent bei Bedarf geladen.",
			"Mapas a pie de los Reinos del Este para la flecha de Polestar, a partir de los mapas de navegación de Leffe. Se carga bajo demanda en ese continente.",
			"Mapas a pie de los Reinos del Este para la flecha de Polestar, a partir de los mapas de navegación de Leffe. Se carga bajo demanda en ese continente.",
			"Cartes de marche des Royaumes de l'Est pour la flèche de Polestar, tirées des cartes de navigation de Leffe. Chargé à la demande sur ce continent.",
			"Polestar 화살표용 동부 왕국 도보 지도. Leffe의 길찾기 지도에서 만들었습니다. 그 대륙에서 필요할 때 불러옵니다.",
			"Mapas a pé dos Reinos do Leste para a seta do Polestar, a partir dos mapas de navegação do Leffe. Carregado sob demanda nesse continente.",
			"Пешие карты Восточных королевств для стрелки Polestar, из навигационных карт Leffe. Загружается по требованию на этом континенте.",
			"Polestar 箭头使用的东部王国步行地图，来自 Leffe 的导航地图。在该大陆上按需加载。",
			"Polestar 箭頭使用的東部王國步行地圖，來自 Leffe 的導航地圖。在該大陸上按需載入。",
		],
	),
	(
		"Polestar_Nav_Kalimdor",
		["Polestar Navigation (Kalimdor)", "Polestar: navegación (Kalimdor)", "Polestar: navegación (Kalimdor)", "Polestar : navigation (Kalimdor)", "Polestar 길찾기 (칼림도어)", "Polestar: navegação (Kalimdor)", "Polestar: навигация (Калимдор)", "Polestar 导航（卡利姆多）", "Polestar 導航（卡林多）"],
		[
			"Laufkarten von Kalimdor für Polestars Pfeil, aus Leffes Navigationskarten. Wird auf diesem Kontinent bei Bedarf geladen.",
			"Mapas a pie de Kalimdor para la flecha de Polestar, a partir de los mapas de navegación de Leffe. Se carga bajo demanda en ese continente.",
			"Mapas a pie de Kalimdor para la flecha de Polestar, a partir de los mapas de navegación de Leffe. Se carga bajo demanda en ese continente.",
			"Cartes de marche de Kalimdor pour la flèche de Polestar, tirées des cartes de navigation de Leffe. Chargé à la demande sur ce continent.",
			"Polestar 화살표용 칼림도어 도보 지도. Leffe의 길찾기 지도에서 만들었습니다. 그 대륙에서 필요할 때 불러옵니다.",
			"Mapas a pé de Kalimdor para a seta do Polestar, a partir dos mapas de navegação do Leffe. Carregado sob demanda nesse continente.",
			"Пешие карты Калимдора для стрелки Polestar, из навигационных карт Leffe. Загружается по требованию на этом континенте.",
			"Polestar 箭头使用的卡利姆多步行地图，来自 Leffe 的导航地图。在该大陆上按需加载。",
			"Polestar 箭頭使用的卡林多步行地圖，來自 Leffe 的導航地圖。在該大陸上按需載入。",
		],
	),
	(
		"Polestar_Options",
		["Polestar-Einstellungen", "Polestar: configuración", "Polestar: configuración", "Polestar : réglages", "Polestar 설정", "Polestar: configurações", "Polestar: настройки", "Polestar 设置", "Polestar 設定"],
		[
			"Teil von Polestar: das Einstellungsfenster, seine Darstellungsseiten und ihre Vorschauen. Wird geladen, wenn du die Einstellungen öffnest.",
			"Parte de Polestar: la ventana de configuración, sus páginas de aspecto y sus vistas previas. Se carga al abrir la configuración.",
			"Parte de Polestar: la ventana de configuración, sus páginas de aspecto y sus vistas previas. Se carga al abrir la configuración.",
			"Fait partie de Polestar : la fenêtre des réglages, ses pages d'apparence et leurs aperçus. Chargé à l'ouverture des réglages.",
			"Polestar의 일부: 설정 창과 모양 페이지, 그 미리 보기. 설정을 열 때 불러옵니다.",
			"Parte do Polestar: a janela de configurações, suas páginas de aparência e as prévias delas. Carregado ao abrir as configurações.",
			"Часть Polestar: окно настроек, его страницы оформления и их предпросмотр. Загружается при открытии настроек.",
			"Polestar 的组成部分：设置窗口、外观页面及其预览。打开设置时加载。",
			"Polestar 的一部分：設定視窗、外觀頁面及其預覽。開啟設定時載入。",
		],
	),
	// The quest-log modes (#3701): Free mode and the finished-quest guide's planner, loaded when one opens.
	(
		"Polestar_FreeMode",
		["Polestar-Freimodus", "Polestar: modo libre", "Polestar: modo libre", "Polestar : mode libre", "Polestar 자유 모드", "Polestar: modo livre", "Polestar: свободный режим", "Polestar 自由模式", "Polestar 自由模式"],
		[
			"Teil von Polestar: der Freimodus, deine eigenen Quests als Guide, und der Guide zum Abgeben erledigter Quests. Wird geladen, wenn einer davon geöffnet wird.",
			"Parte de Polestar: el modo libre, tus propias misiones como guía, y la guía para entregar tus misiones completadas. Se carga al abrir uno de ellos.",
			"Parte de Polestar: el modo libre, tus propias misiones como guía, y la guía para entregar tus misiones terminadas. Se carga al abrir uno de ellos.",
			"Fait partie de Polestar : le mode libre, vos propres quêtes comme guide, et le guide pour rendre vos quêtes terminées. Chargé à l'ouverture de l'un d'eux.",
			"Polestar의 일부: 자유 모드(내가 받은 퀘스트를 가이드로)와 완료한 퀘스트 제출 가이드. 둘 중 하나를 열 때 불러옵니다.",
			"Parte do Polestar: o modo livre, suas próprias missões como guia, e o guia para entregar suas missões concluídas. Carregado ao abrir um deles.",
			"Часть Polestar: свободный режим, ваши собственные задания как гайд, и гайд для сдачи выполненных заданий. Загружается при открытии одного из них.",
			"Polestar 的组成部分：自由模式（把你自己的任务当作指南）和交还已完成任务的指南。打开其中之一时加载。",
			"Polestar 的一部分：自由模式（把你自己的任務當作指南）和繳交已完成任務的指南。開啟其中之一時載入。",
		],
	),
	// Polestar's ten skins and the Atlas layout (one folder since 0.4.3, #3507): loaded with the first one used or
	// listed.
	(
		"Polestar_Skins",
		["Polestar-Skins", "Polestar: aspectos", "Polestar: aspectos", "Polestar : skins", "Polestar 스킨", "Polestar: aparências", "Polestar: облики", "Polestar 皮肤", "Polestar 外觀主題"],
		[
			"Teil von Polestar: seine zehn Skins und das Atlas-Layout. Wird geladen, wenn du einen davon verwendest oder die Einstellungen sie auflisten.",
			"Parte de Polestar: sus diez aspectos y el diseño Atlas. Se carga al usar uno de ellos o cuando la configuración los muestra.",
			"Parte de Polestar: sus diez aspectos y el diseño Atlas. Se carga al usar uno de ellos o cuando la configuración los muestra.",
			"Fait partie de Polestar : ses dix skins et la disposition Atlas. Chargé quand vous en utilisez un ou quand les réglages les affichent.",
			"Polestar의 일부: 스킨 열 가지와 Atlas 레이아웃. 그중 하나를 쓰거나 설정에서 목록을 보일 때 불러옵니다.",
			"Parte do Polestar: suas dez aparências e o layout Atlas. Carregado ao usar uma delas ou quando as configurações as mostram.",
			"Часть Polestar: его десять обликов и макет Atlas. Загружается, когда выбран один из них или когда настройки показывают их список.",
			"Polestar 的组成部分：十款皮肤和 Atlas 布局。使用其中之一或在设置中列出它们时加载。",
			"Polestar 的一部分：十款外觀主題與 Atlas 版面。使用其中之一或在設定中列出它們時載入。",
		],
	),
	(
		"Polestar_QuestDB",
		["Polestar Quest-Datenbank", "Polestar: base de datos de misiones", "Polestar: base de datos de misiones", "Polestar : base de données des quêtes", "Polestar 퀘스트 데이터베이스", "Polestar: banco de dados de missões", "Polestar: база заданий", "Polestar 任务数据库", "Polestar 任務資料庫"],
		[
			"Quest-, NPC-, Objekt- und Gegenstandsdaten für Polestars Questmarkierungen und Tooltips. Wird bei Bedarf geladen.",
			"Datos de misiones, PNJ y objetos para los marcadores de misión y las descripciones emergentes de Polestar. Se carga bajo demanda.",
			"Datos de misiones, PNJ y objetos para los marcadores de misión y las descripciones emergentes de Polestar. Se carga bajo demanda.",
			"Données des quêtes, PNJ et objets pour les marqueurs de quête et les infobulles de Polestar. Chargé à la demande.",
			"Polestar 퀘스트 표시와 툴팁에 쓰는 퀘스트, NPC, 물체, 아이템 데이터. 필요할 때 불러옵니다.",
			"Dados de missões, PNJs, objetos e itens para os marcadores de missão e as dicas do Polestar. Carregado sob demanda.",
			"Данные заданий, NPC, объектов и предметов для меток заданий и подсказок Polestar. Загружается по требованию.",
			"Polestar 任务标记和鼠标提示所用的任务、NPC、物体和物品数据。按需加载。",
			"Polestar 任務標記與滑鼠提示所用的任務、NPC、物件與物品資料。按需載入。",
		],
	),
	(
		"Polestar_Recorder",
		["Polestar Recorder", "Polestar Recorder", "Polestar Recorder", "Polestar : enregistreur", "Polestar 기록기", "Polestar: gravador", "Polestar: запись", "Polestar 记录器", "Polestar 記錄器"],
		[
			"Zeichnet beim Spielen Quests, Wege und Weltdaten auf, um Polestar-Guides zu schreiben. /psrec",
			"Graba misiones, rutas y datos del mundo mientras juegas, para crear guías de Polestar. /psrec",
			"Graba misiones, rutas y datos del mundo mientras juegas, para crear guías de Polestar. /psrec",
			"Enregistre les quêtes, les trajets et les données du monde pendant que vous jouez, pour écrire des guides Polestar. /psrec",
			"플레이하는 동안 퀘스트, 경로, 월드 데이터를 기록해 Polestar 가이드 작성에 씁니다. /psrec",
			"Grava missões, rotas e dados do mundo enquanto você joga, para criar guias do Polestar. /psrec",
			"Записывает задания, маршруты и данные мира во время игры, для создания гайдов Polestar. /psrec",
			"在游戏时记录任务、路线和世界数据，用于编写 Polestar 指南。/psrec",
			"在遊戲時記錄任務、路線與世界資料，用於撰寫 Polestar 指南。/psrec",
		],
	),
	// The games to play on a flight (Maps/Arcade.lua): loaded the first time Play is pressed.
	(
		"Polestar_Arcade",
		["Polestar Arcade", "Polestar: arcade", "Polestar: arcade", "Polestar : arcade", "Polestar 아케이드", "Polestar: arcade", "Polestar: аркада", "Polestar 街机", "Polestar 街機"],
		[
			"Teil von Polestar: Spiele zum Spielen während eines Flugs. Wird geladen, wenn du auf Spielen klickst.",
			"Parte de Polestar: juegos para jugar durante un vuelo. Se carga cuando pulsas Jugar.",
			"Parte de Polestar: juegos para jugar durante un vuelo. Se carga cuando pulsas Jugar.",
			"Fait partie de Polestar : des jeux à jouer pendant un vol. Chargé quand vous cliquez sur Jouer.",
			"Polestar의 일부: 비행 중에 즐기는 게임. 플레이를 누르면 불러옵니다.",
			"Parte do Polestar: jogos para jogar durante um voo. Carregado quando você clica em Jogar.",
			"Часть Polestar: игры, чтобы поиграть в полёте. Загружается, когда вы нажимаете «Играть».",
			"Polestar 的组成部分：飞行途中可玩的游戏。点击“开始游戏”时加载。",
			"Polestar 的一部分：飛行途中可玩的遊戲。點擊「開始遊戲」時載入。",
		],
	),
	// The Skin API's example (docs/SKINS-API.md): in the repository only, never in a release.
	(
		"Polestar_Skin_Example",
		["Polestar: Design-Beispiel", "Polestar: tema de ejemplo", "Polestar: tema de ejemplo", "Polestar : habillage d'exemple", "Polestar 스킨 예제", "Polestar: tema de exemplo", "Polestar: пример оформления", "Polestar 皮肤示例", "Polestar 皮膚範例"],
		[
			"Ein Beispiel-Design für Polestar (Moonlit) für Design-Autoren. Nicht Teil von Polestars Veröffentlichung.",
			"Un tema de ejemplo para Polestar (Moonlit), para autores de temas. No forma parte de la versión de Polestar.",
			"Un tema de ejemplo para Polestar (Moonlit), para autores de temas. No forma parte de la versión de Polestar.",
			"Un habillage d'exemple pour Polestar (Moonlit), pour les auteurs d'habillages. Ne fait pas partie de la version publiée de Polestar.",
			"스킨 제작자를 위한 Polestar 예제 스킨(Moonlit). Polestar 배포판에는 포함되지 않습니다.",
			"Um tema de exemplo para o Polestar (Moonlit), para autores de temas. Não faz parte da versão do Polestar.",
			"Пример оформления для Polestar (Moonlit) для авторов оформлений. Не входит в выпуск Polestar.",
			"供皮肤作者参考的 Polestar 示例皮肤（Moonlit）。不属于 Polestar 的发行版。",
			"供皮膚作者參考的 Polestar 範例皮膚（Moonlit）。不屬於 Polestar 的發行版本。",
		],
	),
];

/// The per-language folders: (prefix, [(title, notes)] in LOCALE_CODES order), %1 the locale code, %2 the
/// folder's language in this language. Polestar_<locale> holds our guides' texts and the game's names in
/// that language (`language_addon`).
static PER_LANGUAGE: &[(&str, [(&str, &str); 9])] = &[(
	LANGUAGE_PREFIX,
	[
		(
			"Polestar - %2",
			"Guide-Texte und Spielnamen für Polestar (Quests, NPCs, Objekte, Gegenstände, Instanzen und mehr). Sprache: %2. Wird bei Bedarf geladen, nur in einem Client dieser Sprache.",
		),
		("Polestar - %2", "Textos de las guías y nombres del juego para Polestar (misiones, PNJ, objetos, instancias y más). Idioma: %2. Se carga bajo demanda solo en un cliente en ese idioma."),
		("Polestar - %2", "Textos de las guías y nombres del juego para Polestar (misiones, PNJ, objetos, instancias y más). Idioma: %2. Se carga bajo demanda solo en un cliente en ese idioma."),
		("Polestar - %2", "Textes des guides et noms du jeu pour Polestar (quêtes, PNJ, objets, instances et plus). Langue : %2. Chargé à la demande, uniquement sur un client dans cette langue."),
		("Polestar - %2", "Polestar 가이드 텍스트와 게임 이름(퀘스트, NPC, 물체, 아이템, 인스턴스 등). 언어: %2. 해당 언어 클라이언트에서만 필요할 때 불러옵니다."),
		("Polestar - %2", "Textos dos guias e nomes do jogo para o Polestar (missões, PNJs, objetos, itens, instâncias e mais). Idioma: %2. Carregado sob demanda, só em um cliente nesse idioma."),
		("Polestar - %2", "Тексты гайдов и названия из игры для Polestar (задания, NPC, объекты, предметы, подземелья и другое). Язык: %2. Загружается по требованию, только в клиенте на этом языке."),
		("Polestar - %2", "Polestar 的指南文本和游戏名称（任务、NPC、物体、物品、副本等）。语言：%2。仅在该语言的客户端中按需加载。"),
		("Polestar - %2", "Polestar 的指南文字與遊戲名稱（任務、NPC、物件、物品、副本等）。語言：%2。僅在該語言的用戶端中按需載入。"),
	],
)];

/// What a language folder's name starts with: Polestar_<locale>.
pub const LANGUAGE_PREFIX: &str = "Polestar_";

/// The language folder of `locale` (docs/ARCHITECTURE.md, "Localisation", "Names" and "Guide texts"):
/// Polestar's interface strings (Interface.lua, `forge i18n sync`), our guides' texts (Texts.lua,
/// `forge guide compile`) and the game's names (Names.lua, `forge data names`) in that language, in one
/// load-on-demand addon that Core/Locale.lua loads on a client in that language.
pub fn language_addon(locale: &str) -> String {
	format!("{LANGUAGE_PREFIX}{locale}")
}

/// The folders the language folders replaced (0.3.0): Polestar_Guides_<locale> and
/// Polestar_Names_<locale>. Polestar never loads them, and a release never ships them.
pub fn retired_language_addons(locale: &str) -> [String; 2] {
	[format!("Polestar_Guides_{locale}"), format!("Polestar_Names_{locale}")]
}

/// The language folder's interface strings (`forge i18n sync` and the translators): never written or
/// removed by `forge guide compile`, `forge data names` or `forge data subzones`.
pub const INTERFACE_FILE: &str = "Interface.lua";

/// The language folder's files, in load order: every writer of the folder lists all four.
pub const LANGUAGE_FILES: [&str; 4] = [INTERFACE_FILE, "Names.lua", "Subzones.lua", "Texts.lua"];

/// <Polestar_<locale>>.toc, written whole and alike by `forge guide compile` (Texts.lua), `forge data
/// names` (Names.lua) and `forge data subzones` (Subzones.lua), so any may run first. `version`: the
/// release's.
pub fn language_toc(locale: &str, iface: &str, version: &str) -> String {
	let language = crate::locales::language(locale);
	let name = language_addon(locale);
	let mut lines = vec![
		format!("## Interface: {iface}"),
		format!("## Title: Polestar - {language}"),
		format!("## Notes: Guide texts and the game's names (quests, NPCs, objects, items, instances and more) in {language} for Polestar. Loaded on demand on a {language} client."),
	];
	lines.extend(toc_lines(&name));
	lines.extend([
		"## Author: Polestar".to_string(),
		format!("## Version: {version}"),
		"## Category: Polestar".into(),
		"## Group: Polestar".into(),
		"## LoadOnDemand: 1".into(),
		"## Dependencies: Polestar".into(),
		"## X-Polestar-Texts: guides".into(),
		format!("## X-Polestar-Locale: {locale}"),
		"## X-License: GPL-3.0-only".into(),
		format!("# {} (Texts.lua), `forge data names` (Names.lua) and `forge data subzones` (Subzones.lua). Do not edit: rebuild with those commands.", crate::format::GENERATED_MARKER),
		String::new(),
	]);
	lines.extend(LANGUAGE_FILES.map(String::from));
	format!("{}\n", lines.join("\n"))
}

/// Each language's name in each language: LANGUAGE_NAMES[in][of], both in LOCALE_CODES order.
static LANGUAGE_NAMES: [[&str; 9]; 9] = [
	["Deutsch", "Spanisch (Spanien)", "Spanisch (Lateinamerika)", "Französisch", "Koreanisch", "Portugiesisch (Brasilien)", "Russisch", "Chinesisch (vereinfacht)", "Chinesisch (traditionell)"],
	["alemán", "español (España)", "español (Latinoamérica)", "francés", "coreano", "portugués (Brasil)", "ruso", "chino (simplificado)", "chino (tradicional)"],
	["alemán", "español (España)", "español (Latinoamérica)", "francés", "coreano", "portugués (Brasil)", "ruso", "chino (simplificado)", "chino (tradicional)"],
	["allemand", "espagnol (Espagne)", "espagnol (Amérique latine)", "français", "coréen", "portugais (Brésil)", "russe", "chinois (simplifié)", "chinois (traditionnel)"],
	["독일어", "스페인어(스페인)", "스페인어(중남미)", "프랑스어", "한국어", "포르투갈어(브라질)", "러시아어", "중국어(간체)", "중국어(번체)"],
	["alemão", "espanhol (Espanha)", "espanhol (América Latina)", "francês", "coreano", "português (Brasil)", "russo", "chinês (simplificado)", "chinês (tradicional)"],
	["немецкий", "испанский (Испания)", "испанский (Латинская Америка)", "французский", "корейский", "португальский (Бразилия)", "русский", "китайский (упрощенный)", "китайский (традиционный)"],
	["德语", "西班牙语（西班牙）", "西班牙语（拉丁美洲）", "法语", "韩语", "葡萄牙语（巴西）", "俄语", "简体中文", "繁体中文"],
	["德語", "西班牙語（西班牙）", "西班牙語（拉丁美洲）", "法語", "韓語", "葡萄牙語（巴西）", "俄語", "簡體中文", "繁體中文"],
];

/// TOC_ADDONS: the addons with fixed texts, in order.
pub fn toc_addons() -> Vec<&'static str> {
	TEXT.iter().map(|t| t.0).collect()
}

/// addon -> [(locale, title, notes)] in LOCALE_CODES order.
pub fn toc_text(addon: &str) -> Result<Vec<(&'static str, String, String)>, String> {
	if let Some((_, titles, notes)) = TEXT.iter().find(|t| t.0 == addon) {
		return Ok(LOCALE_CODES.iter().enumerate().map(|(i, l)| (*l, titles[i].to_string(), notes[i].to_string())).collect());
	}
	for (prefix, templates) in PER_LANGUAGE {
		let Some(pack) = addon.strip_prefix(prefix) else { continue };
		let Some(pi) = LOCALE_CODES.iter().position(|l| *l == pack) else { break };
		let fill = |s: &str, li: usize| s.replacen("%1", pack, 1).replacen("%2", LANGUAGE_NAMES[li][pi], 1);
		return Ok(LOCALE_CODES.iter().enumerate().map(|(i, l)| (*l, fill(templates[i].0, i), fill(templates[i].1, i))).collect());
	}
	Err(format!("no AddOns-list translations for {addon} (tools/lib/i18n/toc.js)"))
}

/// Panics (as the JS throws) for an addon without translations.
pub fn toc_lines(addon: &str) -> Vec<String> {
	let text = toc_text(addon).unwrap_or_else(|e| panic!("{e}"));
	let mut out = Vec::new();
	for (l, title, notes) in text {
		out.push(format!("## Title-{l}: {title}"));
		out.push(format!("## Notes-{l}: {notes}"));
	}
	out
}
