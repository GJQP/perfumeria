@extends('layout.master')

@section('scripts')

<script src="{{ asset('js/custom.js') }}"></script>
@endsection

@section('titulo','Crear Formula')

@section('contenido')
    <div class="container mgt-2">
        <div class="stage tarjeta muli">
            <!--Seleccionar la Empresa-->
            <div class="row blocktext">
                       <p class="mgt-1" for="empresas"><strong>Empresa a la que se creara una Formula de Inicio:</strong><p>
                        <div class="dropdown mgl-1">
                            <button class="btn btn-secondary dropdown-toggle" type="button" id="empresa" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" disabled>
                              Priv I Organics
                            </button>
                        </div>
            </div>
            <!--Tipo de Formula-->
            <div class="row blocktext">
                <p class="mgt-1" for="empresas"><strong>Seleccione el tipo de Formula:</strong><p></p>
                <div class="dropdown mgl-1">
                    <button class="btn btn-secondary dropdown-toggle" type="button" id="tipoformula" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" disabled>
                      Inicio
                    </button>
                    </div>
            </div>
            <!--Tabla de Formula Inicial-->
            <div class="blocktext mgln-4">
            
              <table method="POST" id="tabla" class="mgl-3">
                <form autocomplete="off"></form>
                  @csrf
                  <tr>
                      <th id="">Criterio de Evaluacion</th>
                      <th id="escala">Escala</th>
                      <th id="porcentaje">Porcentaje</th>
                      <th id="eliminar">Acción</th>
                  </tr>
                  
                  <tr id="total">
                      <td class="vacio"></td>
                      <td id="escala">Total</td>
                      <td id="total"> <div class="mgt-5r"> <h5 id="porcentajeTotal">100%</h5></div></td>
                      <td class="vacioac"></td>
                  </tr>
                </table>
              
              </div>
              <div class= "blocktext mgt-2">
                <input type="text" class="form-control min-aprob" name="min-aproblaceholder="Minimo Aprobatorio">
                <span class="input-group-addon">%</span>
              </div>  
              <div class="blocktext row mgt-2">
                <select id="criterios" class="form-control muli" >
                  <option disabled selected value="0"> -- Seleccione un Criterio -- </option>
                  Opciones cuando es formula de Inicio 
                  <option value="ubicacionGeografica">Ubicacion Geografica</option>
                  <option value="alternativaEnvio">Alternativas de Envío</option>
                  <option value="costoEnvio">Costo de Envío</option>
                  <option value="cumplimientoEnvio">Cumplimiento de Envíos</option>
                  <option value="alternativaPago">Alternativas de Pago</option>
                  

              <!--Opciones cuando es formula de Renovacion (Agregar un if para que aparezcan)-->
                  <!--
                  <option value="pedidosSatis">Pedidos Enviados Satisfactoriamente</option>
                  <option value="pedidosRetras">Pedidos Enviados con Retraso</option>
                  <option value="pedidosRecha">Pedidos Rechazados</option>
                  <option value="pedidosCance">Pedidos Cancelados</option>
                  -->
                </select>

                <button type="button" class="btn btn-primary mgl-3" onclick="agregar()">Agregar Criterio</button>
              </div>
                <!--Botones-->
                <div class="blocktext mgt-2 pdb-2 row">
                  <button type="button" class="btn btn-danger">Cancelar</button>
                  <button type="button" class="btn btn-secondary mgl-1" disabled>Crear Formula</button>
                </div>
          </form>
        </div>
    </div>
@endsection