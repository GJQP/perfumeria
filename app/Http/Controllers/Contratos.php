<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

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
        return view('contrato.selecProductos');
    }
}
