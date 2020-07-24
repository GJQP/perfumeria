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
Route::get ('/gestion-formula/{id_prod?}','GestionFormula@index')->name('formula.index');

//Crear Formula
Route::get ('/gestion-formula/crear/{id_prod}','GestionFormula@create');
Route::post('/gestion-formula/crear/registrar','GestionFormula@store')->name('formula.registrar');

//Gestion de contratos
Route::post('/gestion-contratos/crear/{id_prod}/{id_prov}/generar', 'Contratos@registrarContrato')->name('contrato.generar');
Route::get ('/gestion-contratos','Contratos@index')->name('contratos.index');
Route::get ('/gestion-contratos/crear','Contratos@seleccionarProveedores')->name('contrato.seleccionarProveedores');
Route::get ('/gestion-contratos/crear/{id_prod}/{id_prov}','Contratos@crearContrato')->name('contrato.crear');
Route::get ('/gestion-contratos/cancelar-contrato/{id_prod}/{id_prov}/{id_ctra}', 'Contratos@motivoCancelación')->name('contrato.cancelar');
Route::post('/gestion-contratos/cancelar-contrato/fin/{id_prod}/{id_prov}/{id_ctra}', 'Contratos@cancelar')->name('contrato.fin');
Route::get ('/gestion-contratos/renovar/{id_prod}/{id_prov}/{id_ctra}','Contratos@renovarContrato')->name('contrato.renovar');
Route::get ('gestion-contratos/cancelar/{id_cont}/{id_prov}','Contratos@renovarCreacion')->name('contrato.renovarPorCreacion');

//Crear Contrato
Route::get ('/gestion-contratos/{id}/crear/evaluacion-{proveedor}','Contratos@evaluacion');
Route::post('/gestion-contratos/{id}/crear/evaluacion-{proveedor}','Contratos@vistacontrato');

//Gestion Compras
Route::get ('/gestion-compras','Compras@index')->name('compras.index');
Route::get('/gestion-compras/{id_prod}/contrato/{id_prov}/{id_contrato}','Compras@contrato')->name('compras.contrato');


