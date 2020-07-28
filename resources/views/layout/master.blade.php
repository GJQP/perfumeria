<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!--Script-->
        <script src="{{ asset('js/app.js') }}" defer></script>
        @yield('scripts')

        <!--Css-->
        <link href="{{ asset('css/app.css') }}" rel="stylesheet">
        <link href="{{ asset('css/custom.css') }}" rel="stylesheet">
        
        <title>@yield('titulo')</title>
    <body class="gris">
        
        <nav class="navbar-nav">
            <div class="container row nav">
                    <img src="{{ asset('img/IFRA Stripped.png') }}" alt="Ifra logo" class="logo navbar-brand mgl-1">
                    <div class="row titulo justify-content-center">
                        <div>
                             <h1>@yield('titulo')</h1> 
                        </div>
                        <!-- Agregar Validacion de Pagina, Si esta en la inicial, no muestra esto-->
                            <div class="inicio mgrn-5 mgrb-1">
                                <h3> <a id="inicio" href="/inicio">Inicio</a></h3>
                            </div>
                </div>
            </div>
        </nav>
        <div>
            @if(session('status'))
            <div class="alert alert-primary" aling="center">
                {{session('status')}}
            </div>
            @endif
            @if(session('error'))
            <div class="alert alert-danger" aling="center">
                {{session('error')}}
            </div>
        </div>
        @endif
        @yield('contenido')
    
    </body>