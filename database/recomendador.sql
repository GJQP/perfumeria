SELECT
        (CASE
             WHEN p.genero = 'M' THEN 1 --GENERO
             ELSE 0
            END) AS "Criterio Genero",
        (CASE
             WHEN p.edad = 'ADULTO' THEN 1 --EDAD
             ELSE 0
            END) AS "Criterio Edad",
        (CASE
             WHEN p.id = ANY(
                 SELECT pp.id_perf--, pa.palabra
                 FROM (SELECT *
                       FROM rig_palabras_familias pc,
                            rig_familias_perfumes pf
                       WHERE pc.id_fao = pf.id_fao
                      ) pp,
                      rig_palabras_claves pa
                 WHERE pp.id_pal = pa.id
                   AND pa.palabra = 'DIARIO' -- ASPECTO / PREFERENCIA / CARACTER
             ) THEN 1
             ELSE 0
            END) AS "Criterio Preferencia de uso",
        (CASE
             WHEN p.id = ANY(
                 SELECT pp.id_perf--, pa.palabra
                 FROM (SELECT *
                       FROM rig_palabras_familias pc,
                            rig_familias_perfumes pf
                       WHERE pc.id_fao = pf.id_fao
                      ) pp,
                      rig_palabras_claves pa
                 WHERE pp.id_pal = pa.id
                   AND pa.palabra IN('verano','placer') -- ASPECTO / PREFERENCIA / CARACTER
             ) THEN 1
             ELSE 0
            END) AS "Criterio Aspecto",
        (CASE
             WHEN p.id = ANY(
                 SELECT pp.id_perf--, pa.palabra
                 FROM (SELECT *
                       FROM rig_palabras_familias pc,
                            rig_familias_perfumes pf
                       WHERE pc.id_fao = pf.id_fao
                      ) pp,
                      rig_palabras_claves pa
                 WHERE pp.id_pal = pa.id
                   AND pa.palabra IN('verano','placer') -- ASPECTO / PREFERENCIA / CARACTER
             ) THEN 1
             ELSE 0
            END) AS "Criterio Caracter",
        (CASE
             WHEN p.id = ANY(
                 SELECT p.id
                 FROM rig_perfumes p,
                      rig_intensidades i
                 WHERE p.id = i.id_perf
                   AND i.tipo = 'EdT' -- TIPO
             ) THEN 1
             ELSE 0
            END) AS "Criterio Intensidad",
        (CASE
             WHEN p.id = ANY(
                 SELECT fp.id_perf
                 FROM  rig_familias_perfumes fp,
                       rig_familias_olfativas f
                 WHERE fp.id_fao = f.id
                   AND f.nombre IN('Citrico') --FAMILIAS
             ) THEN 1
             ELSE 0
            END) AS "Criterio Familias",
        (CASE
             WHEN p.id = ANY(
                 SELECT esenp.id_perf,f.nombre
                 FROM
                     (SELECT fam.nombre,es.id_esenp as id_esenp_fam
                      FROM rig_familias_olfativas fam,
                           rig_esencias es
                      WHERE fam.id = es.id_fao
                        AND fam.nombre IN ('Orientales','Otros') --ESENCIAS
                     ) f,
                     (SELECT n.id_perf, id_esenp as id_esenp_per
                      FROM rig_notas n
                      WHERE n.tipo = 'FONDO'
                      UNION
                      SELECT m.id_perf, m.id_esenp
                      FROM rig_monoliticos m
                     ) esenp
                 WHERE f.id_esenp_fam = esenp.id_esenp_per
             ) THEN 1
             ELSE 0
            END) AS "Criterio Esencias",
        p.nombre
    FROM rig_perfumes p


--UN PERFUME QUE TENGA POR LO MENOS
--* 1 EL GENERO
--* 2 EDAD
--* 3 TENGA LA PREFERENCIA
--* 4 TENGA LA INTENSIDAD
--* 5 TENGA ALGUN CARACTER (PALABRAS CLAVES)
--* 6 TENGA ALGUNA FAMILIA
--* 7 TENGA ALGUN AROMA
--* 8 TENGA ALGUN ASPECTO

--CURSED
/*
SELECT exodia."Criterio Genero" +
       exodia."Criterio Edad" +
       exodia."Criterio Preferencia de uso" +
       exodia."Criterio Aspecto" +
       exodia."Criterio Caracter" +
       exodia."Criterio Intensidad" +
       exodia."Criterio Familias" +
       exodia."Criterio Esencias" AS cumplimiento,
       exodia.nombre

FROM (SELECT
          (CASE
               WHEN p.genero = 'M' THEN 1 --GENERO
               ELSE 0
              END) AS "Criterio Genero",
          (CASE
               WHEN p.edad = 'ADULTO' THEN 1 --EDAD
               ELSE 0
              END) AS "Criterio Edad",
          (CASE
               WHEN p.id = ANY(
                   SELECT pp.id_perf--, pa.palabra
                   FROM (SELECT *
                         FROM rig_palabras_familias pc,
                              rig_familias_perfumes pf
                         WHERE pc.id_fao = pf.id_fao
                        ) pp,
                        rig_palabras_claves pa
                   WHERE pp.id_pal = pa.id
                     AND pa.palabra = 'DIARIO' -- ASPECTO / PREFERENCIA / CARACTER
               ) THEN 1
               ELSE 0
              END) AS "Criterio Preferencia de uso",
          (CASE
               WHEN p.id = ANY(
                   SELECT pp.id_perf--, pa.palabra
                   FROM (SELECT *
                         FROM rig_palabras_familias pc,
                              rig_familias_perfumes pf
                         WHERE pc.id_fao = pf.id_fao
                        ) pp,
                        rig_palabras_claves pa
                   WHERE pp.id_pal = pa.id
                     AND pa.palabra IN('verano','placer') -- ASPECTO / PREFERENCIA / CARACTER
               ) THEN 1
               ELSE 0
              END) AS "Criterio Aspecto",
          (CASE
               WHEN p.id = ANY(
                   SELECT pp.id_perf--, pa.palabra
                   FROM (SELECT *
                         FROM rig_palabras_familias pc,
                              rig_familias_perfumes pf
                         WHERE pc.id_fao = pf.id_fao
                        ) pp,
                        rig_palabras_claves pa
                   WHERE pp.id_pal = pa.id
                     AND pa.palabra IN('verano','placer') -- ASPECTO / PREFERENCIA / CARACTER
               ) THEN 1
               ELSE 0
              END) AS "Criterio Caracter",
          (CASE
               WHEN p.id = ANY(
                   SELECT p.id
                   FROM rig_perfumes p,
                        rig_intensidades i
                   WHERE p.id = i.id_perf
                     AND i.tipo = 'EdT' -- TIPO
               ) THEN 1
               ELSE 0
              END) AS "Criterio Intensidad",
          (CASE
               WHEN p.id = ANY(
                   SELECT fp.id_perf
                   FROM  rig_familias_perfumes fp,
                         rig_familias_olfativas f
                   WHERE fp.id_fao = f.id
                     AND f.nombre IN('Citrico') --FAMILIAS
               ) THEN 1
               ELSE 0
              END) AS "Criterio Familias",
          (CASE
               WHEN p.id = ANY(
                   SELECT esenp.id_perf
                   FROM
                       (SELECT fam.nombre,es.id_esenp as id_esenp_fam
                        FROM rig_familias_olfativas fam,
                             rig_esencias es
                        WHERE fam.id = es.id_fao
                          AND fam.nombre IN ('Orientales','Otros') --ESENCIAS
                       ) f,
                       (SELECT n.id_perf, id_esenp as id_esenp_per
                        FROM rig_notas n
                        WHERE n.tipo = 'FONDO'
                        UNION
                        SELECT m.id_perf, m.id_esenp
                        FROM rig_monoliticos m
                       ) esenp
                   WHERE f.id_esenp_fam = esenp.id_esenp_per
               ) THEN 1
               ELSE 0
              END) AS "Criterio Esencias",
          p.nombre
      FROM rig_perfumes p) exodia
ORDER BY cumplimiento DESC
