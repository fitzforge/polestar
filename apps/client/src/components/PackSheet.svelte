<script lang="ts">
	// What a polestar://install link asks, before anything happens: the pack's
	// title, author, version and size and the folders it will create, with
	// Install and Cancel. Never a silent install. A link that can't be used says
	// why. The Community page opens it too (`page`), as the confirm for an update
	// that isn't routine: a replaced guide, a new publisher, changed folders; the
	// sheet names what changed and is itself the explicit confirm. It takes focus
	// as it opens (on Cancel), keeps Tab inside, and Escape or the scrim closes it;
	// while installing it shows the phase and stays open.
	import { onMount } from 'svelte';
	import { api, message } from '../lib/backend';
	import { bytes } from '../lib/format';
	import { fade, rise, swap } from '../lib/motion';
	import { toast } from '../lib/toast.svelte';
	import type { Community, Pack, PackLink } from '../lib/types';
	import Band from './Band.svelte';
	import Glyph from './Glyph.svelte';

	let {
		link,
		community,
		page = false,
		onclose,
		ondone,
	}: { link: PackLink; community: Community; page?: boolean; onclose: () => void; ondone?: (action: 'install' | 'update') => void } = $props();

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

	/** What the main button does here, or null when there is nothing to do. */
	const verb = $derived.by((): 'install' | 'update' | null => {
		if (!pack) return null;
		switch (pack.status) {
			case 'update':
			case 'replaced':
				return 'update';
			case 'install':
				return 'install';
			case 'disabled':
			case 'removed':
				return pack.version ? 'install' : null;
			default:
				return null;
		}
	});
	/** An update that isn't routine: the backend wants `confirm`, and this sheet is it. */
	const confirming = $derived(verb === 'update' && (pack?.status === 'replaced' || !!pack?.changes));
	const kind = $derived(
		link.error
			? 'Install link'
			: pack?.status === 'replaced'
				? `Replaced on ${community.site}`
				: page && verb === 'update'
					? `Update from ${community.site}`
					: `Install from ${community.site}`,
	);

	/** The changes an update makes, one line each. */
	function changeLines(p: Pack): string[] {
		const c = p.changes;
		if (!c) return [];
		const lines: string[] = [];
		if (c.publisher && !c.replaced) lines.push(`New publisher: ${c.publisher.from ?? 'unknown'} → ${c.publisher.to ?? 'unknown'}`);
		if (c.added.length) lines.push(`New folders: ${c.added.join(', ')}`);
		if (c.removed.length) lines.push(`Folders it no longer has: ${c.removed.join(', ')}`);
		return lines;
	}

	let panel: HTMLElement;
	let cancel = $state<HTMLButtonElement>();
	onMount(() => cancel?.focus());

	async function install() {
		if (!pack || !verb) return;
		failed = null;
		started = true;
		try {
			toast(await api.packAction(pack.id, verb, confirming));
			ondone?.(verb);
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
			<span class="mark"><Glyph name={link.error || pack?.status === 'replaced' ? 'info' : 'flag'} size={18} color={link.error || pack?.status === 'replaced' ? 'var(--warning)' : 'var(--accent)'} /></span>
			<div class="titles">
				<p class="small dim kind">{kind}</p>
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
			<p class="note by">
				by {pack.author}{#if pack.publisher && pack.publisher !== pack.author}<span class="muted">· shared by {pack.publisher}</span>{/if}
				{#if pack.official}<span class="chip accent">Official</span>{:else if pack.reviewed}<span class="chip">Reviewed</span>{/if}
			</p>
			<dl class="facts">
				<div><dt class="small muted">Version</dt><dd class="num">{#if pack.installed && (pack.status === 'update' || pack.status === 'replaced')}{pack.installed} <span class="arrow">→</span> {/if}{pack.version ?? pack.installed}</dd></div>
				{#if pack.size}<div><dt class="small muted">Download</dt><dd class="num">{bytes(pack.size)}</dd></div>{/if}
				<div class="wide">
					<dt class="small muted">{pack.installed ? 'Its folders in AddOns' : 'It will create in AddOns'}</dt>
					<dd>{#each pack.folders as folder (folder)}<span class="folder path">{folder}</span>{/each}</dd>
				</div>
			</dl>
			{#if pack.status === 'replaced'}
				<p class="out bad">
					The guide you installed as ‘{pack.title}’ was replaced on {community.site} by a different guide{#if pack.changes?.publisher?.to}, from a new publisher: {pack.changes.publisher.to}{/if}. Installing puts the new one in its place. Cancel keeps yours.
				</p>
			{:else if verb === 'update' && pack.changes}
				<div class="changes">
					<p class="small muted">This update isn't routine, so it asks first:</p>
					<ul>
						{#each changeLines(pack) as line (line)}<li>{line}</li>{/each}
					</ul>
				</div>
			{:else if pack.revoked && (pack.status === 'disabled' || pack.status === 'removed')}
				<p class="out bad">{pack.revoked.reason}</p>
				<p class="out">
					{pack.status === 'disabled' ? `Turned off by ${community.site}. Its files were moved out of AddOns.` : `Removed by ${community.site}.`}
					{#if pack.version}Version {pack.version} is still offered.{/if}
				</p>
			{/if}
			{#if pack.status === 'upToDate'}
				<p class="out">{pack.title} {pack.installed} is installed and up to date.</p>
			{:else if pack.status === 'noGame'}
				<p class="out bad">Polestar Client hasn't found WoW: Forever yet. Locate the game in Settings, then open the link again.</p>
			{:else if pack.blocked}
				<p class="out bad">{pack.blocked}</p>
			{:else if failed}
				<p class="out bad" in:swap>{failed}</p>
			{:else if verb}
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
				{pack?.status === 'replaced' ? 'Replace' : verb === 'update' ? `Update to ${pack?.version}` : pack?.installed ? `Install ${pack.version}` : 'Install'}
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
	.changes {
		margin-top: var(--s4);
		padding: var(--s2) var(--s3);
		background: var(--inset);
		border: 1px solid rgba(250, 191, 77, 0.3);
	}
	.changes p {
		margin: 0 0 4px;
	}
	.changes ul {
		margin: 0;
		padding-left: 18px;
		color: var(--warning);
	}
	.changes li {
		overflow-wrap: anywhere;
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
