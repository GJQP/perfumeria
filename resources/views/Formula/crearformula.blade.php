@extends('layout.master')

@section('scripts')

<script src="{{ asset('js/custom.js') }}"></script>
@endsection

@section('titulo','Crear Formula')

@section('contenido')
    <div class="container mgt-2">
        <div class="stage tarjeta muli">
            <!--Tipo de Formula-->
            <p class="mx-auto" for="empresas" id="titulo" onload="modificarFormula()">
                <strong>Selecciona un tipo</strong>
            </p>
            <div>
            <div class="blocktext mgt-2">
                <select id="formula" class="form-control sm" >
                  <option disabled selected value="0"> -- Inicial un Criterio -- </option>
                  <option value="inicial">Inicial</option>
                  <option value="renovacion">Renovacion</option>
                </select>
                <button type="button" class="btn btn-primary mgl-3" onclick="modificarFormula()">Selecionar</button>
            </div>
            <br>
            <div>
            <!--Tabla de Formula Inicial-->
            <form  method="POST" autocomplete="off" action="{{route('formula.registrar', ['id_prod' => $id_prod])}}">
            @csrf
            <div class="blocktext mgln-4">            
              <table id="tabla" class="mgl-3" onchange="evaluacionPorcentaje()">              
                  <tr>
                      <th id="">Criterio de Evaluacion</th>
                      <th id="porcentaje">Porcentaje</th>
                      <th id="eliminar">Acción</th>
                  </tr>                  
                  <tr id="total">
                      <td class="vacio"></td>
                      <td id="total"> <div class="mgt-5r"> <h5 id="porcentajeTotal"></h5></div></td>
                      <td id="escala">Total</td>
                  </tr>
                </table>              
              </div>
              <div class= "blocktext mgt-2">
                <h3 class= "blocktext pr-4">Mínimo aprobatorio</h3>
                <input type="text" class="form-control min-aprob" name="minApro" placeholder="Minimo Aprobatorio">
                <span class="input-group-addon">%</span>
              </div>  
              <div class="blocktext row mgt-2">
                <select id="criterios" class="form-control muli" >
                </select>
                <button type="button" class="btn btn-primary mgl-3" onclick="agregar()">Agregar Criterio</button>
              </div>
                <!--Botones-->
                
                 </div>
              </div>
              <div class="container mgt-2">
                      <!--Seleccionar la Empresa-->
                <div class="row blocktext">
                  <h3 class="modal-title">Registra una nueva escala</h3>
                </div>
                <div class="row blocktext">
                <div class="form-row">
                  <div class="form-group col-md-4">
                    <label for="min">Valor mínimo</label>
                    <input type="text" class="form-control" id="min" name="min" placeholder="Valor mínimo">
                  </div>
                  <div class="form-group col-md-4">
                    <label for="max">Valor maximo</label>
                    <input type="text" class="form-control" id="max" name="max" placeholder="Valor máximo">
                  </div>
                  <div class="form-group col-md-4">
                    <div class="form-row">
                      <button type="submit" class="btn btn-primary mgl-1">Registrar nueva escala y crear fórmula</button>
                    <div>
                  </div>
                </div>
              </div>
                      <!--Tipo de Formula-->
                @if(!empty($escala))
                <table class="mgl-3 "> 
                    <p class="mgt-1 text-center" for="empresas"><strong>Escala actual</strong><p>   
                    <div class="blocktext">
                          <tr>
                              <th id="criterio">Fecha de registro</th>
                              <th id="escala">Valor minimo</th>
                              <th id="porcentaje">Valor máximo</th>
                          </tr> 
                          <tr>
                              <td>{{$escala[0]->fcha_reg}}</td>
                              <td id="escala"> {{$escala[0]->rgo_ini}}</td>
                              <td> {{$escala[0]->rgo_fin}}</td>
                          </tr>
                      </table>
                    </div>
                </div> 	
                  <div class="blocktext mgt-2 pdb-2 ">
                    <div class="blocktext mgt-2 pdb-2 row">
                      <a href="{{route('formula.index')}}" class="btn btn-danger" role="button" aria-pressed="true">Cancelar</a>
                      <button type="submit" class="btn btn-primary mgl-1" >Usar escala actual y crear formula</button>
                    </div>
                  </div>
                </div> 
                @else
                <div class="blocktext mgt-2 pdb-2">
                  <h4>El productor consultado no tiene escalas definidas</h4>
                </div>
                @endif			
              </form>                  
              </div>
              
@endsection