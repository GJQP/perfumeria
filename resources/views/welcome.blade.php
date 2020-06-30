@extends('layout.master')

@section('titulo','Administracion')

@section('contenido')  
        <div class="container gris stage">
            <div class="row">
                <div id="imagen1" class="cuadrado ">
                    <div class="texto">
                        <h1>Empresa</h1> 
                        <li>Gestion de Formula</li>
                        <li>Recomendador de Perfume</li>
                    </div>
                </div>
                <div id="imagen2" class="cuadrado ">
                    <div class="texto">
                        <h1>Contratos</h1> 
                        <li>Crear</li>
                        <li>Gestion de Contratos</li>
                    </div>
            </div>
            <div id="imagen3" class="cuadrado centrar ">
                <div class="texto">
                    <h1>Compras</h1> 
                    <li>Panel de Compras</li>
                </div>
            </div>
        </div>
@endsection