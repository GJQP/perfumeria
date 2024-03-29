@extends('layout.master')

@section('scripts')
<script type="text/javascript" src="{{ asset('js/custom.js') }}"></script>
@endsection

@section('titulo','Gestion de Contratos')

@section('contenido')
<div class="container mgt-2 mgrb-1">
    <div class="stage tarjeta muli">
        <div class="pdt-1 blocktext">
            <form class="form-inline form-group" action="{{route('contrato.seleccionarProveedores')}}" method="GET">
                <label for="sel1">Seleccione un productor para generar un contrato:</label>
                <select class="form-control selecEmp" name="id_prod">
                @foreach ($productores as $productor)
                    <option value="{{$productor->id}}">{{$productor->nombre}}</option>
                @endforeach
                </select>
                <button type="submit" class="btn btn-primary mgl-1">Crear contrato</button>
            </form>
        </div>
        <!--Seleccionar la Empresa-->
        <div class=" blocktext mgt-1 tablaDatos pdb-2">
            @if(!empty($contratos))
            <table>
                <tr>
                    <th class="nombre_prod">Nombre del proveedor</th>
                    <th class="nombre_prov">Nombre del productor</th>
                    <th class="fcha_fin">Vigente hasta</th>
                    <th class="aciones">Acción</th>
                </tr>
                @foreach ($contratos as $contrato)
                <tr>
                    <td>{{$contrato->nombre_prod}}</td>
                    <td>{{$contrato->nombre_prov}}</td>
                    <td>{{$contrato->fcha_cul}}</td>
                    <td>
                        @if(Carbon\Carbon::create($contrato->fcha_cul)->subMonth()->startOfDay()   ->betweenIncluded(Carbon\Carbon::now()->subMonth()->startOfDay(), Carbon\Carbon::now()->startOfDay()))
                            <a href="#"  class="btn btn-info text-light" data-toggle="modal" data-target="#renovar" onclick="guardarId({{$contrato->id}},{{$contrato->id_prov}},{{$contrato->id_prod}})">Renovar contrato </a>
                        @endif
                        <a href="{{route('contrato.cancelar', [$contrato->id_prod, $contrato->id_prov, $contrato->id])}}" class="btn btn-danger text-light">Cancelar contrato</a>
                    </td>
                </tr>
                @endforeach
            </table>
            @else
                <p class="mgt-1 text-center" for="empresas" aling="center"><strong>No hay contratos activos</strong><p>
            @endif
        </div>
    </div>
</div>
    <!-- Popup de confirmacion de renovacion-->
    <div class="modal fade" id="renovar" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Renovar Contrato</h3>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" >
               <p id="cuerpo">
                   ¿Ambas partes desean renovar este Contrato?
               </p>
            </div>
            <div class="modal-footer" id="botones">
                <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-primary" onclick="preguntar()">Renovar</button>
            </div>
            </div>
        </div>
    </div>
@endsection
