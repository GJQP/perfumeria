@extends('layout.master')

@section('titulo','Crear Contrato')

@section('contenido') 
<div class="container mgt-2">
    <div class="stage tarjeta muli">
        <!--Seleccionar la Empresa-->
        <div class="row blocktext">
                   <p class="mgt-1" for="empresas"><strong>Empresa que creara un Contrato:</strong><p>
                    <div class="dropdown mgl-1">
                        <button class="btn btn-secondary dropdown-toggle" type="button" id="empresa" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" disabled>
                          Priv I Organics
                        </button>
                    </div>
        </div>
        <!--Tabla de Empresas-->
        <div class="blocktext mgln-4" id="tablaEmpresas">
            <table class="mgl-3 empresas">
                <tr>
                    <th id="nombres">Nombre de Empresas</th>
                    <th id="productos">Productos</th>
                    <th id="accion">Accion</th>
                </tr>
                <tr>
                    <td>Priv I Organics</td>
                    <td> <div class="blocktext"> 
                        <select id="listaProductos" class="form-control muli">
                            <option disabled selected value="0">Productos de la Empresa</option>
                            <option disabled>Hola</option>
                            <option disabled>Adios</option>
                        </select>
                    </div>
                </td>
                    <!--Agregar Id de la empresa-->
                    <td> <a  id="1" href="/gestion-contratos/1/crear/evaluacion-1"> Iniciar Evaluacion</a></td>
                </tr>
              </table>   
        </div>
        <!--Boton para volver al menu de gestion-->
        <div class="blocktext mgt-1 mgrb-1">
            <button type="button" class="btn btn-danger" > <a href="/gestion-contratos">Cancelar</a></button>
        </div>
    </div>
</div>
@endsection