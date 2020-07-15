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
        $perfumistas = DB::select('SELECT * from rig_perfumistas ORDER BY id');
        return view('perfumista.gestionPerfumistas')->with('perfumistas',$perfumistas);
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

        DB::insert('INSERT into rig_perfumistas (id, nombre, genero, fcha_nac) values (default,?,?,?)',
            [
                $request->input('nombre'),
                $request->input('genero'),
                $request->input('fecha-nacimiento')
            ]);
        
        return redirect()->action('Perfumistas@index');
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
        $perfumista = DB::select('SELECT * from rig_perfumistas WHERE id = ?',[$id]);
        return view('perfumista.perfumista')->with('perfumista',last($perfumista));
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
        DB::update('UPDATE rig_perfumistas set nombre = ?, genero = ?, fcha_nac = ? where id = ?',
            [
                $request->input('nombre'),
                $request->input('genero'),
                $request->input('fecha-nacimiento'),
                $id
            ]
        );
        return redirect()->action('Perfumistas@index');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        DB::delete('DELETE FROM rig_perfumistas WHERE id = ?',[$id]);
        return response()->json(['STATUS'=> 'OK']);
    }
}
