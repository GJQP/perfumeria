<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

//Boton de Inicio
Route::get('/inicio','Contratos@inicio');

//Perfumista
Route::get('/gestion-perfumista','Perfumistas@index');
Route::get('/gestion-perfumista/crear','Perfumistas@create');
Route::post('/gestion-perfumista/crear','Perfumistas@store');
Route::get('/gestion-perfumista/editar-{id}','Perfumista@edit');
Route::get('/gestion-perfumista/#','Perfumistas@destroy');

//Gestion de Formulas
Route::get ('/gestion-formula','GestionFormula@index');

//Crear Formula
Route::get ('/gestion-formula/crear','GestionFormula@crearinicio');

//Gestion de Contratos
Route::get ('/gestion-contratos','Contratos@contratos');
Route::get ('/gestion-contratos/{id}','Contratos@index');

//Crear Contrato
Route::get ('/gestion-contrato/crear','Contratos@create');
Route::get ('/gestion-contratos/{id}/crear/evaluacion-{proveedor}','Contratos@evaluacion');
