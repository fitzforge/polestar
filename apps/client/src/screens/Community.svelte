<script lang="ts">
	import { flip } from 'svelte/animate';
	import { crossfade } from 'svelte/transition';
	import { app } from '../lib/app.svelte';
	import { api, message } from '../lib/backend';
	import { ago, bytes } from '../lib/format';
	import { drop, ease, reduced, rise, swap } from '../lib/motion';
	import { toast } from '../lib/toast.svelte';
	import type { Changelog as Notes, Pack, PackAction, Snapshot } from '../lib/types';
	import PageHeader from '../components/PageHeader.svelte';
	import Glyph from '../components/Glyph.svelte';
	import Emblem from '../components/Emblem.svelte';
	import Changelog from '../components/Changelog.svelte';
	import PackSheet from '../components/PackSheet.svelte';

	let { snapshot }: { snapshot: Snapshot } = $props();

	const DONE: Record<PackAction, string> = { install: 'Installed', update: 'Updated', uninstall: 'Removed' };
	const PHASE: Record<string, string> = { download: 'Downloading', verify: 'Checking', install: 'Installing', remove: 'Removing' };

	const community = $derived(snapshot.community);
	let query = $state('');
	let menu = $state<string | null>(null);
	let armed = $state<string | null>(null);
	let notes = $state<Notes | null>(null);
	let notesFrom: HTMLElement | null = null;
	let checking = $state(false);
	let done = $state<Record<string, PackAction>>({});
	let entered = $state(false);
	$effect(() => {
		const t = setTimeout(() => (entered = true), 1000);
		return () => clearTimeout(t);
	});

	// The page asks for a fresh index once when it opens, unless one came in the last few minutes.
	let asked = false;
	$effect(() => {
		if (asked || !community.available || community.checking) return;
		asked = true;
		if (!community.checkedAt || Date.now() - community.checkedAt > 5 * 60_000) void check(true);
	});

	const spinning = $derived(checking || community.checking);
	const words = $derived(query.trim().toLowerCase().split(/\s+/).filter(Boolean));
	const matches = (p: Pack) => words.every((w) => p.title.toLowerCase().includes(w) || p.author.toLowerCase().includes(w));
	const shown = $derived(community.packs.filter(matches));
	const installed = $derived(shown.filter((p) => p.installed));
	const available = $derived(shown.filter((p) => !p.installed));

	const [send, receive] = crossfade({
		duration: (d) => (reduced() ? 120 : Math.min(420, Math.sqrt(d * 200))),
		easing: ease,
		fallback: (node) => rise(node, { y: 6 }),
	});

	async function act(pack: Pack, action: PackAction) {
		menu = null;
		armed = null;
		try {
			const text = await api.packAction(pack.id, action);
			done[pack.id] = action;
			setTimeout(() => delete done[pack.id], 2600);
			toast(text);
		} catch (e) {
			toast(message(e), 'warning');
		}
	}

	function confirm(key: string, run: () => void) {
		if (armed === key) {
			armed = null;
			run();
			return;
		}
		armed = key;
		setTimeout(() => armed === key && (armed = null), 3000);
	}

	async function check(quiet = false) {
		checking = true;
		const started = Date.now();
		try {
			await api.checkPacks();
		} catch (e) {
			if (!quiet) toast(message(e), 'warning');
		} finally {
			setTimeout(() => (checking = false), Math.max(0, 650 - (Date.now() - started)));
		}
	}

	/** The pack's page on the site (or its own homepage). */
	const pageOf = (p: Pack) => p.homepage ?? `${community.base}/packs/${p.id}`;

	function openNotes(p: Pack, e: MouseEvent) {
		notesFrom = e.currentTarget as HTMLElement;
		notes = {
			name: p.title,
			title: p.title,
			version: p.version ?? p.installed ?? '',
			publishedAt: null,
			body: p.changelog ?? '',
			pageUrl: pageOf(p),
			pageLabel: p.homepage ? "Open the guide's homepage" : `Open it on ${community.site}`,
		};
	}

	function closeNotes() {
		notes = null;
		notesFrom?.focus();
	}

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
	function menuKeys(e: KeyboardEvent) {
		if (!menu || !menuEl) return;
		const items = [...menuEl.querySelectorAll<HTMLElement>('button:not(:disabled)')];
		const at = items.indexOf(document.activeElement as HTMLElement);
		if (e.key === 'Escape' || e.key === 'Tab') {
			e.preventDefault();
			menu = null;
			trigger?.focus();
		} else if (e.key === 'ArrowDown' || e.key === 'ArrowUp') {
			e.preventDefault();
			items[(at + (e.key === 'ArrowDown' ? 1 : items.length - 1)) % items.length]?.focus();
		}
	}
</script>

<svelte:window onclick={() => (menu = null)} onkeydown={menuKeys} />

<PageHeader title="Community Guides" subtitle="Guides players publish on {community.site}, installed beside Polestar and kept up to date.">
	{#snippet aside()}
		{#if community.available}
			<button class="btn" onclick={() => check()} disabled={spinning}>
				<span class="turn" class:spinning><Glyph name="reload" size={13} color="var(--textDim)" /></span>
				Check for updates
			</button>
		{/if}
	{/snippet}
</PageHeader>

<div class="body">
	<div class="column">
		{#if !community.available}
			<div class="empty" in:rise>
				<div class="watermark" aria-hidden="true"><Emblem size={168} /></div>
				<span class="halo"><Glyph name="star" size={36} color="var(--accent)" /></span>
				<h3>Community Guides aren't available yet</h3>
				<p class="note">This version of Polestar Client can't check guides from {community.site} yet, so it doesn't offer any. They arrive with a client update.</p>
			</div>
		{:else}
			<div class="tools">
				<p class="meta small muted" aria-live="polite">
					{#key community.checkedAt ?? 0}
						<span in:swap>
							{#if community.error}
								<span class="bad">{community.error}</span>
							{:else if spinning}
								Looking for guides…
							{:else if community.checkedAt}
								Checked {ago(community.checkedAt, app.now)}
							{:else}
								Not checked yet
							{/if}
						</span>
					{/key}
					<span class="sep">·</span>
					<button class="link small-link" onclick={() => api.openLink(`${community.base}/packs`)}>{community.site}</button>
				</p>
				{#if community.packs.length > 0}
					<label class="search">
						<Glyph name="search" size={13} color="var(--textMuted)" />
						<input class="field" type="search" placeholder="Search by title or author" bind:value={query} spellcheck="false" autocomplete="off" aria-label="Search guides by title or author" />
					</label>
				{/if}
			</div>

			{#if !community.gameFound}
				<div class="banner" in:rise>
					<Glyph name="info" color="var(--warning)" />
					<p class="note">Polestar Client hasn't found WoW: Forever yet, so it can't install guides.</p>
					<button class="btn primary" onclick={() => api.pickFolder()}>Locate the game</button>
				</div>
			{:else if community.gameRunning}
				<div class="banner" in:rise>
					<Glyph name="info" color="var(--warning)" />
					<p class="note">World of Warcraft is running. A guide you install or update loads after /reload or the next start.</p>
				</div>
			{/if}

			{#snippet row(p: Pack, i: number)}
				{@const busy = p.busy}
				{@const progress = p.progress}
				{@const pct = progress?.total ? Math.min(1, progress.done / progress.total) : null}
				<div class="pack" class:busy={!!busy} style:--i={i}>
					<span class="icon"><Glyph name="flag" size={18} color="var(--accent)" /></span>
					<span class="names">
						<span class="name">
							<span class="title" title={p.title}>{p.title}</span>
							{#if p.official}<span class="chip accent">Official</span>{/if}
							{#if p.status === 'unlisted'}<span class="chip">No longer listed</span>{/if}
						</span>
						<span class="small muted author">by {p.author || 'an unknown author'}</span>
						<span class="small versions">
							{#if p.status === 'update' && p.installed && p.version}
								<span class="num muted">{p.installed}</span><span class="arrow">→</span><span class="num">{p.version}</span>
							{:else}
								<span class="num dim">{p.installed ?? p.version}</span>
							{/if}
							{#if p.size && p.status !== 'upToDate'}<span class="sep">·</span><span class="muted num">{bytes(p.size)}</span>{/if}
							{#if p.changelog !== null}<span class="sep">·</span><button class="link small-link" onclick={(e) => openNotes(p, e)}>What's new</button>{/if}
							{#if p.homepage}<span class="sep">·</span><button class="link small-link" onclick={() => api.openLink(p.homepage!)}>Homepage</button>{/if}
						</span>
						{#if p.blocked && !busy}<span class="small why">{p.blocked}</span>{/if}
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
						{:else if p.status === 'upToDate'}
							<span class="chip success" in:swap>Up to date</span>
						{:else if p.status === 'unlisted'}
							<span class="small muted">Removed from {community.site}</span>
						{:else}
							<button class="btn" disabled={!!p.blocked} title={p.blocked ?? undefined} onclick={() => act(p, p.status === 'update' ? 'update' : 'install')} in:swap>
								{p.status === 'update' ? 'Update' : 'Install'}
							</button>
						{/if}
					</span>
					<span class="more">
						{#if p.installed && !busy}
							<button class="icon-btn" aria-label="More for {p.title}" aria-haspopup="menu" aria-expanded={menu === p.id} onclick={(e) => openMenu(p.id, e)}><Glyph name="menu" size={14} /></button>
							{#if menu === p.id}
								<!-- svelte-ignore a11y_click_events_have_key_events -->
								<div class="menu" role="menu" tabindex="-1" bind:this={menuEl} onclick={(e) => e.stopPropagation()} transition:drop>
									<button role="menuitem" onclick={() => api.openLink(pageOf(p))}>
										<Glyph name="search" size={14} color="var(--textDim)" /><span>{p.homepage ? 'Open the homepage' : `Open on ${community.site}`}</span>
									</button>
									<button role="menuitem" class="danger" onclick={() => confirm(`${p.id}:uninstall`, () => act(p, 'uninstall'))}>
										<Glyph name="close" size={14} color="var(--danger)" /><span>{armed === `${p.id}:uninstall` ? 'Click again to remove' : 'Remove'}</span>
										<span class="small muted hint">Removes only {p.folders.join(', ')}</span>
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

			{#if community.packs.length === 0}
				<div class="empty" in:rise>
					<div class="watermark" aria-hidden="true"><Emblem size={168} /></div>
					<span class="halo"><Glyph name="star" size={36} color="var(--accent)" /></span>
					{#if community.error && !spinning}
						<h3>The guide list couldn't be loaded</h3>
						<p class="note">{community.error}</p>
					{:else if spinning || !community.checkedAt}
						<h3>Looking for guides…</h3>
						<p class="note">Reading the guide list from {community.site}.</p>
					{:else}
						<h3>No Community Guides yet</h3>
						<p class="note">When players publish guides on {community.site}, they show up here to install in one click.</p>
					{/if}
				</div>
			{:else}
				{#if installed.length > 0}
					<section class="section" in:rise>
						<h2>Installed <span class="count num">{installed.length}</span></h2>
						<div class="list" class:entered>
							{#each installed as p, i (p.id)}
								<div in:receive={{ key: p.id }} out:send={{ key: p.id }} animate:flip={{ duration: 320, easing: ease }}>{@render row(p, i)}</div>
							{/each}
						</div>
					</section>
				{/if}
				{#if available.length > 0}
					<section class="section" in:rise>
						<h2>Available <span class="count num">{available.length}</span></h2>
						<div class="list" class:entered>
							{#each available as p, i (p.id)}
								<div in:receive={{ key: p.id }} out:send={{ key: p.id }} animate:flip={{ duration: 320, easing: ease }}>{@render row(p, i + installed.length)}</div>
							{/each}
						</div>
					</section>
				{/if}
				{#if shown.length === 0}
					<p class="note none" in:rise>No guide's title or author matches “{query.trim()}”.</p>
				{/if}
			{/if}

			<p class="small muted foot">Guides are made by players, not by Polestar. Each one is checked against {community.site}'s signed list before anything in your AddOns folder changes, and a guide only ever writes its own PolestarPack folders.</p>
		{/if}
	</div>
</div>

{#if notes}
	<Changelog {notes} onclose={closeNotes} />
{/if}

{#if app.link}
	<PackSheet link={app.link} {community} onclose={() => (app.link = null)} />
{/if}

<style>
	.tools {
		display: flex;
		align-items: center;
		gap: var(--s4);
		margin: 0 0 var(--s2);
	}
	.meta {
		flex: 1;
		min-width: 0;
		display: flex;
		align-items: center;
		gap: 6px;
		height: 20px;
		margin: 0;
		white-space: nowrap;
		overflow: hidden;
	}
	.meta > span:first-child {
		overflow: hidden;
		text-overflow: ellipsis;
	}
	.sep {
		margin: 0 4px;
		color: var(--textMuted);
	}
	.bad {
		color: var(--warning);
	}
	.search {
		position: relative;
		display: flex;
		align-items: center;
		flex: none;
	}
	.search :global(.glyph) {
		position: absolute;
		left: 10px;
		pointer-events: none;
	}
	.search .field {
		width: 232px;
		padding-left: 30px;
	}
	.search .field::placeholder {
		color: var(--textMuted);
	}
	@container (max-width: 560px) {
		.tools {
			flex-direction: column;
			align-items: stretch;
			gap: var(--s2);
		}
		.search .field {
			width: 100%;
		}
	}
	.turn {
		display: inline-grid;
	}
	.turn.spinning {
		animation: spin 700ms linear infinite;
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
	.pack {
		position: relative;
		display: grid;
		grid-template-columns: 40px minmax(0, 1fr) auto 28px;
		align-items: center;
		column-gap: var(--s4);
		min-height: 68px;
		padding: var(--s3) 0;
		border-bottom: 1px solid var(--divider);
	}
	.list:not(.entered) .pack {
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
		min-width: 0;
		font-size: 14px;
		font-weight: 600;
	}
	.title {
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
	}
	.author {
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
	.why {
		color: var(--warning);
		max-width: 60ch;
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
	.menu {
		position: absolute;
		right: 0;
		top: 34px;
		z-index: 5;
		width: 260px;
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
		padding: 7px 12px;
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
	.menu .danger span:nth-child(2) {
		color: var(--danger);
	}
	.hint {
		grid-column: 2;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
	}
	.none {
		margin: var(--s4) 0;
	}
	.foot {
		margin: var(--s5) 0 0;
		max-width: 70ch;
	}
	@media (prefers-reduced-motion: reduce) {
		.pack {
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
