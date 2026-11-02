<script lang="ts">
	import { onMount, tick } from 'svelte';
	import { api, message } from '../lib/backend';
	import { bytes, time } from '../lib/format';
	import { msg, t, tn } from '../lib/i18n.svelte';
	import { NEVER, NEVER_NOTE } from '../lib/copy';
	import { fade, rise, swap } from '../lib/motion';
	import { fieldName, kindName } from '../lib/records';
	import type { Preview, Snapshot } from '../lib/types';
	import PageHeader from '../components/PageHeader.svelte';
	import Glyph from '../components/Glyph.svelte';
	import Emblem from '../components/Emblem.svelte';
	import Facts from '../components/Facts.svelte';
	import Characters from '../components/Characters.svelte';

	let { snapshot }: { snapshot: Snapshot } = $props();

	type Tab = 'readable' | 'json' | 'never';
	const tabs: { id: Tab; label: string }[] = [
		{ id: 'readable', label: msg('Readable') },
		{ id: 'json', label: msg('Raw JSON') },
		{ id: 'never', label: msg('Never sent') },
	];
	const PAGE = 200;

	let tab = $state<Tab>('readable');
	let preview = $state<Preview | null>(null);
	let error = $state<string | null>(null);
	let showRecords = $state(false);
	let shown = $state(PAGE);
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
		const at = tabs.findIndex((x) => x.id === tab);
		tab = tabs[(at + (e.key === 'ArrowRight' ? 1 : tabs.length - 1)) % tabs.length].id;
		void tick().then(() => tabEls[tab]?.focus());
	}
</script>

<PageHeader title={t('What we send')} subtitle={`${t('Your next upload, exactly as it will leave this PC, with names already replaced.')} ${t('Nothing else is sent.')}`} />

<!-- svelte-ignore a11y_interactive_supports_focus -->
<div class="tabs" role="tablist" tabindex="-1" bind:this={bar} onkeydown={keys}>
	{#each tabs as item (item.id)}
		<button role="tab" class="tab" class:active={tab === item.id} aria-selected={tab === item.id} tabindex={tab === item.id ? 0 : -1} bind:this={tabEls[item.id]} onclick={() => (tab = item.id)}>{t(item.label)}</button>
	{/each}
	{#if underline}<span class="underline" class:glide style:transform="translateX({underline.x}px)" style:width="{underline.w}px" aria-hidden="true"></span>{/if}
	{#if preview && preview.chunks > 0}
		<span class="size small muted" in:fade>{t('{size} waiting to send', { size: bytes(preview.bytes) })}</span>
	{/if}
</div>

<div class="body">
	<div class="column">
		{#key tab}
			<div class="panel" in:rise={{ y: 4, duration: 200 }}>
				{#if tab === 'never'}
					<p class="note lead">{t('Whatever the Recorder sees, these never leave your PC:')}</p>
					<ul class="never">
						{#each NEVER as item, i (item)}
							<li style:--i={i}><Glyph name="close" size={12} color="var(--textMuted)" /><span>{t(item)}</span></li>
						{/each}
					</ul>
					<p class="note">{t(NEVER_NOTE)}</p>
				{:else if error}
					<p class="note warn selectable">{error}</p>
				{:else if !preview}
					<p class="note loading"><span class="spinner" style:color="var(--accent)"></span>{t("Reading the Recorder's file…")}</p>
				{:else if preview.chunks === 0}
					<div class="empty">
						<div class="watermark" aria-hidden="true"><Emblem size={168} /></div>
						<span class="halo"><Glyph name="eye" size={36} color="var(--accent)" /></span>
						<h3>{t('Nothing waiting to be sent')}</h3>
						<p class="note">{t("Your next upload shows up here, piece by piece, as soon as the game saves the Recorder's file: when you log out or type /reload.")}</p>
					</div>
				{:else if tab === 'json'}
					<div class="jsonbar">
						<span class="note">{tn('Sent in {count} request to {server}.', 'Sent in {count} requests to {server}.', preview.requests, { server: snapshot.serverUrl.replace(/^https?:\/\//, '') })} {t('The server knows this PC only by a random key it gave it, and keeps only a scrambled copy of that key.')}</span>
						<button class="btn copy" class:copied onclick={copy}>
							{#key copied}<span class="copy-label" in:swap>{#if copied}<Glyph name="check" size={12} color="var(--success)" />{t('Copied')}{:else}{t('Copy')}{/if}</span>{/key}
						</button>
					</div>
					<pre class="json selectable">{preview.json}</pre>
				{:else}
					{#each preview.problems as problem, i (i)}
						<p class="note warn selectable">{problem}</p>
					{/each}
					{#if preview.summary}
						<section class="section">
							<h2>{t('In this upload')} <span class="aside small muted">{tn('{count} event', '{count} events', preview.totalRecords)}</span></h2>
							<Facts summary={preview.summary} />
						</section>
						{#if preview.summary.characters.length > 0}
							<section class="section">
								<h2>{t('Characters')} <span class="aside small muted">{t('Class, race and level only, never names')}</span></h2>
								<Characters characters={preview.summary.characters} />
							</section>
						{/if}
					{/if}
					<section class="section">
						<h2>
							{t('Every event')}
							<button class="btn quiet small aside-btn" onclick={() => (showRecords = !showRecords)} aria-expanded={showRecords}>
								{showRecords ? t('Hide') : t('Show them all')}
								<span class="chev" class:up={showRecords}><Glyph name="chevron-down" size={12} /></span>
							</button>
						</h2>
						{#if showRecords}
							<div in:rise={{ y: 4 }}>
								<table>
									<thead class="small muted">
										<tr><th>{t('Time')}</th><th>{t('What')}</th><th>{t('Details')}</th></tr>
									</thead>
									<tbody>
										{#each preview.records.slice(0, shown) as r, i (i)}
											<tr>
												<td class="num muted">{time(r.t)}</td>
												<td><span class="chip" title={r.kind}>{kindName(r.kind)}</span></td>
												<td class="fields">
													{#each r.fields as [name, value], j (j)}
														{#if value !== ''}<span class="pair" title={name}><span class="muted">{fieldName(name)}</span> {value}</span>{/if}
													{/each}
												</td>
											</tr>
										{/each}
									</tbody>
								</table>
								{#if shown < preview.records.length}
									<div class="more">
										<button class="btn" onclick={() => (shown += PAGE)}>{tn('Show {count} more', 'Show {count} more', Math.min(PAGE, preview.records.length - shown))}</button>
										<span class="small muted">{t('{shown} of {total}', { shown, total: preview.totalRecords })}</span>
									</div>
								{:else if preview.records.length < preview.totalRecords}
									<p class="small muted">{tn('The first {count} event; Raw JSON has all {total}.', 'The first {count} events; Raw JSON has all {total}.', preview.records.length, { total: preview.totalRecords })}</p>
								{/if}
							</div>
						{/if}
					</section>
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
	.aside-btn {
		margin-left: auto;
		font-weight: 500;
	}
	.chev {
		display: inline-grid;
		transition: transform var(--base) var(--ease);
	}
	.chev.up {
		transform: rotate(180deg);
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
	table {
		width: 100%;
		border-collapse: collapse;
		user-select: text;
		-webkit-user-select: text;
	}
	th {
		text-align: left;
		font-weight: 500;
		height: 32px;
		border-bottom: 1px solid var(--divider);
	}
	td {
		padding: 7px 12px 7px 0;
		border-bottom: 1px solid var(--divider);
		vertical-align: top;
		font-size: 12px;
	}
	th:first-child,
	td:first-child {
		width: 72px;
	}
	th:nth-child(2),
	td:nth-child(2) {
		width: 136px;
	}
	.fields {
		color: var(--text);
		word-break: break-word;
	}
	.pair {
		display: inline-block;
		margin-right: 12px;
	}
	.more {
		display: flex;
		align-items: center;
		gap: 12px;
		margin-top: 12px;
	}
	@media (prefers-reduced-motion: reduce) {
		.never li {
			animation: none;
		}
	}
</style>
