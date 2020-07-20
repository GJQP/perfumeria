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
Route::get('/gestion-perfumista/{id}','Perfumistas@edit');
Route::put('/gestion-perfumista/{id}','Perfumistas@update');
Route::delete('/gestion-perfumista/{id}','Perfumistas@destroy');

//Gestion de Formulas
Route::get ('/gestion-formula','GestionFormula@index');

//Crear Formula
Route::get ('/gestion-formula/crear','GestionFormula@create');
Route::post('/gestion-formula/crear','GestionFormula@store');

//Gestion de Contratos
Route::get ('/gestion-contratos','Contratos@index')->name('contratos.index');

//Gestion de contrato
Route::get ('/gestion-contratos/crear','Contratos@create')->name('contrato.crear');
Route::get ('/gestion-contratos/cancelar-contrato/{id}', 'Contratos@cancelarContrato')->name('contrato.cancelar');
Route::post('/gestion-contratos/cancelar-contrato/fin', 'Contratos@cancelar')->name('contrato.fin');
Route::get ('/gestion-contratos/renovar/{id}','Contratos@renovarContrato')->name('contrato.renovar');

//Crear Contrato
Route::get ('/gestion-contrato/crear','Contratos@create');
Route::get ('/gestion-contratos/{id}/crear/evaluacion-{proveedor}','Contratos@evaluacion');
Route::post('/gestion-contratos/{id}/crear/evaluacion-{proveedor}','Contratos@vistacontrato');

//Gestion Compras
Route::get ('/gestion-compras','Compras@index');


