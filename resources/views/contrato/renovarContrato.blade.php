@extends('layout.master')

@section('titulo','Renovar Contrato')

@section('contenido')
<div class="container mgt-2">
    <div class="stage tarjeta muli">
        <div class="mgt-1 blocktext">
            <p class="mgt-1" for="empresa"><strong>Empresa que creara un Contrato:</strong><p></p>
            <div>
                  <button class="btn btn-secondary dropdown-toggle" type="button" id="empresa" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" disable>
                    Empresa
                  </button>
            </div>
        </div>
        <!--Tabla de Formula Renovacion-->
        <div class="blocktext mgln-4">
            <table id="tabla" class="mgl-3">
                <form method="POST" autocomplete="off">
                    @method('PUT');
                    @csrf
                <tr>
                    <th id="criterioEva">Criterio de Evaluacion</th>
                    <th id="datosProvedor">Datos del Proveedor</th>
                    <th id="escalaEva">Escala</th>
                    <th id="porcentaje">Porcentaje</th>
                </tr>
                <!--Pedidos Enviados Satisfactoriamente-->
                <tr>
                    <td>Pedidos Enviados Satisfactoriamente</td>
                    <td>
                        <select class="datosProveedor form-control">
                            <option disabled>Caraotas</option>
                            <option disabled>Pasas</option>
                        </select>
                </td>
                <td id="escala"> <div> <input type="text" class="form-control escala" id="escalaubi" name="ubi-esc" placeholder="Escala Maxima 5"></div> </td>
                <td>20%</td>
                </tr>
                <!--Pedidos Cancelados-->
                <tr>
                    <td>Pedidos Cancelados</td>
                    <td>
                        <select class="datosProveedor form-control">
                            <option disabled>Caraotas</option>
                            <option disabled>Pasas</option>
                        </select>
                </td>
                <td id="escala"> <div> <input type="text" class="form-control escala" id="escalaubi" name="ubi-esc" placeholder="Escala Maxima 5"></div> </td>
                <td>20%</td>
                </tr>
                <!--Pedidos Enviados con Retraso-->
                <tr>
                    <td>Pedidos Enviados con Retraso</td>
                    <td>
                        <select class="datosProveedor form-control">
                            <option disabled>Caraotas</option>
                            <option disabled>Pasas</option>
                        </select>
                </td>
                <td id="escala"> <div> <input type="text" class="form-control escala" id="escalaubi" name="ubi-esc" placeholder="Escala Maxima 5"></div> </td>
                <td>20%</td>
                </tr>
                <!--Pedidos Rechazados-->
                <tr>
                    <td>Pedidos Rechazados</td>
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
                <!--Agregar el ID en el boton de cancelar-->
                <button class="btn btn-danger"><a href="/gestion-contrato/1">Cancelar</a></button>
                <button type="button" class="btn btn-primary mgl-1 " data-toggle="modal" data-target="#renovar">Evaluar</button>
            </div>
        
    </div>
</div>
    <!-- Popup para la eliminacion de una formula-->
    <div class="modal fade" id="renovar" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Renovar Contrat</h3>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" id="contenido-modal">
               <p>
                   ¿Esta seguro que desea renovar este contrato?
               </p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">Cancelar</button>
                <button type="submit" class="btn btn-danger">Eliminar</button>
            </div>
            </div>
        </div>
    </div>
</form>
@endsection