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
                            <span class="bs-stepper-label">Detalle de Productos</span>
                        </button>
                    </div>
                    <div class="line"></div>
                    <div class="step" data-target="#envio-part">
                        <button type="button" class="step-trigger" role="tab" aria-controls="envio-part" id="envio-part-trigger">
                            <span class="bs-stepper-circle">2</span>
                            <span class="bs-stepper-label">Método Envío</span>
                        </button>
                    </div>
                    <div class="line"></div>
                    <div class="step" data-target="#pago-part">
                        <button type="button" class="step-trigger" role="tab" aria-controls="pago-part" id="information-part-trigger">
                            <span class="bs-stepper-circle">3</span>
                            <span class="bs-stepper-label">Método de Pago</span>
                        </button>
                    </div>
                    <div class="line"></div>
                    <div class="step" data-target="#monto-part">
                        <button type="button" class="step-trigger" role="tab" aria-controls="monto-part" id="monto-part-trigger">
                            <span class="bs-stepper-circle">4</span>
                            <span class="bs-stepper-label">Confirmación</span>
                        </button>
                    </div>
                </div>
                <div class="bs-stepper-content">
                    <!-- your steps content here -->
                    <div id="detalle-part" class="content" role="tabpanel" aria-labelledby="detalle-part-trigger">
                        <insert-row opciones-ing="{{json_encode($presentaciones)}}"
                                    opciones-otr-ing="{{json_encode($Otrpresentaciones)}}"
                                    cant-env="{{collect($envios)->count() == 1? $envios[0]->id : 0}}"
                                    cant-pag="{{collect($pagos)->count() == 1? $pagos[0]->id : 0}}"
                        ></insert-row>
                    </div>

                    <div id="envio-part" class="content" role="tabpanel" aria-labelledby="envio-part-trigger">
                        <div class="centrar">
                            <p>Seleccione el método de Envío:</p>
                            @foreach($envios as $key => $envio)
                                <input type="radio" name="envio" value="{{$envio->id}}" {{$key == 0? 'checked' : ''}}>
                                <label for="envio">{{$envio->desc}}</label><br>
                            @endforeach
                            <button class="btn btn-primary" onclick="guardarOpcionEnvio(
                                {{collect($pagos)->count() == 1? $pagos[0]->id : ''}})">Next 2</button>
                        </div>

                    </div>

                    <div id="pago-part" class="content" role="tabpanel" aria-labelledby="pago-part-trigger">
                        <div class="centrar">
                            <p>Seleccione el método de Pago para el monto <span id="total"></span></p>
                            @foreach($pagos as $key => $pago)
                                <input type="radio" name="pago" value="{{$pago->id}}" {{$key == 0? 'checked' : ''}}>
                                <label for="envio">{{$pago->desc}}</label><br>
                            @endforeach
                            <button class="btn btn-primary" onclick="guardarPago(true)">Next 3</button>
                        </div>
                    </div>

                    <div id="monto-part" class="content" role="tabpanel" aria-labelledby="monto-part-trigger">
                        <div class="centrar">
                            <h3 class="mgb-3">
                                ¿El proveedor acepta?
                            </h3>
                            <button class="btn btn-danger" onclick="cambiarEstado(false)">Cancelar</button>
                            <button class="btn btn-primary" onclick="cambiarEstado(true)">Confirmar</button>
                        </div>


                    </div>



                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        document.addEventListener('DOMContentLoaded', function () {

            window.id_cto = {{$id_cto}}
            window.id_ped = {{isset($id_ped)? : null }}

            window.stepper = new Stepper(document.querySelector('.bs-stepper'), {
                    linear: true,
                    animation: true,
                    selectors: {
                        steps: '.step',
                        trigger: '.step-trigger',
                        stepper: '.bs-stepper'
                    }
            });

            window.guardarOpcionEnvio = function (idPag) {

                    let id = document.querySelector('input[name="envio"]:checked').value;
                    data = {id_cone: id, id_ped}
                    axios.post(`/pedido/${id_cto}/envio`, data)

                    let recargo = document.querySelector('input[name="envio"]:checked').nextElementSibling.innerText.split(' ').pop()

                    let nuevoPrecio = totalPago * (1 + recargo.split('%')[0]/100);

                    document.getElementById('total').innerHTML ="$ " + (nuevoPrecio).toFixed(2);

                    totalPago = nuevoPrecio.toFixed(2)

                    if (idPag){
                        guardarPago();
                        stepper.next();
                    }


                stepper.next()
            };

            window.guardarPago = function (next) {
                let id = document.querySelector('input[name="pago"]:checked').value;
                data = {id_conp: id, id_ped}
                axios.post(`/pedido/${id_cto}/pago`, data)

                if(next)
                    stepper.next()

            }

            window.cambiarEstado = function (aprobado){

                data = {res: aprobado, id_ped, total: totalPago}

                axios.post(`/pedido/${id_cto}/respuesta`, data).then( () => aprobado? window.location = `/pedido/${id_cto}/${id_ped}`:stepper.to(1) )
            }

            window.totalPago = {!! 00.00 !!};



        })

    </script>
@endsection
