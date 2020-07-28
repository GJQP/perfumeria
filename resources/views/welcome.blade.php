@extends('layout.master')

@section('nombre pagina','IFRA Administracion')
@section('titulo','Administracion')

@section('contenido')  
        <div class="container gris centradoimg mgt-2">
            
                <div id="imagen1" class="cuadrado centrar">
                    <div class="texto">
                        <h1>Empresa</h1> 
                        <li><a class="titulosUni" href="/gestion-formula">Gestion de Formula</a></li>
                        <li>
                            <a class="titulosUni" href="recomendador-perfumes">Recomendador de Perfumes</a>  
                        </li>
                    </div>
                </div>
                <div id="imagen2" class="cuadrado centrar">
                    <div class="texto">
                        <h1>Contratos</h1> 
                        <li><a class="titulosUni"href="{{route('contratos.index')}}" >Gestion de Contratos</a></li>
                    </div>
                </div>
            <div id="imagen3" class="cuadrado centrar ">
                <div class="texto">
                    <h1>Compras</h1> 
                    <li><a class="titulosUni" href="/gestion-compras" >Panel de Compras</a></li>
                </div>
            </div>
        
    </div>
@endsection