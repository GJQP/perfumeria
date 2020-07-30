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
    public function index(Request $request)
    {
        // Extraemos el id del productor
        $id = $request->id_prod;
        
        // Buscamos
        $productores = "SELECT mem.id_prod, prod.nombre FROM rig_membresias mem, rig_productores prod WHERE fcha_fin IS NULL AND id_prod IS NOT NULL AND mem.id_prod = prod.id";
        $productores = DB::select("$productores");
        if(empty($productores))
            return redirect()->back()->with('error', 'No hay proveedores con mebresías activas');

        // Si el id del productor no fué definido agarramos al primero por defecto
        if($id == NULL)
            $id = $productores[0]->id_prod;

        // Obtengo las variables
        $variables = "SELECT rec.id_var, rec.fcha_reg, rec.tipo_eval, rec.peso, var.nombre FROM rig_evaluaciones_criterios rec INNER JOIN rig_variables var ON rec.id_var = var.id WHERE rec.id_prod=$id AND rec.fcha_fin IS NULL";
        $variables = DB::select("$variables");

        // Buscamos los valores de la formula inicial y de renovación
        $iniciales = [];
        $renovaciones = [];
        foreach($variables as $variable)
            if($variable->tipo_eval == "INICIAL")
                $iniciales = array_merge($iniciales, [$variable]);
            else
                $renovaciones = array_merge($renovaciones, [$variable]);

        // Buscamos la escala correspondiente
        $escala = "SELECT DATE(fcha_reg) AS fcha_reg, rgo_ini, rgo_fin FROM rig_escalas WHERE id_prod = $id AND fcha_fin IS NULL";
        $escala = DB::select("$escala");

        return view('Formula.gestionformula')->with([
            "productores" => $productores,
            "iniciales" => $iniciales,
            "renovaciones" => $renovaciones,
            "escala" => $escala,
            "id_prod" => $id
        ]);
    }


    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(int $id_prod)
    {
        $escala = "SELECT DATE(fcha_reg) AS fcha_reg, rgo_ini, rgo_fin FROM rig_escalas WHERE id_prod = $id_prod";
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
    public function store(Request $request, int $id_prod)
    {
        //dd($request->all());
        // Pedimo el valor del mínimo y del máximo
        $minApro = $request->minApro;

        // Verificamos que se seleciona un parámetro
        if($request->p_ubic == NULL && $request->p_alen == NULL && $request->p_prod == NULL && $request->p_pag == NULL && $request->p_cen == NULL)
            return redirect()->back()->with(['error' => 'Debes selecionar almenos una variable']);

        if($minApro < 1 || $minApro > 100)
            return redirect()->back()->with(['error' => 'El minimo aprobatorio debe estar en el rango de de 1 a 100']);

        $pesoTotal = 0;
        // Preparo las variables
        if($request->p_ubic != NULL)
            $pesoTotal += $request->p_ubic;
        if($request->p_alen != NULL)
            $pesoTotal += $request->p_alen;
        if($request->p_pag != NULL)
            $pesoTotal += $request->p_pag;
        if($request->p_cen != NULL)
            $pesoTotal += $request->p_cen;
  
        // Si el peso no es de 100% me retorno
        //dd($pesoTotal);
        if($pesoTotal != 100)
            return  redirect()->back()->with(['error' => 'El peso debe ser igual a 100%']);

        //dd($request->all());
        $vars= [];
        if($request->p_ubic != NULL)
            $vars = array_merge($vars , [['Ubicación geografica', $request->p_ubic]]);
        if($request->p_alen != NULL)
            $vars = array_merge($vars , [['Alternativas de envio', $request->p_alen]]);
        if($request->p_pag != NULL)
            $vars = array_merge($vars , [['Metodos de pago', $request->p_pag]]);
        if($request->p_cen != NULL)
            $vars = array_merge($vars , [['Cumplimiento de envios', $request->p_cen]]);

        // Buscamos las variables
        $variables = "SELECT nombre, id FROM rig_variables";
        $variables = DB::select("$variables");


        $tipoEval = 'INICIAL';
        if($request->p_cen != NULL)
            $tipoEval = 'RENOVACION';
        //dd($variables);
        // Cancelamos la fórmula vieja
        DB::update("UPDATE rig_evaluaciones_criterios SET fcha_fin=current_date WHERE id_prod = $id_prod AND fcha_fin IS NULL AND tipo_eval = '$tipoEval'");

        $cont = 0;
        foreach($variables as $variable)
            foreach($vars as $var)
                if(strcmp($variable->nombre, $var[0]) == 0)
                    DB::insert("INSERT INTO rig_evaluaciones_criterios VALUES($id_prod, $variable->id, NOW() + INTERVAL '0 second', '$tipoEval', '$var[1]')");

        DB::insert("INSERT INTO rig_evaluaciones_criterios VALUES($id_prod, 5, NOW() + INTERVAL '10 second', '$tipoEval', $minApro)");

        return  redirect()->route('formula.index')->with(['status' => 'Fórmula registrada exitosamente']);
    }


    public function escalaCrear($id_prod)
    {
        $escala = DB::select("SELECT id_prod, DATE(fcha_reg) AS fcha_reg, rgo_ini, rgo_fin, fcha_fin FROM rig_escalas WHERE id_prod = $id_prod AND fcha_fin IS NULL");
        return view('Formula.elegirEscala')->with(['escala' => $escala, 'id_prod' => $id_prod]);
    }

    public function escalaRegistrar(Request $request, $id_prod)
    {
        $min = $request->min;
        $max = $request->max;

        // Verificamos que el minimo sea menor al máximo
        if($min >= $max && $min != NULL && $max != NULL)
            return  redirect()->back()->with(['error' => 'El máximo tiene que se mayor que el menor']);

        // Verificamos ambas sean nulas o no lo sean
        if($min == NULL && $max != NULL || $max == NULL && $min != NULL)
            return redirect()->back()->with(['error' => 'Debes especificar ambos rangos de la formula']);
    
        // Verificamos que se encuentre en el rango de el mínimo aprobatorio
        if($min != NULL && $max != NULL)
        {
            DB::update("UPDATE rig_escalas SET fcha_fin=current_date WHERE id_prod = $id_prod AND fcha_fin IS NULL");
            DB::insert("INSERT INTO rig_escalas (id_prod, fcha_reg, rgo_ini, rgo_fin) VALUES ($id_prod, NOW(), $min, $max) RETURNING *");
        }
        return redirect()->route('formula.index')->with(['id_prod' => $id_prod, 'status', 'Escala registrada exitosamente']);
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
