<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class Recomendador extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return view('recomendador.recomendador');
    }

   public function recomendar(Request $request){
        $col = 0;
        $columnas = "p.nombre";
        //GENERO
        if( isset($request->genero) && $request->genero){
            $columnas .= ",
                (CASE
                    WHEN p.genero = '".$request->genero."' THEN 1 --GENERO
                ELSE 0
                END) AS \"Genero\"
            ";
            $col += 1;
        }

       //EDAD
       if( isset($request->edad) && $request->edad){
           $columnas .= ",
                (CASE
                    WHEN p.edad = '".$request->edad."' THEN 1 --EDAD
                    ELSE 0
                END) AS \"Edad\"
           ";
           $col += 1;
       }

       //PREFERENCIA
       if( isset($request->preferencia) && $request->preferencia) {
           $columnas .= ",
                (CASE
                   WHEN p.id = ANY(
                       SELECT p.id
                       FROM rig_perfumes p,
                            (
                                SELECT i.id_perf,
                                       (CASE
                                            WHEN i.tipo = 'EdS' THEN 'diario'
                                            WHEN i.tipo IN ('P','EdP') THEN 'ocasion especial'
                                            ELSE 'trabajo'
                                           END) as uso
                                FROM rig_intensidades i
                            ) i
                       WHERE p.id = i.id_perf
                         AND uso = '".$request->preferencia."'
                    ) THEN 1
                    ELSE 0
                END) AS \"Preferencia\"
           ";
           $col += 1;
       }

       //ASPECTO
       if( isset($request->aspecto) && $request->aspecto) {
            $columnas .= ",
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
                           AND pa.palabra IN(".$request->aspecto.") -- ASPECTO / PREFERENCIA / CARACTER
                     ) THEN 1
                     ELSE 0
                    END) AS \"Aspecto\"
            ";
           $col += 1;
       }

       //CARACTER
       if( isset($request->caracteres) && $request->caracteres) {
           $columnas .= ",
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
                           AND pa.palabra IN(".$request->caracteres.") -- ASPECTO / PREFERENCIA / CARACTER
                     ) THEN 1
                     ELSE 0
                    END) AS \"Caracter\"
            ";
           $col += 1;
       }

       //INTENSIDAD
       if( isset($request->intensidad) && $request->intensidad) {
           $columnas .= ",
                (CASE
                     WHEN p.id = ANY(
                         SELECT p.id
                         FROM rig_perfumes p,
                              rig_intensidades i
                         WHERE p.id = i.id_perf
                           AND i.tipo IN(".$request->intensidad.") -- TIPO
                     ) THEN 1
                     ELSE 0
                    END) AS \"Intensidad\"
           ";
           $col += 1;
       }

       //FAMILIAS
       if( isset($request->familia) && $request->familia) {
           $columnas .= ",
                (CASE
             WHEN p.id = ANY(
                 SELECT fp.id_perf
                 FROM  rig_familias_perfumes fp,
                       rig_familias_olfativas f
                 WHERE fp.id_fao = f.id
                   AND f.nombre IN(".$request->familia.") --FAMILIAS
             ) THEN 1
             ELSE 0
            END) AS \"Familia\"
           ";
           $col += 1;
       }

       //ESENCIAS
       if( isset($request->aromas) && $request->aromas) {
           $columnas .= ",
                (CASE
                WHEN p.id = ANY(
                    SELECT DISTINCT esenp.id_perf
                    FROM
                        (SELECT es.id_esenp as id_esenp_fam
                         FROM (SELECT pf.id_fao
                                FROM rig_palabras_claves pc,
                                     rig_palabras_familias pf
                                WHERE pc.id = pf.id_pal
                                    AND pc.palabra IN (".$request->aromas.") --ESENCIAS
                             ) fam,
                              rig_esencias es
                         WHERE fam.id_fao = es.id_fao
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
            END) AS \"Esencia\"
           ";
           $col += 1;
       }



       $result =  DB::select(
            DB::raw("
                SELECT ".$columnas."
                FROM rig_perfumes p
            ",[])
        );

       foreach ($result as $key => $item){
           $cumplimiento = 0;
           foreach ($item as $k => $val){
               if($k !== "nombre")
                   $cumplimiento += $val;
           }
           //dd($cumplimiento);
           $result[$key]->cumplimiento = $cumplimiento;
       }

       $collection = collect($result);

       $filtrado = $collection->filter(function ($value, $key) {
           return $value->cumplimiento > 0;
       })->sortByDesc('cumplimiento');

       return response()->json($filtrado->values()->all());
   }


   public function getDatosPerfume($id_perf)
   {
        // Buscamos el perfumista
        $perfumista = "SELECT perf.nombre FROM rig_perfumistas perf, rig_perfumes_perfumistas inter WHERE inter.id_perf = $id_perf AND inter.id_prefta = perf.id";
        $perfumista = DB::select($perfumista);

        // Buscamos las notas del perfume
        $notas = "SELECT esen.nombre FROM rig_monoliticos mono, rig_notas nota, rig_esencias_perfumes esen WHERE (mono.id_perf = $id_perf AND mono.id_esenp = esen.cas) OR (nota.id_perf = $id_perf AND nota.id_esenp = esen.cas) GROUP BY esen.nombre";
        $notas = DB::select($notas);

        $perfume = "SELECT * FROM rig_perfumes WHERE id = $id_perf";
        $perfume = DB::select($notas);

        $otros = "SELECT nombre FROM rig_otros_ingredientes ot, rig_componentes_funcionales cp WHERE cp.id_perf = $id_perf AND cp.cas_otr_ing = ot.cas";
        $otros = DB::select($otros);

        $aromas = "SELECT nombre FROM rig_familias_olfativas fao, rig_familias_perfumes inter WHERE fao.id = inter.id_fao AND inter.id_perf = $id_perf";
        $aromas = DB::select($aromas);

        $intensidades = "SELECT tipo FROM rig_intensidades WHERE id_perf = $id_perf";
        $intensidades = DB::select($intensidades);

        $presentaciones_perfumes = "SELECT vol, unidad FROM rig_presentaciones_perfumes WHERE id_perf = 1";
        $presentaciones_perfumes = DB::select($presentaciones_perfumes);

        return request()->json([
            'pefumista' => $perfumista, 
            'notas' => $notas,
            'perfume' => $perfume,
            'ingredientes' => $otros,
            'aromas' => $aromas,
            'intensidades' => $intensidades,
            'presentaciones' => $presentaciones_perfumes
        ]);
   }
}
