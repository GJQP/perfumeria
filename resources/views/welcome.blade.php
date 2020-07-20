@extends('layout.master')

@section('nombre pagina','IFRA Administracion')
@section('titulo','Administracion')

@section('contenido')  
        <div class="container gris centradoimg mgt-2">
            <div class="row">
                <div id="imagen1" class="cuadrado ">
                    <div class="texto">
                        <h1>Empresa</h1> 
                        <li><a href="/gestion-formula">Gestion de Formula</a></li>
                        <li>
                            <a class="recomendador" href="recomendador-perfumes" disabled>Recomendador<br/>
                                <!--El &nbsp es para crear un espacio en blanco para que quede bien justificado-->
                                &nbsp &nbsp &nbsp 
                                de Perfume</a>  
                        </li>
                        <li><a href="/gestion-perfumista">Crear Perfumista</a> </li>
                    </div>
                </div>
                <div id="imagen2" class="cuadrado ">
                    <div class="texto">
                        <h1>Contratos</h1> 
                        <li><a href="/gestion-contratos" >Gestion de Contratos</a></li>
                    </div>
            </div>
            <div id="imagen3" class="cuadrado centrar ">
                <div class="texto">
                    <h1>Compras</h1> 
                    <li><a href="/gestion-compras" >Panel de Compras</a></li>
                </div>
            </div>
        </div>
@endsection