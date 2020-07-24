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
                <div class="dropdown mgl-1">
                    <form class="form-inline form-group" action="{{route('formula.index')}}" method="GET">
                    <p class="mgt-1" for="empresas"><strong>Seleccione la Empresa a la que desee consultar sus Formulas:</strong><p>
                        <select class="form-control selecEmp" name="id_prod">
                        @foreach ($productores as $productor)
                            <option value="{{$productor->id_prod}}">{{$productor->nombre}}</option>
                        @endforeach
                        </select>
                        <button type="submit" class="btn btn-primary mgl-1">Consultar fórmulas</button>
                    </form>
                </div>
            </div>
            <!--Tipo de Formula-->
            @if(!empty($iniciales))
            <p class="mgt-1 text-center" for="empresas"><strong>Fórmula inicial</strong><p>         
            <div class="blocktext mgln-4">       
            <table class="mgl-3 consulta">                
                <tr>
                    <th id="criterio">Criterio de Evaluacion</th>
                    <th id="escala">Escala</th>
                    <th id="porcentaje">Peso</th>
                </tr> 
            @foreach($iniciales as $variable)    
                <tr>
                    <td>{{$variable->nombre}}</td>
                    <td id="escala"> <div class="escala"> <p>{{$escala->rgo_min}} a {{$escala->rgo_max}}</p> </div> </td>
                    <td> <div class="porcentaje"> <p class="mgr-1">{{$variable->peso}}%</p> </div> </td>
                </tr>
            @endforeach
            </table>
            </div>
            @endif
            @if(!empty($renovaciones))
            <p class="mgt-1 text-center" for="empresas" aling="center"><strong>Fórmula renovación</strong><p>
            <div class="blocktext mgln-4">
            <table class="mgl-3 consulta">                
                <tr>
                    <th id="criterio">Criterio de Evaluacion</th>
                    <th id="escala">Escala</th>
                    <th id="porcentaje">Peso</th>
                </tr> 
            @foreach($renovaciones as $variable)    
                <tr>
                    <td>{{$variable->nombre}}</td>
                    <td id="escala"> <div class="escala"> <p>{{$escala->rgo_min}} a {{$escala->rgo_max}}</p> </div> </td>
                    <td> <div class="porcentaje"> <p class="mgr-1">{{$variable->peso}}%</p> </div> </td>
                </tr>
            @endforeach
            </table>
            </div>
            @endif
            @if(empty($renovaciones) && empty($iniciales))
            <p class="mgt-1 text-center" for="empresas" aling="center"><strong>El productor selecionado no tiene fórmulas registradas</strong><p>
            @endif
              <!--Botones-->
              <div class="blocktext mgt-2 pdb-2 row">
                <button type="button" class="btn btn-success mgl-1"><a href="/gestion-formula/crear/{{$productores[0]->id_prod}}">Crear Formula</a></button>
              </div>
        </div>
    </div>
    <!-- Popup para la eliminacion de una formula REMOVIDO-->
<div class="modal fade" id="eliminar" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
        <div class="modal-header">
            <h3 class="modal-title">Eliminar Fórmula</h3>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="modal-body" id="contenido-modal">
           <p>
               ¿Esta seguro que desea eliminar la Formula de esta Empresa?
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