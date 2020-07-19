@extends('layout.master')

@section('scripts')
<script type="text/javascript" src="{{ asset('js/custom.js') }}"></script>
@endsection

@section('titulo','Gestion de Formula')

@section('contenido')  
    <div class="container mgt-2">
        <div class="stage tarjeta muli">
            <!--Seleccionar la Empresa-->
            <div class="row blocktext">
                       <p class="mgt-1" for="empresas"><strong>Seleccione la Empresa a la que desee consultar sus Formulas:</strong><p>
                        <div class="dropdown mgl-1">
                            <button class="btn btn-secondary dropdown-toggle" type="button" id="empresa" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                              Empresa
                            </button>
                            <div class="dropdown-menu muli" aria-labelledby="dropdownMenuButton">
                                <!--Elementos internos del dropdown-->
                                <a class="dropdown-item" onclick="">Action</a>
                                <a class="dropdown-item" onclick="">Another action</a>
                                <a class="dropdown-item" onclick="">Priv I Organics LTD</a>                               
                            </div>
                        </div>
            </div>
            <!--Tipo de Formula-->
            <div class="row blocktext">
                <p class="mgt-1" for="empresas"><strong>Seleccione el tipo de Formula:</strong><p></p>
                <div class="dropdown mgl-1">
                    <button class="btn btn-secondary dropdown-toggle" type="button" id="tipoformula" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      Tipo
                    </button>
                    <div class="dropdown-menu muli" aria-labelledby="dropdownMenuButton">
                        <!--Elementos internos del dropdown-->
                        <a class="dropdown-item" onclick="">Inicial</a>
                        <a class="dropdown-item" onclick="">Renovacion</a>
                    </div>
                </div>
            </div>
            <!--Tabla de Formula Inicial-->
            <div class="blocktext mgln-4">
            <table class="mgl-3 consulta">
                <tr>
                    <th id="criterio">Criterio de Evaluacion</th>
                    <th id="escala">Escala</th>
                    <th id="porcentaje">Porcentaje</th>
                </tr>
                <tr>
                    <td>Ubicacion Geográfica</td>
                    <td id="escala"> <div class="escala"> <p> rango maximo</p> </div> </td>
                    <td> <div class="porcentaje"> <p class="mgr-1">%</p> </div> </td>
                </tr>
                <tr>
                    <td>Alternativa de Envío</td>
                    <td id="escala">  <div class="escala"> <p> rango maximo</p> </div> </td>
                    <td> <div class="porcentaje"> <p class="mgr-1">%</p> </div> </td>
                </tr>
                <tr>
                    <td>Costo de Envío</td>
                    <td id="escala"> <div class="escala"> <p> rango maximo</p> </div> </td>
                    <td> <div class="porcentaje"> <p class="mgr-1">%</p> </div> </td>
                </tr>
                <tr>
                    <td>Cumplimiento de Envíos sin retraso</td>
                    <td id="escala"> <div class="escala"> <p> rango maximo</p> </div> </td>
                    <td> <div class="porcentaje"> <p class="mgr-1">%</p> </div> </td>
                </tr>
                <tr>
                    <td>Alternativas de Pago</td>
                    <td id="escala"> <div class="escala"> <p> rango maximo</p> </div> </td>
                    <td> <div class="porcentaje"> <p class="mgr-1">%</p> </div> </td>
                </tr>
                <tr>
                    <td class="vacio"></td>
                    <td id="escala">Total</td>
                    <td id="total"></td>
                </tr>
              </table>
              </div>
              <!--Botones-->
              <div class="blocktext mgt-2 pdb-2 row">
                <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#eliminar">Eliminar</button>
                <button type="button" class="btn btn-secondary mgl-1"><a href="/gestion-formula/crear">Crear Formula</a></button>
              </div>
        </div>
    </div>
    <!-- Popup para la eliminacion de una formula-->
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