<script lang="ts">
	// What a polestar://install link asks, before anything happens: the pack's
	// title, author, version and size and the folders it will create, with
	// Install and Cancel. Never a silent install. A link that can't be used says
	// why. It takes focus as it opens (on Cancel), keeps Tab inside, and Escape or
	// the scrim closes it; while installing it shows the phase and stays open.
	import { onMount } from 'svelte';
	import { api, message } from '../lib/backend';
	import { bytes } from '../lib/format';
	import { fade, rise, swap } from '../lib/motion';
	import { toast } from '../lib/toast.svelte';
	import type { Community, PackLink } from '../lib/types';
	import Band from './Band.svelte';
	import Glyph from './Glyph.svelte';

	let { link, community, onclose }: { link: PackLink; community: Community; onclose: () => void } = $props();

	const PHASE: Record<string, string> = { download: 'Downloading', verify: 'Checking', install: 'Installing' };

	const pack = $derived(link.pack ? community.packs.find((p) => p.id === link.pack) ?? null : null);
	const looking = $derived(!pack && !link.error && community.available && (community.checking || !community.checkedAt));
	const busy = $derived(pack?.busy ?? null);
	const pct = $derived(pack?.progress?.total ? Math.min(1, pack.progress.done / pack.progress.total) : null);
	let failed = $state<string | null>(null);
	let started = $state(false);

	const heading = $derived(
		link.error
			? "This link can't be used"
			: !community.available
				? "Community Guides aren't available yet"
				: pack
					? pack.title
					: looking
						? 'Looking up the guide…'
						: `${link.pack} isn't on ${community.site}`,
	);
	/** What Install does here, or null when there is nothing to do. */
	const verb = $derived(!pack || pack.status === 'unlisted' || pack.status === 'noGame' ? null : pack.status === 'update' ? 'update' : pack.status === 'install' ? 'install' : null);

	let panel: HTMLElement;
	let cancel = $state<HTMLButtonElement>();
	onMount(() => cancel?.focus());

	async function install() {
		if (!pack || !verb) return;
		failed = null;
		started = true;
		try {
			toast(await api.packAction(pack.id, verb));
			onclose();
		} catch (e) {
			failed = message(e);
		} finally {
			started = false;
		}
	}

	function close() {
		if (!busy && !started) onclose();
	}

	function keys(e: KeyboardEvent) {
		if (e.key === 'Escape') {
			e.preventDefault();
			close();
		} else if (e.key === 'Tab') {
			const items = [...panel.querySelectorAll<HTMLElement>('button:not(:disabled)')];
			const first = items[0];
			const last = items[items.length - 1];
			if (e.shiftKey && document.activeElement === first) {
				e.preventDefault();
				last?.focus();
			} else if (!e.shiftKey && document.activeElement === last) {
				e.preventDefault();
				first?.focus();
			}
		}
	}
</script>

<svelte:window onkeydown={keys} />

<div class="scrim" role="presentation" onclick={close} transition:fade={{ duration: 200 }}></div>
<div class="sheet" role="dialog" aria-modal="true" aria-labelledby="sheet-title" bind:this={panel} in:rise={{ y: 10, duration: 240 }} out:fade={{ duration: 140 }}>
	<Band height={96}>
		<div class="head">
			<span class="mark"><Glyph name={link.error ? 'info' : 'flag'} size={18} color={link.error ? 'var(--warning)' : 'var(--accent)'} /></span>
			<div class="titles">
				<p class="small dim kind">{link.error ? 'Install link' : `Install from ${community.site}`}</p>
				<h2 id="sheet-title">{heading}</h2>
			</div>
		</div>
	</Band>

	<div class="content">
		{#if link.error}
			<p class="note">{link.error}</p>
		{:else if !community.available}
			<p class="note">This version of Polestar Client can't check guides from {community.site} yet, so it can't install {link.pack}. Guides arrive with a client update.</p>
		{:else if !pack}
			{#if looking}
				<p class="note looking"><span class="spinner"></span>Reading the guide list from {community.site}…</p>
			{:else}
				<p class="note">{community.error ?? `No guide named ${link.pack} is listed there. It may have been taken down; look for it on the site again.`}</p>
			{/if}
		{:else}
			<p class="note by">by {pack.author}{#if pack.official}<span class="chip accent">Official</span>{/if}</p>
			<dl class="facts">
				<div><dt class="small muted">Version</dt><dd class="num">{#if pack.installed && pack.status === 'update'}{pack.installed} <span class="arrow">→</span> {/if}{pack.version ?? pack.installed}</dd></div>
				{#if pack.size}<div><dt class="small muted">Download</dt><dd class="num">{bytes(pack.size)}</dd></div>{/if}
				<div class="wide">
					<dt class="small muted">{pack.installed ? 'Its folders in AddOns' : 'It will create in AddOns'}</dt>
					<dd>{#each pack.folders as folder (folder)}<span class="folder path">{folder}</span>{/each}</dd>
				</div>
			</dl>
			{#if pack.status === 'upToDate'}
				<p class="out">{pack.title} {pack.installed} is installed and up to date.</p>
			{:else if pack.status === 'noGame'}
				<p class="out bad">Polestar Client hasn't found WoW: Forever yet. Locate the game in Settings, then open the link again.</p>
			{:else if pack.blocked}
				<p class="out bad">{pack.blocked}</p>
			{:else if failed}
				<p class="out bad" in:swap>{failed}</p>
			{:else}
				<p class="out">Checked against {community.site}'s signed list before anything changes. Nothing else in AddOns is touched.</p>
			{/if}
		{/if}
	</div>

	<footer>
		{#if busy || started}
			{#key pack?.progress?.phase ?? 'start'}
				<span class="phase small" in:swap><span class="spinner"></span>{pack?.progress ? PHASE[pack.progress.phase] ?? 'Installing' : 'Starting'}{#if pct !== null}<span class="num">&nbsp;{Math.round(pct * 100)}%</span>{/if}</span>
			{/key}
			<span class="bar" class:indeterminate={pct === null} aria-hidden="true"><span class="fill" style:transform={pct === null ? undefined : `scaleX(${pct})`}></span></span>
		{/if}
		<span class="spacer"></span>
		<button class="btn quiet" bind:this={cancel} disabled={!!busy || started} onclick={close}>{verb ? 'Cancel' : 'Close'}</button>
		{#if verb}
			<button class="btn primary" disabled={!!pack?.blocked || !!busy || started} title={pack?.blocked ?? undefined} onclick={install}>
				{verb === 'update' ? `Update to ${pack?.version}` : 'Install'}
			</button>
		{/if}
	</footer>
</div>

<style>
	.scrim {
		position: fixed;
		inset: 0;
		z-index: 45;
		background: rgba(5, 8, 15, 0.6);
	}
	.sheet {
		position: fixed;
		z-index: 46;
		/* Over the page it was opened on (the page contains it, as it does the notes drawer). */
		left: 50%;
		top: 50%;
		width: min(460px, calc(100% - 48px));
		margin: 0;
		translate: -50% -50%;
		display: flex;
		flex-direction: column;
		background: var(--bg);
		border: 1px solid var(--border);
		box-shadow: var(--shadowWindow);
	}
	.head {
		position: relative;
		display: flex;
		align-items: center;
		gap: var(--s3);
		padding: 26px var(--s5) 0;
	}
	.mark {
		display: grid;
		place-items: center;
		flex: none;
		width: 40px;
		height: 40px;
		background: var(--inset);
		border: 1px solid var(--border);
	}
	.titles {
		min-width: 0;
	}
	.kind {
		margin: 0 0 3px;
	}
	h2 {
		margin: 0;
		font-size: 18px;
		font-weight: 600;
		line-height: 24px;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
	}
	.content {
		padding: var(--s2) var(--s5) var(--s5);
	}
	.content > p {
		margin: 0;
	}
	.by {
		display: flex;
		align-items: center;
		gap: 8px;
	}
	.looking {
		display: flex;
		align-items: center;
		gap: 8px;
	}
	.facts {
		display: grid;
		grid-template-columns: 1fr 1fr;
		gap: var(--s3) var(--s5);
		margin: var(--s4) 0 0;
		padding: var(--s3) 0 0;
		border-top: 1px solid var(--divider);
	}
	.facts .wide {
		grid-column: 1 / -1;
	}
	dt {
		margin-bottom: 4px;
	}
	dd {
		display: flex;
		flex-wrap: wrap;
		gap: 6px;
		margin: 0;
	}
	.arrow {
		color: var(--accent);
	}
	.folder {
		padding: 2px 8px;
		background: var(--inset);
		border: 1px solid var(--border);
		font: 500 11.5px/1.5 ui-monospace, 'SF Mono', 'Cascadia Mono', 'DejaVu Sans Mono', monospace;
		text-shadow: none;
	}
	.out {
		margin-top: var(--s4) !important;
		max-width: 52ch;
	}
	footer {
		position: relative;
		display: flex;
		align-items: center;
		gap: var(--s2);
		height: 56px;
		padding: 0 var(--s5);
		background: var(--footer);
		border-top: 1px solid var(--border);
	}
	.spacer {
		flex: 1;
	}
	.phase {
		display: inline-flex;
		align-items: center;
		gap: 7px;
		color: var(--accent);
		white-space: nowrap;
	}
	.bar {
		position: absolute;
		left: 0;
		right: 0;
		top: -1px;
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
	@media (prefers-reduced-motion: reduce) {
		.indeterminate .fill {
			animation: none;
			width: 100%;
			opacity: 0.5;
		}
	}
</style>
