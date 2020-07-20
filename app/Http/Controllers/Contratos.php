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
    {   $contratosI = "SELECT con.id, date(con.fcha_reg + interval '1 year') AS fcha, con.id_prod, con.id_prov, pv.nombre AS nombre_prov, pd.nombre AS nombre_prod FROM rig_contratos con, rig_proveedores pv, rig_productores pd WHERE con.fcha_reg + interval '1 year'>= current_date AND con.fcha_fin IS NULL AND con.id_prov = pv.id AND con.id_prod = pd.id";
        $contratosI = DB::select("$contratosI");
        $contratosR = "SELECT con.id, MAX(date(ren.fcha_reg + interval '1 year')) AS fcha, con.id_prod, con.id_prov, pv.nombre AS nombre_prov, pd.nombre AS nombre_prod FROM rig_contratos con, rig_proveedores pv, rig_productores pd, rig_renovaciones ren WHERE (ren.fcha_reg + interval '1 year'>= current_date AND ren.id_ctra = con.id )AND con.fcha_fin IS NULL AND con.id_prov = pv.id AND con.id_prod = pd.id GROUP BY con.id, pv.nombre, pd.nombre";
        $contratosR = DB::select("$contratosR");
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
        $productores = "SELECT prod.id, prod.nombre FROM rig_productores prod, rig_membresias mem WHERE prod.id = mem.id_prod AND mem.fcha_fin IS NULL";
        $productores = DB::select("$productores");
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

    public function cancelar(int $id, Request $request)
    {
        $request = $request->all();
        //dd($request);
        DB::update("UPDATE rig_contratos SET fcha_fin = current_date, mot_fin = '$request[desc]', cancelante = '$request[cancelante]' WHERE id = $id");
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
    public function seleccionarProveedores(Request $request)
    {
        $queryProveedores = "SELECT id_prov FROM rig_membresias WHERE fcha_fin IS NULL AND id_prov IS NOT NULL";
        $queryCondEnvios = "SELECT ce.id_prov FROM rig_condiciones_de_envio ce, rig_sucursales suc WHERE suc.id_prod = $request->id_prod AND suc.id_ubic = ce.id_ubic";
        $query = "SELECT id, nombre FROM rig_proveedores WHERE id = ANY($queryProveedores) AND id = ANY($queryCondEnvios)";
        return view('contratos.elegirProveedor')->with([
            'productores'=>$this->getProductores(),
            'id_prod'=>$request->id_prod,
            'proveedores'=> DB::select($query)
        ]);
    }

    public function crearContrato(int $id_prod, int $id_prov) 
    {
        //dd($id_prod, $id_prov);
        $contratosActivos = "SELECT con.id FROM rig_contratos con WHERE con.fcha_fin IS NULL AND id_prov = $id_prov AND id_prod = $id_prod AND (con.fcha_reg + interval '1 year'>= current_date OR con.id = ANY (SELECT id_ctra FROM rig_renovaciones WHERE fcha_reg + interval '1 year' >= current_date GROUP BY id_ctra)) GROUP BY con.id";
        $contratosActivos = DB::select($contratosActivos);
        if(!empty($contratosActivos))
           return redirect()->back()->with('error', 'El proveedor selecionado ya tiene un contrato activo con el productor');


        $ingredientesExc = "SELECT cas_ing FROM rig_productos_contratados WHERE id_ctra = ANY(SELECT con.id FROM rig_contratos con WHERE con.id_prov = $id_prov AND con.fcha_fin IS NULL AND con.exc = 'SI' AND (con.fcha_reg + interval '1 year'>= current_date OR con.id = ANY (SELECT id_ctra FROM rig_renovaciones WHERE fcha_reg + interval '1 year' >= current_date GROUP BY id_ctra)) GROUP BY con.id) AND cas_ing IS NOT NULL GROUP BY cas_ing";        
        $ingredientesExc = DB::select($ingredientesExc);

        $ingredientesProv = "SELECT cas, nombre FROM rig_ingredientes_esencias WHERE id_prov = $id_prov";
        $ingredientesProv = DB::select($ingredientesProv);

        $ingredientes = [];
        foreach($ingredientesProv as $ingrediente)
        {
            $cont = 0;
            foreach($ingredientesExc as $exc)
                if($ingrediente->cas == $exc->cas_ing)
                    $cont += 1;
            if($cont == 0)
                $ingredientes = array_merge($ingredientes, [$ingrediente]);
        }

        $otrosIngredientesExc = "SELECT cas_otr_ing FROM rig_productos_contratados WHERE id_ctra = ANY(SELECT con.id FROM rig_contratos con WHERE con.id_prov = $id_prov AND con.fcha_fin IS NULL AND con.exc = 'SI' AND (con.fcha_reg + interval '1 year'>= current_date OR con.id = ANY (SELECT id_ctra FROM rig_renovaciones WHERE fcha_reg + interval '1 year' >= current_date GROUP BY id_ctra)) GROUP BY con.id) AND cas_otr_ing IS NOT NULL GROUP BY cas_otr_ing";        
        $otrosIngredientesExc = DB::select($otrosIngredientesExc);

        $otrosIngredientesProv = "SELECT cas, nombre FROM rig_otros_ingredientes WHERE id_prov = $id_prov";
        $otrosIngredientesProv = DB::select($otrosIngredientesProv);

        $otros_ingredientes= [];
        foreach($otrosIngredientesProv as $ingrediente)
        {
            $cont = 0;
            foreach($otrosIngredientesExc as $exc)
                if($ingrediente->cas == $exc->cas_otr_ing)
                    $cont += 1;
            if($cont == 0)
                $otros_ingredientes = array_merge($otros_ingredientes, [$ingrediente]);
        }

        $condicionesEnvio = "SELECT ce.*, pa.nombre AS pais FROM rig_condiciones_de_envio ce, rig_sucursales suc, rig_paises pa WHERE suc.id_prod = 1 AND suc.id_ubic = ce.id_ubic AND id_prov = $id_prov AND ce.id_ubic = pa.id";
        $condicionesEnvio = DB::select($condicionesEnvio);
        $condicionesPago = "SELECT * FROM rig_condiciones_de_pago WHERE id_prov = $id_prov";
        $condicionesPago = DB::select($condicionesPago);
        //dd($ingredientes, $otros_ingredientes, $condicionesEnvio, $condicionesPago);
        if(empty($ingredientes) && empty($otros_ingredientes))
           return redirect()->back()->with('error', 'El proveedor selecionado no tiene productos disponibles');

        return view('contratos.crearContrato')->with([
            'ingredientes' => $ingredientes, 
            'otros_ingredientes' => $otros_ingredientes,
            'condicionesEnvio' => $condicionesEnvio,
            'condicionesPago' => $condicionesPago,
            'id_prov' => $id_prov,
            'id_prod' => $id_prod
            ]);
        
    }

    public function generar(int $id_prod, int $id_prov, Request $request)
    {
        if(($request->ingredientes == null && $request->otros_ingredientes == null) || $request->condicionesEnvio == null || $request->condicionesPago == null)
            return redirect()->back()->with(['error' => 'Debes selecionar almenos un ingrediente, una condición de pago y una de envio']);    
        
        $exc = 'NO';
        if($request->exclusivo != null)
            $exc = 'SI';
        //dd($id_prov,$id_prod,$request->all());
        DB::insert("INSERT INTO rig_contratos (id, fcha_reg, exc, id_prod, id_prov) VALUES (DEFAULT, current_date, '$exc', $id_prod, $id_prov)  RETURNING *");
        $id_ctra = DB::getPdo()->lastInsertId();
        //dd($id_ctra);
        $cont = 1;
        if($request->ingredientes != null)
            foreach($request->ingredientes as $ingrediente)
            {
                DB::insert("INSERT INTO rig_productos_contratados VALUES ($id_ctra, $cont, $id_prov, $ingrediente, null)");
                $cont += 1;
            }
        if($request->otros_ingredientes != null)
            foreach($request->otros_ingredientes as $ingrediente)
            {
                DB::insert("INSERT INTO rig_productos_contratados VALUES ($id_ctra, $cont, $id_prov, null, $ingrediente)");
                $cont += 1;
            }

        $cont = 1;
        foreach($request->condicionesEnvio as $ubicacion)
        {
            DB::insert("INSERT INTO rig_condiciones_contratos VALUES ($id_ctra, $cont, $id_prov, $ubicacion, null, null)");
            $cont++;
        }

        foreach($request->condicionesPago as $id)
        {
            DB::insert("INSERT INTO rig_condiciones_contratos VALUES ($id_ctra, $cont, null, null, $id_prov, $id)");
            $cont++;
        }
        return redirect()->route('contratos.index')->with('status', 'Contrato creado exitosamente');
    }

    /**Funcion para renovar contrato, faltaria pasarle la formula de renovacion de la empresa*/
    public function cambio(){
        return view('contrato.renovarContrato');
    }

    public function evaluacion(){
        return view('contrato.evaluacion');
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

    private function getProductores(){
        $query = "SELECT prod.id, prod.nombre FROM rig_productores prod, rig_membresias mem WHERE prod.id = mem.id_prod AND mem.fcha_fin IS NULL";
        return DB::select("$query");
    }
}
