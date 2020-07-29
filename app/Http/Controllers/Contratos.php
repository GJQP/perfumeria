<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class Contratos extends Controller
{
        //redireccionar a la pagina de inicio
        public function inicio() {
            return view('welcome');
        }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index() {   
        // Consultamos por todos los contratos activos sin verificar su renovación
        $contratosI = "SELECT  con.id_prod, con.id_prov, con.id, date(con.fcha_reg + interval '1 year') AS fcha_cul, pv.nombre AS nombre_prov, pd.nombre AS nombre_prod FROM rig_contratos con, rig_proveedores pv, rig_productores pd WHERE con.fcha_reg + interval '1 year'>= current_date AND con.fcha_fin IS NULL AND con.id_prov = pv.id AND con.id_prod = pd.id";
        $contratosI = DB::select("$contratosI");

        // Consultamos por todos los contratos con renovación activa
        $contratosR = "SELECT con.id_prod, con.id_prov, con.id, MAX(date(ren.fcha_reg + interval '1 year')) AS fcha_cul, pv.nombre AS nombre_prov, pd.nombre AS nombre_prod FROM rig_contratos con, rig_proveedores pv, rig_productores pd, rig_renovaciones ren WHERE (ren.fcha_reg + interval '1 year'>= current_date AND ren.id_ctra = con.id )AND con.fcha_fin IS NULL AND con.id_prov = pv.id AND con.id_prod = pd.id GROUP BY con.id_prod, con.id_prov, con.id, pv.nombre, pd.nombre";
        $contratosR = DB::select("$contratosR");

        //dd($contratosI, $contratosR);
        // Creamos el array de contratos a devolver
        $contratos = array();

        // Esto se implementa para descartar los duplicados
        foreach($contratosI as $contrato) 
        {
            $cont = 0;
            foreach($contratosR as $contratoR)
                if ($contrato->id_prov == $contratoR->id_prov && $contrato->id_prod == $contratoR->id_prod && $contrato->id == $contratoR->id)
                    $cont += 1;
            if($cont == 0)
                array_push($contratos, $contrato);
        }

        // Anexamos todos lo contratos
        $contratos = array_merge($contratos, $contratosR);

        // Selecionamos todos los productores activos y disponibles
        $productores = "SELECT prod.id, prod.nombre FROM rig_productores prod, rig_membresias mem WHERE prod.id = mem.id_prod AND mem.fcha_fin IS NULL";
        $productores = DB::select("$productores");

        // Retornamos la vista index de contratos con las variables necesarias
        return view('contratos.index', ['contratos' => $contratos, 'productores' => $productores]);
    }

    // Falta el modal del dialogo
    public function motivoCancelación(int $id_prod, int $id_prov, int $id) 
    {
        // Buscamos el contrato
        $contrato = "SELECT con.id_prod, con.id_prov, con.id, prod.nombre AS nombre_prod, prov.nombre AS nombre_prov FROM rig_contratos con, rig_productores prod, rig_proveedores prov WHERE con.id_prod = $id_prod AND con.id_prov = $id_prov AND con.id = $id AND con.id_prod = prod.id AND con.id_prov = prov.id";
        $contrato = DB::select("$contrato");

        // Si no existe o ya fué cancelado
        if(empty($contrato))
            return redirect()->back()->with('error', 'Operación sobre contrato inválida');

        // Retornamos la vista
        return view('contratos.cancelar', ['contrato' => $contrato[0]]);
    }

    public function cancelar(int $id_prod, int $id_prov, int $id, Request $request) 
    {
        $request = $request->all();

        // Eliminamos el contrato solicitado
        DB::update("UPDATE rig_contratos SET fcha_fin = current_date, mot_fin = '$request[desc]', cancelante = '$request[cancelante]' WHERE id_prod = $id_prod AND id_prov = $id_prov AND id = $id");
        return redirect()->route('contratos.index')->with('status', 'Contrato cancelado');
    }

    // Esta función se emplea para renovar el contrato entre un productor y un proveedor
    public function renovarContrato(Request $request, $id_prod, $id_prov, $id)
    {
        //dd($id_prod, $id_prov, $id, $request->all());
        $variable = $request->variables['Cumplimiento de envios'];        
        
        $escala = "SELECT DATE(fcha_reg) as fcha_reg, rgo_ini, rgo_fin FROM rig_escalas WHERE id_prod = $id_prod AND fcha_fin IS NULL";
        $escala = DB::select("$escala");
        
        // Obtengo los minimos y máximos de las escalas
        $min = $escala[0]->rgo_ini;
        $max = $escala[0]->rgo_fin;

        // Búsco el mínimo aprobatorio
        $minApro = "SELECT peso FROM rig_evaluaciones_criterios WHERE id_prod=$id_prod AND id_var=5 AND fcha_fin IS NULL AND tipo_eval='RENOVACION'";
        $minApro = DB::select("$minApro");

        // Verifico que las calificaones esten dentro del rango esperado
        $total = 0;
        if($variable < $min || $variable > $max)
            return redirect()->back()->with('error', 'Debes colocar calificaciones válidas');
        else
            $total += $variable;
        
        // Normalizo
        $total -= $min;
        $max -= $min;
        
        // Calculamos el porcentaje obtenido
        $total = ($total/$max)*100;
        //dd($total, $max, $min, $escala, $minApro[0]->peso);

        // Registramos el resultado
        DB::insert("INSERT INTO rig_resultados VALUES ($id_prod, $id_prov, NOW(), 'INICIAL', $total)");        
        
        // Verifico si el productor pasa la evaluación
        if($total < $minApro[0]->peso)
            return redirect()->route('contratos.index')->with('error', 'El proveedor no pasó la evaluación');
        
        // Solicitamos el contrato a renovar
        $contrato = "SELECT id, date(fcha_reg + interval '1 year') AS fcha FROM rig_contratos WHERE id_prod = $id_prod AND id_prov = $id_prov AND id = $id AND fcha_fin IS NULL";
        $contrato = DB::select("$contrato");

        // Verifico si el contrato existe
        if(!empty($contrato))
        {
            // Busco si el contrato tiene alguna renovación asociada
            $renovacion = "SELECT ren.id_ctra, MAX(date(ren.fcha_reg + interval '1 year')) AS fcha FROM rig_contratos con, rig_renovaciones ren WHERE (ren.fcha_reg + interval '1 year'>= current_date AND ren.id_ctra = $id )AND con.fcha_fin IS NULL GROUP BY ren.id_ctra";
            $renovacion = DB::select("$renovacion");

            // Verifico: Si no tiene renovación y está en el período de renovar
            $fecha_fin = Carbon::create($contrato[0]->fcha);
            if(!empty($renovacion))
                $fecha_fin = Carbon::create($renovacion[0]->fcha);                                 
            if($fecha_fin->betweenIncluded(Carbon::now()->subMonth(), Carbon::now()))
            {
                DB::insert("INSERT INTO rig_renovaciones VALUES ($id_prod, $id_prov, $id, DEFAULT, current_date)");
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

    public function renovarCreacion($id_prod, $id_prov, $id_cont){
        $queryUpdate ="UPDATE rig_contratos SET fcha_fin = current_date, mot_fin = 'Se genera otro nuevo', cancelante = 'Ambas partes' WHERE id = $id_cont AND id_prod = $id_prod AND id_prov = $id_prov AND fcha_fin IS NULL";
        DB::update($queryUpdate);
        return redirect()->route('evaluacion.nueva',['id_prod' => $id_prod, 'id_prov' => $id_prov]);
    }

    public function crearContrato(int $id_prod, int $id_prov) 
    {
        // Seleciono todos los id de los contratos vigentes de ambas partes
        $query = "SELECT con.id FROM rig_contratos con WHERE con.fcha_fin IS NULL AND id_prov = $id_prov AND id_prod = $id_prod AND (con.fcha_reg + interval '1 year'>= current_date OR con.id = ANY (SELECT id_ctra FROM rig_renovaciones WHERE id_prod = $id_prod AND id_prov = $id_prov AND fcha_reg + interval '1 year' >= current_date GROUP BY id_ctra)) GROUP BY con.id";
        $contratosActivos = DB::select($query);
        
        // Verifico si ya si se encuentra activo algún contrato entre el proveedor y el productor
        if(!empty($contratosActivos))
           return redirect()->back()->with('error', 'El proveedor selecionado ya tiene un contrato activo con el productor');
        
        // Consulto por todos los ingrendientes/esencias exclusivas del proveedor 
        $ingredientesExc = "SELECT id_ing FROM rig_productos_contratados WHERE id_prov=$id_prov AND id_ctra = ANY(SELECT con.id FROM rig_contratos con WHERE id_prov = $id_prov AND con.fcha_fin IS NULL AND exc ='SI' AND (con.fcha_reg + interval '1 year'>= current_date OR con.id = ANY (SELECT id_ctra FROM rig_renovaciones WHERE id_prov = $id_prov AND fcha_reg + interval '1 year' >= current_date GROUP BY id_ctra)) GROUP BY con.id) AND id_ing IS NOT NULL GROUP BY id_ing";        
        $ingredientesExc = DB::select($ingredientesExc);
        
        // Consulto por todos los ingredientes_esencias que vende el proveedor
        $ingredientesProv = "SELECT id, cas, nombre FROM rig_ingredientes_esencias WHERE id_prov = $id_prov";
        $ingredientesProv = DB::select($ingredientesProv);

        // Creo mi lista de ingredientes_esencias
        $ingredientes = [];
        foreach($ingredientesProv as $ingrediente)
        {
            $cont = 0;
            foreach($ingredientesExc as $exc)
                if($ingrediente->id == $exc->id_ing)
                    $cont += 1;
            if($cont == 0)
                $ingredientes = array_merge($ingredientes, [$ingrediente]);
        }
        
        // Consulto por todos los otros_ingredientes exclusivos que vende el proveedor           
        $otrosIngredientesExc = "SELECT cas_otr_ing FROM rig_productos_contratados WHERE id_prov=$id_prov AND id_ctra = ANY(SELECT con.id FROM rig_contratos con WHERE con.id_prov = $id_prov AND con.fcha_fin IS NULL AND con.exc ='SI' AND (con.fcha_reg + interval '1 year'>= current_date OR con.id = ANY (SELECT ren.id_ctra FROM rig_renovaciones ren WHERE  ren.id_prov = $id_prov AND ren.fcha_reg + interval '1 year' >= current_date GROUP BY ren.id_ctra)) GROUP BY con.id) AND cas_otr_ing IS NOT NULL GROUP BY cas_otr_ing";        
        $otrosIngredientesExc = DB::select($otrosIngredientesExc);
        //dd($otrosIngredientesExc, 'ri');
        // Consulto por todos los otros ingredientes del proveedor
        $otrosIngredientesProv = "SELECT cas, nombre FROM rig_otros_ingredientes WHERE id_prov = $id_prov";
        $otrosIngredientesProv = DB::select($otrosIngredientesProv);
        
        // Creo mi lista de otros_ingredientes
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
        
        // Consulto por mis condiciones de envio
        $condicionesEnvio = "SELECT ce.*, pa.nombre AS pais FROM rig_condiciones_de_envio ce, rig_sucursales suc, rig_paises pa WHERE suc.id_prod = $id_prod AND suc.id_ubic = ce.id_ubic AND id_prov = $id_prov AND ce.id_ubic = pa.id";
        $condicionesEnvio = DB::select($condicionesEnvio);
        
        // Consulto por mis condicioens de pago
        $condicionesPago = "SELECT * FROM rig_condiciones_de_pago WHERE id_prov = $id_prov";
        $condicionesPago = DB::select($condicionesPago);
        
        // Si el proveedor no tiene almenos un ingrediente disponible aborto la creación del contrato
        if(empty($ingredientes) && empty($otros_ingredientes))
           return redirect()->route('contratos.index')->with('error', 'El proveedor selecionado no tiene productos disponibles');
        
        
        //Retornamos la vista del contrato
        return view('contratos.crearContrato')->with([
            'ingredientes' => $ingredientes, 
            'otros_ingredientes' => $otros_ingredientes,
            'condicionesEnvio' => $condicionesEnvio,
            'condicionesPago' => $condicionesPago,
            'id_prov' => $id_prov,
            'id_prod' => $id_prod
        ]);        
    }

    public function registrarContrato(int $id_prod, int $id_prov, Request $request)
    {
        // Verificamos que los datos introducidos cumplan con lo requerido
        if(($request->ingredientes == null && $request->otros_ingredientes == null) || $request->condicionesEnvio == null || $request->condicionesPago == null)
            return redirect()->back()->with(['error' => 'Debes selecionar almenos un ingrediente, una condición de pago y una de envio']);    
        
        $exc = 'NO';
        if($request->exclusivo != null)
            $exc = 'SI';
        // Creamos el contrato con los datos suministrados
        $temp = DB::select("INSERT INTO rig_contratos (id_prod, id_prov, id, fcha_reg, exc) VALUES ($id_prod, $id_prov, DEFAULT, current_date, '$exc') RETURNING id");
        $id_ctra = DB::getPdo()->lastInsertId();
        $cont = 1;
        // dd($request);
        // Insertamos los ingredientes 
        if($request->ingredientes != null)
            foreach($request->ingredientes as $ingrediente)
            {
                DB::insert("INSERT INTO rig_productos_contratados VALUES ($id_prod, $id_prov, $id_ctra, $cont, $id_prov, $ingrediente, null)");
                $cont++;
            }
        if($request->otros_ingredientes != null)
            foreach($request->otros_ingredientes as $ingrediente)
            {
                DB::insert("INSERT INTO rig_productos_contratados VALUES ($id_prod, $id_prov, $id_ctra, $cont, null, null, $ingrediente)");
                $cont++;
            }

        $cont = 1;
        foreach($request->condicionesEnvio as $ubicacion)
        {
            DB::insert("INSERT INTO rig_condiciones_contratos VALUES ($id_prod, $id_prov, $id_ctra, $cont, $id_prov, $ubicacion, null, null)");
            $cont++;
        }

        foreach($request->condicionesPago as $id)
        {
            DB::insert("INSERT INTO rig_condiciones_contratos VALUES ($id_prod, $id_prov, $id_ctra, $cont, null, null, $id_prov, $id)");
            $cont++;
        }
        return redirect()->route('contratos.index')->with('status', 'Contrato creado exitosamente');
    }

    /**Funcion para renovar contrato, faltaria pasarle la formula de renovacion de la empresa*/
    public function cambio()
    {
        return view('contratos.renovarContrato');
    }

    public function evaluacion($id_prod, $id_prov)
    {
        //dd($id_prod, $id_prov);
        
        // Seleciono todos los id de los contratos vigentes de ambas partes
        $query = "SELECT con.id FROM rig_contratos con WHERE con.fcha_fin IS NULL AND id_prov = $id_prov AND id_prod = $id_prod AND (con.fcha_reg + interval '1 year'>= current_date OR con.id = ANY (SELECT id_ctra FROM rig_renovaciones WHERE id_prod = $id_prod AND id_prov = $id_prov AND fcha_reg + interval '1 year' >= current_date GROUP BY id_ctra)) GROUP BY con.id";
        $contratosActivos = DB::select($query);
        
        // Verifico si ya si se encuentra activo algún contrato entre el proveedor y el productor
        if(!empty($contratosActivos))
           return redirect()->back()->with('error', 'El proveedor selecionado ya tiene un contrato activo con el productor');
        
        // Consulto por todos los ingrendientes/esencias exclusivas del proveedor 
        $ingredientesExc = "SELECT id_ing FROM rig_productos_contratados WHERE id_prov=$id_prov AND id_ctra = ANY(SELECT con.id FROM rig_contratos con WHERE id_prov = $id_prov AND con.fcha_fin IS NULL AND exc ='SI' AND (con.fcha_reg + interval '1 year'>= current_date OR con.id = ANY (SELECT id_ctra FROM rig_renovaciones WHERE id_prov = $id_prov AND fcha_reg + interval '1 year' >= current_date GROUP BY id_ctra)) GROUP BY con.id) AND id_ing IS NOT NULL GROUP BY id_ing";        
        $ingredientesExc = DB::select($ingredientesExc);
        
        // Consulto por todos los ingredientes_esencias que vende el proveedor
        $ingredientesProv = "SELECT id, cas, nombre FROM rig_ingredientes_esencias WHERE id_prov = $id_prov";
        $ingredientesProv = DB::select($ingredientesProv);
        
        // Creo mi lista de ingredientes_esencias
        $ingredientes = [];
        foreach($ingredientesProv as $ingrediente)
        {
            $cont = 0;
            foreach($ingredientesExc as $exc)
                if($ingrediente->id == $exc->id_ing)
                    $cont += 1;
            if($cont == 0)
                $ingredientes = array_merge($ingredientes, [$ingrediente]);
        }
        
        // Consulto por todos los otros_ingredientes exclusivos que vende el proveedor           
        $otrosIngredientesExc = "SELECT cas_otr_ing FROM rig_productos_contratados WHERE id_prov=$id_prov AND id_ctra = ANY(SELECT con.id FROM rig_contratos con WHERE id_prov = $id_prov AND con.fcha_fin IS NULL AND exc ='SI' AND (con.fcha_reg + interval '1 year'>= current_date OR con.id = ANY (SELECT id_ctra FROM rig_renovaciones WHERE  id_prov = $id_prov AND fcha_reg + interval '1 year' >= current_date GROUP BY id_ctra)) GROUP BY con.id) AND cas_otr_ing IS NOT NULL GROUP BY cas_otr_ing";        
        $otrosIngredientesExc = DB::select($otrosIngredientesExc);
        
        // Consulto por todos los otros ingredientes del proveedor
        $otrosIngredientesProv = "SELECT cas, nombre FROM rig_otros_ingredientes WHERE id_prov = $id_prov";
        $otrosIngredientesProv = DB::select($otrosIngredientesProv);
        
        // Creo mi lista de otros_ingredientes
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

        // Consulto por mis condiciones de envio
        $condicionesEnvio = "SELECT ce.*, pa.nombre AS pais FROM rig_condiciones_de_envio ce, rig_sucursales suc, rig_paises pa WHERE suc.id_prod = $id_prod AND suc.id_ubic = ce.id_ubic AND id_prov = $id_prov AND ce.id_ubic = pa.id";
        $condicionesEnvio = DB::select($condicionesEnvio);
        
        // Consulto por mis condicioens de pago
        $condicionesPago = "SELECT * FROM rig_condiciones_de_pago WHERE id_prov = $id_prov";
        $condicionesPago = DB::select($condicionesPago);
        
        // Si el proveedor no tiene almenos un igrediente disponible aborto la creación del contrato
        if(empty($ingredientes) && empty($otros_ingredientes))
           return redirect()->back()->with('error', 'El proveedor selecionado no tiene productos disponibles');
        
        // Buscamos la escala correspondiente
        $escala = "SELECT DATE(fcha_reg) as fcha_reg, rgo_ini, rgo_fin FROM rig_escalas WHERE id_prod = $id_prod AND fcha_fin IS NULL";
        $escala = DB::select("$escala");

        // Si no tiene escala
        if(empty($escala))
            return redirect()->route('contratos.index')->with('error', 'El productor no escalas registradas');

        // Obtengo las variables
        $variables = "SELECT rec.id_var, rec.fcha_reg, rec.tipo_eval, rec.peso, var.nombre FROM rig_evaluaciones_criterios rec INNER JOIN rig_variables var ON rec.id_var = var.id WHERE rec.id_prod=$id_prod AND rec.fcha_fin IS NULL AND rec.tipo_eval = 'INICIAL'";
        $variables = DB::select("$variables");

        if(empty($variables))
            return redirect()->route('contratos.index')->with('error', 'El productor no tiene fórmula de evaluación inical registrar');
          //  dd($variables);
        //Retornamos la vista del contrato
        return view('contratos.evaluacion')->with([
            'ingredientes' => $ingredientes, 
            'otros_ingredientes' => $otros_ingredientes,
            'condicionesEnvio' => $condicionesEnvio,
            'condicionesPago' => $condicionesPago,
            'escala' => $escala,
            'variables' =>$variables,
            'id_prov' => $id_prov,
            'id_prod' => $id_prod
        ]);        
    }

    public function registrarEvaluacion(Request $request, $id_prod, $id_prov)
    {
        // Obtenemos las calificaciones
        $variables = $request->all()["variables"];

        // Buscamos la escala correspondiente
        $escala = "SELECT DATE(fcha_reg) as fcha_reg, rgo_ini, rgo_fin FROM rig_escalas WHERE id_prod = $id_prod AND fcha_fin IS NULL";
        $escala = DB::select("$escala");
        
        // Obtengo los minimos y máximos de las escalas
        $min = $escala[0]->rgo_ini;
        $max = $escala[0]->rgo_fin;

        // Búsco el mínimo aprobatorio
        $minApro = "SELECT peso FROM rig_evaluaciones_criterios WHERE id_prod=$id_prod AND id_var=5 AND fcha_fin IS NULL AND tipo_eval='INICIAL'";
        $minApro = DB::select("$minApro");

        // Obtengo las variables
        $form = "SELECT rec.id_var, rec.fcha_reg, rec.tipo_eval, rec.peso, var.nombre FROM rig_evaluaciones_criterios rec INNER JOIN rig_variables var ON rec.id_var = var.id WHERE rec.id_prod=$id_prod AND rec.fcha_fin IS NULL AND rec.tipo_eval = 'INICIAL' AND rec.id_var != 5";
        $form = DB::select("$form");

        // Normalizo la escala
        $max -= $min;

        // Verifico que las calificaones esten dentro del rango esperado
        $total = 0;
        foreach($variables as  $name =>$variable)
            if($variable < $min || $variable > $max)
                return redirect()->back()->with('error', 'Debes cololar calificaciones válidas');
            else
                foreach($form as $f)
                    if(strcmp($f->nombre, $name) == 0)
                        $total += ($variable - $min)*($f->peso/$max);

        // Registramos el resultado
        DB::insert("INSERT INTO rig_resultados VALUES ($id_prod, $id_prov, NOW(), 'INICIAL', $total)");
        
        // Verifico si el productor pasa la evaluación
        if($total < $minApro[0]->peso)
          return redirect()->route('contratos.index')->with('error', 'El proveedor no pasó la evaluación');


        // Continuamos con el proceso de creación
        return redirect()->route('contrato.crear',['id_prod' => $id_prod, 'id_prov' => $id_prov])->with('status', 'Evaluación registrada exitosamente');
    }

    public function renovacionContrato($id_prod, $id_prov, $id)
    {
        //dd($id_prod, $id_prov, $id, '23');
        $vinculantes = "SELECT fcha_reg FROM rig_membresias WHERE (id_prod = $id_prod OR id_prov = $id_prov) AND fcha_fin IS NULL";
        $vinculantes = DB::select($vinculantes);

        // Verificamos que ambos tengan su membresía activa en IFRA
        if(sizeof($vinculantes) != 2)
            return redirect()->route('contratos.index')->with('error', 'Ambas partes deben tener su membresía activa');

        // Buscamos la escala correspondiente
        $escala = "SELECT DATE(fcha_reg) as fcha_reg, rgo_ini, rgo_fin FROM rig_escalas WHERE id_prod = $id_prod AND fcha_fin IS NULL";
        $escala = DB::select("$escala");

        if(empty($escala))
            return redirect()->route('contratos.index')->with('error', 'El productor no tiene fórmulas activas');

        // Obtengo las variables
        $variables = "SELECT rec.id_var, rec.fcha_reg, rec.tipo_eval, rec.peso, var.nombre FROM rig_evaluaciones_criterios rec INNER JOIN rig_variables var ON rec.id_var = var.id WHERE rec.id_prod=$id_prod AND rec.fcha_fin IS NULL AND rec.tipo_eval = 'RENOVACION'";
        $variables = DB::select("$variables");

        if(empty($variables))
            return redirect()->route('contratos.index')->with('error', 'El productor no tiene fórmulas de renovación');

        return view('contratos.reneval')->with([
            'id_prov' => $id_prov,
            'id_prod' => $id_prod,
            'id_ctra' => $id,
            'variables' => $variables,
            'escala' => $escala
        ]);

        //dd($id_prod, $id_prov, $id);
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

    public function vistacontrato()
    {
        return view('contrato.selecProductos');
    }

    private function getProductores()
    {
        $query = "SELECT prod.id, prod.nombre FROM rig_productores prod, rig_membresias mem WHERE prod.id = mem.id_prod AND mem.fcha_fin IS NULL";
        return DB::select("$query");
    }

    public function getPresentaciones($id_prov = null, $id_ing) {
        // Selecciono el ingrediente
        $id_prov = intval($id_prov);
        $query = 0;
        if($id_prov > 0)
            $query = "SELECT * FROM rig_presentaciones_ingredientes WHERE id_prov = $id_prov AND id_ing = $id_ing";
        else
            $query = "SELECT * FROM rig_presentaciones_otros_ingredientes WHERE cas_otr_ing = $id_ing";
          
        // Hago el query
        $query = DB::select($query);
        
        // Retorno la respuesta
        return response()->json(['presentaciones' => $query]);
    }
}
