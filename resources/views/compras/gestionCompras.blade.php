@extends('layout.master')

@section('titulo','Gestion de Compras')

@section('contenido')
<div class="container mgt-2 mgrb-1">
    <div class="stage tarjeta muli">
        <!--Seleccionar la Empresa-->
        <div class="row blocktext">
            <p class="mgt-1" for="empresas"><strong>Seleccione la Empresa a la que desee consultar sus Formulas:</strong><p>
            <div class="dropdown mgl-1">
                <button class="btn btn-secondary dropdown-toggle" type="button" id="empresa" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                Empresa
                </button>
                <div class="dropdown-menu muli" aria-labelledby="dropdownMenuButton">
                    <!--Elementos internos del dropdown-->
                    <a class="dropdown-item" onclick="">Action</a>
                    <a class="dropdown-item" onclick="">Another action</a>
                    <a class="dropdown-item" onclick="">Priv I Organics LTD</a>                               
                </div>
            </div>
        </div>
        <div class="hacerPedido mgt-1"><a>Hacer Pedido</a></div>
        <!-- Tabla de Pedidos-->
        <div class="blocktext mgtp-1">
            <table id="tabla" class="mgl-3">
                  <tr>
                      <th id="nombreEmp">Nombre de la Empresa</th>
                      <th id="estado">Estado</th>
                      <th id="tiempoEntrega">Tiempo Maximo de Entrega</th>
                      <th id="accion">Acción</th>
                  </tr>
                  
        </div>
    </div>
</div>
@endsection