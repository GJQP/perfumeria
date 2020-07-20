@extends('layout.master')

@section('titulo','Gestion de Contratos')

@section('contenido')
<div class="container mgt-2 mgrb-1">
    <div class="stage tarjeta muli">
        <div aling="center">
            <form class="form-inline form-group" action="{{route('contrato.crear')}}" method="GET">
                <label for="sel1">Seleccione un productor para generar un contrato:</label>
                <select class="form-control" name="id_prod">
                @foreach ($productores as $productor)
                    <option value="{{$productor->id}}">{{$productor->nombre}}</option>
                @endforeach
                </select>
                <button type="submit" class="btn btn-primary">Crear contrato</button>
            </form>
        </div>
        <!--Seleccionar la Empresa-->
        <div class=" blocktext mgt-2 tablaDatos">
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
                    <td>{{$contrato->fcha}}</td>
                    <td>
                        @if(Carbon\Carbon::create($contrato->fcha)->lessThanOrEqualTo(Carbon\Carbon::now()->next('month')))
                            <a href="{{route('contrato.renovar', $contrato->id)}}"  class="btn btn-info btn-sm">Renovar contrato</a>
                        @endif
                        <a href="{{route('contrato.cancelar', $contrato->id)}}" class="btn btn-danger btn-sm">Cancelar contrato</a>
                    </td>
                </tr>
                @endforeach
            </table>
        </div>
    </div>
</div>
@endsection
