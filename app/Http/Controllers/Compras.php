<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\DB;

class Compras extends Controller
{
    /*
     *
     *
     * Pasos Compras:

1.Mostrar proveedores (contratos vigentes no cancelados filtro productor para el momento de la consulta)
2.elegir
3.mostrar productos contratados, condiciones de envio y pago
4.Crear pedido – encabezado – guardar
4.1 crear detalles – guardar
4.2 elegir envio si aplica
4.3 calcular y guardar montototal
4.4 si hay varias formas de pago elegir – guardar
4.5 cuando el proveedor confirme o cancele seguir…
si confirma, cambiar estatus y guardar cambio más numero factura
4.5.1 generar pagos según condiciones (mostrar los montos y dejar que el usuario confirme antes de guardar)…
     *
     */

    public function index(Request $request)
    {
        $idProductor = $request->id_prod ? : '1';

        return view('compras.gestionCompras')->with([
            'id_prod'=>$idProductor,
            'productores'=>$this->getProductores(),
            'proveedores'=>$this->getProveedoresContrato($idProductor)
        ]);
    }

    public function contrato($id_prod,$id_prov,$id_contrato){
        $detalle = $this->getDetallesContrato([$id_prod,$id_prov,$id_contrato]);
        abort_if(empty($detalle),404);
        //dd($detalle);

        return view('compras.crearPedido')->with(['detalle'=>$detalle]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
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

    private function getProductores(){
        return DB::select('SELECT id,nombre FROM rig_productores');
    }

    private function getProveedoresContrato($idProductor){

        return DB::select('
            SELECT
	            p.nombre,
                c.id,
                c.fcha_reg
            FROM rig_proveedores p,
	            rig_contratos c
            WHERE
	            p.id = c.id_prov
            AND
                c.fcha_fin IS NULL
	        AND
	            c.id_prod = ?
	        AND
	        (	fcha_reg + interval \'1 year\' >= current_date
		            OR c.id = (
			    SELECT r.id_ctra FROM rig_renovaciones r
			    WHERE
				r.fcha_reg + interval \'1 year\' >= current_date
                AND
				c.id_prod = r.id_prod AND c.id_prov = r.id_prov
		    )
	    )

        ',[$idProductor]);

    }

    private function getDetallesContrato($pkContrato){

        $contrato = DB::select('
            SELECT * FROM rig_contratos c
            WHERE id_prod = ? AND id_prov = ? AND id = ?
                AND
                    fcha_reg + interval \'1 year\' >= current_date
                AND
                    fcha_fin IS NULL
		        OR c.id = (
                    SELECT r.id_ctra FROM rig_renovaciones r
                    WHERE
                    r.fcha_reg + interval \'1 year\' >= current_date
                    AND
                    c.id_prod = r.id_prod AND c.id_prov = r.id_prov
                )
        ',$pkContrato);

        if (empty($contrato)) return [];

        $envios = DB::select('
            SELECT e.nombre, e.porce_serv, e.medio, e.pais FROM (
                    SELECT id_prov, id_ubic FROM rig_condiciones_contratos
                    WHERE id_prod = ? AND id_prov = ? AND id_ctra = ? AND id_ubic IS NOT NULL
                    ) cond,
                    (
                        SELECT ce.id_prov, ce.id_ubic, ce.nombre, ce.porce_serv, ce.medio, p.nombre pais
                        FROM rig_condiciones_de_envio ce,
                             rig_paises p
                        WHERE id_ubic=p.id
                    )e
            WHERE cond.id_prov = e.id_prov AND cond.id_ubic = e.id_ubic
        ',$pkContrato);

        $pagos = DB::select('
            SELECT p.tipo, p.coutas, p.porcen_cuo, p.cant_meses FROM (
                    SELECT id_prov, id_condpgo FROM rig_condiciones_contratos
                    WHERE id_prod = ? AND id_prov = ? AND id_ctra = ? AND id_ubic IS NULL
                    ) cond,
                    rig_condiciones_de_pago p
            WHERE cond.id_prov = p.id_prov AND cond.id_condpgo = p.id
        ',$pkContrato);

        $productos = DB::select('
            SELECT prod.nombre || \' \' ||to_char(prod.cas, \'9999999-00-0\') nombre_cas ,
	        to_char(prod.medida,\'990.00\') || \' \' || prod.unidad presentacion,
	        to_char(prod.precio,\'$ 999,999,990.00\') precio_txt,
            prod.*
                FROM (
                SELECT id_prov_ing, id_ing FROM rig_productos_contratados
                WHERE id_prod = ? AND id_prov = ? AND id_ctra = ?
                ) c,
                (
                    SELECT i.id_prov, i.id, i.cas, i.nombre ,p.cod_present, p.medida,p.precio,p.unidad
                    FROM rig_ingredientes_esencias i,
                         rig_presentaciones_ingredientes p
                    WHERE i.id_prov = p.id_prov AND i.id= p.id_ing
                ) prod
            WHERE c.id_prov_ing = prod.id_prov AND c.id_ing = prod.id
        ',$pkContrato);


        return ['contrato'=>$contrato,
            'envios'=>$envios,
            'pagos'=>$pagos,
            'productos'=>$productos];
    }
}
