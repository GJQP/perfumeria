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
            <div class="perfumes">
                <div>
                    <img class="blocktext" src="" alt="#">
                    <h4 class="mgt-1 blocktext"><u>Nombre del Perfume</u></h4>
                </div>
                <div>
                    <div>
                        <p class="blocktext">Distribuido por:</p>
                        <p class="blocktext">Creado por:</p>
                        <a href="#" class="mgt-1 ficha blocktext">Ficha del Perfume</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection