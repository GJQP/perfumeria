@extends('layout.master')

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
            <table>
                <tr>
                    <th class="nombre_prod">Nombre del proveedor</th>
                    <th class="nombre_prov">Nombre del productor</th>
                    <th class="fcha_fin">Vigente hasta</th>
                    <th class="aciones">Acción</th>
                </tr>
                @if(!$contratos)
                <!--Tr por default cuando no se pasen parametros-->
                <tr class="default">
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                @endif
                @foreach ($contratos as $contrato)
                <tr>
                    <td>{{$contrato->nombre_prod}}</td>
                    <td>{{$contrato->nombre_prov}}</td>
                    <td>{{$contrato->fcha_cul}}</td>
                    <td>
                        @if(Carbon\Carbon::create($contrato->fcha_cul)->lessThanOrEqualTo(Carbon\Carbon::now()->next('month')))
                            <a href="{{route('contrato.renovar', [$contrato->id_prod, $contrato->id_prov, $contrato->id])}}"  class="btn btn-info">Renovar contrato</a>
                        @endif
                        <a href="{{route('contrato.cancelar', [$contrato->id_prod, $contrato->id_prov, $contrato->id])}}" class="btn btn-danger">Cancelar contrato</a>
                    </td>
                </tr>
                @endforeach
            </table>
        </div>
    </div>
</div>
@endsection
