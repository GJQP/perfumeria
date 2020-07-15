@extends('layout.master')

@section('titulo','Evaluación')

@section('contenido')
<div class="container mgt-2">
    <div class="stage tarjeta muli">
        <!--Nombre de la Empresa-->
        <div class="row blocktext">
            <p class="mgt-1" for="empresas"><strong>Empresa que se esta Evaluando:</strong><p>
            <div class="mgl-1">
                <button class="btn btn-secondary" id="empresa" disabled>
                    Priv I Organics
                </button>
            </div>
        </div>
        <!--Tabla de Formula Inicial-->
        <div class="blocktext mgln-4">
            <table id="tabla" class="mgl-3">
                <tr>
                    <th id="criterio">Criterio de Evaluacion</th>
                    <th id="datosProvedor">Datos del Proveedor</th>
                    <th id="escala">Escala</th>
                    <th id="porcentaje">Porcentaje</th>
                </tr>
                
                <tr id="total">
                    <td class="vacio"></td>
                    <td id="escala">Total</td>
                    <td id="total"> <div class="mgt-5r"> <h5>100%</h5></div></td>
                    <td></td>
                </tr>
              </table>
            
            </div>  
    </div>
</div>
@endsection