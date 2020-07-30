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
                         SELECT pp.id_perf--, pa.palabra
                         FROM (SELECT *
                               FROM rig_palabras_familias pc,
                                    rig_familias_perfumes pf
                               WHERE pc.id_fao = pf.id_fao
                              ) pp,
                              rig_palabras_claves pa
                         WHERE pp.id_pal = pa.id
                           AND pa.palabra = '".$request->preferencia."' -- ASPECTO / PREFERENCIA / CARACTER
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
                         SELECT esenp.id_perf
                         FROM
                             (SELECT fam.nombre,es.id_esenp as id_esenp_fam
                              FROM rig_familias_olfativas fam,
                                   rig_esencias es
                              WHERE fam.id = es.id_fao
                                AND fam.nombre IN (".$request->aromas.") --ESENCIAS
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

}
