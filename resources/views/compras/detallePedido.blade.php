@extends('layout.master')

@section('titulo','Gestion de Compras')


@section('scripts')

@endsection

@section('contenido')
    <div class="container mgt-2 mgrb-1" id="app">
        <div class="stage tarjeta muli">
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
                    <div class="step" data-target="#monto-part">
                        <button type="button" class="step-trigger" role="tab" aria-controls="monto-part" id="monto-part-trigger">
                            <span class="bs-stepper-circle">3</span>
                            <span class="bs-stepper-label">Montos</span>
                        </button>
                    </div>
                    <div class="line"></div>
                    <div class="step" data-target="#pago-part">
                        <button type="button" class="step-trigger" role="tab" aria-controls="pago-part" id="information-part-trigger">
                            <span class="bs-stepper-circle">4</span>
                            <span class="bs-stepper-label">Método de Pago</span>
                        </button>
                    </div>
                    <div class="line"></div>
                    <div class="step" data-target="#pagar-part">
                        <button type="button" class="step-trigger" role="tab" aria-controls="pagar-part" id="pagar-part-trigger">
                            <span class="bs-stepper-circle">5</span>
                            <span class="bs-stepper-label">Pagos</span>
                        </button>
                    </div>
                </div>
                <div class="bs-stepper-content">
                    <!-- your steps content here -->
                    <div id="detalle-part" class="content" role="tabpanel" aria-labelledby="detalle-part-trigger">
                        <insert-row opciones="{{json_encode($presentaciones)}}"></insert-row>
                    </div>

                    <div id="envio-part" class="content" role="tabpanel" aria-labelledby="envio-part-trigger">
                        <button class="btn btn-primary" onclick="stepper.next()">Next 2</button>
                    </div>

                    <div id="monto-part" class="content" role="tabpanel" aria-labelledby="monto-part-trigger">
                        <button class="btn btn-primary" onclick="stepper.next()">Next 2</button>
                    </div>

                    <div id="pago-part" class="content" role="tabpanel" aria-labelledby="pago-part-trigger">
                        <button class="btn btn-primary" onclick="stepper.next()">Next 2</button>
                    </div>

                    <div id="pagar-part" class="content" role="tabpanel" aria-labelledby="pagar-part-trigger">
                        <button class="btn btn-primary" onclick="stepper.next()">Next 2</button>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        document.addEventListener('DOMContentLoaded', function () {

            window.stepper = new Stepper(document.querySelector('.bs-stepper'), {
                    linear: true,
                    animation: false,
                    selectors: {
                        steps: '.step',
                        trigger: '.step-trigger',
                        stepper: '.bs-stepper'
                    }
            });

        })

    </script>
@endsection
