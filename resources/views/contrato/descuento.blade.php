@extends('layout.master')

@section('scripts')
<script src="{{ asset('js/selecProd.js') }}"></script>
@endsection

@section('titulo','Descuento')

@section('contenido')
<div class="container mgt-2 mgrb-1">
    <div class="stage tarjeta muli">
        <form method="POST">
            @csrf
        <div class="blocktext row mgt-1" id="desc">
            <p class="mgt-1">Introduzca un descuento(opcional):</p>
            <input type="text" class="form-control descuento pdb-1" name="descuento">
            <span class="input-group-addon">%</span>
        </div>
        <div class="blocktext row ">
            <p class="mgt-1">Fecha de finalizacion del descuento(opcional):</p>
            <input type="text" class="form-control descuento pdb-1" name="fechaDesc">
            <span class="input-group-addon">%</span>
        </div>
          <!--Botones-->
          <div class="row blocktext mgt-1 pdb-2">
            <button type="submit" class="btn btn-primary mgl-1">Aceptar</button>
          </div>
        </form>
    </div>
</div>
@endsection