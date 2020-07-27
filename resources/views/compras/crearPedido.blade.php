@extends('layout.master')

@section('titulo','Gestion de Compras')

@section('contenido')
    <div class="container mgt-2 mgrb-1">
        <div class="stage tarjeta muli">
            <!--Seleccionar la Empresa-->
            <div class="pdt-1 blocktext">
                <div>

                </div>
            </div>
            <div class="blocktext mgtp-1 tablaDatos pdb-2 row">
                <div id="accordion" class="col-sm-6">
                    <h3>Condiciones del Contrato</h3>
                    <div class="card" >
                        <div class="card-header" id="headingOne">
                            <h5 class="mb-0">
                                <button class="btn btn-link" data-toggle="collapse" data-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
                                    PRODUCTOS
                                </button>
                            </h5>
                        </div>

                        <div id="collapseOne" class="collapse" aria-labelledby="headingOne" data-parent="#accordion">
                            <div class="card-body blocktext">
                                <!-- Tabla de PRODUCTOS-->
                                <div class="mgtp-1 pdb-2">
                                    @if(\Illuminate\Support\Arr::has($detalle,'productos'))
                                        <table class="tablaDatos">
                                            <tr>
                                                <th>Nombre (CAS)</th>
                                                <th>Presentación</th>
                                                <th>Precio</th>
                                            </tr>
                                            @foreach($detalle['productos'] as $condicion)
                                                <div class="form-check">
                                                    <tr>
                                                        <td>{{$condicion->nombre_cas}}</td>
                                                        <td>{{$condicion->presentacion}}</td>
                                                        <td>{{$condicion->precio_txt}}</td>
                                                    </tr>
                                                </div>
                                            @endforeach
                                        </table>

                                    @else
                                        <p class="mgt-1"><strong>No hay productos disponibles</strong><p>
                                    @endif

                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-header" id="headingTwo">
                            <h5 class="mb-0">
                                <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                    CONDICIONES DE ENVÍO
                                </button>
                            </h5>
                        </div>
                        <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordion">
                            <div class="card-body blocktext">
                                <!-- Tabla de ENVIOS-->
                                <div class=" mgtp-1 pdb-2">
                                    @if(\Illuminate\Support\Arr::has($detalle,'envios'))
                                        <table class="tablaDatos">
                                            <tr>
                                                <th>Medio</th>
                                                <th>Descripción</th>
                                                <th>Comisión</th>
                                                <th>País</th>
                                            </tr>
                                            @foreach($detalle['envios'] as $condicion)
                                                <div class="form-check">
                                                    <tr>
                                                        <td>{{$condicion->nombre}}</td>
                                                        <td>{{$condicion->porce_serv}} %</td>
                                                        <td>{{$condicion->medio}}</td>
                                                        <td>{{$condicion->pais}}</td>
                                                    </tr>
                                                </div>
                                            @endforeach
                                        </table>

                                    @else
                                        <p class="mgt-1"><strong>No hay condiciones de envío</strong><p>
                                    @endif

                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-header" id="headingThree">
                            <h5 class="mb-0">
                                <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                    CONDICIONES DE PAGO
                                </button>
                            </h5>
                        </div>
                        <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordion">
                            <div class="card-body blocktext">
                                <!-- Tabla de PAGOS-->
                                <div class=" mgtp-1 pdb-2">
                                    @if(\Illuminate\Support\Arr::has($detalle,'pagos'))
                                        <table class="tablaDatos">
                                            <tr>
                                                <th>Tipo</th>
                                                <th>Número de Cuotas</th>
                                                <th>Plazo del Pago</th>
                                            </tr>
                                            @foreach($detalle['pagos'] as $condicion)
                                                <div class="form-check">
                                                    <tr>
                                                        <td>{{$condicion->tipo}}</td>
                                                        <td>{{$condicion->coutas}}</td>
                                                        <td>{{$condicion->cant_meses}}</td>
                                                    </tr>
                                                </div>
                                            @endforeach
                                        </table>

                                    @else
                                        <p class="mgt-1"><strong>No hay condiciones de pagos</strong><p>
                                    @endif

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="blocktext mgtp-1 tablaDatos pdb-2 row">
                <div class="col-sm-12 text-center">
                    <h3>Pedidos</h3>
                </div>
                <div class="col-sm-12 text-center">
                    <button class="btn btn-link btn-success row"><a href="{{route('compras.pedidos',$id_contrato)}}">Crear Pedido</button>
                </div>

                <div>
                    @if(\Illuminate\Support\Arr::has($detalle,'pedidos'))
                        <table class="tablaDatos mgt-2">
                            <tr>
                                <th>Nombre (CAS)</th>
                                <th>Presentación</th>
                                <th>Precio</th>
                            </tr>
                            @foreach($detalle['productos'] as $condicion)
                                <div class="form-check">
                                    <tr>
                                        <td>{{$condicion->nombre_cas}}</td>
                                        <td>{{$condicion->presentacion}}</td>
                                        <td>{{$condicion->precio_txt}}</td>
                                    </tr>
                                </div>
                            @endforeach
                        </table>

                    @else
                        <p class="mgt-1"><strong>No hay productos disponibles</strong><p>
                    @endif

                </div>

            </div>

    </div>
@endsection
