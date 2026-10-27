<script lang="ts">
	import { onMount, tick } from 'svelte';
	import { app, go, type Screen } from '../lib/app.svelte';
	import { STATUS } from '../lib/status';
	import type { Snapshot } from '../lib/types';
	import Beacon from './Beacon.svelte';
	import Emblem from './Emblem.svelte';
	import Glyph from './Glyph.svelte';
	import { MAC } from './TitleBar.svelte';
	import wordmark from '../assets/ui/wordmark-small.png';

	let { snapshot }: { snapshot: Snapshot } = $props();

	type Item = { id: Screen; label: string; glyph: string };
	const top: Item[] = [
		{ id: 'addons', label: 'Addons', glyph: 'layers' },
		{ id: 'community', label: 'Community Guides', glyph: 'star' },
		{ id: 'activity', label: 'Activity', glyph: 'compact' },
	];
	const recording: Item[] = [
		{ id: 'home', label: 'Status', glyph: 'record' },
		{ id: 'sending', label: 'What we send', glyph: 'eye' },
	];
	const status = $derived(STATUS[snapshot.status.kind]);
	// Polestar's own addons and the community packs with an update the game can take.
	const updates = $derived(snapshot.addons.products.filter((p) => p.status === 'update').length + snapshot.community.packs.filter((p) => p.status === 'update' && !p.blocked).length);
	const attention = $derived(snapshot.status.kind === 'attention' || snapshot.status.kind === 'rejected');

	// The selection glides: one wash with its 2px accent bar, moved to the row
	// on screen (transform only). It appears in place the first time.
	let aside: HTMLElement;
	const rows: Partial<Record<Screen, HTMLElement>> = {};
	let marker = $state<{ y: number; h: number } | null>(null);
	let glide = $state(false);

	function place() {
		const row = rows[app.screen];
		if (!row || !aside) return;
		const a = aside.getBoundingClientRect();
		const r = row.getBoundingClientRect();
		marker = { y: r.top - a.top, h: r.height };
	}

	$effect(() => {
		void app.screen;
		void tick().then(place);
	});

	onMount(() => {
		place();
		requestAnimationFrame(() => (glide = true));
		const observer = new ResizeObserver(place);
		observer.observe(aside);
		return () => observer.disconnect();
	});
</script>

<aside bind:this={aside} class:mac={MAC}>
	{#if marker}
		<div class="marker" class:glide style:transform="translateY({marker.y}px)" style:height="{marker.h}px" aria-hidden="true"></div>
	{/if}

	<div class="lockup" data-tauri-drag-region>
		<Emblem size={36} glow target />
		<div class="words">
			<span class="wordmark" style:--w="url({wordmark})" role="img" aria-label="Polestar"></span>
			<span class="tagline small">Client</span>
		</div>
	</div>

	{#snippet row(item: Item)}
		{@const active = app.screen === item.id}
		<button class="nav" class:active bind:this={rows[item.id]} onclick={() => go(item.id)} aria-current={active ? 'page' : undefined}>
			<Glyph name={item.glyph} color={active ? 'var(--accent)' : 'var(--textDim)'} />
			<span class="nav-label">{item.label}</span>
			{#if item.id === 'addons' && updates > 0}
				<span class="badge" title="{updates} {updates === 1 ? 'update' : 'updates'} ready">{updates}</span>
			{:else if item.id === 'home' && attention}
				<span class="dot" title={snapshot.status.title}></span>
			{/if}
		</button>
	{/snippet}

	<nav aria-label="Pages">
		{#each top as item (item.id)}{@render row(item)}{/each}
		<div class="heading small">Recording</div>
		{#each recording as item (item.id)}{@render row(item)}{/each}
	</nav>

	<div class="bottom">
		{@render row({ id: 'settings', label: 'Settings', glyph: 'sliders' })}
		<button class="state" onclick={() => go('home')} title={snapshot.status.title}>
			<Beacon kind={snapshot.status.kind} size={7} />
			<span class="state-label small">{snapshot.consent ? status.short : 'Sharing off'}</span>
		</button>
		<div class="version small">
			<span>Client <span class="num">{snapshot.version}</span></span>
			{#if snapshot.update}
				<button class="chip accent update" onclick={() => go('settings')}>Update to {snapshot.update}</button>
			{/if}
		</div>
	</div>
</aside>

<style>
	aside {
		position: relative;
		display: flex;
		flex-direction: column;
		min-height: 0;
		background: linear-gradient(180deg, rgba(40, 50, 84, 0.35), transparent 180px), var(--sidebar);
		border-right: 1px solid var(--divider);
	}
	/* The lockup centred on the page title's line. */
	.lockup {
		display: flex;
		align-items: center;
		gap: 12px;
		height: 96px;
		padding: 8px var(--sideEdge) 0;
	}
	.mac .lockup {
		height: 112px;
		padding-top: 30px;
	}
	.words {
		display: flex;
		flex-direction: column;
		gap: 5px;
		pointer-events: none;
	}
	/* The wordmark image's ink is 126x18 at (2, 7) of its 256x32: drawn 1:1, cropped to the ink. */
	.wordmark {
		display: block;
		width: 126px;
		height: 18px;
		background: var(--text);
		mask: var(--w) -2px -7px / 256px 32px no-repeat;
		-webkit-mask: var(--w) -2px -7px / 256px 32px no-repeat;
		filter: drop-shadow(1px 1px 0 rgba(0, 0, 5, 0.6));
	}
	.tagline {
		color: var(--textDim);
		letter-spacing: 0.16em;
		text-transform: uppercase;
		font-size: 10.5px;
		font-weight: 600;
		line-height: 1;
	}
	nav {
		display: flex;
		flex-direction: column;
		margin-top: 16px;
	}
	.marker {
		position: absolute;
		top: 0;
		left: 0;
		right: 0;
		z-index: 0;
		background: linear-gradient(90deg, var(--accentWash), var(--selected) 40%);
		pointer-events: none;
	}
	.marker::before {
		content: '';
		position: absolute;
		left: 0;
		top: 0;
		bottom: 0;
		width: 2px;
		background: var(--accent);
		box-shadow: 0 0 8px rgba(230, 186, 102, 0.55);
	}
	.marker.glide {
		transition: transform 280ms var(--easeMove);
	}
	.nav {
		position: relative;
		z-index: 1;
		display: flex;
		align-items: center;
		gap: 12px;
		height: 40px;
		padding: 0 var(--sideEdge);
		border: 0;
		background: none;
		color: var(--textDim);
		text-align: left;
		cursor: pointer;
		transition:
			color var(--fast) var(--ease),
			background-color var(--fast) var(--ease);
	}
	.nav :global(.glyph) {
		transition: background-color var(--base) var(--ease);
	}
	.nav:hover:not(.active) {
		background: var(--hover);
		color: var(--text);
	}
	.nav.active {
		color: var(--text);
	}
	.nav-label {
		flex: 1;
		min-width: 0;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
	}
	.badge {
		display: grid;
		place-items: center;
		min-width: 18px;
		height: 18px;
		padding: 0 5px;
		border-radius: 9999px;
		background: var(--chipAccent);
		color: var(--accent);
		font-size: 11px;
		font-weight: 600;
		text-shadow: none;
		font-variant-numeric: tabular-nums;
	}
	.dot {
		width: 6px;
		height: 6px;
		border-radius: 50%;
		background: var(--warning);
		box-shadow: 0 0 6px rgba(250, 191, 77, 0.6);
	}
	/* A heading row names the rows after it; it is not a choice. */
	.heading {
		display: flex;
		align-items: flex-end;
		height: 36px;
		padding: 0 var(--sideEdge) 8px;
		color: var(--textMuted);
	}
	.bottom {
		position: relative;
		display: flex;
		flex-direction: column;
		margin-top: auto;
		padding-bottom: 14px;
		border-top: 1px solid var(--divider);
	}
	.state {
		position: relative;
		z-index: 1;
		display: flex;
		align-items: center;
		gap: 6px;
		height: 32px;
		margin: 6px 0 0;
		padding: 0 var(--sideEdge) 0 calc(var(--sideEdge) - 4px);
		border: 0;
		background: none;
		color: var(--textDim);
		text-align: left;
		cursor: pointer;
		transition: color var(--fast) var(--ease);
	}
	.state:hover {
		color: var(--text);
	}
	.state-label {
		min-width: 0;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
	}
	.version {
		display: flex;
		align-items: center;
		gap: 8px;
		height: 20px;
		padding: 0 var(--sideEdge);
		color: var(--textMuted);
	}
	.version .num {
		font-size: 11px;
	}
	.update {
		cursor: pointer;
	}
</style>
