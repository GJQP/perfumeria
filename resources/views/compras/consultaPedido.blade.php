@extends('layout.master')

@section('titulo','Gestion de Compras')


@section('scripts')

@endsection

@section('contenido')
    <div class="container mgt-2 mgrb-1" id="app">
        <div class="stage tarjeta muli col-md-6 offset-3">
            <div class="bs-stepper">
                <div class="bs-stepper-header" role="tablist">
                    <!-- your steps here -->
                    <div class="step" data-target="#detalle-part">
                        <button type="button" class="step-trigger" role="tab" aria-controls="detalle-part" id="detalle-part-trigger">
                            <span class="bs-stepper-circle">1</span>
                            <span class="bs-stepper-label">Detalle de Pedido</span>
                        </button>
                    </div>

                    <div class="line"></div>
                    <div class="step" data-target="#pagar-part">
                        <button type="button" class="step-trigger" role="tab" aria-controls="pagar-part" id="pagar-part-trigger">
                            <span class="bs-stepper-circle">2</span>
                            <span class="bs-stepper-label">Pagos</span>
                        </button>
                    </div>
                </div>
                <div class="bs-stepper-content">
                    <!-- your steps content here -->
                    <div id="detalle-part" class="content" role="tabpanel" aria-labelledby="detalle-part-trigger">

                        <div class="col-md-12">
                            <h3>Método de Envío:</h3>
                            <p>{{$cond_env[0]->desc}}</p>
                            <h3>Modalidad de Pago:</h3>
                            <p>{{$cond_pag[0]->desc}}</p>
                        </div>

                        @if(!empty($ingredientes))
                            <div class="col-md-12">
                                <h3>Ingredientes</h3>
                                <table id="tabla" class="tablaDatos mgt-2">
                                    <tr>
                                        <th>Producto</th>
                                        <th>Precio</th>
                                        <th>Cantidad</th>
                                    </tr>
                                    @foreach($ingredientes as $ingrediente)
                                        <tr>
                                            <td>{{$ingrediente->presentacion}}</td>
                                            <td>{{$ingrediente->precio_txt}}</td>
                                            <td>
                                                {{$ingrediente->cantidad}}
                                            </td>
                                        </tr>
                                    @endforeach
                                </table>
                            </div>

                        @endif
                        @if(!empty($otros_ing))
                            <div class="col-md-12">
                                <h3>Otros Ingredientes</h3>
                                <table id="tabla" class="tablaDatos mgt-2">
                                    <tr>
                                        <th>Producto</th>
                                        <th>Precio</th>
                                        <th>Cantidad</th>
                                    </tr>
                                    @foreach($otros_ing as $ingrediente)
                                        <tr>
                                            <td>{{$ingrediente->presentacion}}</td>
                                            <td>{{$ingrediente->precio}}</td>
                                            <td>
                                                {{$ingrediente->cantidad}}
                                            </td>
                                        </tr>
                                    @endforeach
                                </table>
                            </div>
                        @endif
                    </div>

                    <div id="pagar-part" class="content" role="tabpanel" aria-labelledby="pagar-part-trigger">
                        @if(!empty($pagos_com))
                            <div class="col-md-12">
                                <h3>Pagos</h3>
                                <table id="tabla" class="tablaDatos mgt-2">
                                    <tr>
                                        <th>N° Pago</th>
                                        <th>Monto</th>
                                        <th>Fecha de Pago</th>
                                    </tr>
                                    @foreach($pagos_com as $key => $pago)
                                        <tr>
                                            <td>{{$key + 1}}</td>
                                            <td>{{$pago->total}}</td>
                                            <td>
                                                {{$pago->fcha_reg}}
                                            </td>
                                        </tr>
                                    @endforeach
                                </table>
                            </div>

                        @else
                            <div class="col-md-12">
                                <h3>Pagos</h3>
                                <table id="tabla" class="tablaDatos mgt-2">
                                    <tr>
                                        <th>N° Pago</th>
                                        <th>Monto</th>
                                        <th>Fecha de Pago</th>
                                    </tr>
                                    @php($total = 0)
                                    @foreach($pagos_gen as $key => $pago)
                                        <tr>
                                            <td>{{$key + 1}}</td>
                                            <td>$ {{round($pago['total'],2)}}</td>@php($total += round($pago['total'],2) )
                                            <td>
                                                Páguese antes del
                                                {{Carbon\Carbon::now('America/Caracas')->addDays($pago['days'])->format('Y-m-d')}}
                                            </td>
                                        </tr>
                                    @endforeach
                                    <h3>Total a cancelar: $ {{$total}}</h3>
                                </table>
                                <form action="{{route('compras.pagar',['id_ctro'=>$id_cto,'id_ped'=>$id_ped])}}" method="POST">
                                    @csrf
                                    <button type="submit" class="btn btn-success offset-4 mgt-2">Generar Pagos</button>
                                </form>
                            </div>

                        @endif
                    </div>



                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        document.addEventListener('DOMContentLoaded', function () {


                window.stepper = new Stepper(document.querySelector('.bs-stepper'), {
                linear: false,
                animation: false,
                selectors: {
                    steps: '.step',
                    trigger: '.step-trigger',
                    stepper: '.bs-stepper'
                }
                }


            );
            stepper.to(2);
        })

    </script>
@endsection
