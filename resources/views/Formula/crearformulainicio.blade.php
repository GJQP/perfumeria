@extends('layout.master')



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
            
            <table class="mgl-3">
                <form autocomplete="off">
                <tr>
                    <th id="">Criterio de Evaluacion</th>
                    <th id="escala">Escala</th>
                    <th id="porcentaje">Porcentaje</th>
                    <th id="eliminar">Acción</th>
                </tr>
                
                <tr id="ubicacionGeografica" style="display: none;">
                    <td>Ubicacion Geográfica</td>
                    <td id="escala"> <div> <input type="text" class="form-control escala" id="escalaubi" placeholder="Rango Maximo"></div> </td>
                    <td id="porcentaje"> <div class="row"> <input type="text" id="porcentajeubi" class="form-control porcentaje" name="email" required /> 
                        <span class="input-group-addon">%</span></div> 
                    </td>
                </tr>
                <tr id="alternativaEnvio" style="display: none;">
                    <td>Alternativa de Envío</td>
                    <td id="escala"> <div> <input type="text" class="form-control escala" id="escalaenv" placeholder="Rango Maximo"></div> </td>
                    <td id="porcentaje"> <div class="row"> <input type="text" id="porcentajeenv" class="form-control porcentaje" name="email" required /> 
                        <span class="input-group-addon">%</span></div> 
                    </td>
                </tr>
                <tr id="costoEnvio" style="display: none;">
                    <td>Costo de Envío</td>
                    <td id="escala"> <div> <input type="text" class="form-control escala" id="escalacostenv" placeholder="Rango Maximo"></div> </td>
                    <td id="porcentaje"> <div class="row"> <input type="text" id="porcentajecostenv" class="form-control porcentaje" name="email" required /> 
                        <span class="input-group-addon">%</span></div> 
                    </td>
                </tr>
                <tr id="cumplimientoEnvio" style="display: none;">
                    <td>Cumplimiento de Envíos sin retraso</td>
                    <td id="escala"> <div> <input type="text" class="form-control escala" id="escalacumpli" placeholder="Rango Maximo"></div> </td>
                    <td id="porcentaje"> <div class="row"> <input type="text" id="porcentajecumpli" class="form-control porcentaje" name="email" required /> 
                        <span class="input-group-addon">%</span></div> 
                    </td>
                </tr>
                <tr id="alternativaPago" style="display: none;">
                    <td>Alternativas de Pago</td>
                    <td id="escala"> <div> <input type="text" class="form-control escala" id="escalaaltpago" placeholder="Rango Maximo"></div> </td>
                    <td id="porcentaje"> <div class="row"> <input type="text" id="porcentajealtpago" class="form-control porcentaje" name="email" required /> 
                        <span class="input-group-addon">%</span></div> 
                    </td>
                </tr>
                <tr>
                    <td class="vacio"></td>
                    <td id="escala">Total</td>
                    <td id="total"></td>
                    <td class="vacioac"></td>
                </tr>
              </table>
            </form>
              </div>
              <div class="blocktext row mgt-2">
              <select id="criterios" name="criterios" class="form-control">
                <option value="ubicacionGeografica">Ubicacion Geografica</option>
                <option value="alternativaEnvio">Alternativas de Envío</option>
                <option value="costoEnvio">Costo de Envío</option>
                <option value="cumplimientoEnvio">Cumplimiento de Envíos</option>
                <option value="alternativaEnvio">Alternativas de Envío</option>
              </select>

            </div>
              <!--Botones-->
              <div class="blocktext mgt-2 pdb-2 row">
                <button type="button" class="btn btn-danger">Cancelar</button>
                <button type="button" class="btn btn-secondary mgl-1" disabled>Crear Formula</button>
              </div>
        </div>
    </div>
@endsection