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
                <form method="POST" autocomplete="off">
                    @csrf
                <tr>
                    <th id="criterioEva">Criterio de Evaluacion</th>
                    <th id="datosProvedor">Datos del Proveedor</th>
                    <th id="escalaEva">Escala</th>
                    <th id="porcentaje">Porcentaje</th>
                </tr>
                <tr>
                    <td> Destileria Muñoz Galvez</td>
                    <td>
                        <select class="datosProveedor form-control">
                            <option disabled>Caraotas</option>
                            <option disabled>Pasas</option>
                        </select>
                </td>
                <td id="escala"> <div> <input type="text" class="form-control escala" id="escalaubi" name="ubi-esc" placeholder="Escala Maxima 5"></div> </td>
                <td>20%</td>
                </tr>

                <tr id="total">
                    <td class="vacio"></td>
                    <td class="vacio"></td>
                    <td id="escala">Total</td>
                    <td id="total"> <div class="mgt-5r"> <h5>100%</h5></div></td>
                </tr>
                
              </table>
            </div>  
            <div class="blocktext row mgt-2 pdb-2">
                <button class="btn btn-danger"><a href="/gestion-contrato/crear-id">Cancelar</a></button>
                <button type="submit" class="btn btn-primary mgl-1 ">Evaluar</button>
            </div>
        </form>
    </div>
</div>
<!--Modal para decir que si se quiere  crear contrato -->
<div class="modal fade" id="eliminar" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
        <div class="modal-header">
            <h3 class="modal-title">Eliminar Formula</h3>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="modal-body" id="contenido-modal">
           <p>
               ¿Esta seguro que desea eliminar la Formula de Inicio de la Empresa piiiiii?
           </p>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-primary" data-dismiss="modal">Cancelar</button>
            <button type="button" class="btn btn-danger" onclick="eliminar()">Eliminar</button>
        </div>
        </div>
    </div>
</div>
@endsection