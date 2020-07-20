<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class Contratos extends Controller
{
        //redireccionar a la pagina de inicio
        public function inicio()
        {
            return view('welcome');
        }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {   $query = "SELECT con.id, date(con.fcha_reg + interval '1 year') AS fcha, con.id_prod, con.id_prov, pv.nombre AS nombre_prov, pd.nombre AS nombre_prod FROM rig_contratos con, rig_proveedores pv, rig_productores pd WHERE con.fcha_reg + interval '1 year'>= current_date AND con.fcha_fin IS NULL AND con.id_prov = pv.id AND con.id_prod = pd.id";
        $contratosI = DB::select("$query");
        $query = "SELECT con.id, MAX(date(ren.fcha_reg + interval '1 year')) AS fcha, con.id_prod, con.id_prov, pv.nombre AS nombre_prov, pd.nombre AS nombre_prod FROM rig_contratos con, rig_proveedores pv, rig_productores pd, rig_renovaciones ren WHERE (ren.fcha_reg + interval '1 year'>= current_date AND ren.id_ctra = con.id )AND con.fcha_fin IS NULL AND con.id_prov = pv.id AND con.id_prod = pd.id GROUP BY con.id, pv.nombre, pd.nombre";
        $contratosR = DB::select("$query");
        $contratos = array();
        // Esto se implementa para obtener los contratos vigentes
        foreach($contratosI as $contrato)
        {
            $cont = 0;
            foreach($contratosR as $contratoR)
                if ($contrato->id == $contratoR->id)
                    $cont += 1;
            if($cont == 0)
                array_push($contratos, $contrato);
        }
        $contratos = array_merge($contratos, $contratosR);
        $query = "SELECT prod.id, prod.nombre FROM rig_productores prod, rig_membresias mem WHERE prod.id = mem.id_prod AND mem.fcha_fin IS NULL";
        $productores = DB::select("$query");
        return view('contratos.index', ['contratos' => $contratos, 'productores' => $productores]);
    }

    // Falta el modal del dialogo
    public function cancelarContrato(int $id)
    {
        $query = "SELECT con.id, date(con.fcha_reg + interval '1 year') AS fcha, con.id_prod, con.id_prov, pv.nombre AS nombre_prov, pd.nombre AS nombre_prod FROM rig_contratos con, rig_proveedores pv, rig_productores pd WHERE con.fcha_reg + interval '1 year'>= current_date AND con.fcha_fin IS NULL AND con.id_prov = pv.id AND con.id_prod = pd.id AND con.id = $id";
        $contrato = DB::select("$query");
        //dd($contrato);
        return view('contratos.cancelar', ['contrato' => $contrato[0]]);
    }

    public function cancelar(Request $request)
    {
        $request = $request->all();
        dd($request);
        DB::update("UPDATE rig_contratos SET (fcha_fin = current_date, mot_fin = $request[desc], cancelante = $request[cancelante]) WHERE ID = $id");
        return redirect()->route('contratos.index')->with('status', 'Contrato cancelado');
    }

    // Lista 100%
    public function renovarContrato(int $id)
    {
        $query = "SELECT id, date(fcha_reg + interval '11 months') AS fcha FROM rig_contratos WHERE id=$id AND fcha_fin IS NULL";
        $contrato = DB::select("$query");
        if(!empty($contrato) && Carbon::create($contrato[0]->fcha)->lessThanOrEqualTo(Carbon::now()))
        {
            $query = "SELECT ren.id_ctra, MAX(date(ren.fcha_reg + interval '11 months')) AS fcha FROM rig_contratos con, rig_renovaciones ren WHERE (ren.fcha_reg + interval '1 year'>= current_date AND ren.id_ctra = $id )AND con.fcha_fin IS NULL GROUP BY ren.id_ctra";
            $renovacion = DB::select("$query");
            if(empty($renovacion) || Carbon::create($renovacion[0]->fcha)->lessThanOrEqualTo(Carbon::now()))
            {
                DB::insert("INSERT INTO rig_renovaciones VALUES ($id, 2, current_date)");
                return redirect()->route('contratos.index')->with('status', 'Contrato renovado');
            }
        }
        return redirect()->route('contratos.index')->with('error', 'Renovación inválida');
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(Request $request)
    {
        //return view('contratos.crearContrato');
        dd($request);
    }

    /**Funcion para renovar contrato, faltaria pasarle la formula de renovacion de la empresa*/
    public function cambio(){
        return view('contrato.renovarContrato');
    }

    public function evaluacion(){
        //return view('contrato.evaluacion');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
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

    public function vistacontrato(){
        return view('contrato.selecProductos');
    }
}
