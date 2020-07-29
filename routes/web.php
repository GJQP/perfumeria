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
Route::get ('/gestion-formula/crear/{id_prod}','GestionFormula@create')->name('formula.crear');
Route::post ('/gestion-formula/crear/{id_prod}/registrar','GestionFormula@store')->name('formula.registrar');



//Gestion de contratos
Route::post('/gestion-contratos/crear/{id_prod}/{id_prov}/generar', 'Contratos@registrarContrato')->name('contrato.generar');
Route::get ('/gestion-contratos','Contratos@index')->name('contratos.index');
Route::get ('/gestion-contratos/crear','Contratos@seleccionarProveedores')->name('contrato.seleccionarProveedores');
Route::get ('/gestion-contratos/crear/{id_prod}/{id_prov}','Contratos@crearContrato')->name('contrato.crear');
Route::get ('/gestion-contratos/cancelar-contrato/{id_prod}/{id_prov}/{id_ctra}', 'Contratos@motivoCancelación')->name('contrato.cancelar');
Route::post('/gestion-contratos/cancelar-contrato/fin/{id_prod}/{id_prov}/{id_ctra}', 'Contratos@cancelar')->name('contrato.fin');
//Route::get ('/gestion-contratos/renovar/{id_prod}/{id_prov}/{id_ctra}','Contratos@renovarContrato')->name('contrato.renovar');
Route::get ('gestion-contratos/cancelar/{id_cont}/{id_prov}','Contratos@renovarCreacion')->name('contrato.renovarPorCreacion');

//Crear Contrato
Route::get ('/gestion-contratos/evaluacion/{id_prod}/{id_prov}','Contratos@evaluacion')->name('evaluacion.nueva');
Route::post ('/gestion-contratos/evaluacion/registrar/{id_prod}/{id_prov}','Contratos@registrarEvaluacion')->name('evaluacion.registrar');
Route::post('/gestion-contratos/evaluacion_ren/renovar/{id_prod}/{id_prov}/{id}','Contratos@renovarContrato')->name('evaluacion.renregistrar');
Route::get('/gestion-contratos/evaluacion_ren/{id_prod}/{id_prov}/{id_ctra}','Contratos@renovacionContrato');

//Gestion Compras
Route::get ('/gestion-compras','Compras@index')->name('compras.index');
Route::get('/gestion-compras/{id_prod}/contrato/{id_prov}/{id_contrato}','Compras@contrato')->name('compras.contrato');
Route::get('/gestion-compras/pedido/{id_cto}','Compras@pedido')->name('compras.pedidos');
Route::get('/gestion-compras/pagos/{id_cto}/{id_ped}', 'Compras@pagos')->name('compras.pagos');

//ASYNC COMPRAS
Route::post('/pedido/{id_ctro}/detalles', 'Compras@setProductos');
Route::post('/pedido/{id_ctro}/envio', 'Compras@setCondEnv');
Route::post('/pedido/{id_ctro}/pago', 'Compras@setCondPag');
Route::post('/pedido/{id_ctro}/respuesta', 'Compras@setEstado');
Route::get('/pedido/{id_ctro}/{id_ped}','Compras@pagos')->name('compras.detalle');
//POST CREAR PAGO


//Recomendador de Perfumes
Route::get ('/recomendador-perfumes', 'Recomendador@index');
