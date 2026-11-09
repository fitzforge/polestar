// The playground page: draws the frames the server renders, turns the mouse
// and keyboard on the game screen into client input (hit-tested here with
// hit.js, so only a change of mouse focus goes to the server), and drives the
// control panel. Every request returns the next frame.
(function () {
	'use strict';
	const { hitTest, toScreen } = window.PolestarHit;
	const $ = (sel, el = document) => el.querySelector(sel);
	const $$ = (sel, el = document) => [...el.querySelectorAll(sel)];

	let meta = null;
	let state = null;
	let hits = [];
	let glyphCount = 0;
	let hoverId = null;
	let guides = [];
	let screenSize = { w: 1920, h: 1080 };
	const screen = $('#screen');
	const ui = $('#ui');
	const defs = $('#glyph-defs');

	// -------------------------------------------------------------------------
	// Requests: one at a time; hover, drag moves and slider settings coalesce.

	const queue = [];
	let inflight = false;
	const COALESCE = new Set(['hover', 'dragMove', 'leave']);

	async function post(url, body) {
		const res = await fetch(url, { method: 'POST', headers: { 'content-type': 'application/json' }, body: JSON.stringify(body || {}) });
		const data = await res.json();
		if (!res.ok) throw new Error(data.error || res.statusText);
		return data;
	}

	function act(action) {
		return new Promise((resolve) => {
			const last = queue[queue.length - 1];
			const same = last && last.action.type === action.type
				&& (COALESCE.has(action.type) || (action.type === 'set' && last.action.path === action.path));
			if (same) {
				last.action = action;
				last.waiters.push(resolve);
			} else {
				queue.push({ action, waiters: [resolve] });
			}
			pump();
		});
	}

	function call(url, body) {
		return new Promise((resolve) => {
			queue.push({ url, body, waiters: [resolve] });
			pump();
		});
	}

	// Texture crops the page has decoded: a frame is swapped in once its new
	// ones are ready (or after a short wait), so the screen never flashes
	// without its icons.
	const decoded = new Set();
	function preload(svgText) {
		const waits = [];
		for (const m of svgText.matchAll(/href="(\/(?:tex|zoneart)\/[^"]+)"/g)) {
			const url = m[1];
			if (decoded.has(url)) continue;
			decoded.add(url);
			const img = new Image();
			img.src = url;
			waits.push(img.decode().catch(() => {}));
		}
		if (!waits.length) return null;
		return Promise.race([Promise.all(waits), new Promise((r) => setTimeout(r, 400))]);
	}

	async function pump() {
		if (inflight || !queue.length) return;
		inflight = true;
		const item = queue.shift();
		const t0 = performance.now();
		let frame = null;
		try {
			frame = item.url ? await post(item.url, { ...item.body, known: glyphCount }) : await post('/api/act', { action: item.action, known: glyphCount });
			const loading = frame && frame.svg ? preload(frame.svg) : null;
			if (loading) await loading;
			apply(frame, performance.now() - t0, item.action || { type: item.url });
		} catch (err) {
			showNotice(`The playground server did not answer: ${err.message}`, true);
		}
		inflight = false;
		for (const w of item.waiters) w(frame);
		pump();
	}

	// -------------------------------------------------------------------------
	// A frame

	function apply(frame, rtt, action) {
		if (!frame || !frame.svg) {
			if (frame && frame.error) showNotice(frame.error, true);
			return;
		}
		if (frame.glyphBase !== 0 && frame.glyphCount < glyphCount) {
			// The server started over: fetch every glyph again.
			defs.innerHTML = '';
			glyphCount = 0;
			act({ type: 'render' });
			return;
		}
		if (frame.glyphBase === 0) {
			defs.innerHTML = '';
			glyphCount = 0;
		}
		if (frame.glyphs && frame.glyphs.length) {
			defs.insertAdjacentHTML('beforeend', frame.glyphs.join(''));
			glyphCount += frame.glyphs.length;
		}
		ui.innerHTML = frame.svg;
		hits = frame.hits || [];
		state = frame.state;
		showTiming(frame.timing, rtt, action);
		if (frame.errors && frame.errors.length) showErrors(frame.errors);
		if (frame.notice) showNotice(frame.notice, /stopped|crash/i.test(frame.notice));
		if (frame.actionError) showNotice(`That did not run: ${frame.actionError.split('\n')[0]}`, true);
		if (frame.result && typeof frame.result === 'string') reportResult(action, frame.result);
		syncPanel();
		syncWorld();
		syncChat();
		syncPopups();
		refreshCursor();
	}

	function showTiming(t, rtt, action) {
		if (!t) return;
		const total = t.total.toFixed(0);
		const slow = t.total > 150 ? ' class="slow"' : '';
		$('#timing').innerHTML = `${action.type || 'frame'}: <strong${slow}>${total} ms</strong> on the server (Lua ${t.lua.toFixed(0)} ms, drawing ${t.render.toFixed(0)} ms), ${rtt.toFixed(0)} ms round trip`;
	}

	let noticeTimer = null;
	function showNotice(text, bad = false) {
		const n = $('#notice');
		n.textContent = text;
		n.classList.toggle('bad', !!bad);
		n.hidden = false;
		clearTimeout(noticeTimer);
		noticeTimer = setTimeout(() => { n.hidden = true; }, bad ? 9000 : 4000);
	}

	const RESULTS = {
		stuck: 'That goal could not be completed by the simulator; complete it by hand or skip the step.',
		noguide: 'No guide is loaded.',
		none: 'No guide with a route choice fits this character.',
		limit: 'Stopped after many goals; press again to go on.',
	};
	function reportResult(action, result) {
		if (RESULTS[result]) showNotice(RESULTS[result], result !== 'limit');
		else if (action.type === 'guide' || (action.type === 'state' && action.state === 'route')) {
			if (result === 'complete') showNotice('Guide played to its end.');
		}
	}

	function showErrors(list) {
		const box = $('#errors');
		const ol = $('#error-list');
		for (const e of list) {
			const li = document.createElement('li');
			li.textContent = e.msg;
			const pre = document.createElement('pre');
			pre.textContent = (e.trace || '').trim();
			li.append(pre);
			ol.append(li);
		}
		while (ol.children.length > 20) ol.firstChild.remove();
		box.hidden = false;
	}
	$('#errors-clear').addEventListener('click', () => {
		$('#error-list').innerHTML = '';
		$('#errors').hidden = true;
	});

	// -------------------------------------------------------------------------
	// Text with the client's colour codes

	function escapeHtml(s) {
		return String(s).replace(/[&<>"]/g, (c) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' })[c]);
	}
	function colourCodes(s) {
		let out = '', open = 0;
		const parts = String(s).replace(/\|\|/g, '\u0001').split(/(\|c[0-9a-fA-F]{8}|\|r|\|T[^|]*\|t|\|H[^|]*\|h|\|h)/);
		for (const p of parts) {
			if (/^\|c/.test(p)) { out += `<span style="color:#${p.slice(4, 10)}">`; open++; }
			else if (p === '|r') { if (open) { out += '</span>'; open--; } }
			else if (/^\|[TtHh]/.test(p)) continue;
			else out += escapeHtml(p.replace(/\u0001/g, '|'));
		}
		return out + '</span>'.repeat(open);
	}

	function syncChat() {
		const chat = $('#chat');
		const lines = (state.chat || []).slice(-10);
		chat.innerHTML = lines.map((l) => `<p>${colourCodes(l)}</p>`).join('');
	}

	function syncPopups() {
		const box = $('#popups');
		box.innerHTML = '';
		(state.popups || []).forEach((p, i) => {
			const d = document.createElement('div');
			d.className = 'popup';
			d.innerHTML = `<p>${colourCodes(p.text)}</p>`;
			const yes = document.createElement('button');
			yes.textContent = p.accept || 'Okay';
			yes.addEventListener('click', () => act({ type: 'popup', index: i + 1, choice: 'accept' }));
			d.append(yes);
			if (p.cancel) {
				const no = document.createElement('button');
				no.textContent = p.cancel;
				no.addEventListener('click', () => act({ type: 'popup', index: i + 1, choice: 'cancel' }));
				d.append(no);
			}
			box.append(d);
		});
	}

	// The world behind the UI: the zone's painting when the art cache has it.
	let worldMap = null;
	function syncWorld() {
		const map = state.player.map;
		if (map === worldMap) return;
		worldMap = map;
		const zone = meta.zones.find((z) => z.id === map);
		$('#world').style.backgroundImage = zone && zone.art ? `url(/zoneart/${map}.png)` : '';
	}

	// -------------------------------------------------------------------------
	// Input on the game screen

	let down = null; // { id, button, x, y, dragging }
	let focusPending = false; // a click on an edit box is on its way
	const pendingFocus = () => focusPending;
	function point(e) {
		return toScreen(screen.getBoundingClientRect(), screenSize, e.clientX, e.clientY);
	}

	function refreshCursor() {
		const h = hoverId != null ? hits.find((x) => x.id === hoverId) : null;
		screen.classList.toggle('pointer', !!h && (h.k === 'Button' || h.k === 'CheckButton') && !h.x);
		screen.classList.toggle('text', !!h && h.k === 'EditBox');
		screen.classList.toggle('grab', !!(down && down.dragging));
	}

	screen.addEventListener('mousemove', (e) => {
		const p = point(e);
		if (down) {
			if (!down.dragging && Math.hypot(p.x - down.x, p.y - down.y) * p.scale > 4) {
				down.dragging = true;
				act({ type: 'dragStart', id: down.id, button: down.button, x: p.x, y: p.y, x0: down.x, y0: down.y });
			} else if (down.dragging) {
				act({ type: 'dragMove', x: p.x, y: p.y });
			}
			refreshCursor();
			return;
		}
		const h = hitTest(hits, p.x, p.y, 'm');
		const id = h ? h.id : null;
		if (id !== hoverId) {
			hoverId = id;
			act({ type: 'hover', id, x: p.x, y: p.y });
			refreshCursor();
		}
	});
	screen.addEventListener('mouseleave', () => {
		if (down) return;
		hoverId = null;
		act({ type: 'leave' });
		refreshCursor();
	});
	screen.addEventListener('contextmenu', (e) => e.preventDefault());
	screen.addEventListener('mousedown', (e) => {
		if (e.button !== 0 && e.button !== 2) return;
		e.preventDefault();
		screen.focus();
		const p = point(e);
		const h = hitTest(hits, p.x, p.y, 'm');
		down = { id: h ? h.id : null, button: e.button === 2 ? 'RightButton' : 'LeftButton', x: p.x, y: p.y, dragging: false };
	});
	window.addEventListener('mouseup', (e) => {
		if (!down) return;
		const p = point(e);
		const d = down;
		down = null;
		if (d.dragging) act({ type: 'dragStop', x: p.x, y: p.y });
		else {
			const h = hits.find((x) => x.id === d.id);
			focusPending = !!h && h.k === 'EditBox';
			act({ type: 'click', id: d.id, button: d.button, x: d.x, y: d.y }).then(() => { focusPending = false; });
		}
		refreshCursor();
	});
	window.addEventListener('mousemove', (e) => {
		if (down && down.dragging && !screen.contains(e.target)) {
			const p = point(e);
			act({ type: 'dragMove', x: p.x, y: p.y });
		}
	});
	screen.addEventListener('wheel', (e) => {
		e.preventDefault();
		const p = point(e);
		const h = hitTest(hits, p.x, p.y, 'w');
		if (h) act({ type: 'wheel', id: h.id, delta: e.deltaY < 0 ? 1 : -1, x: p.x, y: p.y });
	}, { passive: false });

	const KEYS = { Escape: 'ESCAPE', Enter: 'ENTER', Backspace: 'BACKSPACE', Tab: 'TAB' };
	screen.addEventListener('keydown', (e) => {
		if (e.ctrlKey || e.metaKey || e.altKey) return;
		// Typing goes to the game (an edit box takes it when one has focus; the
		// frame that says so may still be on its way). With nothing focused,
		// "/" and Enter open the chat line, as in game.
		const typing = state && state.focus != null;
		if (!typing && (e.key === '/' || e.key === 'Enter') && !pendingFocus()) {
			e.preventDefault();
			$('#slash-input').focus();
			if (e.key === '/') $('#slash-input').value = '/';
		} else if (KEYS[e.key]) {
			e.preventDefault();
			act({ type: 'key', key: KEYS[e.key] });
		} else if (e.key.length === 1) {
			e.preventDefault();
			act({ type: 'key', key: 'CHAR', text: e.key });
		}
	});

	const fsBtn = $('#fullscreen');
	const game = $('.game');
	fsBtn.addEventListener('click', () => {
		if (document.fullscreenElement) document.exitFullscreen();
		else if (game.requestFullscreen) game.requestFullscreen();
		$('#screen').focus();
	});
	document.addEventListener('fullscreenchange', () => {
		const on = !!document.fullscreenElement;
		fsBtn.textContent = on ? 'Exit full screen' : 'Full screen';
		fsBtn.setAttribute('aria-pressed', String(on));
	});
	$('#slash').addEventListener('submit', async (e) => {
		e.preventDefault();
		const input = $('#slash-input');
		const text = input.value.trim();
		if (!text) return;
		input.value = '';
		if (/^\/reload(ui)?$/i.test(text)) return call('/api/reload');
		if (!text.startsWith('/')) return act({ type: 'slash', text: `/run print(${JSON.stringify(text)})` });
		return act({ type: 'slash', text });
	});

	// -------------------------------------------------------------------------
	// The panel

	const fmt = {
		pct: (v) => `${Math.round(v * 100)}%`,
		int: (v) => String(Math.round(v)),
		signed: (v) => (v > 0 ? `+${v.toFixed(2)}` : v.toFixed(2)),
		upnext: (v) => (Number(v) === 0 ? 'Off' : String(v)),
	};

	function hex(c) {
		if (!Array.isArray(c)) return '#4fd1c5';
		return '#' + c.slice(0, 3).map((v) => Math.round(Math.max(0, Math.min(1, v)) * 255).toString(16).padStart(2, '0')).join('');
	}
	function rgb(h) {
		const n = parseInt(h.slice(1), 16);
		return [((n >> 16) & 255) / 255, ((n >> 8) & 255) / 255, (n & 255) / 255].map((v) => Math.round(v * 1000) / 1000);
	}

	function set(path, value) {
		return act({ type: 'set', path, value });
	}

	// Look controls: bound by data-path.
	for (const input of $$('input[type="range"][data-path]')) {
		const out = input.parentElement.querySelector('output');
		input.addEventListener('input', () => {
			out.textContent = fmt[input.dataset.format](Number(input.value));
			set(input.dataset.path, Number(input.value));
		});
	}
	for (const input of $$('input[type="checkbox"][data-path]')) {
		input.addEventListener('change', () => set(input.dataset.path, input.checked));
	}
	for (const input of $$('input[type="color"][data-path]')) {
		input.addEventListener('input', () => set(input.dataset.path, rgb(input.value)));
	}
	for (const b of $$('button[data-unset]')) b.addEventListener('click', () => set(b.dataset.unset, false));
	document.addEventListener('click', (e) => {
		const b = e.target.closest('.seg[data-path] button');
		if (b) set(b.parentElement.dataset.path, b.value);
	});
	$('#tip-toggle').addEventListener('click', () => act({ type: 'tip' }));
	$('#reset-look').addEventListener('click', () => act({ type: 'resetLook' }));

	function luaLiteral(v) {
		if (v === null || v === undefined) return 'nil';
		if (typeof v === 'string') return JSON.stringify(v);
		if (typeof v !== 'object') return String(v);
		if (Array.isArray(v)) return `{ ${v.map(luaLiteral).join(', ')} }`;
		return `{ ${Object.entries(v).map(([k, x]) => `${/^[A-Za-z_]\w*$/.test(k) ? k : `[${JSON.stringify(k)}]`} = ${luaLiteral(x)}`).join(', ')} }`;
	}
	$('#copy-settings').addEventListener('click', async () => {
		await act({ type: 'render' }); // after every change still on its way
		const changed = (state.changed || []).slice().sort((a, b) => a[0].localeCompare(b[0]));
		let text;
		if (!changed.length) {
			text = '-- Every setting is at its default.';
		} else {
			const run = changed.map(([k, v]) => `/run Polestar.Set(${JSON.stringify(k)}, ${luaLiteral(v)})`);
			const db = changed.map(([k, v]) => `PolestarDB.settings.${k.split('.').map((p) => (/^[A-Za-z_]\w*$/.test(p) ? p : `[${JSON.stringify(p)}]`)).join('.').replace(/\.\[/g, '[')} = ${luaLiteral(v)}`);
			text = ['-- In game: paste each line into chat', ...run, '', '-- As PolestarDB values (WTF/Account/<account>/SavedVariables/Polestar.lua)', ...db].join('\n');
		}
		showCopy('Changed settings', 'Paste the /run lines into chat in game, or set the values in PolestarDB.', text);
	});

	// The copy dialog with its text selected (and on the clipboard when the browser allows).
	async function showCopy(title, lede, text) {
		$('#copy-title').textContent = title;
		$('#copy-lede').textContent = lede;
		$('#copy-text').value = text;
		$('#copy-dialog').showModal();
		$('#copy-text').select();
		try { await navigator.clipboard.writeText(text); } catch { /* the dialog shows it */ }
	}

	// Guide controls
	for (const b of $$('[data-act]')) b.addEventListener('click', () => act({ type: b.dataset.act }));
	for (const b of $$('[data-state]')) b.addEventListener('click', () => act({ type: 'state', state: b.dataset.state }));
	$('#step-prev').addEventListener('click', () => act({ type: 'prevStep' }));
	$('#step-next').addEventListener('click', () => act({ type: 'nextStep' }));
	$('#step-pick').addEventListener('change', (e) => act({ type: 'gotoStep', step: Number(e.target.value) }));
	$('#guide-load').addEventListener('click', () => {
		const id = $('#guide-pick').value;
		if (id) act({ type: 'loadGuide', guide: id });
	});
	// The picked guide as an import string (tools/lib/pack/importstring.js), as `polestar export` prints it.
	$('#guide-export').addEventListener('click', async () => {
		const id = $('#guide-pick').value;
		if (!id) return;
		let r;
		try { r = await post('/api/import', { guide: id }); } catch (err) { r = { error: err.message }; }
		if (r.text) showCopy('Import string', `${id}: paste it on the Import page in game (/polestar import).`, r.text);
		else showCopy('No import string', `${id} cannot go in an import string.`, r.error || 'unknown error');
	});

	// Windows
	document.addEventListener('click', (e) => {
		const b = e.target.closest('[data-open], [data-section], [data-close]');
		if (!b) return;
		if (b.dataset.close) act({ type: 'close' });
		else if (b.dataset.section) act({ type: 'open', what: 'section', arg: b.dataset.section });
		else act({ type: 'open', what: b.dataset.open });
	});

	// Character
	function raceOptions() {
		const faction = $('#ch-faction').value;
		const races = Object.keys(meta.races).filter((r) => meta.races[r][faction]);
		const sel = $('#ch-race');
		const keep = sel.value;
		sel.innerHTML = races.map((r) => `<option value="${r}">${escapeHtml(meta.raceNames[r] || r)}</option>`).join('');
		if (races.includes(keep)) sel.value = keep;
		classOptions();
	}
	function classOptions() {
		const faction = $('#ch-faction').value;
		const race = $('#ch-race').value;
		const classes = (meta.races[race] && meta.races[race][faction] && meta.races[race][faction].classes) || [];
		const sel = $('#ch-class');
		const keep = sel.value;
		sel.innerHTML = classes.map((c) => `<option value="${c}">${escapeHtml(meta.classNames[c] || c)}</option>`).join('');
		if (classes.includes(keep)) sel.value = keep;
	}
	$('#ch-faction').addEventListener('change', raceOptions);
	$('#ch-race').addEventListener('change', classOptions);
	$('#ch-new').addEventListener('click', () => {
		const body = { faction: $('#ch-faction').value, race: $('#ch-race').value, cls: $('#ch-class').value };
		call('/api/character', body).then(loadGuides);
	});
	$('#level-set').addEventListener('click', () => act({ type: 'level', level: Number($('#ch-level').value) }));

	// Position
	const minimap = $('#minimap');
	const artImages = new Map();
	function zoneImage(id) {
		if (!artImages.has(id)) {
			const img = new Image();
			img.onload = () => drawMinimap();
			img.src = `/zoneart/${id}.png`;
			artImages.set(id, img);
		}
		return artImages.get(id);
	}
	function drawMinimap() {
		if (!state) return;
		const ctx = minimap.getContext('2d');
		const W = minimap.width, H = minimap.height;
		const id = Number($('#zone-pick').value) || state.player.map;
		const zone = meta.zones.find((z) => z.id === id);
		ctx.fillStyle = '#1b2230';
		ctx.fillRect(0, 0, W, H);
		const img = zone && zone.art ? zoneImage(id) : null;
		if (img && img.complete && img.naturalWidth) ctx.drawImage(img, 0, 0, W, H);
		else {
			ctx.strokeStyle = 'rgba(255,255,255,0.06)';
			for (let i = 1; i < 10; i++) {
				ctx.beginPath(); ctx.moveTo((i * W) / 10, 0); ctx.lineTo((i * W) / 10, H); ctx.stroke();
				ctx.beginPath(); ctx.moveTo(0, (i * H) / 10); ctx.lineTo(W, (i * H) / 10); ctx.stroke();
			}
			ctx.fillStyle = 'rgba(247,248,253,0.5)';
			ctx.font = '500 13px Inter, sans-serif';
			ctx.fillText(zone ? zone.name : `Map ${id}`, 10, 20);
		}
		const wp = state.waypoint;
		if (wp && wp.map === id && wp.x != null) {
			ctx.strokeStyle = '#ffd25a';
			ctx.lineWidth = 2;
			ctx.beginPath(); ctx.arc((wp.x / 100) * W, (wp.y / 100) * H, 6, 0, Math.PI * 2); ctx.stroke();
		}
		const p = state.player;
		if (p.map === id && p.x != null) {
			ctx.fillStyle = '#4fd1c5';
			ctx.strokeStyle = '#0a0d14';
			ctx.lineWidth = 2;
			ctx.beginPath(); ctx.arc((p.x / 100) * W, (p.y / 100) * H, 5, 0, Math.PI * 2); ctx.fill(); ctx.stroke();
		}
	}
	minimap.addEventListener('click', (e) => {
		const r = minimap.getBoundingClientRect();
		const x = Math.round(((e.clientX - r.left) / r.width) * 1000) / 10;
		const y = Math.round(((e.clientY - r.top) / r.height) * 1000) / 10;
		act({ type: 'move', map: Number($('#zone-pick').value), x, y });
	});
	$('#zone-pick').addEventListener('change', drawMinimap);

	// World
	for (const b of $$('[data-time]')) b.addEventListener('click', () => act({ type: 'time', seconds: Number(b.dataset.time) }));
	$('#q-accept').addEventListener('click', () => {
		const q = Number($('#q-id').value);
		if (q > 0) act({ type: 'quest', op: 'accept', quest: q });
	});
	$('#quests').addEventListener('click', (e) => {
		const b = e.target.closest('button[data-op]');
		if (b) act({ type: 'quest', op: b.dataset.op, quest: Number(b.dataset.quest) });
	});

	// Session
	$('#eui').addEventListener('change', (e) => call('/api/eui', { on: e.target.checked }));
	$('#reload').addEventListener('click', () => call('/api/reload'));
	$('#restart').addEventListener('click', () => call('/api/restart'));

	// -------------------------------------------------------------------------
	// Keeping the panel in step with the session

	function setIfIdle(el, fn) {
		if (document.activeElement !== el) fn();
	}

	let lastSteps = null;
	let lastSections = '';
	function syncPanel() {
		const look = state.look || {};
		for (const input of $$('input[type="range"][data-path]')) {
			setIfIdle(input, () => {
				const v = Number(look[input.dataset.path]);
				input.value = v;
				input.parentElement.querySelector('output').textContent = fmt[input.dataset.format](v);
			});
		}
		for (const input of $$('input[type="checkbox"][data-path]')) input.checked = !!look[input.dataset.path];
		for (const input of $$('input[type="color"][data-path]')) {
			const v = look[input.dataset.path];
			setIfIdle(input, () => { if (Array.isArray(v)) input.value = hex(v); });
			input.parentElement.classList.toggle('unset', !Array.isArray(v));
		}
		const skins = $('#skins');
		const wantSkins = (state.skins || []).join(',');
		if (skins.dataset.list !== wantSkins) {
			skins.dataset.list = wantSkins;
			skins.innerHTML = (state.skins || []).map((s) => `<button type="button" value="${s}">${s}</button>`).join('');
		}
		const schemes = $('#schemes');
		const want = (state.schemes || []).join(',');
		if (schemes.dataset.list !== want) {
			schemes.dataset.list = want;
			schemes.innerHTML = (state.schemes || []).map((s) => `<button type="button" value="${s}">${s === 'ellesmere' ? 'EllesmereUI' : s}</button>`).join('');
		}
		for (const seg of $$('.seg[data-path]')) {
			for (const b of $$('button', seg)) b.setAttribute('aria-pressed', String(look[seg.dataset.path] === b.value));
		}

		// Guide
		const g = state.guide;
		$('#guide-title').textContent = g ? `${g.title}, step ${g.step || '-'} of ${g.count}${g.pending ? ' (route choice waiting)' : ''}` : 'No guide loaded';
		const pick = $('#step-pick');
		const steps = g ? g.id + g.count : null;
		if (steps !== lastSteps) {
			lastSteps = steps;
			pick.innerHTML = g ? g.steps.map((t, i) => `<option value="${i + 1}">${i + 1}. ${escapeHtml(t)}</option>`).join('') : '';
		}
		setIfIdle(pick, () => { if (g && g.step) pick.value = g.step; });
		$('#goals').innerHTML = g && g.goals ? g.goals.map((x) => `<li class="${x.status === 'done' ? 'done' : x.status === 'active' ? 'active' : ''}">${escapeHtml(x.text)}</li>`).join('') : '';
		$('#tip-toggle').disabled = !(g && g.hasTip);
		setIfIdle($('#guide-pick'), () => { if (g && guides.some((x) => x.id === g.id)) $('#guide-pick').value = g.id; });

		// Hub sections
		const sections = (state.sections || []).map((s) => s.key).join(',');
		if (sections !== lastSections) {
			lastSections = sections;
			const box = $('#windows');
			$$('[data-section]', box).forEach((b) => b.remove());
			const after = $('[data-open="hub"]', box);
			for (const s of (state.sections || []).slice().reverse()) {
				const b = document.createElement('button');
				b.type = 'button';
				b.dataset.section = s.key;
				b.textContent = s.label;
				after.after(b);
			}
		}

		// Character
		const p = state.player;
		const raceName = meta.raceNames[p.race] || p.race;
		$('#who').textContent = `Level ${p.level} ${raceName} ${meta.classNames[p.class] || p.class}, ${p.faction}, in ${p.zone || 'the world'}`;
		setIfIdle($('#ch-level'), () => { $('#ch-level').value = p.level; });
		const zp = $('#zone-pick');
		setIfIdle(zp, () => { if (zp.dataset.player !== String(p.map)) { zp.dataset.player = String(p.map); zp.value = p.map; } });
		$('#where').textContent = p.x != null ? `${p.zone}: ${p.x.toFixed(1)}, ${p.y.toFixed(1)}. Click the map to walk there.` : '';
		drawMinimap();

		// Quests
		$('#quests').innerHTML = (state.quests || []).map((q) => {
			const objs = q.objectives.map((o) => `${o[0]}/${o[1]}`).join(', ');
			return `<li><span>${escapeHtml(q.title)}</span><small>${q.id}${objs ? `: ${objs}` : ''}${q.ready ? ', ready to turn in' : ''}</small>
				<span class="q-actions">${q.ready ? '' : `<button type="button" data-op="complete" data-quest="${q.id}">Complete</button>`}<button type="button" data-op="turnin" data-quest="${q.id}">Turn in</button><button type="button" data-op="abandon" data-quest="${q.id}" class="link">Abandon</button></span></li>`;
		}).join('') || '<li><small>The quest log is empty.</small></li>';

		$('#eui').checked = !!state.eui;
	}

	// -------------------------------------------------------------------------
	// Start

	async function loadGuides() {
		guides = await (await fetch('/api/guides')).json();
		const faction = state ? state.player.faction : null;
		const mine = guides.filter((g) => !g.faction || g.faction === faction || g.faction === 'Both');
		const cats = [...new Set(mine.map((g) => g.cat))];
		$('#guide-pick').innerHTML = cats.map((c) => `<optgroup label="${escapeHtml(c)}">${mine.filter((g) => g.cat === c)
			.map((g) => `<option value="${escapeHtml(g.id)}">${escapeHtml(g.title)}${g.lo ? ` (${g.lo}${g.hi && g.hi !== g.lo ? `-${g.hi}` : ''})` : ''}</option>`).join('')}</optgroup>`).join('');
		if (state && state.guide) $('#guide-pick').value = state.guide.id;
	}

	async function start() {
		meta = await (await fetch('/api/meta')).json();
		screenSize = meta.screen;
		if (meta.emblem) $('#emblem').src = meta.emblem;
		if (meta.stars) $('.band').style.backgroundImage = `linear-gradient(rgba(40,50,90,0.55), rgba(40,50,90,0.85)), url(${meta.stars})`;
		$('#zone-pick').innerHTML = meta.zones.map((z) => `<option value="${z.id}">${escapeHtml(z.name)}${z.art ? '' : ''}</option>`).join('');
		const c = meta.config || {};
		const frame = await act({ type: 'render' });
		const p = frame && frame.state ? frame.state.player : {};
		$('#ch-faction').value = p.faction || c.faction || 'Alliance';
		raceOptions();
		$('#ch-race').value = p.race || 'Human';
		classOptions();
		$('#ch-class').value = p.class || 'WARRIOR';
		await loadGuides();
		// The menu and the guide window side by side.
		if (frame && frame.state && !frame.state.hub) act({ type: 'open', what: 'hub', arg: 'side' });
		screen.focus();
		watchVersion(meta.version);
	}

	// `polestar dev` restarts the session after a rebuild: the page asks for the
	// rebuild count every second and redraws (with the new guide list) when it
	// changes, without waiting for a click. `known` is the count /api/meta gave
	// before the first frame, so a rebuild during start-up is not missed.
	function watchVersion(known) {
		setInterval(async () => {
			let version;
			try {
				version = (await (await fetch('/api/version')).json()).version;
			} catch {
				return;
			}
			if (version !== known) {
				act({ type: 'render' });
				loadGuides().catch(() => {});
			}
			known = version;
		}, 1000);
	}
	// For scripted sessions and debugging: the current hit map and state, and
	// where a screen point is on the page.
	window.PolestarPlay = {
		get hits() { return hits; },
		get state() { return state; },
		pageXY(x, y) {
			const r = screen.getBoundingClientRect();
			const s = Math.min(r.width / screenSize.w, r.height / screenSize.h);
			return { x: r.left + (r.width - screenSize.w * s) / 2 + x * s, y: r.top + (r.height - screenSize.h * s) / 2 + y * s };
		},
		act,
	};
	start().catch((err) => showNotice(`Could not start: ${err.message}`, true));
})();
