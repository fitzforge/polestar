<script lang="ts">
	import { onMount, tick } from 'svelte';
	import { api, message } from '../lib/backend';
	import { bytes, plural } from '../lib/format';
	import { NEVER, NEVER_NOTE } from '../lib/copy';
	import { fade, rise, swap } from '../lib/motion';
	import type { Preview, Snapshot } from '../lib/types';
	import PageHeader from '../components/PageHeader.svelte';
	import Glyph from '../components/Glyph.svelte';
	import Emblem from '../components/Emblem.svelte';
	import SentUploads from '../components/SentUploads.svelte';
	import UploadDetail from '../components/UploadDetail.svelte';

	let { snapshot }: { snapshot: Snapshot } = $props();

	type Tab = 'readable' | 'json' | 'sent' | 'never';
	const tabs: { id: Tab; label: string }[] = [
		{ id: 'readable', label: 'Readable' },
		{ id: 'json', label: 'Raw JSON' },
		{ id: 'sent', label: 'Already sent' },
		{ id: 'never', label: 'Never sent' },
	];

	let tab = $state<Tab>('readable');
	let preview = $state<Preview | null>(null);
	let error = $state<string | null>(null);
	let copied = $state(false);

	// The next upload changes when new play arrives or some is sent.
	$effect(() => {
		void snapshot.pending;
		api.preview().then(
			(p) => ((preview = p), (error = null)),
			(e) => (error = message(e)),
		);
	});

	async function copy() {
		if (!preview) return;
		await navigator.clipboard.writeText(preview.json);
		copied = true;
		setTimeout(() => (copied = false), 1800);
	}

	// The active tab's underline glides between tabs (transform only).
	let bar: HTMLElement;
	const tabEls: Partial<Record<Tab, HTMLElement>> = {};
	let underline = $state<{ x: number; w: number } | null>(null);
	let glide = $state(false);
	function place() {
		const el = tabEls[tab];
		if (!el || !bar) return;
		underline = { x: el.offsetLeft, w: el.offsetWidth };
	}
	$effect(() => {
		void tab;
		void tick().then(place);
	});
	onMount(() => {
		place();
		requestAnimationFrame(() => (glide = true));
	});

	function keys(e: KeyboardEvent) {
		if (e.key !== 'ArrowLeft' && e.key !== 'ArrowRight') return;
		const at = tabs.findIndex((t) => t.id === tab);
		tab = tabs[(at + (e.key === 'ArrowRight' ? 1 : tabs.length - 1)) % tabs.length].id;
		void tick().then(() => tabEls[tab]?.focus());
	}
</script>

<PageHeader title="What we send" subtitle={tab === 'sent' ? 'What has already left this PC, with names replaced as it was sent.' : 'Your next upload, exactly as it will leave this PC, with names already replaced. Nothing else is sent.'} />

<!-- svelte-ignore a11y_interactive_supports_focus -->
<div class="tabs" role="tablist" tabindex="-1" bind:this={bar} onkeydown={keys}>
	{#each tabs as t (t.id)}
		<button role="tab" class="tab" class:active={tab === t.id} aria-selected={tab === t.id} tabindex={tab === t.id ? 0 : -1} bind:this={tabEls[t.id]} onclick={() => (tab = t.id)}>{t.label}</button>
	{/each}
	{#if underline}<span class="underline" class:glide style:transform="translateX({underline.x}px)" style:width="{underline.w}px" aria-hidden="true"></span>{/if}
	{#if preview && preview.chunks > 0}
		<span class="size small muted" in:fade>{bytes(preview.bytes)} waiting to send</span>
	{/if}
</div>

<div class="body">
	<div class="column">
		{#key tab}
			<div class="panel" in:rise={{ y: 4, duration: 200 }}>
				{#if tab === 'never'}
					<p class="note lead">Whatever the Recorder sees, these never leave your PC:</p>
					<ul class="never">
						{#each NEVER as item, i (item)}
							<li style:--i={i}><Glyph name="close" size={12} color="var(--textMuted)" /><span>{item}</span></li>
						{/each}
					</ul>
					<p class="note">{NEVER_NOTE}</p>
				{:else if tab === 'sent'}
					<SentUploads {snapshot} />
				{:else if error}
					<p class="note warn selectable">{error}</p>
				{:else if !preview}
					<p class="note loading"><span class="spinner" style:color="var(--accent)"></span>Reading the Recorder's file…</p>
				{:else if preview.chunks === 0}
					<div class="empty">
						<div class="watermark" aria-hidden="true"><Emblem size={168} /></div>
						<span class="halo"><Glyph name="eye" size={36} color="var(--accent)" /></span>
						<h3>Nothing waiting to be sent</h3>
						<p class="note">Your next upload shows up here, piece by piece, as soon as the game saves the Recorder's file: when you log out or type /reload.</p>
						<button class="btn quiet small to-sent" onclick={() => (tab = 'sent')}>See what's already been sent</button>
					</div>
				{:else if tab === 'json'}
					<div class="jsonbar">
						<span class="note">Sent in {plural(preview.requests, 'request', 'requests')} to {snapshot.serverUrl.replace(/^https?:\/\//, '')}. The server knows this PC only by a random key it gave it, and keeps only a scrambled copy of that key.</span>
						<button class="btn copy" class:copied onclick={copy}>
							{#key copied}<span class="copy-label" in:swap>{#if copied}<Glyph name="check" size={12} color="var(--success)" />Copied{:else}Copy{/if}</span>{/key}
						</button>
					</div>
					<pre class="json selectable">{preview.json}</pre>
				{:else}
					<UploadDetail upload={preview} heading="In this upload" />
				{/if}
			</div>
		{/key}
	</div>
</div>

<style>
	/* The tab band: 40px tabs standing on one hairline under the band. */
	.tabs {
		position: relative;
		flex: none;
		display: flex;
		align-items: flex-end;
		gap: 4px;
		height: 40px;
		margin-top: -8px;
		padding: 0 var(--edge) 0 20px;
		border-bottom: 1px solid var(--divider);
		outline: none;
	}
	.tab {
		position: relative;
		height: 40px;
		padding: 0 12px;
		border: 0;
		background: none;
		color: var(--textDim);
		font-size: 12px;
		cursor: pointer;
		transition:
			color var(--fast) var(--ease),
			background-color var(--fast) var(--ease);
	}
	.tab:hover {
		background: var(--hover);
		color: var(--text);
	}
	.tab.active {
		color: var(--text);
	}
	.underline {
		position: absolute;
		left: 0;
		bottom: -1px;
		height: 2px;
		background: var(--accent);
		box-shadow: 0 0 8px rgba(230, 186, 102, 0.5);
	}
	.underline.glide {
		transition:
			transform var(--slow) var(--easeMove),
			width var(--slow) var(--easeMove);
	}
	.size {
		margin-left: auto;
		align-self: center;
	}
	.body {
		padding-top: var(--s3);
	}
	.lead {
		margin: var(--s2) 0 6px;
	}
	.loading {
		display: flex;
		align-items: center;
		gap: 10px;
		margin: var(--s4) 0;
	}
	.never {
		list-style: none;
		margin: 0 0 14px;
		padding: 0;
	}
	.never li {
		display: flex;
		align-items: center;
		gap: 12px;
		height: 38px;
		border-bottom: 1px solid var(--divider);
		animation: enter 280ms var(--ease) backwards;
		animation-delay: calc(var(--i) * 30ms + 180ms);
	}
	@keyframes enter {
		from {
			opacity: 0;
			transform: translateY(4px);
		}
	}
	.warn {
		color: var(--warning);
		margin: 0 0 var(--s3);
	}
	.to-sent {
		margin-top: var(--s3);
	}
	.jsonbar {
		display: flex;
		align-items: center;
		justify-content: space-between;
		gap: var(--s4);
		min-height: 52px;
		padding-bottom: var(--s2);
	}
	.jsonbar .note {
		max-width: 64ch;
	}
	.copy {
		min-width: 92px;
	}
	.copy.copied {
		border-color: rgba(107, 217, 153, 0.45);
	}
	.copy-label {
		display: inline-flex;
		align-items: center;
		gap: 6px;
	}
	.json {
		margin: 0;
		padding: 12px 14px;
		background: var(--inset);
		border: 1px solid var(--border);
		font: 400 11.5px/1.55 ui-monospace, 'SF Mono', 'Cascadia Mono', 'DejaVu Sans Mono', monospace;
		color: var(--textDim);
		white-space: pre-wrap;
		word-break: break-all;
		text-shadow: none;
	}
	@media (prefers-reduced-motion: reduce) {
		.never li {
			animation: none;
		}
	}
</style>
