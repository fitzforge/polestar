<script lang="ts">
	// What an upload holds, the next one or one already sent: anything wrong with it, its
	// summary, its characters and, on request, every event.
	import { count, plural, time } from '../lib/format';
	import { rise } from '../lib/motion';
	import { fieldName, kindName } from '../lib/records';
	import type { Preview } from '../lib/types';
	import Characters from './Characters.svelte';
	import Facts from './Facts.svelte';
	import Glyph from './Glyph.svelte';

	let { upload, heading }: { upload: Preview; heading: string } = $props();

	const PAGE = 200;
	let showRecords = $state(false);
	let shown = $state(PAGE);
</script>

{#each upload.problems as problem, i (i)}
	<p class="note warn selectable">{problem}</p>
{/each}
{#if upload.summary}
	<section class="section">
		<h2>{heading} <span class="aside small muted">{plural(upload.totalRecords, 'event', 'events')}</span></h2>
		<Facts summary={upload.summary} />
	</section>
	{#if upload.summary.characters.length > 0}
		<section class="section">
			<h2>Characters <span class="aside small muted">Class, race and level only, never names</span></h2>
			<Characters characters={upload.summary.characters} />
		</section>
	{/if}
{/if}
<section class="section">
	<h2>
		Every event
		<button class="btn quiet small aside-btn" onclick={() => (showRecords = !showRecords)} aria-expanded={showRecords}>
			{showRecords ? 'Hide' : 'Show them all'}
			<span class="chev" class:up={showRecords}><Glyph name="chevron-down" size={12} /></span>
		</button>
	</h2>
	{#if showRecords}
		<div in:rise={{ y: 4 }}>
			<table>
				<thead class="small muted">
					<tr><th>Time</th><th>What</th><th>Details</th></tr>
				</thead>
				<tbody>
					{#each upload.records.slice(0, shown) as r, i (i)}
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
			{#if shown < upload.records.length}
				<div class="more">
					<button class="btn" onclick={() => (shown += PAGE)}>Show {count(Math.min(PAGE, upload.records.length - shown))} more</button>
					<span class="small muted">{count(shown)} of {count(upload.totalRecords)}</span>
				</div>
			{:else if upload.records.length < upload.totalRecords}
				<p class="small muted">The first {count(upload.records.length)} events; Raw JSON has all {count(upload.totalRecords)}.</p>
			{/if}
		</div>
	{/if}
</section>

<style>
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
</style>
