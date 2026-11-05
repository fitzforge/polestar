<script lang="ts">
	// Characters as class, race and level only: the Recorder never keeps names.
	import { className, race } from '../lib/format';
	import type { CharacterSummary } from '../lib/types';

	let { characters }: { characters: CharacterSummary[] } = $props();
</script>

<div class="rows">
	{#each characters as c, i (i)}
		{@const grew = c.levelMax != null && c.levelMax !== c.levelMin}
		<div class="row">
			<span class="label">{race(c.race)} {className(c.class)}</span>
			{#if c.faction}<span class="small muted">{c.faction}</span>{/if}
			{#if c.levelMin != null}
				<span class="value num">{grew ? `Level ${c.levelMin} → ${c.levelMax}` : `Level ${c.levelMin}`}</span>
			{/if}
		</div>
	{/each}
</div>
