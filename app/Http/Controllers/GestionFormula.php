<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class GestionFormula extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index($id = NULL)
    {
        $productores = "SELECT mem.id_prod, prod.nombre FROM rig_membresias mem, rig_productores prod WHERE fcha_fin IS NULL AND id_prod IS NOT NULL AND mem.id_prod = prod.id";
        $productores = DB::select("$productores");
        if(empty($productores))
            return redirect()->back()->with('error', 'No hay proveedores con mebresías activas');
        //dd($productores);
        if($id == NULL)
            $id = $productores[0]->id_prod;
        $variables = "SELECT rec.id_var, rec.fcha_reg, rec.tipo_eval, rec.peso FROM rig_evaluaciones_criterios rec INNER JOIN rig_variables var ON rec.id_var = var.id WHERE rec.id_prod=$id";
        $variables = DB::select("$variables");
        $iniciales = [];
        $renovaciones = [];
        foreach($variables as $variable)
            if($variable->tipo_eval == "INICIAL")
                $iniciales = array_merge($iniciales, $variable);
            else
                $renovaciones = array_merge($renovaciones, $variable);
        $escala = "SELECT fcha_reg, rgo_ini, rgo_fin FROM rig_escalas WHERE id_prod = $id";
        $escala = DB::select("$escala");
        return view('Formula.gestionformula')->with([
            "productores" => $productores,
            "iniciales" => $iniciales,
            "renovaciones" => $renovaciones,
            "escalas" => $escala
        ]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(int $id_prod)
    {
        $escala = "SELECT fcha_reg, rgo_ini, rgo_fin FROM rig_escalas WHERE id_prod = $id_prod";
        $escala = DB::select("$escala");
        return view('Formula.crearformula')->with([
            "id_prod" => $id_prod,
            "escala" => $escala
        ]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //dd($request->all());
        $var= [];
        if($request->p_ubic != NULL)
            $var = array_merge($var , [['Ubicación geografica', $request->p_ubic]]);
        if($request->p_alen != NULL)
            $var = array_merge($var , [['Alternativas de envio', $request->p_alen]]);
        if($request->p_prod != NULL)
            $var = array_merge($var , [['Costos de los productos', $request->p_prod]]);
        if($request->p_pag != NULL)
            $var = array_merge($var , [['Condiciones de pago', $request->p_pag]]);
        if($request->p_cen != NULL)
            $var = array_merge($var , [['Cumplimiento de envios', $request->p_cum]]);

        $variables = "SELECT nombre, id FROM rig_variables";
        $variables = DB::select("$variables");
        dd($variables, $var);
        return redirect()->back()->with(['error' => 'La suma de las variables debe ser igual a 100 y el mínimo aprobatorio debe estar entre 1 y 100']);
        dd("Hola");
        return view('formula.index');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
