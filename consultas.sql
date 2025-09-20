SELECT
  l.id,
  l.nombre,
  SUM(NVL(c.precio_unitario, 0)) AS precio_total
FROM listas_de_reproduccion l
JOIN canciones_en_lista cel ON cel.lista_id = l.id
JOIN canciones c ON c.id = cel.cancion_id
GROUP BY l.id, l.nombre
ORDER BY precio_total DESC
FETCH FIRST 3 ROWS ONLY;

SELECT
  c.id,
  c.nombre,
  c.precio_unitario,
  tm.nombre AS tipo_medio
FROM canciones c
JOIN tipos_medio tm ON tm.id = c.medio_id
LEFT JOIN canciones_en_lista cel ON cel.cancion_id = c.id
WHERE cel.cancion_id IS NULL
  AND UPPER(tm.nombre) LIKE '%AAC%'
ORDER BY c.nombre;

SELECT
  a.nombre                                  AS nombre_artista,
  COUNT(DISTINCT al.id)                     AS total_albumes,
  ROUND(AVG(NVL(c.precio_unitario, 0)), 2)  AS precio_promedio
FROM artistas a
JOIN albumes  al ON al.artista_id = a.id
JOIN canciones c  ON c.album_id   = al.id
GROUP BY a.id, a.nombre
HAVING COUNT(DISTINCT al.id) > 5
ORDER BY total_albumes DESC, precio_promedio DESC;
