<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;

class Perfumistas extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $perfumistas = DB::select('select * from rig_perfumista');
        return view('perfumista.gestionPerfumistas')->with($perfumistas);
    }    
    

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('perfumista.perfumista'); 
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $request->validate([
            'nombre' =>'required',
            'genero' =>'required',
        ]);
        DB::insert('insert into rig_perfumista (id, name, genero, fecha_nacimiento) values (default,?,?,?)',[$request->input('nombre'), $request->input('genero'), $request->input('fecha-nacimiento')]);
        $perfumistas = DB::select('select * from rig_perfumista');
        return view('perfumista.gestionPerfumistas')->with($perfumistas);
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
        //Falta pasar la info
        return view('perfumista.perfumista')->with();
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
