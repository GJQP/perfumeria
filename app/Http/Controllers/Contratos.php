<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\RedirectResponse;

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
    {
        //$resultado = insert;
      return view('contrato.gestionContratos')->with('$resultado');
    }

    //Funcion de Prueba, se puede cambiar la ruta por index
    public function contratos(){
        return view('contrato.gestionContratos');
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('contrato.crearContrato');
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
        //insert del resultado de la evaluacion
        return redirect('/gestion-contratos/1/crear/evaluacion-1/1');
    }

    public function contrato(){
        return view('contrato.selecProductos');
    }

    public function storeContrato(){
        return redirect('/gestion-contratos/1/crear/evaluacion-1/1/descuento');
    }

    public function descuento(){
        return view('contrato.descuento');
    }

    public function storeDescuento($request, $id){
        //insert del descuento
        //tambien hay que agregarle el ID para que te muestre la empresa de una vez
        return redirect('/gestion-contratos');
    }

}
