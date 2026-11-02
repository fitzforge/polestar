<script lang="ts">
	// Characters as class, race and level only: the Recorder never keeps names.
	import { className, race } from '../lib/format';
	import { msg, t } from '../lib/i18n.svelte';
	import type { CharacterSummary } from '../lib/types';

	let { characters }: { characters: CharacterSummary[] } = $props();

	/** The game's faction tokens (UnitFactionGroup) as players say them. */
	const FACTIONS: Record<string, string> = { Alliance: msg('Alliance'), Horde: msg('Horde') };
</script>

<div class="rows">
	{#each characters as c, i (i)}
		{@const grew = c.levelMax != null && c.levelMax !== c.levelMin}
		<div class="row">
			<span class="label">{t('{race} {class}', { race: race(c.race), class: className(c.class) })}</span>
			{#if c.faction}<span class="small muted">{FACTIONS[c.faction] ? t(FACTIONS[c.faction]) : c.faction}</span>{/if}
			{#if c.levelMin != null}
				<span class="value num">{grew ? t('Level {from} → {to}', { from: c.levelMin, to: c.levelMax ?? c.levelMin }) : t('Level {level}', { level: c.levelMin })}</span>
			{/if}
		</div>
	{/each}
</div>
