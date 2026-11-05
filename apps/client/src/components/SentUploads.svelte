<script lang="ts">
	// The "Already sent" tab of What we send: the uploads the server accepted that this PC still
	// keeps (sent.jsonl), each opening on what it held. Read on this PC only; nothing is asked of
	// the server.
	import { app } from '../lib/app.svelte';
	import { api, message } from '../lib/backend';
	import { bytes, plural, when } from '../lib/format';
	import { rise } from '../lib/motion';
	import type { Preview, SentUpload, Snapshot } from '../lib/types';
	import Emblem from './Emblem.svelte';
	import Glyph from './Glyph.svelte';
	import UploadDetail from './UploadDetail.svelte';

	let { snapshot }: { snapshot: Snapshot } = $props();

	const keyOf = (u: SentUpload) => `${u.at}:${u.install}`;

	let uploads = $state<SentUpload[] | null>(null);
	let error = $state<string | null>(null);
	let open = $state<string | null>(null);
	let detail = $state<Preview | null>(null);
	let detailError = $state<string | null>(null);
	let showRaw = $state(false);

	// A new upload lands here as soon as the server has accepted it.
	$effect(() => {
		void snapshot.status.lastUpload;
		api.sentUploads().then(
			(list) => ((uploads = list), (error = null)),
			(e) => (error = message(e)),
		);
	});

	function toggle(upload: SentUpload) {
		const key = keyOf(upload);
		if (open === key) {
			open = null;
			return;
		}
		open = key;
		detail = null;
		detailError = null;
		showRaw = false;
		api.sentUpload(upload.at, upload.install).then(
			(d) => {
				if (open === key) detail = d;
			},
			(e) => {
				if (open === key) detailError = message(e);
			},
		);
	}
</script>

{#if error}
	<p class="note warn selectable">{error}</p>
{:else if !uploads}
	<p class="note loading"><span class="spinner" style:color="var(--accent)"></span>Reading what was sent…</p>
{:else if uploads.length === 0}
	<div class="empty">
		<div class="watermark" aria-hidden="true"><Emblem size={168} /></div>
		<span class="halo"><Glyph name="check" size={36} color="var(--accent)" /></span>
		<h3>Nothing sent in the last 8 days</h3>
		<p class="note">What the server accepts from this PC shows up here, so you can look back at exactly what left it. Activity lists older uploads.</p>
	</div>
{:else}
	<p class="note lead">What the server accepted from this PC in the last 8 days, as it left. Activity lists older uploads.</p>
	<div class="list" role="list">
		{#each uploads as upload, i (keyOf(upload))}
			{@const key = keyOf(upload)}
			<div class="entry" class:open={open === key} role="listitem" style:--i={i}>
				<button class="line" onclick={() => toggle(upload)} aria-expanded={open === key}>
					<span class="kind"><Glyph name="check" size={14} color="var(--success)" /></span>
					<span class="what">
						{bytes(upload.bytes)} of play
						<span class="muted small">· {plural(upload.records, 'event', 'events')}</span>
					</span>
					<span class="when num muted">{when(upload.at, app.now)}</span>
					<span class="chev" aria-hidden="true"><Glyph name="chevron-down" size={12} color="var(--textMuted)" /></span>
				</button>
				{#if open === key}
					<div class="detail" in:rise={{ y: 4, duration: 180 }}>
						{#if detailError}
							<p class="note warn selectable">{detailError}</p>
						{:else if !detail}
							<p class="note loading"><span class="spinner" style:color="var(--accent)"></span>Reading this upload…</p>
						{:else}
							<UploadDetail upload={detail} heading="In this upload" />
							<section class="section">
								<h2>
									Raw JSON
									<button class="btn quiet small aside-btn" onclick={() => (showRaw = !showRaw)} aria-expanded={showRaw}>
										{showRaw ? 'Hide' : 'Show it'}
										<span class="raw-chev" class:up={showRaw}><Glyph name="chevron-down" size={12} /></span>
									</button>
								</h2>
								{#if showRaw}
									<pre class="json selectable" in:rise={{ y: 4 }}>{detail.json}</pre>
								{/if}
							</section>
						{/if}
					</div>
				{/if}
			</div>
		{/each}
	</div>
{/if}

<style>
	.lead {
		margin: var(--s2) 0 var(--s3);
	}
	.warn {
		color: var(--warning);
		margin: 0 0 var(--s3);
	}
	.loading {
		display: flex;
		align-items: center;
		gap: 10px;
		margin: var(--s4) 0;
	}
	.list {
		border-top: 1px solid var(--divider);
	}
	.entry {
		border-bottom: 1px solid var(--divider);
		animation: enter 300ms var(--ease) backwards;
		animation-delay: calc(min(var(--i), 8) * 28ms + 120ms);
	}
	@keyframes enter {
		from {
			opacity: 0;
			transform: translateY(5px);
		}
	}
	.line {
		display: grid;
		grid-template-columns: 20px minmax(0, 1fr) 128px 12px;
		align-items: center;
		gap: var(--s3);
		width: 100%;
		min-height: 44px;
		padding: 0 4px 0 0;
		border: 0;
		background: none;
		text-align: left;
		cursor: pointer;
		transition: background-color var(--fast) var(--ease);
	}
	.line:hover {
		background: var(--hover);
	}
	.kind {
		display: grid;
		place-items: center;
	}
	.what {
		min-width: 0;
		overflow: hidden;
		white-space: nowrap;
		text-overflow: ellipsis;
	}
	.when {
		text-align: right;
		white-space: nowrap;
	}
	.chev,
	.raw-chev {
		display: inline-grid;
		place-items: center;
		transition: transform var(--base) var(--ease);
	}
	.open .chev,
	.raw-chev.up {
		transform: rotate(180deg);
	}
	.detail {
		padding: var(--s2) 0 var(--s3) 32px;
	}
	.aside-btn {
		margin-left: auto;
		font-weight: 500;
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
		.entry {
			animation: none;
		}
	}
</style>
