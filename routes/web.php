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
Route::get ('/gestion-contratos','Contratos@contratos');
Route::get ('/gestion-contratos/{id}','Contratos@index');

//Mostrar Empresas
Route::get ('/gestion-contrato/crear','Contratos@create');

//Evaluacion Inicial
Route::get ('/gestion-contratos/{id}/crear/evaluacion-{proveedor}','Contratos@evaluacion');

//Crear Contrato
Route::post('/gestion-contratos/{id}/crear/evaluacion-{proveedor}','Contratos@vistacontrato');

//Seleccion de elementos del Contrato
Route::get('/gestion-contratos/{id}/crear/evaluacion-{proveedor}/{contrato}','Contratos@contrato');

//Guardar el contrato
Route::post('/gestion-contratos/{id}/crear/evaluacion-{proveedor}/{contrato}','Contratos@storeContrato');

//Cargar Pagina del decuento
Route::get('/gestion-contratos/{id}/crear/evaluacion-{proveedor}/{contrato}/descuento','Contratos@descuento');

//Guardar el descuento
Route::post('/gestion-contratos/{id}/crear/evaluacion-{proveedor}/{contrato}/descuento','Contratos@storeDescuento');

//Evaluacion de Renovacion
Route::get('/gestion-contratos/{id}/renovar/evaluacion-{proveedor}','Contratos@renovacion');

//Guardar el porcentaje de la renovacion
Route::put('/gestion-contratos/{id}/renovar/evaluacion-{proveedor}','Contratos@storeRenovacion');

//Gestion Compras
Route::get ('/gestion-compras','Compras@index');
