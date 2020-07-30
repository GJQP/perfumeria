<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
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
        $idProductor = $request->id_prod ?: '1';

        return view('compras.gestionCompras')->with([
            'id_prod' => $idProductor,
            'productores' => $this->getProductores(),
            'proveedores' => $this->getProveedoresContrato($idProductor)
        ]);
    }

    public function contrato($id_prod, $id_prov, $id_contrato)
    {
        $detalle = $this->getDetallesContrato([$id_prod, $id_prov, $id_contrato]);
        abort_if(empty($detalle), 404);

        $pedidos = DB::select('
            SELECT p.fcha_reg, p.estatus, p.factura, p.id
            FROM rig_pedidos p,
                rig_condiciones_contratos ctr
            WHERE
                  p.id_ctra_cone = ctr.id
                  AND
                  ctr.id_prov = ? AND ctr.id_prod = ? AND ctr.id_ctra = ?
            ORDER BY id DESC
        ',[$id_prov,$id_prod,$id_contrato]);

        //dd($pedidos);

        return view('compras.crearPedido')->with(['detalle' => $detalle, 'id_contrato' => $id_contrato, 'pedidos'=>$pedidos]);
    }

    public function pedido($id_cto, Request $request)
    {

        //ddd($this->getEnvio($id_cto));
        //abort si no puedo hacer un nuevo pedido o redirect al que tengo abierto


        return view('compras.detallePedido')->with([
            'presentaciones' => $this->getProductos($id_cto),
            'Otrpresentaciones' => $this->getOtrosProductos($id_cto),
            'envios' => $this->getEnvio($id_cto),
            'pagos' => $this->getPagos($id_cto),
            'id_cto' => $id_cto,
            'selected' => []
        ]);
    }

    public function pagos($id_cto, $id_ped)
    {

        $data = $this->getDetallePedido($id_ped);

        $data['id_cto']=$id_cto;
        $data['id_ped']=$id_ped;

        //dd($data);

        return view('compras.consultaPedido')->with($data);
    }

    public function pagar($id_cto, $id_ped){

        $data = $this->getDetallePedido($id_ped);
        $data['id_cto']=$id_cto;
        $data['id_ped']=$id_ped;

        $i = 1;

        foreach ($data['pagos_gen'] as $pago){

            $fecha = Carbon::now('America/Caracas')->addDays(rand(round($pago['days']/4,0),$pago['days']))->format('Y-m-d');

            DB::insert('
                INSERT INTO rig_pagos (id_ped, id_ord, fcha_reg, total)
                VALUES (?,?,?,?)
            ',[
                $pago['id_ped'],
                $i++,
                $fecha ,
                $pago['total']
            ]);
        }



        return redirect()->route('compras.detalle',['id_ctro'=>$id_cto,'id_ped'=>$id_ped]);
    }

    public function setProductos(Request $request)
    {
        //dd($request->ingredientes);
        DB::beginTransaction();

        $pedido = DB::insert('
            INSERT INTO rig_pedidos
                (fcha_reg,estatus, factura)
                VALUES (current_date,?, NULL)
        ', ['NO ENVIADO']);

        $id_ped = DB::select('SELECT currval(\'rig_pedidos_id_seq\') AS id_ped');

        $i = 1;

        if (isset($request['ingredientes'])) {
            foreach ($request->ingredientes as $ingrediente)
                DB::insert('
                    INSERT INTO rig_detalles_pedidos
                    (id_ped, renglon, cantidad, id_prov_ing, id_ing, cod_pre_ing)
                    VALUES (currval(\'rig_pedidos_id_seq\'),?,?,?,?,?)
                ', [
                    $i++,
                    $ingrediente['cantidad'],
                    $ingrediente['id_prov'],
                    $ingrediente['id_ing'],
                    $ingrediente['cod_present']
                ]);
        }

        if (isset($request['otros_ingredientes'])) {
            foreach ($request->otros_ingredientes as $ingrediente)
                DB::insert('
                    INSERT INTO rig_detalles_pedidos
                    (id_ped,renglon, cantidad, cas_otr_ing, cod_pre_otr)
                    VALUES (currval(\'rig_pedidos_id_seq\'),?,?,?,?)
            ', [
                    $i++,
                    $ingrediente['cantidad'],
                    $ingrediente['cas'],
                    $ingrediente['cod_present']
                ]);
        }

        DB::commit();

        return response()->json($id_ped[0]);

    }

    public function setCondEnv($id_cto, Request $request)
    {

        //dd($request);

        $pkContrato = DB::select('SELECT id_prod, id_prov FROM rig_contratos WHERE id = ?', [
            $id_cto
        ]);

        DB::update('UPDATE rig_pedidos SET
                       id_prod_cone = ?,
                       id_prov_cone = ?,
                       id_ctra_cone = ?,
                       id_cone = ?
                        WHERE id= ?
        ', [
            $pkContrato[0]->id_prod,
            $pkContrato[0]->id_prov,
            $id_cto,
            $request->id_cone,
            $request->id_ped
        ]);

    }

    public function setCondPag($id_cto, Request $request)
    {

        //dd($request);

        $pkContrato = DB::select('SELECT id_prod, id_prov FROM rig_contratos WHERE id = ?', [
            $id_cto
        ]);

        DB::update('UPDATE rig_pedidos SET
                       id_prod_conp = ?,
                       id_prov_conp = ?,
                       id_ctra_conp = ?,
                       id_conp = ?
                     WHERE id = ?
        ', [
            $pkContrato[0]->id_prod,
            $pkContrato[0]->id_prov,
            $id_cto,
            $request->id_conp,
            $request->id_ped
        ]);

    }

    public function setEstado(Request $request)
    {

        if ($request->res){
            DB::update('
            UPDATE rig_pedidos
            SET estatus = ?,
                total = ?,
                factura = DEFAULT
            WHERE id = ?
            ', [
                'ENVIADO',
                $request->total,
                $request->id_ped
            ]);
        }
        else{
            DB::update('
            UPDATE rig_pedidos
            SET estatus = ?,
                total = ?,
            WHERE id = ?
            ', [
                'RECHAZADO',
                $request->total,
                $request->id_ped
            ]);
        }


    }

    private function findOrCreate($id_cto)
    {
        //
    }

    private function getProductores()
    {
        return DB::select('SELECT id,nombre FROM rig_productores');
    }

    private function getProveedoresContrato($idProductor)
    {

        return DB::select('
            SELECT
	            p.nombre,
                p.id id_prov,
                c.id id_contrato,
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

        ', [$idProductor]);

    }

    private function getDetallesContrato($pkContrato)
    {

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
        ', $pkContrato);

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
        ', $pkContrato);

        $pagos = DB::select('
            SELECT p.tipo, p.coutas, p.porcen_cuo, p.cant_meses
                FROM (
                    SELECT id_prov, id_condpgo FROM rig_condiciones_contratos
                    WHERE id_prod = ? AND id_prov = ? AND id_ctra = ? AND id_ubic IS NULL
                    ) cond,
                    rig_condiciones_de_pago p
            WHERE cond.id_prov = p.id_prov AND cond.id_condpgo = p.id
        ', $pkContrato);

        $productos = DB::select('
            SELECT prod.nombre || \' \' ||to_char(prod.cas, \'9999999-00-0\') nombre_cas ,
	        to_char(prod.medida,\'990.00\') || \' \' || prod.unidad presentacion,
	        to_char(prod.precio,\'$ 999,999,990.00\') precio_txt
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
        ', $pkContrato);

        return ['contrato' => $contrato,
            'envios' => $envios,
            'pagos' => $pagos,
            'productos' => $productos];
    }

    private function getProductos($id_cto)
    {
        return DB::select('
            SELECT prod.nombre || \' \' ||
	        to_char(prod.medida,\'990.00\') || \' \' || prod.unidad presentacion,
	        to_char(prod.precio,\'$ 999,999,990.00\') precio_txt,
            prod.precio,
            prod.id_prov,
            prod.id_ing,
            prod.cod_present
                FROM (
                SELECT id_prov_ing, id_ing FROM rig_productos_contratados
                WHERE id_ctra = ?
                ) c,
                (
                    SELECT i.id_prov, i.id, i.cas, i.nombre ,p.cod_present, p.medida,p.precio,p.unidad, p.id_ing
                    FROM rig_ingredientes_esencias i,
                         rig_presentaciones_ingredientes p
                    WHERE i.id_prov = p.id_prov AND i.id= p.id_ing
                ) prod
            WHERE c.id_prov_ing = prod.id_prov AND c.id_ing = prod.id
        ', [$id_cto]);
    }

    private function getOtrosProductos($id_cto)
    {
        return DB::select('
            SELECT
                o.nombre || \' \' ||
                to_char(o.volumen,\'990.00\') || \'ml\' as presentacion,
                to_char(o.precio,\'$ 999,999,990.00\') precio,
                o.precio,
                o.cas,
                o.cod_present
                FROM (
                SELECT cas_otr_ing FROM rig_productos_contratados
                WHERE id_ctra = ?
                ) c,
                (
                    SELECT p.precio, p.volumen, i.nombre, i.cas, p.cod_present
                    FROM rig_otros_ingredientes i,
                         rig_presentaciones_otros_ingredientes p
                    WHERE i.cas = p.cas_otr_ing
                ) o
            WHERE c.cas_otr_ing = o.cas
        ', [$id_cto]);
    }

    private function getEnvio($id_cto)
    {
        return DB::select('
            SELECT
                   e.nombre || \' \' || e.medio || \' \' || \'a \' || p.nombre || \' \' || e.porce_serv || \'%\' AS desc,
                   c.id
            FROM rig_condiciones_contratos c,
                 rig_condiciones_de_envio e

            JOIN rig_paises p
            ON p.id = e.id_ubic

            WHERE
                c.id_ctra = ?
                AND
                c.id_prov_ce = e.id_prov
                AND
                c.id_ubic = e.id_ubic

        ', [$id_cto]);
    }

    private function getPagos($id_cto)
    {
        return DB::select('
            SELECT
                   p.coutas || \' cuota(s) de \' || p.cant_meses || \' meses al \' || p.porcen_cuo || \'%\' AS desc,
                   c.id
            FROM rig_condiciones_contratos c,
                 rig_condiciones_de_pago p

            WHERE
                c.id_ctra = ?
                AND
                c.id_prov_cp = p.id_prov
                AND
                c.id_condpgo = p.id

        ', [$id_cto]);

    }

    private function getDetallePedido($id_ped)
    {
        $ingredientes = DB::select('
            SELECT item.presentacion, d.cantidad, item.precio_txt
                FROM
                    (
                        SELECT
                            i.nombre || \' \' ||
                            to_char(pres.medida,\'990.00\') || \' \' || pres.unidad presentacion,
                            to_char(pres.precio,\'$ 999,999,990.00\') precio_txt,
                            pres.cod_present,
                            i.id as id_ing,
                            i.id_prov
                        FROM rig_ingredientes_esencias i,
                             rig_presentaciones_ingredientes pres
                        WHERE i.id = pres.id_ing AND i.id_prov = pres.id_prov
                    ) item,
                     rig_detalles_pedidos d
                WHERE d.id_ped = ?
                     AND item.id_prov = d.id_prov_ing  AND item.id_ing = d.id_ing AND item.cod_present = d.cod_pre_ing
        ', [$id_ped]);

        $otros_ing = DB::select('
            SELECT item.cod_present, item.presentacion, item.precio, d.cantidad
            FROM (SELECT i.nombre || \' \' ||
                       to_char(p.volumen,\'990.00 ml\') presentacion,
                       to_char(p.precio,\'$ 999,999,990.00\') precio,
                       i.cas,
                       p.cod_present
                FROM rig_otros_ingredientes i,
                     rig_presentaciones_otros_ingredientes p
                WHERE i.cas = p.cas_otr_ing) item,
                    rig_detalles_pedidos d
                WHERE
                      d.cas_otr_ing = item.cas AND d.cod_pre_otr = item.cod_present
                      AND d.id_ped = ?
        ',[$id_ped]);

        $cond_env = DB::select('
            SELECT condiciones.desc, condiciones.id_cone FROM
                    (SELECT cond.*, cont.id as id_cone FROM
                                (SELECT
                                e.nombre || \' \' || e.medio || \' \' || \'a \' || p.nombre || \' \' || e.porce_serv || \'%\' AS desc,
                                e.id_prov,
                                e.id_ubic
                            FROM rig_condiciones_de_envio e,
                                 rig_paises p
                            WHERE e.id_ubic = p.id) cond,
                    rig_condiciones_contratos cont
                    WHERE cond.id_ubic = cont.id_ubic AND cond.id_prov = cont.id_prov) condiciones,
                    rig_pedidos ped
                WHERE condiciones.id_prov = ped.id_prov_cone AND condiciones.id_cone = ped.id_cone
                  AND ped.id = ?
        ',[$id_ped]);

        $cond_pag = DB::select('
            SELECT
                c_pag.coutas || \' cuota(s) de \' || c_pag.cant_meses || \' meses al \' || c_pag.porcen_cuo || \'% de interés por pago\' AS desc,
                c_pag.*
            FROM (SELECT pago.*, c_con.id_prov as id_prov_con, c_con.id_prod, c_con.id as id_conp, c_con.id_ctra as id_cont
                    FROM rig_condiciones_de_pago pago,
                     rig_condiciones_contratos c_con
                    WHERE pago.id = c_con.id_condpgo AND pago.id_prov = c_con.id_prov
                ) c_pag,
                 rig_pedidos ped
            WHERE c_pag.id_prod = ped.id_prod_conp
                    AND c_pag.id_prov = ped.id_prov_conp
                    AND c_pag.id_cont = ped.id_ctra_conp
                    AND c_pag.id_conp = ped.id_conp
                    AND ped.id = ?
        ',[$id_ped]);

        $pedido = DB::select('
            SELECT * FROM rig_pedidos WHERE id = ?
        ',[$id_ped]);

        return [
            'ingredientes'=>$ingredientes,
            'otros_ing'=>$otros_ing,
            'cond_env'=>$cond_env,
            'cond_pag'=>$cond_pag,
            'ped'=>$pedido[0],
            'pagos_gen'=>$this->generarPagos($cond_pag[0]->coutas,$cond_pag[0]->cant_meses, (float) $cond_pag[0]->porcen_cuo, (float) $pedido[0]->total, $pedido[0]->id ),
            'pagos_com'=>DB::select('SELECT * FROM rig_pagos WHERE id_ped=?',[$id_ped])
        ];


    }

    private function generarPagos($cuota, $plazo, $interes, $total, $id_ped)
    {
        $pago = [];

        for($i = 0; $i < $cuota; $i++){
            $pago[] = [
                    'id_ped'=>$id_ped,
                    'days'=>$plazo * 30 * $i,
                    'total'=>$total/$cuota * (1 + $interes / 100)
                ];

        }

        return $pago;

    }
}
