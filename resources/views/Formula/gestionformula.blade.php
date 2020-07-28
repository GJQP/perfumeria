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
                <div class="dropdown mgl-1 mgt-1">
                    <form class="form-inline form-group" action="{{route('formula.index')}}" method="GET">
                        <label for="id_prod">Seleccione la empresa a gestionar sus formulas:</label>
                        <select class="form-control selecEmp" name="id_prod" id="id_prod">
                            @foreach ($productores as $productor)
                                <option value="{{$productor->id_prod}}" {{$productor->id_prod == $id_prod? 'selected':''}}>{{$productor->nombre}}</option>
                            @endforeach
                        </select>
                        <button type="submit" class="btn btn-primary selecEmp">Cambiar productor</button>
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
                    <td id="escala">{{$escala[0]->rgo_ini}} a {{$escala[0]->rgo_fin}}</td>
                    <td>{{$variable->peso}}%</td>
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
                    <td id="escala">{{$escala[0]->rgo_ini}} a {{$escala[0]->rgo_fin}}</td>
                    <td>{{$variable->peso}}%</td>
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
                <a href="{{route('formula.crear',['id_prod' => $id_prod])}}" class="btn btn-primary btn-lg" role="button" aria-disabled="true"> Crear nueva fórmula </a>
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