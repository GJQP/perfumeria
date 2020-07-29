@extends('layout.master')

@section('titulo','Gestion de Compras')

@section('contenido')
<div class="container mgt-2 mgrb-1">
    <div class="stage tarjeta muli">
        <!--Seleccionar la Empresa-->
        <div class="pdt-1 blocktext">
            <div>
                <form class="form-inline form-group" action="{{route('compras.index')}}" method="GET">
                    <label for="id_prod">Seleccione la Empresa que desea realizar un pedido:</label>
                    <select class="form-control" name="id_prod" id="id_prod">
                        @foreach ($productores as $productor)
                            <option value="{{$productor->id}}" {{$productor->id == $id_prod? 'selected':''}}>{{$productor->nombre}}</option>
                        @endforeach
                    </select>
                    <button type="submit" class="btn btn-primary mgl-1">Cambiar productor</button>
                </form>
            </div>
        </div>
        <!-- Tabla de Pedidos-->
        <div class="blocktext mgtp-1 tablaDatos pdb-2">
            @if($proveedores)
                <table>
                    <tr>
                        <th id="nombreEmp">Nombre de la Empresa</th>
                        <th id="estado">Estado</th>
                        <th id="emisiónContrato">Fecha Emisión de Contrato</th>
                        <th id="accion">Acción</th>
                    </tr
                    @foreach($proveedores as $proveedor)
                        <tr>
                            <td>{{$proveedor->nombre}}</td>
                            <td>Activo</td>
                            <td>{{$proveedor->fcha_reg}}</td>
                            <td>
                                <div>
                                    <button class="btn btn-link btn-primary">
                                        <a
                                            href="{{route('compras.contrato',[$id_prod,$proveedor->id_prov,$proveedor->id_contrato])}}"
                                        >
                                            Ver Pedidos
                                        </a>
                                    </button>

                                </div>
                            </td>
                        </tr>
                    @endforeach
                </table>
            @else
                <p class="mgt-1"><strong>Esta empresa no tiene contratos vigentes</strong><p>
            @endif

        </div>
    </div>
</div>
@endsection
