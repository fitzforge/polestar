<script lang="ts">
	import { onMount, tick } from 'svelte';
	import { api, message } from '../lib/backend';
	import { ltr } from '../lib/format';
	import { CLIENT_URL, CONTRACT_URL, SOURCE_URL } from '../lib/copy';
	import { rise, swap } from '../lib/motion';
	import { toast } from '../lib/toast.svelte';
	import { diagnostics, showFrames } from '../lib/diagnostics.svelte';
	import { intro, setFullIntro } from '../lib/intro.svelte';
	import { chooseLanguage } from '../lib/app.svelte';
	import { LANGUAGES, meta, msg, parts, resolve, t } from '../lib/i18n.svelte';
	import type { Channel, Snapshot } from '../lib/types';
	import PageHeader from '../components/PageHeader.svelte';
	import Glyph from '../components/Glyph.svelte';

	const DISCORD_URL = 'https://discord.gg/polestar';

	let { snapshot }: { snapshot: Snapshot } = $props();

	/** What Automatic means on this system, in that language's own name. */
	const automatic = () => LANGUAGES.find((l) => l.code === resolve('auto'))?.name ?? 'English';

	let autostart = $state<boolean | null>(null);
	let server = $state('');
	let busy = $state<string | null>(null);
	let armed = $state(false);
	let armTimer: number | undefined;
	let advanced = $state(false);
	let checkedClient = $state(false);

	$effect(() => {
		api.getAutostart().then((on) => (autostart = on));
	});
	$effect(() => {
		server = snapshot.serverUrl;
	});
	let packsSite = $state('');
	$effect(() => {
		packsSite = snapshot.community.base;
	});

	/** Runs an action; its outcome (or error) is said in a toast. */
	async function run(key: string, action: () => Promise<string | void>) {
		busy = key;
		try {
			const text = await action();
			if (text) toast(text);
		} catch (e) {
			toast(message(e), 'warning');
		} finally {
			busy = null;
		}
	}

	function deleteData() {
		if (!armed) {
			armed = true;
			clearTimeout(armTimer);
			armTimer = window.setTimeout(() => (armed = false), 3000);
			return;
		}
		armed = false;
		clearTimeout(armTimer);
		run('delete', async () => {
			await api.deleteServerData();
			return t('Deleted. Uploads are paused; when you resume, this PC is set up again as new.');
		});
	}

	async function checkClient() {
		await run('check', async () => {
			const found = await api.checkUpdate();
			if (!found) {
				checkedClient = true;
				setTimeout(() => (checkedClient = false), 2600);
			}
		});
	}

	// The update channel's selected segment glides (transform only).
	const channels: [Channel, string][] = [
		['stable', msg('Stable')],
		['beta', msg('Beta')],
	];
	const segEls: Partial<Record<Channel, HTMLElement>> = {};
	let thumb = $state<{ x: number; w: number } | null>(null);
	let glide = $state(false);
	function place() {
		const el = segEls[snapshot.addons.channel];
		if (el) thumb = { x: el.offsetLeft, w: el.offsetWidth };
	}
	$effect(() => {
		void snapshot.addons.channel;
		void tick().then(place);
	});
	onMount(() => {
		place();
		requestAnimationFrame(() => (glide = true));
	});
</script>

<PageHeader title={t('Settings')} subtitle={t('How Polestar Client runs on this PC.')} />

<div class="body">
	<div class="column">
		<section class="section">
			<h2>{t('Recording')}</h2>
			<div class="rows">
				<div class="row" title={t('Off: nothing is sent, and the Recording pages offer to opt in again. What was already sent stays until you delete it below.')}>
					<span class="label">{t('Share my play')}</span>
					<button class="toggle" role="switch" aria-checked={snapshot.consent} aria-label={t('Share my play')} onclick={() => run('sharing', () => api.setSharing(!snapshot.consent))}></button>
				</div>
				<div class="row" class:off={!snapshot.consent} title={t('Stops sending until you resume. The Recorder keeps recording in the game.')}>
					<span class="label">{t('Pause uploads')}</span>
					<button class="toggle" role="switch" aria-checked={snapshot.paused} aria-label={t('Pause uploads')} disabled={!snapshot.consent} onclick={() => run('pause', () => api.setPaused(!snapshot.paused))}></button>
				</div>
			</div>
		</section>

		<section class="section">
			<h2>{t('Addons')}</h2>
			<div class="rows">
				<div class="row" title={t('Looks for new releases every 6 hours and says so in the tray.')}>
					<span class="label">{t('Check for updates automatically')}</span>
					<button class="toggle" role="switch" aria-checked={snapshot.addons.autoCheck} aria-label={t('Check for updates automatically')} onclick={() => run('autoCheck', () => api.setAddonPrefs({ autoCheck: !snapshot.addons.autoCheck }))}></button>
				</div>
				<div class="row" title={t("Installs updates to Polestar's own addons as soon as they are found, while the game is closed. Community Guides have their own setting below.")}>
					<span class="label">{t('Install addon updates automatically')}</span>
					<button class="toggle" role="switch" aria-checked={snapshot.addons.autoInstall} aria-label={t('Install addon updates automatically')} onclick={() => run('autoInstall', () => api.setAddonPrefs({ autoInstall: !snapshot.addons.autoInstall }))}></button>
				</div>
				<div class="row" title={t('Beta also offers pre-releases: newer, less tested.')}>
					<span class="label">{t('Update channel')}</span>
					<div class="segments" role="radiogroup" aria-label={t('Update channel')}>
						{#if thumb}<span class="thumb" class:glide style:transform="translateX({thumb.x}px)" style:width="{thumb.w}px" aria-hidden="true"></span>{/if}
						{#each channels as [id, label] (id)}
							<button role="radio" class="segment" aria-checked={snapshot.addons.channel === id} bind:this={segEls[id]} onclick={() => run('channel', () => api.setAddonPrefs({ channel: id }))}>{t(label)}</button>
						{/each}
					</div>
				</div>
			</div>
		</section>

		<section class="section">
			<h2>{t('Community Guides')}</h2>
			<div class="rows">
				<div class="row" title={t("Only routine updates, a day after they're published, while the game is closed. A new publisher or changed folders always asks first.")}>
					<span class="label">{t('Update guides automatically')}</span>
					<button class="toggle" role="switch" aria-checked={snapshot.community.autoUpdate} aria-label={t('Update guides automatically')} onclick={() => run('packAutoUpdate', () => api.setPackAutoUpdate(!snapshot.community.autoUpdate))}></button>
				</div>
				<div class="row" title={t('After a guide installs, tells {site} which guide and version, nothing else, so its author sees how many players use it. Off: nothing is sent.', { site: snapshot.community.site })}>
					<span class="label">{t('Count my guide installs')}</span>
					<button class="toggle" role="switch" aria-checked={snapshot.community.telemetry} aria-label={t('Count my guide installs')} onclick={() => run('telemetry', () => api.setPackTelemetry(!snapshot.community.telemetry))}></button>
				</div>
			</div>
		</section>

		<section class="section">
			<h2>{t('General')}</h2>
			<div class="rows one">
				<div class="row" title={t('The language of Polestar Client. Automatic follows your system.')}>
					<label class="label" for="language">{t('Language')}</label>
					<select id="language" class="field" onchange={(e) => { const choice = e.currentTarget.value; run('language', () => chooseLanguage(choice)); }}>
						<option value="auto" selected={(snapshot.language || 'auto') === 'auto'}>{t('Automatic ({language})', { language: automatic() })}</option>
						{#each LANGUAGES as l (l.code)}
							<option value={l.code} selected={snapshot.language === l.code}>{l.name}</option>
						{/each}
					</select>
				</div>
			</div>
			{#if meta()?.status === 'ai'}
				<p class="out note">
					{#each parts(t('Translated by machine. Corrections are welcome on {discord}.'), ['discord']) as p}{#if p.slot === 'discord'}<button class="link" onclick={() => api.openLink(DISCORD_URL)}>Discord</button>{:else}{p.text}{/if}{/each}
				</p>
			{/if}
			<div class="rows">
				<div class="row" title={t('Starts Polestar Client in the tray when you log in to your computer.')}>
					<span class="label">{t('Start with my computer')}</span>
					<button
						class="toggle"
						role="switch"
						aria-checked={!!autostart}
						aria-label={t('Start with my computer')}
						disabled={autostart === null}
						onclick={() =>
							run('autostart', async () => {
								await api.setAutostart(!autostart);
								autostart = await api.getAutostart();
							})}
					></button>
				</div>
				<div class="row" title={t('On: the intro plays in full every time Polestar Client opens, from the tray too. Off: in full only on the first launch after an install or update, a short one on other launches. A click or any key skips it.')}>
					<span class="label">{t('Play the full intro every launch')}</span>
					<button class="toggle" role="switch" aria-checked={intro.full} aria-label={t('Play the full intro every launch')} onclick={() => setFullIntro(!intro.full)}></button>
				</div>
			</div>
		</section>

		<section class="section">
			<h2>{t('Game')}</h2>
			<div class="rows one">
				<div class="row">
					<span class="label short">{t('WoW: Forever folder')}</span>
					<span class="path dim" title={snapshot.game.dir ?? ''}>{snapshot.game.dir ? ltr(snapshot.game.dir) : t('Not found')}</span>
					<button
						class="btn"
						disabled={busy === 'folder'}
						onclick={() =>
							run('folder', async () => {
								const check = await api.pickFolder();
								if (check?.problem) throw `${check.path}: ${check.problem}`;
								return check ? t('Using {path}.', { path: check.path }) : undefined;
							})}>{t('Change…')}</button
					>
				</div>
			</div>
		</section>

		<section class="section">
			<h2>{t('Your data')}</h2>
			<div class="tiles">
				<button class="tile" class:armed onclick={deleteData} disabled={busy === 'delete'}>
					{#if busy === 'delete'}<span class="spinner tile-mark" style:color="var(--danger)"></span>{:else}<span class="tile-mark"><Glyph name="close" size={18} color="var(--danger)" /></span>{/if}
					{#key armed}<span class="tile-title" in:swap>{armed ? t('Click again to delete') : t('Delete my data from the server')}</span>{/key}
					<span class="small muted">{t('Removes everything this PC sent, then starts afresh.')}</span>
				</button>
				<button class="tile" onclick={() => run('folder-open', () => api.openDataFolder())}>
					<span class="tile-mark"><Glyph name="folder" size={18} color="var(--accent)" /></span>
					<span class="tile-title">{t('Open the data folder')}</span>
					<span class="small muted path-line" title={snapshot.dataDir}>{snapshot.dataDir}</span>
				</button>
			</div>
		</section>

		<section class="section">
			<h2>{t('About')}</h2>
			<div class="rows one">
				<div class="row">
					<span class="label">Polestar Client <span class="num muted">{snapshot.version}</span></span>
					{#if snapshot.update}
						<button class="btn primary" disabled={busy === 'update'} onclick={() => run('update', () => api.installUpdate())}>
							{#if busy === 'update'}<span class="spinner"></span>{t('Updating…')}{:else}{t('Update to {version}', { version: snapshot.update })}{/if}
						</button>
					{:else}
						<button class="btn" disabled={busy === 'check'} onclick={checkClient}>
							{#if busy === 'check'}<span class="spinner"></span>{t('Checking…')}{:else if checkedClient}<span class="ok" in:swap><Glyph name="check" size={12} color="var(--success)" />{t('Up to date')}</span>{:else}{t('Check for client updates')}{/if}
						</button>
					{/if}
				</div>
				<div class="row" title={t('A small overlay with the frame rate and how the window is drawn, for reporting stutter. Ctrl+Shift+F shows and hides it anywhere.')}>
					<span class="label">{t('Show the frame rate')} <span class="small muted">· Ctrl+Shift+F</span></span>
					<button class="toggle" role="switch" aria-checked={diagnostics.frames} aria-label={t('Show the frame rate')} onclick={() => showFrames(!diagnostics.frames)}></button>
				</div>
				<div class="row links">
					<button class="link" onclick={() => api.openLink(CONTRACT_URL)}>{t('What is collected, and why')}</button>
					<button class="link" onclick={() => api.openLink(CLIENT_URL)}>{t("The client's source")}</button>
					<button class="link" onclick={() => api.openLink(SOURCE_URL)}>{t('Polestar on GitHub')}</button>
				</div>
			</div>
		</section>

		<!-- Developers only: a release build always sends to the default server and takes
		     Community Guides from polestar.guide (src-tauri/src/store.rs). -->
		{#if import.meta.env.DEV}
		<section class="section">
			<h2>
				<button class="disclosure" aria-expanded={advanced} onclick={() => (advanced = !advanced)}>
					<span class="chev" class:open={advanced}><Glyph name="chevron-down" size={12} /></span>Advanced
				</button>
				<span class="aside small muted">Only if you run your own servers</span>
			</h2>
			{#if advanced}
				<div in:rise={{ y: 4, duration: 180 }}>
					<form
						class="row server"
						onsubmit={(e) => {
							e.preventDefault();
							run('server', async () => {
								server = await api.setServerUrl(server);
								return `Uploads now go to ${server}.`;
							});
						}}
					>
						<label class="label" for="server">Server address</label>
						<input id="server" class="field" bind:value={server} spellcheck="false" autocomplete="off" />
						{#if server !== snapshot.defaultServerUrl}
							<button type="button" class="btn quiet" onclick={() => (server = snapshot.defaultServerUrl)}>Default</button>
						{/if}
						<button class="btn" type="submit" disabled={server === snapshot.serverUrl}>Save</button>
					</form>
					<p class="out note">Leave it at {snapshot.defaultServerUrl} unless you run your own recording server.</p>
					<form
						class="row server"
						onsubmit={(e) => {
							e.preventDefault();
							run('packs', async () => {
								packsSite = await api.setPacksUrl(packsSite);
								return `Community Guides now come from ${packsSite}.`;
							});
						}}
					>
						<label class="label" for="packs-site">Community site</label>
						<input id="packs-site" class="field" bind:value={packsSite} spellcheck="false" autocomplete="off" />
						{#if packsSite !== snapshot.community.defaultBase}
							<button type="button" class="btn quiet" onclick={() => (packsSite = snapshot.community.defaultBase)}>Default</button>
						{/if}
						<button class="btn" type="submit" disabled={packsSite === snapshot.community.base || busy === 'packs'}>Save</button>
					</form>
					<p class="out note">Where Community Guides come from: {snapshot.community.defaultBase}, or http://localhost:3100 while developing the site.</p>
				</div>
			{/if}
		</section>
		{/if}
	</div>
</div>

<style>
	.short {
		flex: none !important;
	}
	.path {
		flex: 1;
		min-width: 0;
		text-align: right;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
		direction: rtl;
		font-size: 12px;
	}
	.segments .thumb.glide {
		transition:
			transform var(--slow) var(--easeMove),
			width var(--slow) var(--easeMove);
	}
	.segments .thumb:not(.glide) {
		transition: none;
	}
	.server {
		gap: var(--s2);
		margin: 0;
	}
	.out + .server {
		margin-top: var(--s4);
	}
	.server .label {
		flex: none;
		width: 120px;
	}
	.server .field {
		flex: 1;
		min-width: 0;
	}
	.disclosure {
		display: inline-flex;
		align-items: center;
		gap: 8px;
		height: 32px;
		margin-left: -4px;
		padding: 0 6px 0 4px;
		border: 0;
		background: none;
		font-size: 13px;
		font-weight: 600;
		cursor: pointer;
		transition: background-color var(--fast) var(--ease);
	}
	.disclosure:hover {
		background: var(--hover);
	}
	.chev {
		display: inline-grid;
		transform: rotate(-90deg);
		transition: transform var(--base) var(--ease);
	}
	.chev.open {
		transform: none;
	}
	.tiles {
		display: grid;
		grid-template-columns: 1fr 1fr;
		gap: var(--s3);
		margin-top: var(--s3);
	}
	@container (max-width: 560px) {
		.tiles {
			grid-template-columns: 1fr;
		}
	}
	.tile {
		position: relative;
		display: flex;
		flex-direction: column;
		justify-content: center;
		gap: 3px;
		height: 60px;
		padding: 0 12px 0 48px;
		background: var(--panelAlt);
		border: 1px solid var(--border);
		text-align: left;
		cursor: pointer;
		min-width: 0;
		transition:
			border-color var(--base) var(--ease),
			background-color var(--base) var(--ease),
			transform var(--fast) var(--ease);
	}
	.tile:hover:not(:disabled) {
		background-image: linear-gradient(var(--hover), var(--hover));
	}
	.tile:active:not(:disabled) {
		transform: translateY(1px);
	}
	.tile-mark {
		position: absolute;
		left: 16px;
		top: 20px;
	}
	.tile.armed {
		border-color: var(--danger);
		background: var(--chipDanger);
	}
	.tile.armed .tile-title {
		color: var(--danger);
	}
	.tile-title {
		font-size: 13px;
	}
	.path-line {
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
	}
	.links {
		gap: 20px;
	}
	.ok {
		display: inline-flex;
		align-items: center;
		gap: 6px;
	}
</style>
