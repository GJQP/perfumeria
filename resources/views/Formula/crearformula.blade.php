@extends('layout.master')

@section('scripts')

<script src="{{ asset('js/custom.js') }}"></script>
@endsection

@section('titulo','Crear Formula')

@section('contenido')
    <div class="container mgt-2">
        <div class="stage tarjeta muli">
            <!--Tipo de Formula-->
            <div>
            <div class="blocktext mgt-2">
                <p class="mgt-1 pr-3" for="empresas" id="titulo" onload="modificarFormula()"><strong>Selecciona un tipo</strong><p></p>
                <select id="formula" class="form-control sm" >
                  <option disabled selected value="0"> -- Inicial un Criterio -- </option>
                  <option value="inicial">Inicial</option>
                  <option value="renovacion">Renovacion</option>
                </select>
                <button type="button" class="btn btn-primary mgl-3" onclick="modificarFormula()">Selecionar</button>
            </div>
            <div>
            <!--Tabla de Formula Inicial-->
            <form  method="POST" autocomplete="off" action="{{route('formula.registrar')}}">
            <div class="blocktext mgln-4">            
              <table id="tabla" class="mgl-3">              
                  @csrf
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
                <input type="text" class="form-control min-aprob" name="min" placeholder="Minimo Aprobatorio">
                <span class="input-group-addon">%</span>
              </div>  
              <div class="blocktext row mgt-2">
                <select id="criterios" class="form-control muli" >
                </select>
                <button type="button" class="btn btn-primary mgl-3" onclick="agregar()">Agregar Criterio</button>
              </div>
                <!--Botones-->
                <div class="blocktext mgt-2 pdb-2 row">
                  <a href="{{route('formula.index')}}" class="btn btn-danger" role="button" aria-pressed="true">Cancelar</a>
                  <button type="submit" class="btn btn-primary mgl-1" >Crear Formula</button>
                </div>
          </form>
        </div>
    </div>
@endsection