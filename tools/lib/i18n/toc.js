'use strict';
// The game's AddOns list shows each addon's `## Title` and `## Notes`, and in
// a client language the `## Title-<locale>` and `## Notes-<locale>` beside
// them. These are the translations of every Polestar addon's, written once
// here (AI translations, glossary: tools/lib/i18n/glossary; Polestar, Codex
// and the names of people and projects are kept as they are).
//
//   tocLines(addon) -> ['## Title-deDE: ...', '## Notes-deDE: ...', ...]
//     for every locale (LOCALE_CODES order). addon: the folder name;
//     Polestar_Names_<locale> and Polestar_Guides_<locale> (the per-language
//     packs) name their own language.
// The TOCs in the repository carry these lines as they are; the generated
// ones (Codex, QuestDB, ItemDB, Guides, the names packs) get them from their
// builders. tests/i18n-toc.test.js checks every TOC under addon/.

const { LOCALE_CODES } = require('./locales');

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
};

// The per-language packs: { title, notes } templates, %1 the locale code,
// %2 the pack's language in this language.
const PER_LANGUAGE = {
	Polestar_Names_: {
		deDE: ['Polestar Namen (%1)', 'Spielnamen für Polestar (Quests, NPCs, Objekte, Gegenstände, Instanzen und mehr). Sprache: %2. Wird bei Bedarf geladen, nur in einem Client dieser Sprache.'],
		esES: ['Polestar: nombres (%1)', 'Nombres del juego para Polestar (misiones, PNJ, objetos, instancias y más). Idioma: %2. Se carga bajo demanda solo en un cliente en ese idioma.'],
		esMX: ['Polestar: nombres (%1)', 'Nombres del juego para Polestar (misiones, PNJ, objetos, instancias y más). Idioma: %2. Se carga bajo demanda solo en un cliente en ese idioma.'],
		frFR: ['Polestar : noms (%1)', 'Noms du jeu pour Polestar (quêtes, PNJ, objets, instances et plus). Langue : %2. Chargé à la demande, uniquement sur un client dans cette langue.'],
		koKR: ['Polestar 이름 (%1)', 'Polestar용 게임 이름(퀘스트, NPC, 물체, 아이템, 인스턴스 등). 언어: %2. 해당 언어 클라이언트에서만 필요할 때 불러옵니다.'],
		ptBR: ['Polestar: nomes (%1)', 'Nomes do jogo para o Polestar (missões, PNJs, objetos, itens, instâncias e mais). Idioma: %2. Carregado sob demanda, só em um cliente nesse idioma.'],
		ruRU: ['Polestar: названия (%1)', 'Названия из игры для Polestar (задания, NPC, объекты, предметы, подземелья и другое). Язык: %2. Загружается по требованию, только в клиенте на этом языке.'],
		zhCN: ['Polestar 名称 (%1)', 'Polestar 使用的游戏名称（任务、NPC、物体、物品、副本等）。语言：%2。仅在该语言的客户端中按需加载。'],
		zhTW: ['Polestar 名稱 (%1)', 'Polestar 使用的遊戲名稱（任務、NPC、物件、物品、副本等）。語言：%2。僅在該語言的用戶端中按需載入。'],
	},
	Polestar_Guides_: {
		deDE: ['Polestar Guides (%1)', 'Guide-Texte für Polestar. Sprache: %2. Wird bei Bedarf geladen, nur in einem Client dieser Sprache.'],
		esES: ['Polestar: guías (%1)', 'Textos de las guías de Polestar. Idioma: %2. Se carga bajo demanda solo en un cliente en ese idioma.'],
		esMX: ['Polestar: guías (%1)', 'Textos de las guías de Polestar. Idioma: %2. Se carga bajo demanda solo en un cliente en ese idioma.'],
		frFR: ['Polestar : guides (%1)', 'Textes des guides de Polestar. Langue : %2. Chargé à la demande, uniquement sur un client dans cette langue.'],
		koKR: ['Polestar 가이드 (%1)', 'Polestar 가이드 텍스트. 언어: %2. 해당 언어 클라이언트에서만 필요할 때 불러옵니다.'],
		ptBR: ['Polestar: guias (%1)', 'Textos dos guias do Polestar. Idioma: %2. Carregado sob demanda, só em um cliente nesse idioma.'],
		ruRU: ['Polestar: гайды (%1)', 'Тексты гайдов Polestar. Язык: %2. Загружается по требованию, только в клиенте на этом языке.'],
		zhCN: ['Polestar 指南 (%1)', 'Polestar 指南文本。语言：%2。仅在该语言的客户端中按需加载。'],
		zhTW: ['Polestar 指南 (%1)', 'Polestar 指南文字。語言：%2。僅在該語言的用戶端中按需載入。'],
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

// addon -> { [locale]: { title, notes } }
function tocText(addon) {
	const fixed = TEXT[addon];
	if (fixed) return Object.fromEntries(LOCALE_CODES.map((l) => [l, { title: fixed.title[l], notes: fixed.notes[l] }]));
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

module.exports = { tocText, tocLines, TOC_ADDONS: Object.keys(TEXT) };
