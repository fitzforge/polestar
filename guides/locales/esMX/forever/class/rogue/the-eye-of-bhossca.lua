-- Spanish (Latin America) (esMX): the guide forever/class/rogue/the-eye-of-bhossca (forever/class/rogue/the-eye-of-bhossca.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:277246} Ruby-Adorned Blade · {area:796} Scarlet Monastery
	["The {item:277246}, C's payment for a solo job inside the {area:796}."] = "{item:277246}, el pago de C por un trabajo en solitario dentro del {area:796}.",

	-- Step 1: C's dead drop
	["C's dead drop"] = "El buzón secreto de C",
	-- {object:410369} Dead Drop · {area:204} Pyrewood Village · {area:236} Shadowfang Keep
	["C's next job comes by letter: once you are level 30 and have done the horn job, visit any capital city and C's letter arrives in the mailbox; only then does the {object:410369} near {area:204}, in southern Silverpine just south of {area:236}, offer it. The quest data lists a minimum of 25, but players get the letter, and the job, at 30."] = "El siguiente trabajo de C llega por carta: cuando tengas nivel 30 y hayas hecho el trabajo del cuerno, visita cualquier capital y la carta de C llega al buzón; recién entonces {object:410369}, cerca de {area:204}, en el sur de Bosque de Argénteos justo al sur de {area:236}, lo ofrece. Los datos de la misión dicen nivel mínimo 25, pero los jugadores reciben la carta, y el trabajo, a nivel 30.",

	-- Step 2: The Scarlet Monastery
	-- {area:796} Scarlet Monastery
	["The {area:796}"] = "El {area:796}",
	-- {zone:1420} Tirisfal Glades · {spell:427592} Scarlet Initiate's Uniform · {spell:921} Pick Pocket · {npc:4293} Scarlet Scryer · {item:210963} Scryer's Key · {item:210968} Reliquary Key
	["The monastery stands in the far north-east of {zone:1420}. Go in alone, out of any group. Before entering, take the {spell:427592} from the Supply Locker in the stables behind the monastery and wear it; stealth and suspicious actions remove it, so put it back on after each wing change. In the Graveyard, in the Chamber of Atonement (the first big room), {spell:921} a {npc:4293} or Scarlet Crier for the {item:210963}. In the Library, open the Personal Letterbox in the Athenaeum with it and read the Confidential Message. It sends you back to sit on both benches between the two statues in the Graveyard. Watch for the mechanism's messages, then take the {item:210968} from the stone coffer: an elite stands by the coffer with a patrol behind it, but from beside the northern mausoleum you can turn the camera until the box shows and click it through the wall (an interact key works too). An elite ghost walks near the mausoleum; the broken piece at its edge keeps you out of its path. Then return to the Library for the locked reliquary and the eye. Avoid fighting through the instance."] = "El monasterio está en el extremo noreste de {zone:1420}. Entra solo, fuera de cualquier grupo. Antes de entrar, toma {spell:427592} del casillero de suministros de los establos detrás del monasterio y póntelo; el sigilo y las acciones sospechosas lo quitan, así que vuelve a ponértelo cada vez que cambies de ala. En el Cementerio, en la Cámara de la Expiación (la primera sala grande), usa {spell:921} sobre un {npc:4293} o un pregonero Escarlata para {item:210963}. En la Biblioteca, abre con él el buzón personal del Athenaeum y lee el mensaje confidencial. Te manda de vuelta a sentarte en los dos bancos entre las dos estatuas del Cementerio. Atento a los mensajes del mecanismo, y luego toma {item:210968} del cofre de piedra: un élite está junto al cofre con una patrulla detrás, pero desde al lado del mausoleo norte puedes girar la cámara hasta ver la caja y hacer clic a través de la pared (una tecla de interactuar también sirve). Un fantasma élite camina cerca del mausoleo; el trozo roto en su borde te mantiene fuera de su camino. Luego vuelve a la Biblioteca por el relicario cerrado y el ojo. Evita pelear a lo largo de la instancia.",
	["Solo route: Graveyard key, Library letter, Graveyard benches and coffer, then Library reliquary for the eye. Read the letter before the bench puzzle; check the disguise each time you change wings."] = "Ruta en solitario: llave en el Cementerio, carta en la Biblioteca, bancos y cofre en el Cementerio, y luego el relicario de la Biblioteca para el ojo. Lee la carta antes del acertijo de los bancos; revisa el disfraz cada vez que cambies de ala.",

	-- Step 3: Back to the dead drop
	["Back to the dead drop"] = "Regresa al buzón secreto",
	-- {object:410369} Dead Drop
	["Place the eye in the {object:410369} near Pyrewood. Check a capital mailbox for C's payment letter on your next planned city visit, then return here for the reward quest. The payment may not be available immediately; do not repeat the infiltration just because the reward has not appeared."] = "Deja el ojo en {object:410369} cerca de Piroleña. Revisa el buzón de una capital en tu próxima visita planeada para ver la carta de pago de C, y luego vuelve aquí para la misión de recompensa. Puede que el pago no esté disponible enseguida; no repitas la infiltración solo porque la recompensa todavía no apareció.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Find the Eye of Bhossca inside the {area:796}."] = "Encuentra el Eye of Bhossca dentro del {area:796}.",
	-- ["Place the eye in the {object:410369} near Pyrewood. C's payment is the second Eye of Bhossca quest at the same chest."] = "Deja el ojo en {object:410369}, cerca de Aldea Piroleña. El pago de C es la segunda misión Eye of Bhossca, en el mismo cofre.",
	-- ["The monastery stands in the far north-east of {zone:1420}. Go in alone; C advises a disguise from the monastery's grounds before you enter."] = "El monasterio está en el extremo noreste de {zone:1420}. Entra solo; C recomienda conseguir un disfraz en los terrenos del monasterio antes de entrar.",
	-- ["The {object:410369} is a chest near {area:204} in southern Silverpine, just south of {area:236}. C's next note waits there once you are 25."] = "{object:410369} es un cofre cerca de {area:204}, en el sur del Bosque de Argénteos, justo al sur de {area:236}. La siguiente nota de C te espera ahí cuando seas nivel 25.",
}
