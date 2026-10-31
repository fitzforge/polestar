<script lang="ts">
	import { flip } from 'svelte/animate';
	import { crossfade } from 'svelte/transition';
	import { app } from '../lib/app.svelte';
	import { api, message } from '../lib/backend';
	import { ago } from '../lib/format';
	import { drop, ease, reduced, rise, stagger, swap } from '../lib/motion';
	import { toast } from '../lib/toast.svelte';
	import type { AddonAction, Changelog as Notes, Product, Snapshot } from '../lib/types';
	import PageHeader from '../components/PageHeader.svelte';
	import Glyph from '../components/Glyph.svelte';
	import Emblem from '../components/Emblem.svelte';
	import Changelog from '../components/Changelog.svelte';

	let { snapshot }: { snapshot: Snapshot } = $props();

	const RELEASES = 'https://github.com/fitzforge/polestar/releases';
	const GLYPHS: Record<string, string> = { recorder: 'record', libforeverdata: 'layers' };
	const DONE: Record<AddonAction, string> = { install: 'Installed', update: 'Updated', repair: 'Repaired', uninstall: 'Removed' };
	const PHASE: Record<string, string> = { download: 'Downloading', verify: 'Checking', install: 'Installing', remove: 'Removing' };

	let menu = $state<string | null>(null);
	let armed = $state<string | null>(null);
	let notes = $state<Notes | null>(null);
	let notesFrom: HTMLElement | null = null;
	let updatingAll = $state(false);
	let checking = $state(false);
	/** The first rows rise in with a stagger; later changes move by crossfade and flip instead. */
	let entered = $state(false);
	$effect(() => {
		const t = setTimeout(() => (entered = true), 1000);
		return () => clearTimeout(t);
	});
	/** Products that just finished an action: the row shows it for a moment, then settles. */
	let done = $state<Record<string, AddonAction>>({});

	const addons = $derived(snapshot.addons);
	const updates = $derived(addons.products.filter((p) => p.status === 'update'));
	/** Community packs with an update the game can take: Update all does them too. */
	const packUpdates = $derived(snapshot.community.packs.filter((p) => p.status === 'update' && !p.blocked).length);
	const pending = $derived(updates.length + packUpdates);
	const installed = $derived(addons.products.filter((p) => p.installed));
	const available = $derived(addons.products.filter((p) => !p.installed));
	const spinning = $derived(checking || addons.checking);

	// Rows moving between Installed and Not installed travel as one.
	const [send, receive] = crossfade({
		duration: (d) => (reduced() ? 120 : Math.min(420, Math.sqrt(d * 200))),
		easing: ease,
		fallback: (node) => rise(node, { y: 6 }),
	});

	async function act(product: Product, action: AddonAction) {
		menu = null;
		armed = null;
		try {
			const text = await api.addonAction(product.id, action);
			done[product.id] = action;
			setTimeout(() => delete done[product.id], 2600);
			toast(text);
		} catch (e) {
			toast(message(e), 'warning');
		}
	}

	/** Consequential actions (removing, updating while the game runs) take a second click within 3 s. */
	function confirm(key: string, run: () => void) {
		if (armed === key) {
			armed = null;
			run();
			return;
		}
		armed = key;
		setTimeout(() => armed === key && (armed = null), 3000);
	}

	async function check() {
		checking = true;
		const started = Date.now();
		try {
			await api.checkAddons();
		} catch (e) {
			toast(message(e), 'warning');
		} finally {
			// Long enough to be seen turning, never a flash.
			setTimeout(() => (checking = false), Math.max(0, 650 - (Date.now() - started)));
		}
	}

	async function updateAll() {
		updatingAll = true;
		try {
			toast(await api.updateAll());
		} catch (e) {
			toast(message(e), 'warning');
		} finally {
			updatingAll = false;
		}
	}

	async function openNotes(product: Product, e: MouseEvent) {
		notesFrom = e.currentTarget as HTMLElement;
		try {
			notes = await api.changelog(product.id);
		} catch (err) {
			toast(message(err), 'warning');
		}
	}

	function closeNotes() {
		notes = null;
		notesFrom?.focus();
	}

	// The ⋯ menu: opens on its first item, arrows move, Escape and Tab close it
	// and give focus back to its button.
	let menuEl = $state<HTMLElement | null>(null);
	let trigger: HTMLElement | null = null;
	function openMenu(id: string, e: MouseEvent) {
		e.stopPropagation();
		trigger = e.currentTarget as HTMLElement;
		menu = menu === id ? null : id;
	}
	$effect(() => {
		if (menu && menuEl) menuEl.querySelector<HTMLElement>('button:not(:disabled)')?.focus();
	});
	function closeMenu() {
		menu = null;
		trigger?.focus();
	}
	function menuKeys(e: KeyboardEvent) {
		if (!menu || !menuEl) return;
		const items = [...menuEl.querySelectorAll<HTMLElement>('button:not(:disabled)')];
		const at = items.indexOf(document.activeElement as HTMLElement);
		if (e.key === 'Escape' || e.key === 'Tab') {
			e.preventDefault();
			closeMenu();
		} else if (e.key === 'ArrowDown' || e.key === 'ArrowUp') {
			e.preventDefault();
			items[(at + (e.key === 'ArrowDown' ? 1 : items.length - 1)) % items.length]?.focus();
		}
	}

	const released = (p: Product) => (p.latest?.publishedAt ? `released ${ago(Date.parse(p.latest.publishedAt), app.now)}` : null);
</script>

<svelte:window onclick={() => (menu = null)} onkeydown={menuKeys} />

<PageHeader title="Addons" subtitle="Polestar's addons for WoW: Forever, installed and kept up to date from the project's GitHub releases.">
	{#snippet aside()}
		<button class="btn" onclick={check} disabled={spinning}>
			<span class="turn" class:spinning><Glyph name="reload" size={13} color="var(--textDim)" /></span>
			Check for updates
		</button>
		{#if pending > 0}
			<button
				class="btn"
				class:primary={!addons.gameRunning}
				class:armed={armed === 'all'}
				disabled={updatingAll || !addons.gameFound}
				onclick={() => (addons.gameRunning ? confirm('all', updateAll) : updateAll())}
				in:swap
			>
				{#if updatingAll}<span class="spinner"></span>Updating…{:else if armed === 'all'}Click again: the game is running{:else if addons.gameRunning}Update all anyway{:else}Update all ({pending}){/if}
			</button>
		{/if}
	{/snippet}
</PageHeader>

<div class="body">
	<div class="column">
		<p class="meta small muted" aria-live="polite">
			{#key addons.checkedAt ?? 0}
				<span in:swap>
					{#if addons.error}
						<span class="bad">{addons.error}</span>
					{:else if spinning}
						Looking for new releases…
					{:else if addons.checkedAt}
						Checked {ago(addons.checkedAt, app.now)}
					{:else}
						Not checked yet
					{/if}
				</span>
			{/key}
			<span class="sep">·</span>
			<span title="Change it in Settings">{addons.channel === 'beta' ? 'Beta channel' : 'Stable channel'}</span>
		</p>

		{#if !addons.gameFound}
			<div class="banner" in:rise>
				<Glyph name="info" color="var(--warning)" />
				<p class="note">Polestar Client hasn't found WoW: Forever yet, so it can't install anything.</p>
				<button class="btn primary" onclick={() => api.pickFolder()}>Locate the game</button>
			</div>
		{:else if addons.gameRunning}
			<div class="banner" in:rise>
				<Glyph name="info" color="var(--warning)" />
				<p class="note">World of Warcraft is running. Close it before updating: the game only loads addons when it starts, and it may hold their files open.</p>
			</div>
		{/if}

		{#snippet row(p: Product, i: number)}
			{@const busy = p.busy}
			{@const progress = p.progress}
			{@const pct = progress?.total ? Math.min(1, progress.done / progress.total) : null}
			<div class="product" class:busy={!!busy} style:--i={i}>
				<span class="icon">
					{#if p.id === 'polestar'}<Emblem size={22} />{:else}<Glyph name={GLYPHS[p.id] ?? 'layers'} size={20} color="var(--accent)" />{/if}
				</span>
				<span class="names">
					<span class="name">{p.name}{#if p.latest?.prerelease}<span class="chip warning">Beta</span>{/if}</span>
					<span class="small muted blurb" title={p.blurb}>{p.blurb}</span>
					<span class="small versions">
						{#if p.status === 'update' && p.installed && p.latest}
							<span class="num muted">{p.installed}</span><span class="arrow">→</span><span class="num">{p.latest.version}</span>
						{:else if p.installed}
							<span class="num dim">{p.installed}</span>
						{:else if p.latest}
							<span class="num dim">{p.latest.version}</span>
						{/if}
						{#if p.latest}
							{#if released(p)}<span class="sep">·</span><span class="muted">{released(p)}</span>{/if}
							<span class="sep">·</span><button class="link small-link" onclick={(e) => openNotes(p, e)}>What's new</button>
						{/if}
					</span>
				</span>
				<span class="action">
					{#if busy}
						{#key progress?.phase ?? busy}
							<span class="phase small" in:swap>
								<span class="spinner"></span>{progress ? PHASE[progress.phase] : PHASE[busy === 'uninstall' ? 'remove' : 'download']}{#if pct !== null}<span class="num">&nbsp;{Math.round(pct * 100)}%</span>{/if}
							</span>
						{/key}
					{:else if done[p.id]}
						<span class="chip success settled" in:swap><Glyph name="check" size={11} color="var(--success)" />{DONE[done[p.id]]}</span>
					{:else if p.status === 'noGame'}
						<span class="small muted">Game not found</span>
					{:else if p.status === 'unknown'}
						<span class="small muted">{spinning ? 'Checking…' : 'Not checked'}</span>
					{:else if p.status === 'unavailable'}
						<button class="link" onclick={() => api.openLink(RELEASES)}>Not published yet</button>
					{:else if p.status === 'upToDate'}
						<span class="chip success" in:swap>Up to date</span>
					{:else}
						{@const action = p.status === 'install' ? 'install' : 'update'}
						{#if addons.gameRunning && action === 'update'}
							<button class="btn small" class:armed={armed === `${p.id}:update`} onclick={() => confirm(`${p.id}:update`, () => act(p, 'update'))}>
								{armed === `${p.id}:update` ? 'Click again' : 'Update anyway'}
							</button>
						{:else}
							<button class="btn" onclick={() => act(p, action)} in:swap>{action === 'install' ? 'Install' : 'Update'}</button>
						{/if}
					{/if}
				</span>
				<span class="more">
					{#if p.installed && !busy}
						<button class="icon-btn" aria-label="More for {p.name}" aria-haspopup="menu" aria-expanded={menu === p.id} onclick={(e) => openMenu(p.id, e)}><Glyph name="menu" size={14} /></button>
						{#if menu === p.id}
							<!-- svelte-ignore a11y_click_events_have_key_events -->
							<div class="menu" role="menu" tabindex="-1" bind:this={menuEl} onclick={(e) => e.stopPropagation()} transition:drop>
								<button role="menuitem" disabled={!p.latest} onclick={() => act(p, 'repair')}>
									<Glyph name="reload" size={14} color="var(--textDim)" /><span>Repair</span>
									<span class="small muted hint">Download {p.installed} again and replace it</span>
								</button>
								<button role="menuitem" class="danger" onclick={() => confirm(`${p.id}:uninstall`, () => act(p, 'uninstall'))}>
									<Glyph name="close" size={14} color="var(--danger)" /><span>{armed === `${p.id}:uninstall` ? 'Click again to remove' : 'Uninstall'}</span>
									<span class="small muted hint">Removes only {p.name}'s folders</span>
								</button>
							</div>
						{/if}
					{/if}
				</span>
				{#if busy}
					<span class="bar" class:indeterminate={pct === null} aria-hidden="true" transition:swap>
						<span class="fill" style:transform={pct === null ? undefined : `scaleX(${pct})`}></span>
					</span>
				{/if}
			</div>
		{/snippet}

		<section class="section">
			<h2>Installed <span class="count num">{installed.length}</span></h2>
			<div class="list" class:entered>
				{#each installed as p, i (p.id)}
					<div in:receive={{ key: p.id }} out:send={{ key: p.id }} animate:flip={{ duration: 320, easing: ease }}>{@render row(p, i)}</div>
				{:else}
					<p class="note none" in:rise>Nothing from Polestar is installed in this game yet.</p>
				{/each}
			</div>
		</section>
		{#if available.length > 0}
			<section class="section" in:rise>
				<h2>Not installed <span class="count num">{available.length}</span></h2>
				<div class="list" class:entered>
					{#each available as p, i (p.id)}
						<div in:receive={{ key: p.id }} out:send={{ key: p.id }} animate:flip={{ duration: 320, easing: ease }}>{@render row(p, i + installed.length)}</div>
					{/each}
				</div>
			</section>
		{/if}

		<p class="small muted foot">Each download is checked against the checksum GitHub publishes for it before anything in your AddOns folder changes. Other addons are never touched.</p>
	</div>
</div>

{#if notes}
	<Changelog notes={notes} onclose={closeNotes} />
{/if}

<style>
	.meta {
		display: flex;
		align-items: center;
		gap: 6px;
		height: 20px;
		margin: 0 0 var(--s2);
		white-space: nowrap;
	}
	.sep {
		margin: 0 4px;
		color: var(--textMuted);
	}
	.bad {
		color: var(--warning);
	}
	.turn {
		display: inline-grid;
		transition: transform 400ms var(--ease);
	}
	.turn.spinning {
		animation: spin 700ms linear infinite;
	}
	.armed {
		border-color: var(--warning);
		color: var(--warning);
	}
	.banner {
		display: flex;
		align-items: center;
		gap: var(--s3);
		min-height: 48px;
		padding: var(--s2) var(--s3) var(--s2) var(--s4);
		margin-bottom: var(--s2);
		background: var(--panel);
		border: 1px solid rgba(250, 191, 77, 0.3);
	}
	.banner p {
		flex: 1;
		margin: 0;
	}
	.list {
		position: relative;
	}
	.product {
		position: relative;
		display: grid;
		grid-template-columns: 40px minmax(0, 1fr) auto 28px;
		align-items: center;
		column-gap: var(--s4);
		min-height: 68px;
		padding: var(--s3) 0;
		border-bottom: 1px solid var(--divider);
	}
	.list:not(.entered) .product {
		animation: enter 320ms var(--ease) backwards;
		animation-delay: calc(min(var(--i), 8) * 30ms + 180ms);
	}
	@keyframes enter {
		from {
			opacity: 0;
			transform: translateY(6px);
		}
	}
	.icon {
		display: grid;
		place-items: center;
		width: 40px;
		height: 40px;
		background: var(--inset);
		border: 1px solid var(--border);
	}
	.names {
		display: flex;
		flex-direction: column;
		gap: 3px;
		min-width: 0;
	}
	.name {
		display: flex;
		align-items: center;
		gap: 8px;
		font-size: 14px;
		font-weight: 600;
		white-space: nowrap;
	}
	.blurb {
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
	}
	.versions {
		display: flex;
		align-items: center;
		gap: 6px;
		min-width: 0;
		margin-top: 2px;
		white-space: nowrap;
	}
	.versions .num {
		font-size: 11px;
	}
	.versions .sep {
		margin: 0;
	}
	.arrow {
		color: var(--accent);
	}
	.small-link {
		font-size: 11px;
	}
	.action {
		display: flex;
		justify-content: flex-end;
		align-items: center;
		min-width: 120px;
	}
	.phase {
		display: inline-flex;
		align-items: center;
		gap: 7px;
		color: var(--accent);
		white-space: nowrap;
	}
	.settled :global(.glyph) {
		animation: pop 300ms var(--easePop);
	}
	@keyframes pop {
		from {
			transform: scale(0.4);
			opacity: 0;
		}
	}
	/* Progress along the row's foot: the fill scales (transform only); unknown
	   length sweeps instead of pretending to a number. */
	.bar {
		position: absolute;
		left: 0;
		right: 0;
		bottom: -1px;
		height: 2px;
		overflow: hidden;
		background: var(--track);
	}
	.fill {
		position: absolute;
		inset: 0;
		background: var(--accent);
		box-shadow: 0 0 8px rgba(230, 186, 102, 0.6);
		transform-origin: left;
		transform: scaleX(0);
		transition: transform 300ms var(--ease);
	}
	.indeterminate .fill {
		width: 35%;
		transform: none;
		animation: sweep 1100ms var(--easeMove) infinite;
	}
	@keyframes sweep {
		from {
			transform: translate3d(-100%, 0, 0);
		}
		to {
			transform: translate3d(300%, 0, 0);
		}
	}
	.more {
		position: relative;
		display: flex;
		justify-content: flex-end;
	}
	/* The shared popup menu: raised ground and a hairline, grown from its trigger. */
	.menu {
		position: absolute;
		right: 0;
		top: 34px;
		z-index: 5;
		width: 248px;
		padding: 5px 0;
		background: var(--panel);
		border: 1px solid var(--border);
		box-shadow: var(--shadowWindow);
		transform-origin: top right;
		text-align: left;
	}
	.menu button {
		display: grid;
		grid-template-columns: 14px 1fr;
		column-gap: 10px;
		align-items: center;
		width: 100%;
		padding: 7px 12px 7px 12px;
		border: 0;
		background: none;
		text-align: left;
		font-size: 12px;
		cursor: pointer;
		transition: background-color var(--fast) var(--ease);
	}
	.menu button:hover:not(:disabled),
	.menu button:focus-visible {
		background: var(--hover);
		outline: none;
		box-shadow: inset 2px 0 0 var(--accent);
	}
	.menu button:disabled {
		opacity: 0.5;
		cursor: default;
	}
	.menu .danger span:nth-child(2) {
		color: var(--danger);
	}
	.hint {
		grid-column: 2;
	}
	.none {
		margin: var(--s3) 0;
	}
	.foot {
		margin: var(--s5) 0 0;
		max-width: 70ch;
	}
	@media (prefers-reduced-motion: reduce) {
		.product {
			animation: none;
		}
		.turn.spinning {
			animation: none;
		}
		.indeterminate .fill {
			animation: none;
			width: 100%;
			opacity: 0.5;
		}
	}
</style>
