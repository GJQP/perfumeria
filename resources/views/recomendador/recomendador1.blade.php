@extends('layout.master')

@section('script')
    <script src="{{ asset('js/app.js') }}"></script>
@endsection
@section('titulo','Recomendador de Perfumes')

@section('contenido')  
<div class="container mgt-2 mgrb-1">
    <!--Filtros-->
    <form>
        <div id="app">
            <Filtros></Filtros>
        </div>
    </form>
    <!--Rueda con la informacion-->
    <div class="stage tarjeta muli mgt-1 pdb-2">
        <div class=" mgl-2 row">
            <!--Lado izquierdo para la Rueda-->
            <div class="rueda blocktext">
                Hola
            </div>
            <!--Lado derecho para mostrar perfumes-->
            <div class="perfumes blocktext">
                
            </div>
        </div>
    </div>
</div>
@endsection