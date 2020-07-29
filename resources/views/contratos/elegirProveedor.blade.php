@extends('layout.master')

@section('titulo','Crear Contrato')

@section('contenido')
<div class="container mgt-2">
    <div class="stage tarjeta muli">
        <example-component></example-component>
        <!--Seleccionar la Empresa-->
        <div class="row blocktext">
            <div class="pdt-1 blocktext">
                <form class="form-inline form-group" action="{{route('contrato.seleccionarProveedores')}}" method="GET">
                    <label for="sel1">Productor a generar un contrato:</label>
                    <select class="form-control selecEmp" name="id_prod">
                        @foreach ($productores as $productor)
                            <option value="{{$productor->id}}" {{$productor->id == $id_prod? 'selected':''}}>{{$productor->nombre}}</option>
                        @endforeach
                    </select>
                    <button type="submit" class="btn btn-primary mgl-1">Cambiar productor</button>
                </form>
            </div>
        </div>
        <!--Tabla de Empresas-->
        <div class="blocktext mgln-4" id="tablaEmpresas">
            <table class="mgl-3 empresas">
                <tr>
                    <th id="nombres">Nombre de Empresas</th>
                    <th id="accion">Accion</th>
                </tr>
                @foreach($proveedores as $proveedor)
                    <tr>
                        <td>{{$proveedor->nombre}}</td>
                    </td>
                        <td><a class="aN" href="{{route('evaluacion.nueva', [$id_prod, $proveedor->id])}}">Iniciar evaluación</a></td>
                    </tr>
                @endforeach                
              </table>
        </div>
        <!--Boton para volver al menu de gestion-->
        <div class="blocktext mgt-1 mgrb-1">
            <button type="button" class="btn btn-danger" > <a href="{{route('contratos.index')}}">Cancelar</a></button>
        </div>
    </div>
</div>
@endsection
